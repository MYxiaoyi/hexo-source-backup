---
title: ROS学习
mermaid: true
date: 2024-03-22
tags: [嵌入式, C语言, 笔记, python, linux, ros]
comments: true
categories: [嵌入式]
---

1、工作空间

<font style="color:rgba(0, 0, 0, 0.87);">类似的，在ROS机器人开发中，我们针对机器人某些功能进行代码开始时，各种编写的代码、参数、脚本等文件，也需要放置在某一个文件夹里进行管理，这个文件夹在ROS系统中就叫做</font>**<font style="color:rgba(0, 0, 0, 0.87);">工作空间</font>**<font style="color:rgba(0, 0, 0, 0.87);">。</font>

<font style="color:rgba(0, 0, 0, 0.87);">所以工作空间是一个存放项目开发相关文件的文件夹，也是</font>**<font style="color:rgba(0, 0, 0, 0.87);">开发过程中存放所有资料的大本营</font>**<font style="color:rgba(0, 0, 0, 0.87);">。</font>

<font style="color:rgba(0, 0, 0, 0.87);">ROS系统中一个典型的工作空间结构如图所示，这个dev_ws就是工作空间的根目录，里边会有四个子目录，或者叫做四个子空间。</font>

![](/images/posts/ROS学习/1.png)

+ **<font style="color:rgba(0, 0, 0, 0.87);">src，代码空间</font>**<font style="color:rgba(0, 0, 0, 0.87);">，未来编写的代码、脚本，都需要人为的放置到这里；</font>
+ **<font style="color:rgba(0, 0, 0, 0.87);">build，编译空间</font>**<font style="color:rgba(0, 0, 0, 0.87);">，保存编译过程中产生的中间文件；</font>
+ **<font style="color:rgba(0, 0, 0, 0.87);">install，安装空间</font>**<font style="color:rgba(0, 0, 0, 0.87);">，放置编译得到的可执行文件和脚本；</font>
+ **<font style="color:rgba(0, 0, 0, 0.87);">log，日志空间</font>**<font style="color:rgba(0, 0, 0, 0.87);">，编译和运行过程中，保存各种警告、错误、信息等日志。</font>

<font style="color:rgba(0, 0, 0, 0.87);">总体来讲，这四个空间的文件夹，我们绝大部分操作都是在src中进行的，编译成功后，就会执行install里边的结果，build和log两个文件夹用的很少。</font>

## **<font style="color:rgba(0, 0, 0, 0.87);">创建工作空间</font>**
<font style="color:rgba(0, 0, 0, 0.87);">了解了工作空间的概念和结果，接下来我们可以使用如下命令创建一个工作空间，并且下载教程的代码：</font>



```plain
$ mkdir -p ~/dev_ws/src
$ cd ~/dev_ws/src
$ git clone https://gitee.com/guyuehome/ros2_21_tutorials.git
```

## **<font style="color:rgba(0, 0, 0, 0.87);">自动安装依赖</font>**
<font style="color:rgba(0, 0, 0, 0.87);">我们从社区中下载的各种代码，多少都会有一些依赖，我们可以手动一个一个安装，也可以使用rosdep工具自动安装：</font>



```plain
$ sudo apt install -y python3-pip
$ sudo pip3 install rosdepc
$ sudo rosdepc init
$ rosdepc update
$ cd ..
$ rosdepc install -i --from-path src --rosdistro humble -y
```

## **<font style="color:rgba(0, 0, 0, 0.87);">编译工作空间</font>**
<font style="color:rgba(0, 0, 0, 0.87);">依赖安装完成后，就可以使用如下命令编译工作空间啦，如果有缺少的依赖，或者代码有错误，编译过程中会有报错，否则编译过程应该不会出现任何错误：</font>



```plain
$ sudo apt install python3-colcon-ros
$ cd ~/dev_ws/
$ colcon build
```

<font style="color:rgba(0, 0, 0, 0.87);">编译成功后，就可以在工作空间中看到自动生产的build、log、install文件夹了。</font>

## **<font style="color:rgba(0, 0, 0, 0.87);">创建功能包</font>**
<font style="color:rgba(0, 0, 0, 0.87);">如何在ROS2中创建一个功能包呢？我们可以使用这个指令：</font>



```plain
$ ros2 pkg create --build-type <build-type> <package_name>
```

<font style="color:rgba(0, 0, 0, 0.87);">ros2命令中：</font>

+ **<font style="color:rgba(0, 0, 0, 0.87);">pkg</font>**<font style="color:rgba(0, 0, 0, 0.87);">：表示功能包相关的功能；</font>
+ **<font style="color:rgba(0, 0, 0, 0.87);">create</font>**<font style="color:rgba(0, 0, 0, 0.87);">：表示创建功能包；</font>
+ **<font style="color:rgba(0, 0, 0, 0.87);">build-type</font>**<font style="color:rgba(0, 0, 0, 0.87);">：表示新创建的功能包是C++还是Python的，如果使用C++或者C，那这里就跟ament_cmake，如果使用Python，就跟ament_python；</font>
+ **<font style="color:rgba(0, 0, 0, 0.87);">package_name</font>**<font style="color:rgba(0, 0, 0, 0.87);">：新建功能包的名字。</font>

<font style="color:rgba(0, 0, 0, 0.87);">比如在终端中分别创建C++和Python版本的功能包：</font>



```plain
$ cd ~/dev_ws/src
$ ros2 pkg create --build-type ament_cmake learning_pkg_c               # C++
$ ros2 pkg create --build-type ament_python learning_pkg_python # Python
```

## **<font style="color:rgba(0, 0, 0, 0.87);">编译功能包</font>**
<font style="color:rgba(0, 0, 0, 0.87);">在创建好的功能包中，我们可以继续完成代码的编写，之后需要编译和配置环境变量，才能正常运行：</font>



```plain
$ cd ~/dev_ws
$ colcon build   # 编译工作空间所有功能包
$ source install/local_setup.bash
```

## **<font style="color:rgba(0, 0, 0, 0.87);">功能包的结构</font>**
<font style="color:rgba(0, 0, 0, 0.87);">功能包并不是普通的文件夹，那如何判断一个文件夹是否是功能包呢？我们来分析下刚才新创建两个功能包的结构。</font>

### **<font style="color:rgba(0, 0, 0, 0.87);">C++功能包</font>**
<font style="color:rgba(0, 0, 0, 0.87);">首先看下C++类型的功能包，其中必然存在两个文件：</font>**<font style="color:rgba(0, 0, 0, 0.87);">package.xml</font>**<font style="color:rgba(0, 0, 0, 0.87);">和</font>**<font style="color:rgba(0, 0, 0, 0.87);">CMakerLists.txt</font>**<font style="color:rgba(0, 0, 0, 0.87);">。</font>

![](/images/posts/ROS学习/2.png)

<font style="color:rgba(0, 0, 0, 0.87);">package.xml文件的主要内容如下，包含功能包的版权描述，和各种依赖的声明。</font>

![](/images/posts/ROS学习/3.png)

<font style="color:rgba(0, 0, 0, 0.87);">CMakeLists.txt文件是编译规则，C++代码需要编译才能运行，所以必须要在该文件中设置如何编译，使用CMake语法。</font>

![](/images/posts/ROS学习/4.png)

### **<font style="color:rgba(0, 0, 0, 0.87);">Python功能包</font>**
<font style="color:rgba(0, 0, 0, 0.87);">C++功能包需要将源码编译成可执行文件，但是Python语言是解析型的，不需要编译，所以会有一些不同，但也会有这两个文件：</font>**<font style="color:rgba(0, 0, 0, 0.87);">package.xml</font>**<font style="color:rgba(0, 0, 0, 0.87);">和</font>**<font style="color:rgba(0, 0, 0, 0.87);">setup.py</font>**<font style="color:rgba(0, 0, 0, 0.87);">。</font>

![](/images/posts/ROS学习/5.png)

<font style="color:rgba(0, 0, 0, 0.87);">package.xml文件的主要内容和C++版本功能包一样，包含功能包的版权描述，和各种依赖的声明。</font>

![](/images/posts/ROS学习/6.png)

<font style="color:rgba(0, 0, 0, 0.87);">setup.py文件里边也包含一些版权信息，除此之外，还有“entry_points”配置的程序入口，在后续编程讲解中，我们会给大家介绍如何使用。</font>

![](/images/posts/ROS学习/7.png)

## **<font style="color:rgba(0, 0, 0, 0.87);">Hello World节点（面向过程）</font>**
<font style="color:rgba(0, 0, 0, 0.87);">ROS2中节点的实现当然是需要编写程序了，我们从Hello World例程开始，先来实现一个最为简单的节点，功能并不复杂，就是循环打印一个“Hello World”字符串到终端中。</font>

### **<font style="color:rgba(0, 0, 0, 0.87);">运行效果</font>**
<font style="color:rgba(0, 0, 0, 0.87);">大家先不要着急看代码，是骡子是马，先拉出来溜溜，我们通过ros2 run命令，运行编译好的课程代码，看下这个节点执行的效果如何，然后再来分析代码的实现过程，做到知其然也知其所以然。</font>



```plain
$ ros2 run learning_node node_helloworld
```

<font style="color:rgba(0, 0, 0, 0.87);">运行成功后，可以在终端中看到循环打印“Hello World”字符串的效果。</font>

![](/images/posts/ROS学习/8.png)

### **<font style="color:rgba(0, 0, 0, 0.87);">代码解析</font>**
<font style="color:rgba(0, 0, 0, 0.87);">这个节点是如何实现的呢？我们来看下代码。</font>

<font style="color:rgba(0, 0, 0, 0.87);">learning_node/node_helloworld.py</font>

```python
#!/usr/bin/env python3 
# -*- coding: utf-8 -*-

"""
@作者: 古月居(www.guyuehome.com)
@说明: ROS2节点示例-发布“Hello World”日志信息, 使用面向过程的实现方式
"""

import rclpy                                   # ROS2 Python接口库
from rclpy.node import Node                    # ROS2 节点类
import time

def main(args=None):                           # ROS2节点主入口main函数
    rclpy.init(args=args)                      # ROS2 Python接口初始化
    node = Node("node_helloworld")             # 创建ROS2节点对象并进行初始化

    while rclpy.ok():                          # ROS2系统是否正常运行
        node.get_logger().info("Hello World")  # ROS2日志输出
        time.sleep(0.5)                        # 休眠控制循环时间

    node.destroy_node()                        # 销毁节点对象    
    rclpy.shutdown()                           # 关闭ROS2 Python接口
```

<font style="color:rgba(0, 0, 0, 0.87);">完成代码的编写后需要设置功能包的编译选项，让系统知道Python程序的入口，打开功能包的setup.py文件，加入如下入口点的配置：</font>

```json
 entry_points={
        'console_scripts': [
         'node_helloworld       = learning_node.node_helloworld:main',
        ],
```

### **<font style="color:rgba(0, 0, 0, 0.87);">创建节点流程</font>**
<font style="color:rgba(0, 0, 0, 0.87);">代码中出现的函数大家未来会经常用到，大家先不用纠结函数的具体使用方法，更重要的是理解节点的编码流程。</font>

<font style="color:rgba(0, 0, 0, 0.87);">总结一下，想要实现一个节点，代码的实现流程是这样做：</font>

+ <font style="color:rgba(0, 0, 0, 0.87);">编程接口初始化</font>
+ <font style="color:rgba(0, 0, 0, 0.87);">创建节点并初始化</font>
+ <font style="color:rgba(0, 0, 0, 0.87);">实现节点功能</font>
+ <font style="color:rgba(0, 0, 0, 0.87);">销毁节点并关闭接口</font>

<font style="color:rgba(0, 0, 0, 0.87);">大家如果有学习过C++或者Pyhton的话，应该可以发现这里我们使用的是面向过程的编程方法，这种方式虽然实现简单，但是对于稍微复杂一点的机器人系统，就很难做到模块化编码。</font>

<font style="color:rgba(0, 0, 0, 0.87);"></font>

{% externalLinkCard "" "https://www.f123.club/" "https://www.f123.club/wp-content/uploads/2021/08/UN77_C6SA5GU39GBAWJ.png" %}

{% heatMapCard %}

{% tagRoulette "记忆衰退,表达欲丧失,更加怠惰,无感,好想睡觉" "🕹️" %}