---
title: ESP32-IDF新建工程和创建分区
mermaid: true
date: 2025-06-06
tags: [嵌入式, C语言, 笔记, 单片机]
comments: true
categories: [嵌入式]
---

esp32文件路径：D:/Espressif/frameworks/esp-idf-v5.4.1/components/**

创建工程：<font style="color:rgb(77, 77, 77);">查看->命令面板，在里面搜索create project from extersion template</font>

![](/images/posts/ESP32-IDF新建工程和创建分区/1.png)

<font style="color:rgb(77, 77, 77);">步骤2) 选择要创建工程的路径</font>

![](/images/posts/ESP32-IDF新建工程和创建分区/2.png)

<font style="color:rgb(77, 77, 77);">步骤3）选择工程的类型</font>

![](/images/posts/ESP32-IDF新建工程和创建分区/3.png)

<font style="color:rgb(77, 77, 77);">步骤4）在main.c的app_main函数我们添加一个打印</font><font style="color:rgb(78, 161, 219) !important;">printf</font><font style="color:rgb(77, 77, 77);">  
</font><font style="color:rgb(77, 77, 77);"> </font>![](/images/posts/ESP32-IDF新建工程和创建分区/4.png)

后面就是选择芯片，选择烧入方式，编译下载。

### <font style="color:rgb(79, 79, 79);">创建分区文件</font>
<font style="color:rgb(77, 77, 77);">命令面板 搜索partition table,出来以下画面，我们打开分区编辑器UI</font>

![](/images/posts/ESP32-IDF新建工程和创建分区/5.png)

SDK编辑器设置好对于的文件和flash大小![](/images/posts/ESP32-IDF新建工程和创建分区/6.png)

# <font style="color:rgb(34, 34, 38);">logging库</font>
```c
#include "esp_log.h"
static const char* TAG = "Wireless Link";
void esp32_logging_lib_show()
{
    ESP_LOGE(TAG, "I am error log");
    ESP_LOGW(TAG, "I am warning log");
    ESP_LOGI(TAG, "I am info log");
    ESP_LOGD(TAG, "I am debug log");
    ESP_LOGV(TAG, "I am verbose log");
}
```

#### `**<font style="color:rgb(79, 79, 79);">xTaskCreate</font>**`**<font style="color:rgb(79, 79, 79);"> 函数原型</font>**
`<font style="color:rgb(77, 77, 77);">xTaskCreate</font>`<font style="color:rgb(77, 77, 77);"> 是 </font><font style="color:rgb(78, 161, 219) !important;">FreeRTOS</font><font style="color:rgb(77, 77, 77);"> 中用于创建任务的函数。</font>

```c
BaseType_t xTaskCreate(
    TaskFunction_t pvTaskCode,       // 任务函数指针
    const char * const pcName,       // 任务名称（字符串）
    configSTACK_DEPTH_TYPE usStackDepth, // 任务堆栈大小（以字为单位）
    void *pvParameters,             // 传递给任务函数的参数
    UBaseType_t uxPriority,         // 任务优先级
    TaskHandle_t *pxCreatedTask      // 任务句柄（用于引用任务）
);

xTaskCreate(uart_select_task, "uart_select_task", 4 * 1024, NULL, 5, NULL);
```

### <font style="color:rgb(79, 79, 79);"></font><font style="color:rgb(79, 79, 79);">json基础</font>
<font style="color:rgb(77, 77, 77);">JSON（</font><font style="color:rgb(78, 161, 219) !important;">JavaScript</font><font style="color:rgb(77, 77, 77);"> Object Notation）是一种轻量级的数据交换格式，易于人阅读和编写，同时也易于机器解析和生成。它基于JavaScript的一个子集，但独立于语言，广泛用于Web应用中的数据交换。</font><font style="color:rgb(51, 51, 51);">  
</font><font style="color:rgb(51, 51, 51);">json编程</font>

![](/images/posts/ESP32-IDF新建工程和创建分区/7.png)

<font style="color:rgb(51, 51, 51);">{"FUNC":"HW","OPERATE":"LED_ON","PARAM1":null,"PARAM2":null,"PARAM3":null,"PARAM4":null,"PARAM5":null,"PARAM6":null}</font>

<font style="color:rgb(77, 77, 77);">在ESP IDF中已经集成了json的库，就是</font><font style="color:rgb(78, 161, 219) !important;">cJson</font><font style="color:rgb(77, 77, 77);">，只需要引用这个头文件即可以使用其中的API</font>

```c
#include "cJSON.h"
    /* 解析上位机的json格式 */
    cJSON* parse_json = cJSON_Parse((const char *)shell_string);
 
    if(!parse_json)
    {
        ESP_LOGE(TAG, "Not specific json format:%s\n",shell_string);
        goto exit;
    }
 
    uint8_t* func_value = (uint8_t*)((cJSON *)cJSON_GetObjectItem(parse_json,"FUNC"))->valuestring;
    uint8_t* operate_value = (uint8_t*)((cJSON *)cJSON_GetObjectItem(parse_json,"OPERATE"))->valuestring;
    uint8_t* para1 = (uint8_t*)((cJSON *)cJSON_GetObjectItem(parse_json,"PARAM1"))->valuestring;
    uint8_t* para2 = (uint8_t*)((cJSON *)cJSON_GetObjectItem(parse_json,"PARAM2"))->valuestring;
    uint8_t* para3 = (uint8_t*)((cJSON *)cJSON_GetObjectItem(parse_json,"PARAM3"))->valuestring;
    uint8_t* para4 = (uint8_t*)((cJSON *)cJSON_GetObjectItem(parse_json,"PARAM4"))->valuestring;
    uint8_t* para5 = (uint8_t*)((cJSON *)cJSON_GetObjectItem(parse_json,"PARAM5"))->valuestring;
    uint8_t* para6 = (uint8_t*)((cJSON *)cJSON_GetObjectItem(parse_json,"PARAM6"))->valuestring;
    ESP_UNUSED(para1);
    ESP_UNUSED(para2);
    ESP_UNUSED(para3);
    ESP_UNUSED(para4);
    ESP_UNUSED(para5);
    ESP_UNUSED(para6);
    if(!func_value || !operate_value)
    {
        ESP_LOGE(TAG, "Not specific json format:%s\n",shell_string);
        goto exit;
    }
 
    if(strcmp((const char *)func_value,"HW") == 0)
    {
        if(strcmp((const char *)operate_value,"LED_ON") == 0)
        {
            ESP_LOGD(TAG, "UART PARSE DEBUG:operate LED_ON\n");
            LED_ON;
            goto exit;
        }
 
        if(strcmp((const char *)operate_value,"LED_OFF") == 0)
        {
            ESP_LOGD(TAG, "UART PARSE DEBUG:operate LED_OFF\n");
            LED_OFF;
            goto exit;
        }
 
    }
```

