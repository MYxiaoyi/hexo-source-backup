---
title: STM32单片机外设初始化例程
mermaid: true
date: 2023-01-18
tags: [嵌入式, 单片机, 技术, C语言]
cover: rgba(138, 237, 234, 0.47)
comments: true
categories: [嵌入式]
---

# STM32单片机外设初始化例程

## 一、起因

由于自己学习STM32单片机是零零散散的学习的，没有系统的进行学习，学习的东西非常的混乱，没有做过什么整体的框架整理，所以在此将STM32的外设的初始化进行系统的打包成一个文档，把程序的过程进行整理。

## 二、基本流程

### 1、基本STM32硬件知识点

STM32的单片机的开发程序发展的流程基本都是从寄存器阶段到标准库阶段到现在的HAL库、RTOS。所以第一步我们需要清楚单片机的整体工作流程。

![](/images/posts/STM32单片机外设初始化例程/1.webp)

通过图上可以看出，STM32单片机有一个Cortex-M3的内核CPU控制，分出三条数据总线控制各个外设：

- **指令存储区总线（两条）**：I-Code总线和D-Code总线
- **系统总线（System）**：用于访问内存和外设
- **私有外设总线**：负责一部分私有外设的访问，主要就是访问调试组件

I-Code用于取指，D-Code用于查表等操作，它们按最佳执行速度进行优化。

系统总线（System）用于访问内存和外设，覆盖的区域包括SRAM，片上外设，片外RAM，片外扩展设备，以及系统级存储区的部分空间。

私有外设总线负责一部分私有外设的访问，主要就是访问调试组件。它们也在系统级存储区。

还有一个DMA总线，从字面上看，DMA是data memory access的意思，是一种连接内核和外设的桥梁，它可以访问外设、内存，传输不受CPU的控制，并且是双向通信。简而言之，这个家伙就是一个速度很快的且不受老大控制的数据搬运工。

从结构框图上看，STM32的外设有串口、定时器、IO口、FSMC、SDIO、SPI、I2C等，这些外设按照速度的不同，分别挂载到AHB、APB2、APB1这三条总线上。

其中寄存器其实可以理解为内存的地址，cpu通过地址访问对应的空间的内存数据，这个内存数据用来控制各个外设的开关。

`stm32`的函数一切库的封装始于寄存器的映射操作。
![](/images/posts/STM32单片机外设初始化例程/2.webp)
![](/images/posts/STM32单片机外设初始化例程/4.webp)

如果进行寄存器开发，就需要怼地址以及对寄存器进行字节赋值，不仅效率低而且容易出错。

因此我们开始使用库函数进行编程。
![](/images/posts/STM32单片机外设初始化例程/3.webp)

### 内核库文件分析

#### `cor_cm3.h`
这个头文件实现了：  
1. 内核结构体寄存器定义  
2. 内核寄存器内存映射  
3. 内存寄存器位定义  

> 跟处理器相关的头文件`stm32f10x.h`实现的功能一样，一个是针对内核的寄存器，一个是针对内核之外，即处理器的寄存器。

#### `misc.h`
内核应用函数库头文件，对应`stm32f10x_xxx.h`。

#### `misc.c`
内核应用函数库文件，对应`stm32f10x_xxx.c`。

在CM3这个内核里面还有一些功能组件，如：
- `NVIC`
- `SCB` 
- `ITM`
- `MPU`
- `CoreDebug`

> CM3带有非常丰富的功能组件，但是芯片厂商在设计MCU的时候有一些并不是非要不可的，是可裁剪的，比如`MPU`、`ITM`等在STM32里面就没有。  
> 其中`NVIC`在每一个CM3内核的单片机中都会有，但都会被裁剪，只能是CM3 NVIC的一个子集。在`NVIC`里面还有一个`SysTick`，是一个系统定时器，可以提供时基，一般为操作系统定时器所用。

`misc.h`和`mics.c`这两个文件提供了操作这些组件的函数，并可以在CM3内核单片机直接移植。

---

### 处理器外设库文件分析

#### `startup_stm32f10x_hd.s`
这个是由汇编编写的启动文件，是STM32上电启动的第一个程序，启动文件主要实现了：

- 初始化堆栈指针 `SP`
- 设置 `PC` 指针`=Reset_Handler`
- 设置向量表的地址，并初始化向量表（向量表里面放的是 STM32 所有中断函数的入口地址）
- 调用库函数 `SystemInit`（把系统时钟配置成 72M，`SystemInit` 在库文件 `stytem_stm32f10x.c` 中定义）
- 跳转到标号`_main`，最终去到 C 的世界

#### `system_stm32f10x.c`
这个文件的作用是里面实现了各种常用的系统时钟设置函数，有：
- 72M
- 56M 
- 48M
- 36M
- 24M
- 8M

> 我们使用的是把系统时钟设置成72M。

#### `Stm32f10x.h`
这个头文件非常重要，实现了：

1. 处理器外设寄存器的结构体定义
2. 处理器外设的内存映射
3. 处理器外设寄存器的位定义

> 关于1和2我们在用寄存器点亮LED的时候有讲解。

**关于第3点说明：**  
处理器外设寄存器的位定义就是把外设的每个寄存器的每一个位写1的16进制数定义成一个宏，宏名即用该位的名称表示。

**示例：**
```c
// 一般的操作方法
ADC->CR2 = 0x00000001;

// 使用位定义后的操作
ADC->CR2 = ADC_CR2_ADON;
```

#### `stm32f10x_xxx.h`
外设xxx应用函数库头文件，这里面主要定义了实现外设某一功能的结构体。

> 比如通用定时器有很多功能：定时功能、输出比较功能、输入捕捉功能。这个头文件就为我们打包好了要实现某一个功能的寄存器（以结构体的形式定义）。

#### `stm32f10x_xxx.c`
外设xxx应用函数库，这里面写好了操作xxx外设的所有常用的函数。

> 我们使用库编程的时候，使用的最多的就是这里的函数。

---

### SystemInit 相关问题

在工程中新建`main.c`后直接编译会报错：
```
Undefined symbol SystemInit (referred from startup_stm32f10x_hd.o).
```

**原因分析：**  
从启动文件`startup_stm32f10x_hd.s`中我们知道：
```assembly
;Reset handler
Reset_Handler PROC
    EXPORT Reset_Handler [WEAK]
    IMPORT __main
    ;IMPORT SystemInit
    ;LDR R0, =SystemInit
    BLX R0
    LDR R0, =__main
    BX R0
ENDP
```
> 汇编中`;`分号是注释的意思  
> `Reset_Handler`调用了`SystemInit`函数（用来初始化系统时钟），该函数是在库文件`system_stm32f10x.c`中实现的。

**解决方案：**  
在main文件里面定义一个`SystemInit`空函数，为的是骗过编译器，把这个错误去掉。

> 关于配置系统时钟之后会出文章RCC时钟树详细介绍，主要配置：
> - 时钟控制寄存器(RCC_CR)
> - 时钟配置寄存器(RCC_CFGR)  
> 
> 但最好是直接使用CubeMX直接生成，因为它的配置过程有些冗长。  
> 如果使用库，库函数`SystemInit`会帮我们把系统时钟设置成72M。


## <font style="color:rgb(18, 18, 18);">2、基本stm32外设配置流程</font>
**程序模板**

#### 第一步：申明结构体；
```c
xxx_InitTypeDef xxx_InitStructure;
```

#### 第二步：开启时钟；
（第一步和第二步顺序不能调换：标准c要求所有变量/结构体,都必须在代码段之前声明）

```c
RCC_xPeriphClockCmd(RCC_AxBxPeriph_xxx, ENABLE)
```

> *2.5：引脚复用（如果有）并且开启复用的时钟
>

```c
GPIO_PinAFConfig(GPIOx,GPIO_PinSourcex,GPIO_AF_x)
```

#### 第三步：初始化结构体；
```c
xxx_Init(xxx,&xxx_InitStructure)
```

### *若有设置中断
> 中断名在startup_stm32f40_41xx.s中定义。
>

#### 第一步：使能外设某特定中断（定时器，串口，ADC）
```c
xxx_ITConfig(xxx, xxx, ENABLE);
```

#### 第二步：初始化 NVIC
```c
NVIC_Init(&NVIC_InitStructure);
```

#### 第三步：设置系统中断优先级分组(通常在主函数中配置）
```c
NVIC_PriorityGroupConfig(NVIC_PriorityGroup_x);
```

中断服务函数(典型）

```c
void xxx_IRQHandler(void)
{
    if(xxx_GetITStatus(xxx)!=RESET)//判断某个线上的中断是否发生 
  { …中断逻辑…
      xxx_ClearITPendingBit(xxx); //清除 LINE 上的中断标志位 
  }
}
```

其它中断相关

```c
xxx_GetITStatus(xxx)//获取中断状态，查看中断是否发生 
//
xxx_ClearITPendingBit(xxx)；//清除
else
xxx_ClearFlag(xxx);//清除
//前者会先判断这种中断是否使能，使能了才去判断中断标志位，
//而后者直接用来判断状态标志位。
```

### END.定时器/串口/ADC使能
```c
xxx_Cmd(xxx, ENABLE);
```

## 3、结构体变量配置具体形式
#### 初始化结构体初始化 GPIO 的常用格式
```c
GPIO_InitTypeDef GPIO_InitStructure;
GPIO_InitStructure.GPIO_Pin = GPIO_Pin_x | GPIO_Pin_x;
GPIO_InitStructure.GPIO_Mode = GPIO_Mode_xxx;
GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
GPIO_Init(GPIOx,&GPIO_InitStructure);
```

#### 初始化结构体初始化 USART 的常用格式
```c
USART_InitTypeDef USART_InitStructure;
USART_InitStructure.USART_BaudRate = bound;//一般设置为 9600;
USART_InitStructure.USART_WordLength = USART_WordLength_8b;//字长为 8 位数据格式
USART_InitStructure.USART_StopBits = USART_StopBits_1;//一个停止位
USART_InitStructure.USART_Parity = USART_Parity_No;//无奇偶校验位
USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
USART_InitStructure.USART_Mode = USART_Mode_Rx |USART_Mode_Tx;//收发模式
USART_Init(USARTX, &USART_InitStructure); //初始化串口
```

#### 初始化结构体初始化 NVIC 的常用格式
```c
NVIC_InitTypeDef NVIC_InitStructure;
NVIC_InitStructure.NVIC_IRQChannel = xxx_IRQn;//设置中断名
NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority=3;//抢占优先级 3
NVIC_InitStructure.NVIC_IRQChannelSubPriority =3; //响应优先级 3
NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE; //IRQ 通道使能
NVIC_Init(&NVIC_InitStructure); //根据指定的参数初始化 VIC 寄存器、
```

#### 初始化结构体初始化外部中断的常用格式
```c
 EXTI_InitTypeDef EXTI_InitStructure;
 EXTI_InitStructure.EXTI_Line=EXTI_Linex;
 EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
 EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_xxx;//上升，下降沿或任意电平
 EXTI_InitStructure.EXTI_LineCmd = ENABLE;
 EXTI_Init(&EXTI_InitStructure); //初始化外设 EXTI 寄存器
```

#### 初始化结构体初始化定时器中断的常用格式
```c
TIM_TimeBaseInitTypeDef TIM_TimeBaseStructure;
TIM_TimeBaseStructure.TIM_Period = xxx;
TIM_TimeBaseStructure.TIM_Prescaler =xxx; 
TIM_TimeBaseStructure.TIM_ClockDivision = TIM_CKD_DIVx; 
TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_x;
TIM_TimeBaseInit(TIMx, &TIM_TimeBaseStructure);
```

#### 初始化结构体初始化输出比较的常用格式
```c
TIM_OCInitTypeDef TIM_OCInitStructure;
TIM_OCInitStructure.TIM_OCMode = TIM_OCMode_PWMx; //选择模式 PWM
TIM_OCInitStructure.TIM_OutputState = TIM_OutputState_Enable; //比较输出使能
TIM_OCInitStructure.TIM_OCPolarity = TIM_OCPolarity_xxx; //输出极性
TIM_OCxInit(TIMx, &TIM_OCInitStructure); //根据T指定的参数初始化外设
```



#### 设置 ADC 的通用控制寄存器 CCR( common control register)
```c
ADC_CommonInitTypeDef ADC_CommonInitStructure;
ADC_CommonInitStructure.ADC_Mode = ADC_Mode_Independent;//独立模式
ADC_CommonInitStructure.ADC_TwoSamplingDelay = ADC_TwoSamplingDelay_xCycles;//两个采样阶段之间的延迟周期数，5~20
ADC_CommonInitStructure.ADC_DMAAccessMode = ADC_DMAAccessMode_Disabled;
ADC_CommonInitStructure.ADC_Prescaler = ADC_Prescaler_Div4;//需保证 ADC1 的时钟频率不超过 36MHz。
ADC_CommonInit(&ADC_CommonInitStructure);//初始化
```

#### 初始化结构体初始化ADC的常用格式
```c
ADC_InitTypeDef ADC_InitStructure;
ADC_InitStructure.ADC_Resolution = ADC_Resolution_xb;//6,8,10,12
ADC_InitStructure.ADC_ScanConvMode = DISABLE;//非扫描模式
ADC_InitStructure.ADC_ContinuousConvMode = DISABLE;//关闭连续模式
ADC_InitStructure.ADC_ExternalTrigConvEdge = ADC_ExternalTrigConvEdge_None;
//禁止触发检测，使用软件触发
ADC_InitStructure.ADC_DataAlign = ADC_DataAlign_Right;//右对齐
ADC_InitStructure.ADC_NbrOfConversion = 1;//1 个转换在规则序列中
ADC_Init(ADC1, &ADC_InitStructure);//ADC 初始化
```

# 三、GPIO配置
### 1、常用函数

> **GPIO_Init** 初始化GPIO，设置GPIO的模式，速度，引脚数 
**GPIO_ReadInputDataBit**读取一位GPIO的输入数据	
**GPIO_ReadInputData**	读取GPIOx的输入数据	
**GPIO_ReadOutputDataBit**	读取一位GPIO的输出数据	
**GPIO_ReadOutputDat**a	读取GPIOx的输出数据	
**GPIO_SetBits**	使GPIO设置为高电平，可一起设置多，也可以设置一个	
**GPIO_ResetBits**	使GPIO设置为高电平，课一起设置多，也可以设置一个	
**GPIO_WriteBit**	设置GPIO的一个管脚	
**GPIO_Write**	设置GPIOx全部管脚	
**GPIO_ToggleBits** 翻转指定的GPIO口
**GPIO_PinAFConfig** 改变指定管脚的映射关系，即配置指定管脚的复用功能

### <font style="color:rgb(77, 77, 77);">设计框图</font>
![](/images/posts/4.png)

### <font style="color:rgb(77, 77, 77);">例程代码</font>
#### 示例一:<font style="color:rgb(77, 77, 77);">LED灯初始化GPIO口例程</font>
```c
void LED_GPIO_Config(void)
{		
		/*定义一个GPIO_InitTypeDef类型的结构体*/
		GPIO_InitTypeDef GPIO_InitStructure;
		/*开启LED相关的GPIO外设时钟*/
		RCC_APB2PeriphClockCmd( RCC_APB2Periph_GPIOC|RCC_APB2Periph_GPIOB,ENABLE);
		/*选择要控制的GPIO引脚*/
		GPIO_InitStructure.GPIO_Pin = GPIO_Pin_1;
		/*设置引脚模式为通用推挽输出*/
		GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;   
		/*设置引脚速率为50MHz */   
		GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz; 
		/*调用库函数，初始化GPIO*/
		GPIO_Init(GPIOC, &GPIO_InitStructure);	
		/*选择要控制的GPIO引脚*/
		GPIO_InitStructure.GPIO_Pin = GPIO_Pin_2;
		/*调用库函数，初始化GPIO*/
		GPIO_Init(GPIOB, &GPIO_InitStructure);
		/*选择要控制的GPIO引脚*/
		GPIO_InitStructure.GPIO_Pin = GPIO_Pin_1;
		/*调用库函数，初始化GPIO*/
		GPIO_Init(GPIOC, &GPIO_InitStructure);
}
```

参数：**GPIO_InitStruct**，GPIO的初始化相关结构体。该结构体里的成员变量决定了我们具体的初始化参数。以下进行说明：

              GPIO_Pin：指定具体的io脚，如GPIO_Pin_0，GPIO_Pin_1这样的宏定义。

              GPIO_Mode：指定GPIO的模式，

**输入模式**

		+ 输入浮空： GPIO_Mode_IN_FLOATING
		+  输入上拉： GPIO_Mode_IPU
		+  输入下拉 ：GPIO_Mode_IPD
		+  模拟输入 ：GPIO_Mode_AIN

**输出模式**

            +  开漏输出 GPIO_Mode_Out_OD
            + 推挽输出 GPIO_Mode_Out_PP
            + 复用功能推挽 GPIO_Mode_AF_PP
            +  复用功能开漏 GPIO_Mode_AF_OD

GPIO_Speed：指定IO最快翻转速度，也就是当使用IO产生频率（如PWM）的最大速度：

            + GPIO_Speed_10MHz,
            + GPIO_Speed_2MHz, 
            + GPIO_Speed_50MHz等

#### 示例二:把GPIO配置成输入
> 常规方式按键使用中断触发，本案例很少被使用在按键中。
>

```c
void KEY_Init(void)
{
GPIO_InitTypeDef GPIO_InitStructure;
//结构体定义
RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA|RCC_APB2Periph_GPIOC,ENABLE);
//使能 PORTA,PORTC 时钟
GPIO_InitStructure.GPIO_Pin = GPIO_Pin_15;
//PA15
GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU; 
//设置成上拉输入
GPIO_Init(GPIOA, &GPIO_InitStructure);
//初始化 GPIOA15
GPIO_InitStructure.GPIO_Pin = GPIO_Pin_5;
//PC5
GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU; 
//设置成上拉输入
GPIO_Init(GPIOC, &GPIO_InitStructure);
//初始化 GPIOC5
GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0;
//PA0
GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPD; 
//PA0 设置成输入，默认下拉 
GPIO_Init(GPIOA, &GPIO_InitStructure);
//初始化 GPIOA.0
}
```

#### <font style="color:rgb(51, 51, 51);">示例三:配置复用功能 PA9 PA10 配置成串口1的收发接口</font>
```c
    GPIO_InitTypeDef GPIO_InitStructure;
    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOA,ENABLE);//使能GPIOA时钟
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_USART1,ENABLE);//使能USART1时钟
    //串口1对应引脚复用映射
    GPIO_PinAFConfig(GPIOA,GPIO_PinSource9,GPIO_AF_USART1);//GPIOA9复用为USART1
    GPIO_PinAFConfig(GPIOA,GPIO_PinSource10,GPIO_AF_USART1);//GPIOA10复用为USART1
    //USART1端口配置
    GPIO_InitStructure.GPIO_Pin= GPIO_Pin_9 | GPIO_Pin_10; //GPIOA9与GPIOA10
    GPIO_InitStructure.GPIO_Mode= GPIO_Mode_AF;//复用功能
    GPIO_InitStructure.GPIO_Speed= GPIO_Speed_50MHz;      //速度50MHz
    GPIO_InitStructure.GPIO_OType= GPIO_OType_PP; //推挽复用输出
    GPIO_InitStructure.GPIO_PuPd= GPIO_PuPd_UP; //上拉
    GPIO_Init(GPIOA,&GPIO_InitStructure);//初始化PA9，PA10
```

# 四、外部中断
### 1、常用函数
>void EXTI_DeInit(void); 重设为缺省值
void EXTI_Init(EXTI_InitTypeDef* EXTI_InitStruct); 根据EXTI_InitStruct结构体的配置进行初始化
void EXTI_StructInit(EXTI_InitTypeDef* EXTI_InitStruct);把结构体变量的每一个变量按照缺省值填入。
void EXTI_GenerateSWInterrupt(uint32_t EXTI_Line);产生一个中断
FlagStatus EXTI_GetFlagStatus(uint32_t EXTI_Line);获取指定的EXTI线路挂起的标志位
void EXTI_ClearFlag(uint32_t EXTI_Line);清楚EXTI的挂起标志位
ITStatus EXTI_GetITStatus(uint32_t EXTI_Line);检查指定的EXTI线路触发请求发送与否
void EXTI_ClearITPendingBit(uint32_t EXTI_Line);清楚EXTI线路挂起位

---

voidNVIC_PriorityGroupConfig(uint32_t NVIC_PriorityGroup)<font style="color:rgb(77, 77, 77);">中断优先级分组</font>

| **<font style="color:rgb(79, 79, 79);">分组号</font>** | **<font style="color:rgb(79, 79, 79);">4 bit 分配情况</font>** | **<font style="color:rgb(79, 79, 79);">说明</font>** |
| :---: | :---: | :---: |
| <font style="color:rgb(79, 79, 79);">第0组</font> | <font style="color:rgb(79, 79, 79);">0 : 4</font> | <font style="color:rgb(79, 79, 79);">无抢占式优先级，16 个子优先级</font> |
| <font style="color:rgb(79, 79, 79);">第1组</font> | <font style="color:rgb(79, 79, 79);">1 : 3</font> | <font style="color:rgb(79, 79, 79);">2 个抢占式优先级，8 个子优先级</font> |
| <font style="color:rgb(79, 79, 79);">第2组</font> | <font style="color:rgb(79, 79, 79);">2 : 2</font> | <font style="color:rgb(79, 79, 79);">4 个抢占式优先级，4 个子优先级</font> |
| <font style="color:rgb(79, 79, 79);">第3组</font> | <font style="color:rgb(79, 79, 79);">3 : 1</font> | <font style="color:rgb(79, 79, 79);">8 个抢占式优先级，2 个子优先级</font> |
| <font style="color:rgb(79, 79, 79);">第4组</font> | <font style="color:rgb(79, 79, 79);">4 : 0</font> | <font style="color:rgb(79, 79, 79);">16 个抢占式优先级，无子优先级</font> |


> 如果用户没有设置优先级分组，即用户没有调用">NVIC_PriorityGroupConfig(uint32_t NVIC_PriorityGroup)则优先级分组默认设置为分组 0，即无抢占式优先级、16个子优先级。
> NVIC_Init(&NVIC_InitStruct); 根据NVIC_InitStruct结构体的配置进行初始化

### 设计框图
![](/images/posts/STM32单片机外设初始化例程/5.png)

![](/images/posts/STM32单片机外设初始化例程/6.png)

### 例程代码
**<font style="color:rgb(77, 77, 77);">相关配置代码的介绍</font>**

```c
//0、初始化GPIO
GPIO_InitTypeDef GPIO_InitStructure;
GPIO_StructInit(&GPIO_InitStructure);
GPIO_InitStructure.GPIO_Pin = Z_GPIO_PIN;
GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; //浮空输入
GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
GPIO_Init(Z_GPIO_PORT, &GPIO_InitStructure);
RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO,ENABLE);	//使能复用功能时钟
RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA | RCC_APB2Periph_GPIOB, ENABLE);
//1.配置中断线
EXTI_InitTypeDef EXTI_InitStruct;//创建结构体来初始化中断线
EXTI_ClearITPendingBit(EXTI_Line9);     //清除中断标志位
GPIO_EXTILineConfig(GPIO_PortSourceGPIOC, GPIO_PinSource5);
EXTI_InitStructure.EXTI_Line = EXTI_Line13;//选择EXTI的信号源
EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;/* EXTI为中断模式 */
EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;/* 下降沿中断 */
EXTI_InitStructure.EXTI_LineCmd = ENABLE;/* 使能中断 */	
EXTI_Init(&EXTI_InitStructure);
//2.配置NVIC中断优先级
NVIC_InitTypeDef NVIC_InitStructure;//创建结构体来初始化中断优先级
NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);//配置分组号
NVIC_InitStruct.NVIC_IRQChannel = EXTI0_IRQn;
//使能按键所在的外部中断通道
NVIC_InitStruct.NVIC_IRQChannelCmd = ENABLE;
NVIC_InitStruct.NVIC_IRQChannelPreemptionPriority = 0x02;//设置抢占优先级
NVIC_InitStruct.NVIC_IRQChannelSubPriority = 0x01;//设置子优先级
NVIC_Init(&NVIC_InitStruct);
//3.实现中断服务函数（注意配置完之后清除函数的挂起）
void EXTI0_IRQHandler(void)
{
	delay_ms(10); //消抖?
	if (WK_UP == 1)
	{
		LED0 = 1;//led函数宏
		LED1 = 1;
	}
	EXTI_ClearITPendingBit(EXTI_Line0); //清除 EXTI0 线路挂起，清除位
}

```

> NVIC_InitTypeDef 结构体中间有四个成员变量，这四个成员变量的作用是：
>
> + NVIC_IRQChannel：定义初始化的是哪个中断，这个我们可以在 stm32f10x.h 中找到每个中断对应的名字。
> + NVIC_IRQChannelPreemptionPriority：定义这个中断的抢占优先级别。
> + NVIC_IRQChannelSubPriority：定义这个中断的子优先级别。
> + NVIC_IRQChannelCmd：使能or失能NVIC
>

> <font >EXTI的配置，EXTI_Trigger这里支持三种模式；</font>
>
> + <font >EXTI_Trigger_Rising 上升沿触发；</font>
> + <font >EXTI_Trigger_Falling 下降沿触发；</font>
> + <font >EXTI_Trigger_Rising_Falling 上升沿和下降沿都可以触发；</font>
>

**中断服务函数在stm32f10x_it.c中编写，在汇编文件中查询**

#### 完整代码
```c
void CountSensor_Init(void)
{
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB, ENABLE);
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO, ENABLE);
	
	GPIO_InitTypeDef GPIO_InitStructure;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_14;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOB, &GPIO_InitStructure);
	
	GPIO_EXTILineConfig(GPIO_PortSourceGPIOB, GPIO_PinSource14);
	
	EXTI_InitTypeDef EXTI_InitStructure;
	EXTI_InitStructure.EXTI_Line = EXTI_Line14;
	EXTI_InitStructure.EXTI_LineCmd = ENABLE;
	EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
	EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;
	EXTI_Init(&EXTI_InitStructure);
	
	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);
	
	NVIC_InitTypeDef NVIC_InitStructure;
	NVIC_InitStructure.NVIC_IRQChannel = EXTI15_10_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
	NVIC_Init(&NVIC_InitStructure);
}
void EXTI15_10_IRQHandler(void)
{
	if (EXTI_GetITStatus(EXTI_Line14) == SET)
	{
		if (GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_14) == 0)
		{
			CountSensor_Count ++;
		}
		EXTI_ClearITPendingBit(EXTI_Line14);
	}
}
```

# 五、定时器
### 1、常用函数
>void TIM_DeInit
void TIM_TimeBaseInit
void TIM_OC1Init
void TIM_OC2Init
void TIM_OC3Init
void TIM_OC4Init
void TIM_ICInit
void TIM_PWMIConfig
void TIM_BDTRConfig
void TIM_TimeBaseStructInit
void TIM_OCStructInit
void TIM_ICStructInit
void TIM_BDTRStructInit
void TIM_Cmd
void TIM_CtrlPWMOutputs
void TIM_ITConfig
void TIM_GenerateEvent
void TIM_DMAConfig
void TIM_DMACmd
void TIM_InternalClockConfig
void TIM_ITRxExternalClockConfig
void TIM_TIxExternalClockConfig
void TIM_ETRClockMode1Config
void TIM_ETRClockMode2Config
void TIM_ETRConfig
void TIM_PrescalerConfig
void TIM_CounterModeConfig
void TIM_SelectInputTrigger
void TIM_EncoderInterfaceConfig
void TIM_ForcedOC1Config
void TIM_ForcedOC2Config
void TIM_ForcedOC3Config
void TIM_ForcedOC4Config
void TIM_ARRPreloadConfig
void TIM_SelectCOM
void TIM_SelectCCDMA
void TIM_CCPreloadControl
void TIM_OC1PreloadConfig
void TIM_OC2PreloadConfig
void TIM_OC3PreloadConfig
void TIM_OC4PreloadConfig
void TIM_OC1FastConfig
void TIM_OC2FastConfig
void TIM_OC3FastConfig
void TIM_OC4FastConfig
void TIM_ClearOC1Ref
void TIM_ClearOC2Ref
void TIM_ClearOC3Ref
void TIM_ClearOC4Ref
void TIM_OC1PolarityConfig
void TIM_OC1NPolarityConfig
void TIM_OC2PolarityConfig
void TIM_OC2NPolarityConfig
void TIM_OC3PolarityConfig
void TIM_OC3NPolarityConfig
void TIM_OC4PolarityConfig(TIM_TypeDef* TIMx, uint16_t TIM_OCPolarity);
void TIM_CCxCmd(TIM_TypeDef* TIMx, uint16_t TIM_Channel, uint16_t TIM_CCx);
void TIM_CCxNCmd(TIM_TypeDef* TIMx, uint16_t TIM_Channel, uint16_t TIM_CCxN);
void TIM_SelectOCxM(TIM_TypeDef* TIMx, uint16_t TIM_Channel, uint16_t TIM_OCMode);
void TIM_UpdateDisableConfig(TIM_TypeDef* TIMx, FunctionalState NewState);
void TIM_UpdateRequestConfig(TIM_TypeDef* TIMx, uint16_t TIM_UpdateSource);
void TIM_SelectHallSensor(TIM_TypeDef* TIMx, FunctionalState NewState);
void TIM_SelectOnePulseMode(TIM_TypeDef* TIMx, uint16_t TIM_OPMode);
void TIM_SelectOutputTrigger(TIM_TypeDef* TIMx, uint16_t TIM_TRGOSource);
void TIM_SelectSlaveMode(TIM_TypeDef* TIMx, uint16_t TIM_SlaveMode);
void TIM_SelectMasterSlaveMode(TIM_TypeDef* TIMx, uint16_t TIM_MasterSlaveMode);
void TIM_SetCounter(TIM_TypeDef* TIMx, uint16_t Counter);
void TIM_SetAutoreload(TIM_TypeDef* TIMx, uint16_t Autoreload);
void TIM_SetCompare1(TIM_TypeDef* TIMx, uint16_t Compare1);
void TIM_SetCompare2(TIM_TypeDef* TIMx, uint16_t Compare2);
void TIM_SetCompare3(TIM_TypeDef* TIMx, uint16_t Compare3);
void TIM_SetCompare4(TIM_TypeDef* TIMx, uint16_t Compare4);
void TIM_SetIC1Prescaler(TIM_TypeDef* TIMx, uint16_t TIM_ICPSC);
void TIM_SetIC2Prescaler(TIM_TypeDef* TIMx, uint16_t TIM_ICPSC);
void TIM_SetIC3Prescaler(TIM_TypeDef* TIMx, uint16_t TIM_ICPSC);
void TIM_SetIC4Prescaler(TIM_TypeDef* TIMx, uint16_t TIM_ICPSC);
void TIM_SetClockDivision(TIM_TypeDef* TIMx, uint16_t TIM_CKD);
uint16_t TIM_GetCapture1(TIM_TypeDef* TIMx);
uint16_t TIM_GetCapture2(TIM_TypeDef* TIMx);
uint16_t TIM_GetCapture3(TIM_TypeDef* TIMx);
uint16_t TIM_GetCapture4(TIM_TypeDef* TIMx);
uint16_t TIM_GetCounter(TIM_TypeDef* TIMx);
uint16_t TIM_GetPrescaler(TIM_TypeDef* TIMx);
FlagStatus TIM_GetFlagStatus(TIM_TypeDef* TIMx, uint16_t TIM_FLAG);
void TIM_ClearFlag(TIM_TypeDef* TIMx, uint16_t TIM_FLAG);
ITStatus TIM_GetITStatus(TIM_TypeDef* TIMx, uint16_t TIM_IT);
void TIM_ClearITPendingBit(TIM_TypeDef* TIMx, uint16_t TIM_IT);

### 设计框图
 

| 类型 | 编号 | 总线 | 功能 |
| :---: | :---: | :---: | :---: |
| <font style="color:black;">高级定时器</font> | <font style="color:black;">TIM1</font><font style="color:black;">、</font><font style="color:black;">TIM8</font> | <font style="color:black;">APB2</font> | <font style="color:black;">拥有通用定时器全部功能，并额外具有重复计数器、死区生成、互补输出、刹车输入等功能</font> |
| <font style="color:black;">通用定时器</font> | <font style="color:black;">TIM2</font><font style="color:black;">、</font><font style="color:black;">TIM3</font><font style="color:black;">、</font><font style="color:black;">TIM4</font><font style="color:black;">、</font><font style="color:black;">TIM5</font> | <font style="color:black;">APB1</font> | <font style="color:black;">拥有基本定时器全部功能，并额外具有内外时钟源选择、输入捕获、输出比较、编码器接口、主从触发模式等功能</font> |
| <font style="color:black;">基本定时器</font> | <font style="color:black;">TIM6</font><font style="color:black;">、</font><font style="color:black;">TIM7</font> | <font style="color:black;">APB1</font> | <font style="color:black;">拥有定时中断、主模式触发</font><font style="color:black;">DAC</font><font style="color:black;">的功能</font> |

![](/images/posts/STM32单片机外设初始化例程/7.png)
![](/images/posts/STM32单片机外设初始化例程/8.png)
![](/images/posts/STM32单片机外设初始化例程/9.png)


### 例程代码
定时器中断实现步骤

① 能定时器时钟。

       RCC_APB1PeriphClockCmd();

②  初始化定时器，配置ARR,PSC。

      TIM_TimeBaseInit();

③开启定时器中断，配置NVIC。

      void TIM_ITConfig();

      NVIC_Init();

④  使能定时器。

      TIM_Cmd();

⑥  编写中断服务函数。

      TIMx_IRQHandler();

```c
void TIM3_Int_Init(u16 arr,u16 psc)
{
    TIM_TimeBaseInitTypeDef  TIM_TimeBaseStructure;
	NVIC_InitTypeDef NVIC_InitStructure;
 
	RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM3, ENABLE); //时钟使能
	TIM_InternalClockConfig(TIM3);
	//定时器TIM3初始化
	TIM_TimeBaseInitStructure.TIM_Period = 10000 - 1; //设置在下一个更新事件装入活动的自动重装载寄存器周期的值	
	TIM_TimeBaseInitStructure.TIM_Prescaler = 7200 - 1; //设置用来作为TIMx时钟频率除数的预分频值
	TIM_TimeBaseStructure.TIM_ClockDivision = TIM_CKD_DIV1; //设置时钟分割:TDTS = Tck_tim
	TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;  //TIM向上计数模式
	TIM_TimeBaseInit(TIM3, &TIM_TimeBaseStructure); //根据指定的参数初始化TIMx的时间基数单位

    TIM_ClearFlag(TIM3, TIM_FLAG_Update);//清除标志位
	TIM_ITConfig(TIM3,TIM_IT_Update,ENABLE ); //使能指定的TIM3中断,允许更新中断
 
	//中断优先级NVIC设置
    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);//选择分组
	NVIC_InitStructure.NVIC_IRQChannel = TIM3_IRQn;  //TIM3中断
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;  //先占优先级0级
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3;  //从优先级3级
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE; //IRQ通道被使能
	NVIC_Init(&NVIC_InitStructure);  //初始化NVIC寄存器
 
 
	TIM_Cmd(TIM3, ENABLE);  //使能TIMx					 
}
//定时器3中断服务程序
void TIM3_IRQHandler(void)   //TIM3中断
{
	if (TIM_GetITStatus(TIM3, TIM_IT_Update) != RESET)  //检查TIM3更新中断发生与否
		{
		TIM_ClearITPendingBit(TIM3, TIM_IT_Update  );  //清除TIMx更新中断标志 
		LED1=!LED1;
		}
}
```

