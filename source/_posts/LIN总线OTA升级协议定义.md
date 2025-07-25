---
title: LIN总线OTA升级协议定义
mermaid: true
date: 2025-07-14
tags: [嵌入式, C语言]
cover: rgba(237, 138, 220, 0.47)
comments: true
categories: [嵌入式]
---

## 一、LIN ID枚举定义
### 1. 基本ID枚举
```c
typedef enum
{
    gID_OtapCmd_c = 0x31,
    gID_OtapGetStatus_c,
    gID_OtapData_c
} lin_id_t;
```

### 2. ID功能说明
+ **gID_OtapCmd_c (0x31)**：LIN主节点指示从节点开始/结束固件传输的命令ID
+ **gID_OtapGetStatus_c**：LIN主节点获取从节点实时状态的状态查询ID
+ **gID_OtapData_c**：LIN主节点向从节点传输实际固件数据的数据传输ID



## 二、命令与状态枚举定义
### 1. gID_OtapCmd_c命令枚举
```c
typedef enum
{
    LIN_OTA_CMD_NONE = 0x00,  // 无命令
    LIN_OTA_CMD_START,        // 开始传输命令
    LIN_OTA_CMD_END,          // 结束传输命令
    LIN_OTA_CMD_CONTINUE      // 继续传输命令
} lin_ota_cmd_c;
```

### 2. gID_OtapGetStatus_c状态枚举
```c
typedef enum
{
    LIN_OTA_STATUS_IDLE = 0x00,   // 空闲状态
    LIN_OTA_STATUS_READY,         // 准备就绪状态
    LIN_OTA_STATUS_RUNNING,       // 传输进行中状态
    LIN_OTA_STATUS_FINISH,        // 传输完成状态
    LIN_OTA_STATUS_ABORT          // 传输中止状态
} lin_ota_status_t;
```



## 三、数据帧格式定义
### 1. 各ID数据帧结构对比
| ID类型 | 数据帧长度 | 数据帧详细定义 |
| --- | --- | --- |
| gID_OtapCmd_c | 8字节 | 传输状态码 + 扇区号(1B) + 固件版本号(2B) + 保留字段(4B) |
| gID_OtapGetStatus_c | 8字节 | 传输状态码 + 扇区号(1B) + 扇区CRC校验码(2B) + 保留字段(4B) |
| gID_OtapData_c | 8字节 | 全部为固件数据(实际传输时可通过多帧拼接实现更大数据量传输) |


### 2. 字段详细说明
+ **传输状态码**：使用`lin_ota_cmd_c`枚举值(仅gID_OtapCmd_c)或`lin_ota_status_t`枚举值(仅gID_OtapGetStatus_c)
+ **扇区号**：指定数据存储的目标扇区(0-255)
+ **固件版本号**：2字节大端序版本号(如0x0100表示1.00版本)
+ **扇区CRC校验码**：2字节大端序CRC校验值，用于验证扇区数据完整性
+ **保留字段**：保留未来扩展使用，当前应置为0



## 四、OTA升级流程详解
### 1. 初始化与开始传输阶段
1. LIN主节点通过`gID_OtapCmd_c`发送开始传输命令：
    - 状态码：`LIN_OTA_CMD_START`
    - 扇区号：0
    - 固件版本号：0x0100(大端序)
    - 保留字段：0x00000000
2. LIN从节点收到命令后进入等待状态，准备接收数据
3. LIN主节点通过`gID_OtapGetStatus_c`查询状态：
    - 期望从节点返回：`LIN_OTA_STATUS_READY`状态码



### 2. 数据传输阶段(以扇区1为例)
4. LIN主节点通过`gID_OtapData_c`发送1K字节固件数据
5. LIN从节点存储数据并计算扇区CRC校验码
6. LIN主节点再次查询状态：
    - 期望从节点返回：`LIN_OTA_STATUS_FINISH`状态码
    - 校验码：扇区1的CRC校验码(大端序)
7. LIN主节点发送继续传输命令到扇区1：
    - 状态码：`LIN_OTA_CMD_CONTINUE`
    - 扇区号：1
    - 固件版本号：0x0100
    - 保留字段：0x00000000
8. 重复步骤4-6直到当前扇区数据传输完成
9. 主节点查询状态应收到：`LIN_OTA_STATUS_FINISH`状态码



### 3. 传输结束阶段
10. 所有扇区数据传输完成后，主节点发送结束命令：
    - 状态码：`LIN_OTA_CMD_END`
    - 扇区号：0
    - 固件版本号：0x0100
    - 保留字段：0x00000000
11. LIN从节点收到结束命令后完成固件升级流程

## 五、图表说明

```mermaid
sequenceDiagram
    participant UI as 用户界面
    participant Updater as OTA升级器
    participant LIN as LIN设备
    
    UI->>Updater: startUpgrade(固件数据, 版本号)
    activate Updater
    Updater->>LIN: 打开设备
    Updater->>LIN: 发送开始命令
    LIN-->>Updater: 准备就绪状态
    
    loop 每个扇区
        Updater->>LIN: 发送继续命令(扇区号)
        
        loop 128次
            Updater->>LIN: 发送数据帧(8字节)
        end
        
        Updater->>LIN: 查询扇区状态
        LIN-->>Updater: 返回完成状态
    end
    
    Updater->>LIN: 发送结束命令
    deactivate Updater
    Updater->>UI: 发送完成信号
    UI->>LIN: 关闭设备
```

### OTA 固件升级流程说明：
1. **初始化升级**  
```mermaid
sequenceDiagram
    UI->>Updater: startUpgrade(固件数据, 版本号)
```
    - 用户界面调用 OTA 升级器，传入固件数据和版本号
2. **LIN 设备准备**  
```mermaid
sequenceDiagram
    Updater->>LIN: 打开设备
    Updater->>LIN: 发送开始命令
    LIN-->>Updater: 准备就绪状态
```
    - 打开 LIN 设备连接  
    - 发送升级开始命令
3. **扇区数据写入**  
4. 
```mermaid
sequenceDiagram
    loop 每个扇区
        Updater->>LIN: 发送继续命令(扇区号)
        loop 128次
            Updater->>LIN: 发送数据帧(8字节)
        end
        Updater->>LIN: 查询扇区状态
        LIN-->>Updater: 返回完成状态
    end
```
    - 循环处理每个扇区（共 128 帧/扇区）  
    - 每帧发送 8 字节数据  
    - 查询并确认扇区写入状态
1. **升级完成**  
```mermaid
sequenceDiagram
    Updater->>LIN: 发送结束命令
    Updater->>UI: 发送完成信号
    UI->>LIN: 关闭设备
```
    - 发送升级结束命令  
    - 通知用户界面升级完成  
    - 关闭 LIN 设备连接

## 六、协议关键点说明
1. **数据分片机制**：由于LIN帧数据域仅8字节，1K数据需通过128帧`gID_OtapData_c`传输
2. **CRC校验机制**：从节点需对每个扇区数据计算CRC并通过`gID_OtapGetStatus_c`返回
3. **版本一致性**：所有命令帧需包含相同的固件版本号以确保版本一致性
4. **错误处理**：当收到`LIN_OTA_STATUS_ABORT`状态码时，主节点应重新发起传输流程

### 关键参数说明：
| 步骤 | 数据量 | 说明 |
| --- | --- | --- |
| 单帧数据 | 8 字节 | LIN 总线标准数据帧大小 |
| 单扇区传输 | 128 帧 | 共 1KB (128×8=1024 字节) |
| 状态确认 | 每扇区结束后 | 确保数据完整写入 |


> **注意事项**：  
>
> 1. 每个扇区写入后必须等待状态确认  
> 2. LIN 设备需实现"准备就绪"和"完成状态"协议  
> 3. 异常处理需包含：超时重传、校验失败回滚等机制
>

{% externalLinkCard "" "https://www.f123.club/" "https://www.f123.club/wp-content/uploads/2021/08/UN77_C6SA5GU39GBAWJ.png" %}

{% heatMapCard %}

{% tagRoulette "记忆衰退,表达欲丧失,更加怠惰,无感,好想睡觉" "🕹️" %}