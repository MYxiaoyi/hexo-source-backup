---
title: C语言函数指针作为结构体成员实现成员操作
mermaid: true
date: 2022-11-16
tags: [嵌入式, C语言, 技术]
comments: true
categories: [嵌入式]
---
# C语言函数指针与结构体函数指针在嵌入式中的应用

## 一、起因

在嵌入式操作系统开发时，发现非常多的功能实现是基于结构体函数指针实现的。函数指针在嵌入式中的应用非常广泛，常常把函数指针作为结构体的成员、作为函数的参数等。为了填补C语言的基础知识，特此记录学习过程。

在C语言程序中，数据结构和算法是两个基本元素。C语言的基本数据类型、结构体、数组和联合体是数据结构的代表；C语言中的函数则是算法的代表。只有将数据结构和算法有机结合才能构成具有一定功能的程序。

## 二、C语言函数指针基础

### 1. 函数指针定义

函数指针的定义形式为：
```c
returnType (*pointerName)(param list);
```

- `returnType` 为函数返回值类型
- `pointerName` 为指针名称
- `param list` 为函数参数列表

注意：`()`的优先级高于`*`，第一个括号不能省略。

### 2. 基本示例

```c
#include <stdio.h>

// 返回两个数中较大的一个
int max(int a, int b) {
    return a > b ? a : b;
}

int main() {
    int x, y, maxval;
    // 定义函数指针
    int (*pmax)(int, int) = max;  // 也可以写作int (*pmax)(int a, int b)
    
    printf("Input two numbers:");
    scanf("%d %d", &x, &y);
    maxval = (*pmax)(x, y);
    printf("Max value: %d\n", maxval);
    
    return 0;
}
```

### 3. 函数指针定义示例

```c
int add2(int x, int y) {
    return x + y;
}

int main() {
    int (*func)(int, int);
    func = &add2;  // 指针赋值,或者func=add2; add2与&add2意义相同
    printf("func(3,4)=%d\n", func(3, 4));
    
    return 0;
}
```

### 4. 使用typedef定义函数指针类型

```c
typedef int (*FUN)(int, int);
FUN func = &add2;
func();
```

## 三、结构体中定义函数指针

### 1. 结构体指针变量的定义形式

#### 形式1：先定义结构体类型，再定义变量
```c
struct 结构体标识符 {
    成员变量列表;
};
struct 结构体标识符 *指针变量名;
```

#### 形式2：在定义类型的同时定义变量
```c
struct 结构体标识符 {
    成员变量列表;
} *指针变量名;
```

#### 形式3：直接定义变量
```c
struct {
    成员变量列表;
} *指针变量名;
```

### 2. 结构体中指向函数的指针示例

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct student {
    int id;
    char name[50];
    void (*initial)();
    void (*process)(int id, char *name);
    void (*destroy)();
} stu;

void initial() {
    printf("initialization...\n");
}

void process(int id, char *name) {
    printf("process...\n%d\t%s\n", id, name);
}

void destroy() {
    printf("destroy...\n");
}

int main() {
    stu *stu1;
    stu1 = (stu *)malloc(sizeof(stu));
    
    stu1->id = 1000;
    strcpy(stu1->name, "C++");
    stu1->initial = initial;
    stu1->process = process;
    stu1->destroy = destroy;
    
    printf("%d\t%s\n", stu1->id, stu1->name);
    stu1->initial();
    stu1->process(stu1->id, stu1->name);
    stu1->destroy();
    
    free(stu1);
    return 0;
}
```

### 3. 回调函数示例

```c
#include <stdio.h>

typedef struct {
    int a;
    void (*pshow)(int);
} TMP;

void func(TMP *tmp) {
    if(tmp->a > 10) { // 如果a>10,则执行回调函数
        (tmp->pshow)(tmp->a);
    }
}

void show(int a) {
    printf("a的值是%d\n", a);
}

void main() {
    TMP test;
    test.a = 11;
    test.pshow = show;
    func(&test);
}
```

## 四、函数指针的两个主要用途

### 1. 将函数作为参数传递给函数

```c
#include <stdio.h>

// Calculate用于计算积分
double Calculate(double(*func)(double x), double a, double b) {
    double dx = 0.0001; // 细分的区间长度
    double sum = 0;
    
    for(double xi = a+dx; xi <= b; xi += dx) {
        double area = func(xi) * dx;
        sum += area;
    }
    return sum;
}

double func_1(double x) {
    return x * x;
}

double func_2(double x) {
    return x * x * x;
}

void main() {
    printf("%lf\n", Calculate(func_1, 0, 1));
    printf("%lf\n", Calculate(func_2, 0, 1));
}
```

### 2. 引用不在代码段中的函数

在嵌入式系统中，常用于调用固化在ROM中的系统函数。例如编写bootload的跳转函数
```c
#define INFLASH_ADDR_BOOTLOAD   ((uint32_t)0x08000000)  // bootload的起始地址

/* 初始化堆栈指针 */
void MSR_MSP(uint32_t addr) 
{
  __ASM("msr msp, r0");  // set Main Stack value 将主堆栈地址保存到MSP寄存器(R13)中
  __ASM("bx lr");        // 跳转到lr中存放的地址处。bx是强制跳转指令 lr是连接寄存器，是STM32单片机的R14
}

typedef void (*IapFun)(void); // 声明一个函数指针，用于跳转到绝对地址执行程序
IapFun JumpToBootload; 

/*!
 *  功  能: 跳转到应用程序 
 *  param1: 用户代码起始地址
 *  retval: 无返回值
 */
void IapLoadBootload(void)
{
    /*
        应用程序APP中设置把 中断向量表 放置在0x08003000 开始的位置；而中断向量表里第一个放的就是栈顶地址的值
        也就是说，这句话即通过判断栈顶地址值是否正确（是否在0x2000 0000 - 0x 2000 2000之间） 来判断是否应用程序
        已经下载了，因为应用程序的启动文件刚开始就去初始化化栈空间，如果栈顶值对了，说应用程已经下载了启动文件,初始化也执行了；
    */
        
        
	  if( ((*(uint32_t*)INFLASH_ADDR_BOOTLOAD) & 0x2FFE0000) == 0x20000000 )// 检查栈顶地址是否合法,查看参考手册内存章节的SRAM小节
	  { 
        BoardDisableIrq();   // 禁止中断
		    JumpToBootload = (IapFun)*(uint32_t*)(INFLASH_ADDR_BOOTLOAD+4);        // 用户代码区第二个字为程序开始地址(新程序复位地址)		
		    MSR_MSP(*(uint32_t*)INFLASH_ADDR_BOOTLOAD);		                // 初始化APP堆栈指针(用户代码区的第一个字用于存放栈顶地址)
		                                 
        JumpToBootload();	                                    // 设置PC指针为bootload复位中断函数的地址，往下执行
	  }
}
```

## 五、嵌入式系统中结构体函数指针的应用

### 1. 函数指针作为结构体成员

![](/images/posts/C语言函数指针作为结构体成员实现成员操作/1.png)

### 2. 函数指针作为函数的参数

![](/images/posts/C语言函数指针作为结构体成员实现成员操作/2.png)

## 六、使用结构体指针编写回调函数示例

```c
#include <stdio.h>
#include <stdlib.h>

/****************************************
 * 函数指针结构体
 ***************************************/
typedef struct _OP {
    float (*p_add)(float, float); 
    float (*p_sub)(float, float); 
    float (*p_mul)(float, float); 
    float (*p_div)(float, float); 
} OP; 

/****************************************
 * 加减乘除函数
 ***************************************/
float ADD(float a, float b) {
    return a + b;
}

float SUB(float a, float b) {
    return a - b;
}

float MUL(float a, float b) {
    return a * b;
}

float DIV(float a, float b) {
    return a / b;
}

/****************************************
 * 初始化函数指针
 ***************************************/
void init_op(OP *op) {
    op->p_add = ADD;
    op->p_sub = SUB;
    op->p_mul = &MUL;
    op->p_div = &DIV;
}

/****************************************
 * 库函数
 ***************************************/
float add_sub_mul_div(float a, float b, float (*op_func)(float, float)) {
    return (*op_func)(a, b);
}

int main(int argc, char *argv[]) {
    OP *op = (OP *)malloc(sizeof(OP)); 
    init_op(op);
    
    /* 直接使用函数指针调用函数 */ 
    printf("ADD = %f, SUB = %f, MUL = %f, DIV = %f\n", 
           (op->p_add)(1.3, 2.2), 
           (*op->p_sub)(1.3, 2.2), 
           (op->p_mul)(1.3, 2.2), 
           (*op->p_div)(1.3, 2.2));
     
    /* 调用回调函数 */ 
    printf("ADD = %f, SUB = %f, MUL = %f, DIV = %f\n", 
           add_sub_mul_div(1.3, 2.2, ADD), 
           add_sub_mul_div(1.3, 2.2, SUB), 
           add_sub_mul_div(1.3, 2.2, MUL), 
           add_sub_mul_div(1.3, 2.2, DIV));

    return 0; 
}
```

{% tagRoulette "早餐,能量开启,营养均衡,元气满满,唤醒味蕾" "🍳" %}