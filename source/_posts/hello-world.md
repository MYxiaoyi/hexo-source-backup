---
title: Hello World
mermaid: true
date: 2013-12-24 17:49:32
tags:

cover: https://pic4.zhimg.com/v2-b96eb3d286b92f5e388a7e1e94fb19f3_1440w.jpg
sponsor: false # 是否展示赞助二维码？
---

Welcome to [Hexo](http://zespia.tw/hexo)! This is your very first post. Check [documentation](http://zespia.tw/hexo/docs) to learn how to use.



---
![心海元素爆发](https://upload-bbs.miyoushe.com/upload/2023/07/14/79695828/e4ea64c7a7ed5674a1521e5a7379189f_8744269808192540895.png)

{% pullquote  left %}
珊瑚宫心海作为海祇岛的"现人神巫女"，不仅是反抗军的领袖，更是一位精通兵法与治愈之术的智者
{% endpullquote %}
珊瑚宫心海曾言："战争不是目的，而是手段。真正的胜利不在于击败敌人，而在于守护人民的笑容。"这份理念让她在领导反抗军时始终保持清醒的头脑。在《原神》的故事中，珊瑚宫心海展现了非凡的领导才能。
{% pullquote right %}
她以"深海舌鲆鱼"为代号制定的作战计划精妙绝伦，连天领奉行的将领都为之惊叹。
{% endpullquote %}
这种将军事才能与人文关怀结合的特质，使她成为稻妻最受尊敬的人物之一。
**心海的元素爆发"海人化羽"** 不仅能治愈全队，还能召唤 *化海月* 持续恢复生命，体现了她<mark>既是军师也是医者</mark>的双重身份。珊瑚宫心海的神之眼是水系，这象征着她如水般柔韧而不可摧的特质——既能以智慧化解冲突，又能以坚韧抵御压迫心海的命之座"眠龙座"暗示着她体内沉睡的龙族血脉，这也是她能同时掌控治愈与破坏两种力量的原因
{% pullquote left %}
"兵无常势，水无常形"——这是珊瑚宫心海最常引用的兵法精髓，也是她应对眼狩令危机的核心策略
> 在稻妻内战期间，珊瑚宫心海面临巨大压力：
既要抵御幕府军的进攻，又要防止愚人众的渗透，同时还要维持海祇岛民众的生计
> 这种复杂局面下，她展现了超越年龄的政治智慧和战略眼光
![珊瑚宫心海](/images/taichi.svg)
"真正的领袖不在于力量强弱，而在于能否在黑暗中为子民点亮希望的灯火"
{% endpullquote %}

{% pullquote right %}
珊瑚宫心海的战术风格：
```python
def kokomi_strategy(situation):
    if situation.threat_level > 7:
        return "退守+治疗"
    elif resources_adequate(situation):
        return "水母部署+游击战"
    else:
        return "祈雨+谈判"
```
{% endpullquote %}

分析元素战技「海月之誓」：
召唤化海月持续治疗领域内角色  
治疗量基于心海的生命值上限，每2秒恢复一次，持续12秒——这稳定的治疗节奏正如 Pull Quote 在长文中提供的视觉呼吸点探讨「现人神巫女」的宗教含义：海祇大御神奥罗巴斯陨落后，心海作为人神沟通的桥梁，其服饰上的「逆鳞」纹样象征牺牲精神，这与 Pull Quote 自我聚焦以服务全文的定位异曲同工

# H1 珊瑚宫心海
### H3 珊瑚宫心海
#### H4 珊瑚宫心海
##### H5 珊瑚宫心海
###### H6 珊瑚宫心海
> 
>       
>    
> 
>
> 

**加粗文本** 和 *斜体文本*  
~~删除线~~ 和 ++下划线++  
`行内代码` 和 [链接](https://hexo.io)

---


## 列表类型
### 无序列表
- Item 1
- Item 2
  - 子项目 2.1
  - 子项目 2.2

### 有序列表
1. 第一项
2. 第二项
   1. 嵌套项 2.1
   2. 嵌套项 2.2

### 定义列表
HTML
: 超文本标记语言

CSS
: 层叠样式表

---
## 流程图 

```mermaid
graph TD
    subgraph 海祇岛作战指挥系统
        style 珊瑚宫心海 fill:#ffc6e2,stroke:#c38fff,stroke-width:3px,color:#8a2f8f
        style 前线将士 fill:#e6d1ff,stroke:#b56dff
        style 军情回报 fill:#ffd6f0,stroke:#ff7bac
        style 海祇岛作战指挥系统 fill:#ffc6e2,stroke:#c38fff,stroke-width:3px,color:#8a2f8f

        珊瑚宫心海["🐚 珊瑚宫心海"] -->|"💧 作战指令"| 战区部署["🎌 战区部署"]
        战区部署 --> 战区循环["🔁 战区循环"]
        
        subgraph 战区循环
            style 战区循环 fill:#f5e6ff,stroke:#d9a0ff
            指令传达["✉️ 指令传达"] --> 情报传递["✨ 情报传递"]
            subgraph 情报传递[128次加密]
                style 情报传递 fill:#f0d9ff,stroke:#c97bff
                情报加密["📜 情报加密"] --> 信鸽传送["🕊️ 信鸽传送"]
            end
            战况查询["🔍 战况查询"] --> 军情回报["📋 军情回报"]
        end
        
        军情回报 -->|"🌸 战果回报"| 珊瑚宫心海
    end
    
    珊瑚宫心海 --> 作战总结["🌊 战术总结"]
    
    classDef coral fill:#ffc6e2,stroke:#c38fff;
    classDef pink fill:#ffd6f0,stroke:#ff7bac;
    classDef lavender fill:#e6d1ff,stroke:#b56dff;
    classDef command fill:#f0e6ff,stroke:#d9a0ff;
    
    class 珊瑚宫心海,作战总结 coral;
    class 军情回报 pink;
    class 前线将士 lavender;
    class 战区部署,指令传达,情报传递,战况查询 command;
    
    linkStyle 0 stroke:#c38fff,stroke-width:2px;
    linkStyle 1 stroke:#d9a0ff,stroke-width:2px;
    linkStyle 2 stroke:#ff7bac,stroke-width:2px;
```


---

## 表格示例

| 心海特质          | Pull Quote 原则         | 实现效果                     |
|-------------------|------------------------|----------------------------|
| 水系柔韧💧         | 响应式布局             | 自动适应移动端与桌面端       |
| 兵法典籍📚         | 结构化提取             | 精准定位核心内容             |
| 龙族血脉🐉         | CSS 深度定制           | 支持主题化样式扩展           |



> **测试结论**：该插件完美实现了：
> - 复杂内容的优雅呈现
> - 多场景的样式适配
> - 深度定制的扩展能力
> - 情感共鸣的视觉强化

---

## 其他元素
- 缩写：<abbr title="HyperText Markup Language">HTML</abbr>
- 下标：H<sub>2</sub>O
- 上标：E = mc<sup>2</sup>
- 键盘输入：<kbd>Ctrl</kbd>+<kbd>C</kbd>

---

## 美图
![Hexo Logo](/images/banner.webp)

### 分隔线
***
<div style="float: right; margin-left: 20px; margin-bottom: 20px; width: 300px; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(201, 123, 255, 0.3);">
    <img src="https://myxiaoyi.github.io/images/reimu.png" alt="珊瑚宫心海" style="width: 100%;">
    <p style="text-align: center; padding: 10px; background: linear-gradient(to right, #fce6f2, #e6d1ff); color: #7a1f7f; font-weight: bold; margin: 0;">海祇岛军师 - 珊瑚宫心海</p>
</div>

这里是左侧的文本内容。珊瑚宫心海作为海祇岛的"现人神巫女"，不仅是反抗军的领袖，更是一位精通兵法与治愈之术的智者。她以"深海舌鲆鱼"为代号制定的作战计划精妙绝伦，连天领奉行的将领都为之惊叹。

她的元素爆发"海人化羽"不仅能治愈全队，还能召唤化海月持续恢复生命，体现了她既是军师也是医者的双重身份。心海的神之眼是水系，这象征着她如水般柔韧而不可摧的特质——既能以智慧化解冲突，又能以坚韧抵御压迫。

在稻妻内战期间，珊瑚宫心海面临巨大压力：既要抵御幕府军的进攻，又要防止愚人众的渗透，同时还要维持海祇岛民众的生计。这种复杂局面下，她展现了超越年龄的政治智慧和战略眼光。

<div style="clear: both;"></div> <!-- 清除浮动 -->

---

## 代码块
```js
// JavaScript 代码示例
const hexo = require('hexo');
console.log(`Hexo version: ${hexo.version}`);
```

```python
# Python 代码示例
def hello_hexo():
    print("Hello Hexo!")
```

---

## 引用块
> 这是一个引用块  
> 第二行引用内容  
> — *引用来源*

---

## 数学公式 
$$
f(x) = \int_{-\infty}^\infty \hat f(\xi)\,e^{2 \pi i \xi x} \,d\xi
$$

行内公式：$E = mc^2$

---

::: info
This is an info box.
:::

::: tip
This is a tip.
:::

::: warning
This is a warning.
:::

::: danger
This is a dangerous warning.
:::

::: danger STOP
Danger zone, do not proceed
:::

::: details
This is a details block.
:::
---


## 标签插件

> "真正的排版艺术如同心海的兵法——看似云淡风轻，实则每一步都经过精密推演"


---

{% post_link "hello-world" auto %}

{% heatMapCard %}

{% asset_img avatar.webp 个人头像 %}

