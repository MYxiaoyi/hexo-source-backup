---
title: QML Fluid Element 动态元素
mermaid: true
date: 2024-03-22
tags: [嵌入式, C++, 笔记,Qt, QML]
comments: true
categories: [嵌入式]
---

**<font style="color:rgb(51, 51, 51);">这章的源代码能够在</font>**[assetts folder](http://qmlbook.org/assets)**<font style="color:rgb(51, 51, 51);">找到。</font>**

<font style="color:rgb(51, 51, 51);">这一章介绍如何控制属性值的变化，通过动画的方式在一段时间内来改变属性值。这项技术是建立一个现代化的平滑界面的基础，通过使用状态和过渡来扩展你的用户界面。每一种状态定义了属性的改变，与动画联系起来的状态改变称作过渡。</font>

# <font style="color:rgb(51, 51, 51);">动画（Animations）</font>
<font style="color:rgb(51, 51, 51);">动画被用于属性的改变。一个动画定义了属性值改变的曲线，将一个属性值变化从一个值过渡到另一个值。动画是由一连串的目标属性活动定义的，平缓的曲线算法能够引发一个定义时间内属性的持续变化。所有在QtQuick中的动画都由同一个计时器来控制，因此它们始终都保持同步，这也提高了动画的性能和显示效果。</font>

**<font style="color:rgb(51, 51, 51);">注意</font>**

**<font style="color:rgb(51, 51, 51);">动画控制了属性的改变，也就是值的插入。这是一个基本的概念，QML是基于元素，属性与脚本的。每一个元素都提供了许多的属性，每一个属性都在等待使用动画。在这本书中你将会看到这是一个壮阔的场景，你会发现你自己在看一些动画时欣赏它们的美丽并且肯定自己的创造性想法。然后请记住：动画控制了属性的改变，每个元素都有大量的属性供你任意使用。</font>**

```python
// animation.qml

import QtQuick 2.5

Image {
    id: root
    source: "assets/background.png"

    property int padding: 40
    property int duration: 4000
    property bool running: false

    Image {
        id: box
        x: root.padding;
        y: (root.height-height)/2
        source: "assets/box_green.png"

        NumberAnimation on x {
            to: root.width - box.width - root.padding
            duration: root.duration
            running: root.running
        }
        RotationAnimation on rotation {
            to: 360
            duration: root.duration
            running: root.running
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.running = true
    }

}
```

<font style="color:rgb(51, 51, 51);">上面的示例显示了应用于 and 属性的简单动画。每个动画的持续时间为 4000 毫秒 （msec），并永远循环。x 上的动画将 x 坐标从对象逐渐移动到 240px。旋转动画从当前角度运行到 360 度。这两个动画并行运行，并在加载 UI 后鼠标点击后立即启动。</font>

<font style="color:rgb(51, 51, 51);">现在你可以通过to属性和duration属性来实现动画效果。或者你可以在opacity或者scale上添加动画作为例子，集成这两个参数，你可以实现火箭逐渐消失在太空中，试试吧!</font>

```python
            PropertyAnimation on opacity {
                to: 0
                duration: root.duration
                running: root.running
            }
```

### <font style="color:rgb(51, 51, 51);">动画元素（Animation Elements）</font>
<font style="color:rgb(51, 51, 51);">有几种类型的动画，每一种都在特定情况下都有最佳的效果，下面列出了一些常用的动画：</font>

+ <font style="color:rgb(51, 51, 51);">PropertyAnimation（属性动画）- 使用属性值改变播放的动画</font>
+ <font style="color:rgb(51, 51, 51);">NumberAnimation（数字动画）- 使用数字改变播放的动画</font>
+ <font style="color:rgb(51, 51, 51);">ColorAnimation（颜色动画）- 使用颜色改变播放的动画</font>
+ <font style="color:rgb(51, 51, 51);">RotationAnimation（旋转动画）- 使用旋转改变播放的动画</font>

<font style="color:rgb(51, 51, 51);">除了上面这些基本和通常使用的动画元素，QtQuick还提供了一切特殊场景下使用的动画：</font>

+ <font style="color:rgb(51, 51, 51);">PauseAnimation（停止动画）- 运行暂停一个动画</font>
+ <font style="color:rgb(51, 51, 51);">SequentialAnimation（顺序动画）- 允许动画有序播放</font>
+ <font style="color:rgb(51, 51, 51);">ParallelAnimation（并行动画）- 允许动画同时播放</font>
+ <font style="color:rgb(51, 51, 51);">AnchorAnimation（锚定动画）- 使用锚定改变播放的动画</font>
+ <font style="color:rgb(51, 51, 51);">ParentAnimation（父元素动画）- 使用父对象改变播放的动画</font>
+ <font style="color:rgb(51, 51, 51);">SmotthedAnimation（平滑动画）- 跟踪一个平滑值播放的动画</font>
+ <font style="color:rgb(51, 51, 51);">SpringAnimation（弹簧动画）- 跟踪一个弹簧变换的值播放的动画</font>
+ <font style="color:rgb(51, 51, 51);">PathAnimation（路径动画）- 跟踪一个元素对象的路径的动画</font>
+ <font style="color:rgb(51, 51, 51);">Vector3dAnimation（3D容器动画）- 使用QVector3d值改变播放的动画</font>

<font style="color:rgb(51, 51, 51);">我们将在后面学习怎样创建一连串的动画。当使用更加复杂的动画时，我们可能需要在播放一个动画时中改变一个属性或者运行一个脚本。对于这个问题，QtQuick提供了一个动作元素：</font>

+ <font style="color:rgb(51, 51, 51);">PropertyAction（属性动作）- 在播放动画时改变属性</font>
+ <font style="color:rgb(51, 51, 51);">ScriptAction（脚本动作）- 在播放动画时运行脚本</font>

<font style="color:rgb(51, 51, 51);">在这一章中我们将会使用一些小的例子来讨论大多数类型的动画。</font>

### <font style="color:rgb(51, 51, 51);">应用动画（Applying Animations）</font>
<font style="color:rgb(51, 51, 51);">动画可以通过以下几种方式来应用：</font>

+ <font style="color:rgb(51, 51, 51);">属性动画 - 在元素完整加载后自动运行</font>
+ <font style="color:rgb(51, 51, 51);">属性动作 - 当属性值改变时自动运行</font>
+ <font style="color:rgb(51, 51, 51);">独立运行动画 - 使用start()函数明确指定运行或者running属性被设置为true（比如通过属性绑定）</font>

<font style="color:rgb(51, 51, 51);">后面我们会谈论如何在状态变换时播放动画。</font>

```plain
Item {
    id: root
    width: container.childrenRect.width
    height: container.childrenRect.height
    property alias text: label.text
    property alias source: image.source
    signal clicked

    Column {
        id: container
        Image {
            id: image
        }
        Text {
            id: label
            width: image.width
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            color: "#ececec"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
```

<font style="color:rgb(51, 51, 51);">为了给图片下面的元素定位，我们使用了Column（列）定位器，并且使用基于列的子矩形（childRect）属性来计算它的宽度和高度（width and height）。我们导出了文本（text）和图形源（source）属性，一个点击信号（clicked signal）。我们使用文本元素的wrapMode属性来设置文本与图像一样宽并且可以自动换行。</font>

**<font style="color:rgb(51, 51, 51);">对象升序。</font>**

<font style="color:rgb(51, 51, 51);">这三个对象都位于相同的 y 位置 （）。他们需要全部前往.他们每个人都使用不同的方法，具有不同的副作用和功能。</font><font style="color:rgb(199, 37, 78);">y=200y=40</font>

```python
 ClickableImageV2 {
        id: greenBox
        x: 40; y: root.height-height
        source: "assets/box_green.png"
        text: "animation on property"
        NumberAnimation on y {
            to: 40; duration: 4000
        }
    }
```

**<font style="color:rgb(51, 51, 51);">第一个对象</font>**

<font style="color:rgb(51, 51, 51);">第一个火箭使用了Animation on 属性变化的策略来完成。动画会在加载完成后立即播放。点击火箭可以重置它回到开始的位置。在动画播放时重置第一个火箭不会有任何影响。在动画开始前的几分之一秒设置一个新的y轴坐标让人感觉挺不安全的，应当避免这样的属性值竞争的变化。</font>

<font style="color:rgb(51, 51, 51);"></font>

<font style="color:rgb(51, 51, 51);"></font>

<font style="color:rgb(51, 51, 51);"></font>

```python
    ClickableImageV2 {
        id: blueBox
        x: (root.width-width)/2; y: root.height-height
        source: "assets/box_blue.png"
        text: "behavior on property"
        Behavior on y {
            NumberAnimation { duration: 4000 }
        }

        onClicked: y = 40
        // random y on each click
//        onClicked: y = 40+Math.random()*(205-40)
    }
```

**<font style="color:rgb(51, 51, 51);">第二个对象</font>**

<font style="color:rgb(51, 51, 51);"></font><font style="color:rgb(51, 51, 51);">第二个火箭使用了behavior on 属性行为策略的动画。这个行为告诉属性值每时每刻都在变化，通过动画的方式来改变这个值。可以使用行为元素的enabled : false来设置行为失效。当你点击这个火箭时它将会开始运行（y轴坐标逐渐移至40）。然后其它的点击对于位置的改变没有任何的影响。你可以试着使用一个随机值（例如 40+(Math.random()*(205-40)）来设置y轴坐标。你可以发现动画始终会将移动到新位置的时间匹配在4秒内完成。</font>

<font style="color:rgb(51, 51, 51);"></font>

<font style="color:rgb(51, 51, 51);"></font>

<font style="color:rgb(51, 51, 51);"></font>

```python
 ClickableImageV2 {
        id: redBox
        x: root.width-width-40; y: root.height-height
        source: "assets/box_red.png"
        onClicked: anim.start()
//        onClicked: anim.restart()

        text: "standalone animation"

        NumberAnimation {
            id: anim
            target: redBox
            properties: "y"
            to: 40
            duration: 4000
        }
    }
```

**<font style="color:rgb(51, 51, 51);">第三个对象</font>**

<font style="color:rgb(51, 51, 51);">第三个火箭使用standalone animation独立动画策略。这个动画由一个私有的元素定义并且可以写在文档的任何地方。点击火箭调用动画函数start()来启动动画。每一个动画都有start()，stop()，resume()，restart()函数。这个动画自身可以比其他类型的动画更早的获取到更多的相关信息。我们只需要定义目标和目标元素的属性需要怎样改变的一个动画。我们定义一个to属性的值，在这个例子中我们也定义了一个from属性的值允许动画可以重复运行。</font>

**<font style="color:rgb(51, 51, 51);">另一个启动/停止一个动画的方法是绑定一个动画的running属性。当需要用户输入控制属性时这种方法非常有用：</font>**

```python
 NumberAnimation {
        ...
        // animation runs when mouse is pressed
        running: area.pressed
    }
    MouseArea {
        id: area
    }
```

## <font style="color:rgb(51, 51, 51);">缓冲曲线（Easing Curves）</font>
<font style="color:rgb(51, 51, 51);">属性值的改变能够通过一个动画来控制，缓冲曲线属性影响了一个属性值改变的插值算法。我们现在已经定义的动画都使用了一种线性的插值算法，因为一个动画的默认缓冲类型是Easing.Linear。在一个小场景下的x轴与y轴坐标改变可以得到最好的视觉效果。一个线性插值算法将会在动画开始时使用from的值到动画结束时使用的to值绘制一条直线，所以缓冲类型定义了曲线的变化情况。精心为一个移动的对象挑选一个合适的缓冲类型将会使界面更加自然，例如一个页面的滑出，最初使用缓慢的速度滑出，然后在最后滑出时使用高速滑出，类似翻书一样的效果。</font>

![](https://cdn.nlark.com/yuque/0/2024/png/33668333/1709691245443-36428021-3abc-43aa-b0dc-6641f71a156c.png)

**<font style="color:rgb(51, 51, 51);">注意：不要过度的使用动画。用户界面动画的设计应该尽量小心，动画是让界面更加生动而不是充满整个界面。眼睛对于移动的东西非常敏感，很容易干扰用户的使用。</font>**

**<font style="color:rgb(51, 51, 51);"></font>**

<font style="color:rgb(51, 51, 51);">在下面的例子中我们将会使用不同的缓冲曲线，每一种缓冲曲线都都使用了一个可点击图片来展示，点击将会在动画中设置一个新的缓冲类型并且使用这种曲线重新启动动画。</font>

```python
// EasingCurves.qml

import QtQuick 2.5
import QtQuick.Layouts 1.2

Rectangle {
    id: root
    width: childrenRect.width
    height: childrenRect.height

    color: '#4a4a4a'
    gradient: Gradient {
        GradientStop { position: 0.0; color: root.color }
        GradientStop { position: 1.0; color: Qt.lighter(root.color, 1.2) }
    }

    ColumnLayout {

        Grid {
            spacing: 8
            columns: 5
            EasingType {
                easingType: Easing.Linear
                title: 'Linear'
                onClicked: {
                    animation.easing.type = easingType
                    box.toggle = !box.toggle
                }
            }
            EasingType {
                easingType: Easing.InExpo
                title: "InExpo"
                onClicked: {
                    animation.easing.type = easingType
                    box.toggle = !box.toggle
                }
            }
            EasingType {
                easingType: Easing.OutExpo
                title: "OutExpo"
                onClicked: {
                    animation.easing.type = easingType
                    box.toggle = !box.toggle
                }
            }
            EasingType {
                easingType: Easing.InOutExpo
                title: "InOutExpo"
                onClicked: {
                    animation.easing.type = easingType
                    box.toggle = !box.toggle
                }
            }
            EasingType {
                easingType: Easing.InOutCubic
                title: "InOutCubic"
                onClicked: {
                    animation.easing.type = easingType
                    box.toggle = !box.toggle
                }
            }
            EasingType {
                easingType: Easing.SineCurve
                title: "SineCurve"
                onClicked: {
                    animation.easing.type = easingType
                    box.toggle = !box.toggle
                }
            }
            EasingType {
                easingType: Easing.InOutCirc
                title: "InOutCirc"
                onClicked: {
                    animation.easing.type = easingType
                    box.toggle = !box.toggle
                }
            }
            EasingType {
                easingType: Easing.InOutElastic
                title: "InOutElastic"
                onClicked: {
                    animation.easing.type = easingType
                    box.toggle = !box.toggle
                }
            }
            EasingType {
                easingType: Easing.InOutBack
                title: "InOutBack"
                onClicked: {
                    animation.easing.type = easingType
                    box.toggle = !box.toggle
                }
            }
            EasingType {
                easingType: Easing.InOutBounce
                title: "InOutBounce"
                onClicked: {
                    animation.easing.type = easingType
                    box.toggle = !box.toggle
                }
            }
        }
        Item {
            height: 80
            Layout.fillWidth: true
            Box {
                id: box
                property bool toggle
                x: toggle?20:root.width-width-20
                anchors.verticalCenter: parent.verticalCenter
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#2ed5fa" }
                    GradientStop { position: 1.0; color: "#2467ec" }
                }
                Behavior on x {
                    NumberAnimation {
                        id: animation
                        duration: 500
                    }
                }
            }
        }
    }
}
```

## <font style="color:rgb(51, 51, 51);">动画分组（Grouped Animations）</font>
<font style="color:rgb(51, 51, 51);">通常使用的动画比一个属性的动画更加复杂。例如你想同时运行几个动画并把他们连接起来，或者在一个一个的运行，或者在两个动画之间执行一个脚本。动画分组提供了很好的帮助，作为命名建议可以叫做一组动画。有两种方法来分组：平行与连续。你可以使用SequentialAnimation（连续动画）和ParallelAnimation（平行动画）来实现它们，它们作为动画的容器来包含其它的动画元素。</font>

![](https://cdn.nlark.com/yuque/0/2024/png/33668333/1709693400013-21b78616-019c-43cc-a4bf-b678236c0aca.png)

```python
    BrightSquare {
        id: root
        width: 300
        height: 200
        property int duration: 3000
        ClickableImageV3 {
            id: rocket
            x: 20; y: 120
            source: "images/rocket2.png"
            onClicked: anim.restart()
        }
        ParallelAnimation {
            id: anim
            NumberAnimation {
                target: rocket
                properties: "y"
                to: 20
                duration: root.duration
                easing.type:Easing.OutExpo
            }
            NumberAnimation {
                target: rocket
                properties: "x"
                to: 160
                duration: root.duration
            }
        }
    }

}
```

<font style="color:rgb(51, 51, 51);">一个连续的动画将会一个一个的运行子动画。</font>

```python
import QtQuick 2.0
BrightSquare {
    id: root
    width: 300
    height: 200
    property int duration: 3000
    ClickableImageV3 {
        id: rocket
        x: 20; y: 120
        source: "assets/rocket2.png"
        onClicked: anim.restart()
    }
    SequentialAnimation {
        id: anim
        NumberAnimation {
            target: rocket
            properties: "y"
            to: 20
            // 60% of time to travel up
            duration: root.duration*0.6
        }
        NumberAnimation {
            target: rocket
            properties: "x"
            to: 160
            // 40% of time to travel sideways
            duration: root.duration*0.4
        }
    }
}
```

<font style="color:rgb(51, 51, 51);">分组动画也可以被嵌套，例如一个连续动画可以拥有两个平行动画作为子动画。我们来看看这个足球的例子。这个动画描述了一个从左向右扔一个球的行为：</font>

![](https://cdn.nlark.com/yuque/0/2024/png/33668333/1709693973021-accb3bf7-e016-4374-b801-b4a3e1475320.png)

<font style="color:rgb(51, 51, 51);">要弄明白这个动画我们需要剖析这个目标的运动过程。我们需要记住这个动画是通过属性变化来实现的动画，下面是不同部分的转换：</font>

+ <font style="color:rgb(51, 51, 51);">从左向右的x坐标转换（X1）。</font>
+ <font style="color:rgb(51, 51, 51);">从下往上的y坐标转换（Y1）然后跟着一个从上往下的Y坐标转换（Y2）。</font>
+ <font style="color:rgb(51, 51, 51);">整个动画过程中360度旋转。</font>

<font style="color:rgb(51, 51, 51);">这个动画将会花掉3秒钟的时间。</font>

<font style="color:rgb(51, 51, 51);">我们使用一个空的基本元素对象（Item）作为根元素，它的宽度为480，高度为300。</font>

```python
import QtQuick 1.1
Item {
    id: root
    width: 480
    height: 300
    property int duration: 3000
    ...
}
```

<font style="color:rgb(51, 51, 51);">我们定义动画的总持续时间作为参考，以便更好的同步各部分的动画。</font>

<font style="color:rgb(51, 51, 51);">下一步我们需需要添加一个背景，在我们这个例子中有两个矩形框分别使用了绿色渐变和蓝色渐变填充。</font>

```python
 Rectangle {
        id: sky
        width: parent.width
        height: 200
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0080FF" }
            GradientStop { position: 1.0; color: "#66CCFF" }
        }
    }
    Rectangle {
        id: ground
        anchors.top: sky.bottom
        anchors.bottom: root.bottom
        width: parent.width
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#00FF00" }
            GradientStop { position: 1.0; color: "#00803F" }
        }
    }
```

<font style="color:rgb(51, 51, 51);">上面部分的蓝色区域高度为200像素，下面部分的区域使用上面的蓝色区域的底作为锚定的顶，使用根元素的底作为底。</font>

<font style="color:rgb(51, 51, 51);">让我们将足球加入到屏幕上，足球是一个图片，位于路径“images/soccer_ball.png”。首先我们需要将它放置在左下角接近边界处。</font>

```python
 Image {
        id: ball
        x: 20; y: 240
        source: "assets/soccer_ball.png"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                ball.x = 20; ball.y = 240
                anim.restart()
            }
        }
    }
```

<font style="color:rgb(51, 51, 51);">图片与鼠标区域连接，点击球将会重置球的状态，并且动画重新开始。</font>

<font style="color:rgb(51, 51, 51);">首先使用一个连续的动画来播放两次的y轴变换和一次x轴。</font>

```python
ParallelAnimation{
               id: anim
               SequentialAnimation {

                       NumberAnimation {
                           target: ball
                           properties: "y"
                           to: 20
                           duration: root.duration * 0.6
                           easing.type:Easing.OutQuad
                       }
                       NumberAnimation {
                           target: ball
                           properties: "y"
                           to: 240
                           duration: root.duration * 0.4
                           easing.type:Easing.InCubic
                       }
                   }
               NumberAnimation { // X1 animation
                          target: ball
                          properties: "x"
                          to: 400
                          duration: root.duration
                      }
           }
```

<font style="color:rgb(51, 51, 51);">在动画总时间的40%的时间里完成上升部分，在动画总时间的60%的时间里完成下降部分，一个动画完成后播放下一个动画。目前还没有使用任何缓冲曲线。缓冲曲线将在后面使用easing curves来添加，现在我们只关心如何使用动画来完成过渡。</font>

<font style="color:rgb(51, 51, 51);">现在我们需要添加x轴坐标转换。x轴坐标转换需要与y轴坐标转换同时进行，所以我们需要将y轴坐标转换的连续动画和x轴坐标转换一起压缩进一个平行动画中。</font>

<font style="color:rgb(51, 51, 51);">最后我们想要旋转这个球，我们需要向平行动画中添加一个新的动画，我们选择RotationAnimation来实现旋转。</font>

```python
 ParallelAnimation {
        id: anim
        SequentialAnimation {
            // ... our Y1, Y2 animation
        }
        NumberAnimation { // X1 animation
            // X1 animation
        }
        RotationAnimation {
            target: ball
            properties: "rotation"
            to: 720
            duration: root.duration
        }
    }
```

<font style="color:rgb(51, 51, 51);">我们已经完成了整个动画链表，然后我们需要给动画提供一个正确的缓冲曲线来描述一个移动的球。对于Y1动画我们使用Easing.OutQuad缓冲曲线，它看起来更像是一个圆周运动。Y2使用了Easing.InCubic缓冲曲线，因为在最后球会发生反弹。（试试使用Easing.InBounce，你会发现反弹将会立刻开始。）。X1和ROT1动画都使用线性曲线。</font>

```python
   Item {
        id: root
        width: 480
        height: 300
        property int duration: 3000
        Rectangle {
               id: sky
               width: parent.width
               height: 200
               gradient: Gradient {
                   GradientStop { position: 0.0; color: "#0080FF" }
                   GradientStop { position: 1.0; color: "#66CCFF" }
               }
           }
           Rectangle {
               id: ground
               anchors.top: sky.bottom
               anchors.bottom: root.bottom
               width: parent.width
               gradient: Gradient {
                   GradientStop { position: 0.0; color: "#00FF00" }
                   GradientStop { position: 1.0; color: "#00803F" }
               }
           }
           Image {
                  id: ball
                  x: 20; y: 240
                  source: "images/soccer_ball.png"
                  MouseArea {
                      anchors.fill: parent
                      onClicked: {
                          ball.x = 20; ball.y = 240 ;ball.rotation = 0
                          anim.restart()
                      }
                  }
              }
           ParallelAnimation{
               id: anim
               SequentialAnimation {

                       NumberAnimation {
                           target: ball
                           properties: "y"
                           to: 20
                           duration: root.duration * 0.6
                           easing.type:Easing.OutQuad
                       }
                       NumberAnimation {
                           target: ball
                           properties: "y"
                           to: 240
                           duration: root.duration * 0.4
                           easing.type:Easing.InCubic
                       }
                   }
               NumberAnimation { // X1 animation
                          target: ball
                          properties: "x"
                          to: 400
                          duration: root.duration
                      }
               RotationAnimation {
                           target: ball
                           properties: "rotation"
                           to: 720
                           duration: root.duration
                       }
           }
    }

```

# <font style="color:rgb(51, 51, 51);">状态与过渡（States and Transitions）</font>
<font style="color:rgb(51, 51, 51);">通常我们将用户界面描述为一种状态。一个状态定义了一组属性的改变，并且会在一定的条件下被触发。另外在这些状态转化的过程中可以有一个过渡，定义了这些属性的动画或者一些附加的动作。当进入一个新的状态时，动作也可以被执行。</font>

## <font style="color:rgb(51, 51, 51);">状态（States）</font>
<font style="color:rgb(51, 51, 51);">在QML中，使用State元素来定义状态，需要与基础元素对象（Item）的states序列属性连接。状态通过它的状态名来鉴别，由组成它的一系列简单的属性来改变元素。默认的状态在初始化元素属性时定义，并命名为“”（一个空的字符串）。</font>

```python
    Item {
        id: root
        states: [
            State {
                name: "go"
                PropertyChanges { ... }
            },
            State {
                name: "stop"
                PropertyChanges { ... }
            }
        ]
    }
```

<font style="color:rgb(51, 51, 51);">状态的改变由分配一个元素新的状态属性名来完成。</font>

**<font style="color:rgb(51, 51, 51);">注意</font>**

**<font style="color:rgb(51, 51, 51);">另一种切换属性的方法是使用状态元素的when属性。when属性能够被设置为一个表达式的结果，当结果为true时，状态被使用</font>**<font style="color:rgb(51, 51, 51);">。</font>

```python
 Item {
        id: root
        states: [
            ...
        ]
        Button {
            id: goButton
            ...
            onClicked: root.state = "go"
        }
    }
```

![]()

<font style="color:rgb(51, 51, 51);">例如一个交通信号灯有两个信号灯。上面的一个信号灯使用红色，下面的信号灯使用绿色。在这个例子中，两个信号灯不会同时发光。让我们看看状态图。</font>

![](https://cdn.nlark.com/yuque/0/2024/png/33668333/1709696409604-e3c522b7-fdc2-4fed-ac67-bb03633c0dcb.png)

<font style="color:rgb(51, 51, 51);">当系统启动时，它会自动切换到停止模式作为默认状态。停止状态改变了light1为红色并且light2为黑色（关闭）。一个外部的事件能够触发现在的状态变换为“go”状态。在go状态下，我们改变颜色属性，light1变为黑色（关闭），light2变为绿色。</font>

<font style="color:rgb(51, 51, 51);">为了实现这个方案，我们给这两个灯绘制一个用户界面的草图，为了简单起见，我们使用两个包含园边的矩形框，设置园半径为宽度的一半（宽度与高度相同）。</font>

```python
Rectangle {
        id: light1
        x: 25; y: 15
        width: 100; height: width
        radius: width/2
        color: "black"
    }
    Rectangle {
        id: light2
        x: 25; y: 135
        width: 100; height: width
        radius: width/2
        color: "black"
    }
```

<font style="color:rgb(51, 51, 51);">就像在状态图中定义的一样，我们有一个“go”状态和一个“stop”状态，它们将会分别将交通灯改变为红色和绿色。我们设置state属性到stop来确保初始化状态为stop状态。</font>

```python
    Item {
        id: root1
        width: 640
        height: 480
        //color: "black"
        states: [
            State {
                name: "stop"
                PropertyChanges {
                    target: light1
                    color: "red"
                }
                PropertyChanges {
                    target: light2
                    color: "black"
                }
            },
            State {
                name: "go"
                PropertyChanges {
                    target: light1
                    color: "black"
                }
                PropertyChanges {
                    target: light2
                    color: "green"
                }
            }
        ]
        state: "stop"
        Rectangle {
            id: light1
            x: 25
            y: 15
            width: 100
            height: width
            radius: width / 2
            color: "black"
        }
        Rectangle {
            id: light2
            x: 25
            y: 135
            width: 100
            height: width
            radius: width / 2
            color: "black"
        }
        Text {
            x: 45
            y: 255
            color: "white"
            text: "红绿灯"
            font.pixelSize: 20
        }

        MouseArea {
            anchors.fill: parent
            onClicked: parent.state = (parent.state == "stop" ? "go" : "stop")
        }
    }
```

![](https://cdn.nlark.com/yuque/0/2024/png/33668333/1709697650715-1ede14db-ef63-4508-aac0-dea1c1b4bb97.png)

## <font style="color:rgb(51, 51, 51);">过渡（Transitions）</font>
<font style="color:rgb(51, 51, 51);">一系列的过渡能够被加入任何元素，一个过渡由状态的改变触发执行。你可以使用属性的from:和to:来定义状态改变的指定过渡。这两个属性就像一个过滤器，当过滤器为true时，过渡生效。你也可以使用“</font>_<font style="color:rgb(51, 51, 51);">”来表示任何状态。例如from:”</font>_<font style="color:rgb(51, 51, 51);">“; to:”*”表示从任一状态到另一个任一状态的默认值，这意味着过渡用于每个状态的切换。</font>

<font style="color:rgb(51, 51, 51);">在这个例子中，我们期望从状态“go”到“stop”转换时实现一个颜色改变的动画。对于从“stop”到“go”状态的改变，我们期望保持颜色的直接改变，不使用过渡。我们使用from和to来限制过渡只在从“go”到“stop”时生效。在过渡中我们给每个灯添加两个颜色的动画，这个动画将按照状态的描述来改变属性。</font>

```python
 transitions: [
                Transition {
                    from: "stop"; to: "go"
                    ColorAnimation { target: light1; properties: "color"; duration: 500 }
                    ColorAnimation { target: light2; properties: "color"; duration: 500 }
                },
                Transition {
                    from: "go"; to: "stop"
                    ColorAnimation { target: light1; properties: "color"; duration: 500 }
                    ColorAnimation { target: light2; properties: "color"; duration: 500 }
                }
            ]
```

![](https://cdn.nlark.com/yuque/0/2024/png/33668333/1709697640118-f659870b-4c97-43a0-8357-65fb884e4a31.png)

<font style="color:rgb(51, 51, 51);">接下来，你可以修改下这个例子，例如缩小未点亮的等来突出点亮的等。为此，你需要在状态中添加一个属性用来缩放，并且操作一个动画来播放缩放属性的过渡。另一个选择是可以添加一个“attention”状态，灯会出现黄色闪烁，为此你需要添加为这个过渡添加一个一秒连续的动画来显示黄色（使用“to”属性来实现，一秒后变为黑色）。也许你也可以改变缓冲曲线来使这个例子更加生动。</font>

<font style="color:rgb(51, 51, 51);"></font>

