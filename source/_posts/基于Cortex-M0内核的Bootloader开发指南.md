---
title: 基于Cortex-M0内核的Bootloader开发指南
mermaid: true
date: 2025-03-28
tags: [嵌入式, C语言, 笔记, 单片机, bootloader]
comments: true
categories: [嵌入式]
---


> <font style="color:rgb(64, 64, 64);">在嵌入式系统中，Bootloader是芯片上电后运行的第一段代码，负责初始化硬件、验证应用程序完整性，并实现固件升级功能。针对资源受限的</font>**<font style="color:rgb(64, 64, 64);">Cortex-M0</font>**<font style="color:rgb(64, 64, 64);">内核的MM32G0001的MCU实现，过程中设计到中断向量表的不同的区分。</font>
>

#### **<font style="color:rgb(64, 64, 64);">一、Bootloader的核心作用</font>**
1. **<font style="color:rgb(64, 64, 64);">硬件初始化</font>**<font style="color:rgb(64, 64, 64);">：配置时钟、外设、中断向量表。</font>
2. **<font style="color:rgb(64, 64, 64);">应用程序跳转</font>**<font style="color:rgb(64, 64, 64);">：验证APP有效性后跳转到用户程序。</font>
3. **<font style="color:rgb(64, 64, 64);">固件升级</font>**<font style="color:rgb(64, 64, 64);">：通过UART、I2C等接口接收新固件并烧录到Flash。</font>

#### **<font style="color:rgb(64, 64, 64);">二、Bootloader工作流程图</font>**
```plain
+---------------------+
|      上电启动        |
+---------------------+
           |
           V
+---------------------+
| 初始化时钟、GPIO、串口 |
+---------------------+
           |
           V
+---------------------+
| 检测升级触发条件       |
| (如按键/USB信号)       |
+---------------------+
           |------------------- 是 -------------------+
           |                                         |
          否                                          |
           |                                         V
           V                                +---------------------+
+---------------------+                     |  进入Bootloader模式  |
| 检查APP有效性         |                     | (等待固件传输)        |
| (CRC校验或标志位)      |                     +---------------------+
+---------------------+                                |
           |                                           |
          有效                                          V
           |                                +---------------------+
           V                                |  接收数据并写入Flash |
+---------------------+                     |  (分块校验+烧录)     |
| 跳转到应用程序(APP)   |                     +---------------------+
+---------------------+                                |
           |                                           |
           +------------------- 完成 ------------------+
                                           |
                                           V
                                +---------------------+
                                | 复位或跳转到新APP     |
                                +---------------------+
```

#### **<font style="color:rgb(64, 64, 64);">三、关键设计步骤</font>**
##### **<font style="color:rgb(64, 64, 64);">1. 内存分配</font>**
+ **<font style="color:rgb(64, 64, 64);">Bootloader区域</font>**<font style="color:rgb(64, 64, 64);">：占用Flash起始地址（如0x08000000~0x080013FF）。</font>
+ **<font style="color:rgb(64, 64, 64);">应用程序区域</font>**<font style="color:rgb(64, 64, 64);">：紧随其后（如0x08001400~0x080037FF）。</font>
+ **<font style="color:rgb(64, 64, 64);">中断向量表重定向</font>**<font style="color:rgb(64, 64, 64);">：APP中需通过</font>`<font style="color:rgb(64, 64, 64);">SCB->VTOR</font>`<font style="color:rgb(64, 64, 64);">设置偏移量。(M0内核没有)</font>

**<font style="color:rgb(64, 64, 64);">链接脚本示例（APP端）</font>**<font style="color:rgb(64, 64, 64);"> </font><font style="color:rgb(64, 64, 64);">：</font>

```c
MEMORY {
        FLASH (rx) : ORIGIN = 0x08001400, LENGTH = 9K
        RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 2K
    }
```

keill设置

![](/images/posts/基于Cortex-M0内核的Bootloader开发指南/1.png)

##### **<font style="color:rgb(64, 64, 64);">2. 跳转到应用程序</font>**
```c
typedef void (*AppEntry)(void);

void JumpToApp(uint32_t appAddress) {
    // 检查栈顶地址是否合法
    if (((*(uint32_t*)appAddress) & 0x2FFE0000) == 0x20000000) {
        // 设置APP的栈指针和复位向量
        __set_MSP(*(uint32_t*)appAddress);
        AppEntry entry = (AppEntry)(*(uint32_t*)(appAddress + 4));

        // 关闭所有中断
        __disable_irq();

        // 跳转到APP
        entry();
    }
}
```

##### **<font style="color:rgb(64, 64, 64);">3. 固件接收与烧录</font>**
<font style="color:rgb(64, 64, 64);">通过UART接收数据并写入Flash：</font>

```c
FLASH_Status flash_bsp_write_block(uint16_t BlockNum, uint8_t *data)
{
    FLASH_Status err_Status;

    // 解锁闪存以允许写操作
    FLASH_Unlock();

    // 清除所有错误标志位，确保写操作前状态标志处于已知状态
    FLASH_ClearFlag(FLASH_FLAG_EOP | FLASH_FLAG_PGERR | FLASH_FLAG_WRPRTERR);

    /* 将数据写入指定的页 */
    for (uint16_t i = 0; i < 128; i += 4)
    {
        err_Status += FLASH_ProgramWord(FLASH_APP1_BASE_ADDRESS + (BlockNum * 0x80) + i, *(uint32_t *)(data + i));
    }

    // 清除操作结束标志位，为后续操作做好准备
    FLASH_ClearFlag(FLASH_FLAG_EOP);

    // 锁定闪存以防止未经授权的访问或修改
    FLASH_Lock();

    // 返回写操作的状态
    return err_Status;
}

```

##### **<font style="color:rgb(64, 64, 64);">4. 升级触发条件检测</font>**
<font style="color:rgb(64, 64, 64);">如检测到指令</font>

```c
if(reg_value == 0x0000)
    {
        enter_app();
    }
```

#### **<font style="color:rgb(64, 64, 64);">四、调试技巧</font>**
1. **<font style="color:rgb(64, 64, 64);">半主机问题</font>**<font style="color:rgb(64, 64, 64);">：禁用标准库依赖，避免在Bootloader中使用printf</font><font style="color:rgb(64, 64, 64);">。</font>
2. **<font style="color:rgb(64, 64, 64);">看门狗</font>**<font style="color:rgb(64, 64, 64);">：在长时间操作中复位看门狗。</font>
3. **<font style="color:rgb(64, 64, 64);">Flash保护</font>**<font style="color:rgb(64, 64, 64);">：确保操作前正确解锁Flash。</font>

#### **<font style="color:rgb(64, 64, 64);">五、中断向量表详解</font>**
##### <font style="color:rgb(64, 64, 64);">1、对比 Cortex-M0 和 M3 内核的中断向量表迁移方式：</font>
| **<font style="color:rgb(64, 64, 64);">特性</font>** | **<font style="color:rgb(64, 64, 64);">Cortex-M0</font>** | **<font style="color:rgb(64, 64, 64);">Cortex-M3</font>** |
| --- | --- | --- |
| <font style="color:rgb(64, 64, 64);">向量表偏移寄存器(VTOR)</font> | **<font style="color:rgb(64, 64, 64);">可选特性</font>**<font style="color:rgb(64, 64, 64);">（依赖芯片厂商实现）</font> | **<font style="color:rgb(64, 64, 64);">强制支持</font>**<font style="color:rgb(64, 64, 64);">（SCB->VTOR 寄存器）</font> |
| <font style="color:rgb(64, 64, 64);">默认向量表地址</font> | <font style="color:rgb(64, 64, 64);">0x00000000（固定）</font> | <font style="color:rgb(64, 64, 64);">0x00000000（可通过VTOR动态修改）</font> |
| <font style="color:rgb(64, 64, 64);">重映射灵活性</font> | <font style="color:rgb(64, 64, 64);">依赖Flash物理地址或厂商自定义方法</font> | <font style="color:rgb(64, 64, 64);">任意地址（通过VTOR设置）</font> |


**<font style="color:rgb(64, 64, 64);">注</font>**<font style="color:rgb(64, 64, 64);">：MM32G0001 的 VTOR 功能</font>**<font style="color:rgb(64, 64, 64);">由芯片厂商自定义实现</font>**<font style="color:rgb(64, 64, 64);">，需查阅手册确认其行为！MM32G0001没有此功能</font>

<font style="color:rgb(64, 64, 64);">####</font>

##### <font style="color:rgb(64, 64, 64);">2、MM32G0001中断向量表配置方法</font>
###### **<font style="color:rgb(64, 64, 64);">M0内核中断向量表偏移存在问题</font>**
+ <font style="color:rgb(64, 64, 64);">芯片复位后默认从 </font><font style="color:rgb(64, 64, 64);">0x08000000</font><font style="color:rgb(64, 64, 64);">（Flash起始地址）加载向量表。向量表的位置由Flash的物理地址决定，无法通过软件动态调整。</font>

###### **<font style="color:rgb(64, 64, 64);">MM32G0001的特殊性</font>**
+ <font style="color:rgb(64, 64, 64);">MM32G0001虽然是Cortex-M0内核，但支持自定义的向量表映射机制，需参考具体芯片手册。</font>

###### 解决方法
通过切换内存映射方法，切换中断向量表，系统默认将flash的0x8000000地址映射到地址0x000000地址，通过修改SYSCFG->CFGR寄存器将ram的0x20000000内存映射到地址0x000000，通过查阅可以看到中断入口函数存放在bin文件的最前面：

![](/images/posts/基于Cortex-M0内核的Bootloader开发指南/2.png)

再通过启动文件可以看到一共48个中断<font style="color:rgb(77, 77, 77);">53行Vectors---到-->102行Vectors_End 每一个DCD都代表一个中断向量 （ 中断服务程序的入口地址 ）分为内核中断和外部中断，其中32位系统中，每一个中断入口函数指针占4字节。所以一共占用48*4= 192 = 0xC0字节。</font>

![](/images/posts/基于Cortex-M0内核的Bootloader开发指南/3.png)

通过查看hex文件可以知道我们16进制文件的0xc前都是中断入口函数指针后面接着是其他函数的入口函数指针。

![](/images/posts/基于Cortex-M0内核的Bootloader开发指南/4.png)

所以我们的方式是把前面的0XC0自己的入口函数指针复制到内存空间中。

```c
// 获取APP的向量表地址
    memcpy((uint32_t *)RAM_APP1_BASE_ADDRESS, (uint32_t *)FLASH_APP1_BASE_ADDRESS, 48*4);
```

需要在APP的程序中屏蔽前面部分的内存，防止被修改

![](/images/posts/基于Cortex-M0内核的Bootloader开发指南/5.png)

完成上诉步骤，接着就可以实现从以0x2000 0000作为起始地址映射向量表：

```c
RCC_APB1PeriphClockCmd(RCC_APB1PERIPH_SYSCFG, ENABLE);
SYSCFG->CFGR &= ~SYSCFG_CFGR_MEM_MODE; // 清除原有配置
SYSCFG->CFGR |= (0x3 << SYSCFG_CFGR_MEM_MODE_Pos); // MEM_MODE=11
RCC_APB1PeriphClockCmd(RCC_APB1PERIPH_SYSCFG, DISABLE);
```

    这里需要注意，MM32和STM32单片机区别，MM32单片机在修改内存映射修改时需要启动相对应的时钟。而在STM32无需这项操作。

##### 跳转APP整体完整操作
 禁用中断，确保后续操作不会被中断->禁用定时器中断\禁用发送和接收->获取APP的向量表地址复制RAM中-> 配置SYSCFG，设置RAM映射到0地址->重启中断(减少app代码修改)->定义一个函数指针->获取应用程序的入口地址-> 设置主栈指针(MSP)为应用程序的初始栈指针->调用应用程序的入口函数，开始执行应用程序->APP中屏蔽前0xc0的内存地址

**<font style="color:rgb(64, 64, 64);">流程图</font>**

```plain
graph TD
    A[Bootloader开始] --> B[禁用所有中断]
    B --> C[复制APP向量表到RAM]
    C --> D[配置SYSCFG重映射RAM到0x00000000]
    D --> E[设置MSP为APP栈顶地址]
    E --> F[跳转到APP入口函数]
    F --> G[APP运行]
```

####  **<font style="color:rgb(64, 64, 64);">六：结语</font>**
<font style="color:rgb(64, 64, 64);">在本次关于MM32G001 MCU（Cortex-M0内核）的Bootloader开发指南中，我们详细探讨了Bootloader在嵌入式系统中的重要角色，特别是在中断向量表映射方面的特殊需求。通过深入分析Cortex-M0与Cortex-M3内核在中断向量表映射机制上的差异，明确了在MM32G001上实现Bootloader的关键步骤和注意事项。</font>

<font style="color:rgb(64, 64, 64);">我回顾了Bootloader的核心功能，包括硬件初始化、应用程序有效性检查、固件升级以及中断向量表的重映射。特别是在MM32G001上，由于其Cortex-M0内核不支持动态修改向量表偏移寄存器（VTOR），我采用了硬件重映射的方法，通过将应用程序的向量表复制到RAM，并配置系统控制寄存器（SYSCFG）以实现中断向量表的重映射。这一过程确保了在不修改应用程序代码的前提下，实现安全可靠的跳转。</font>

<font style="color:rgb(64, 64, 64);">通过完整的代码示例和详细的步骤说明，我们展示了如何禁用中断、复制向量表到RAM、配置SYSCFG寄存器以及跳转到应用程序入口函数。这些步骤不仅确保了系统的稳定性，还为开发者提供了清晰的实现路径。</font>

<font style="color:rgb(64, 64, 64);">在实际开发过程中，强调了以下关键点：</font>

1. **<font style="color:rgb(64, 64, 64);">内存对齐</font>**<font style="color:rgb(64, 64, 64);">：确保Flash和RAM地址按芯片手册要求对齐，避免地址错误导致的系统崩溃。</font>
2. **<font style="color:rgb(64, 64, 64);">中断清除</font>**<font style="color:rgb(64, 64, 64);">：跳转前清除所有挂起的中断，防止在应用程序运行过程中出现意外中断。</font>
3. **<font style="color:rgb(64, 64, 64);">调试验证</font>**<font style="color:rgb(64, 64, 64);">：使用内存查看工具和调试器，确保向量表复制正确，中断向量表重映射成功。</font>

<font style="color:rgb(64, 64, 64);">建议读者在开发过程中参考MM32G001的芯片手册，确保配置和操作符合芯片的具体要求。</font>

> <font style="color:rgb(64, 64, 64);">个人博客：WWW.f123.club</font>
>


