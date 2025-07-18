---
title: 关于
date: 2021-09-22 21:01:47
comments: true
---

{% raw %}
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>冯笑一 | 嵌入式工程师</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@400;500;700&family=Press+Start+2P&display=swap" rel="stylesheet">
    <style>      
        bodydiv {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Noto Sans SC', sans-serif;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 1000px;
            width: 100%;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 1;
        }
        
        /* 顶部装饰 */
        .top-decoration {
            height: 8px;
            background: linear-gradient(90deg, #6b11cb97, #81adf8ff, #4ecdc4);
        }
        
        /* 头部区域 */
        .header {
            position: relative;
            padding: 40px;
            background: linear-gradient(rgba(255,255,255,0.95), rgba(255,255,255,0.95)), 
                        url('https://i.pinimg.com/564x/0c/76/7c/0c767c1d9b6d9f1b9b5b0b5c5e5b5b5b.jpg');
            background-size: cover;
            background-position: center;
            text-align: center;
            border-bottom: 1px solid #eee;
        }
        
        .avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 5px solid white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin: 0 auto 20px;
            background: linear-gradient(45deg, #ffffffff, #e0eafcff);
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-size: 60px;
            font-weight: bold;
            overflow: hidden; /* 隐藏图片超出圆形的部分 */
        }
        
        .name {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: #2c3e50;
            position: relative;
            display: inline-block;
        }
        
        .name::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, #6a11cb, #2575fc);
            border-radius: 2px;
        }
        
        .title {
            font-size: 1.5rem;
            color: #556270;
            margin-bottom: 25px;
        }
        
        .intro {
            font-size: 1.2rem;
            line-height: 1.8;
            max-width: 800px;
            margin: 0 auto;
            color: #4a5568;
            background: rgba(255,255,255,0.7);
            padding: 20px;
            border-radius: 15px;
            backdrop-filter: blur(5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .highlight {
            background: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
            padding: 2px 8px;
            border-radius: 5px;
            font-weight: 600;
        }
        
        /* 内容区域 */
        .content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            padding: 40px;
        }
        
        @media (max-width: 768px) {
            .content {
                grid-template-columns: 1fr;
            }
        }
        
        .card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
            border: 1px solid #f0f4f8;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1);
        }
        
        .card-title {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            margin-bottom: 25px;
            color: #2c3e50;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f4f8;
        }
        
        .card-title i {
            margin-right: 12px;
            color: #2575fc;
        }
        
        /* 联系信息 */
        .contact-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
        }
        
        .contact-item {
            display: flex;
            align-items: center;
            padding: 12px 0;
        }
        
        .contact-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            flex-shrink: 0;
        }
        
        .contact-icon i {
            color: white;
            font-size: 20px;
        }
        
        .contact-details {
            flex-grow: 1;
        }
        
        .contact-label {
            font-weight: 600;
            color: #556270;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }
        
        .contact-value {
            font-size: 1.1rem;
            color: #2c3e50;
            font-weight: 500;
        }
        
        /* 兴趣爱好 */
        .hobby-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        
        .hobby-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            padding: 20px;
            background: #f9fbfd;
            border-radius: 12px;
            transition: all 0.3s ease;
        }
        
        .hobby-item:hover {
            background: #eef7ff;
            transform: translateY(-3px);
        }
        
        .hobby-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #4ecdc4 0%, #5563de 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            font-size: 24px;
            color: white;
        }
        
        .hobby-name {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .hobby-desc {
            font-size: 0.9rem;
            color: #718096;
        }
        
        /* 网站信息 */
        .website-info {
            grid-column: span 2;
        }
        
        @media (max-width: 768px) {
            .website-info {
                grid-column: span 1;
            }
        }
        
        .tech-stack {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
            margin: 25px 0;
        }
        
        .tech-item {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        .tech-icon {
            width: 60px;
            height: 60px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 10px;
            font-size: 28px;
            color: #2575fc;
        }
        
        .tech-name {
            font-weight: 600;
            color: #4a5568;
        }
        
        /* 底部区域 */
        .footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 30px;
        }
        
        .social-links {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 20px 0 30px;
        }
        
        .social-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            color: white;
            font-size: 20px;
        }
        
        .social-icon:hover {
            background: #2575fc;
            transform: translateY(-5px);
        }
        
        .copyright {
            margin-top: 20px;
            color: rgba(255,255,255,0.7);
            font-size: 0.9rem;
        }
        
        /* 二次元装饰元素 */
        .anime-element {
            position: absolute;
            z-index: 0;
        }
        
        .element-1 {
            top: 50px;
            left: 5%;
            font-size: 50px;
            transform: rotate(-15deg);
            color: rgba(106, 17, 203, 0.1);
        }
        
        .element-2 {
            top: 100px;
            right: 5%;
            font-size: 40px;
            transform: rotate(15deg);
            color: rgba(37, 117, 252, 0.1);
        }
        
        .element-3 {
            bottom: 100px;
            left: 10%;
            font-size: 45px;
            transform: rotate(10deg);
            color: rgba(78, 205, 196, 0.1);
        }
        
        .element-4 {
            bottom: 150px;
            right: 8%;
            font-size: 55px;
            transform: rotate(-10deg);
            color: rgba(85, 99, 222, 0.1);
        }
        
        /* 按钮样式 */
        .blog-button {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 30px;
            background: linear-gradient(90deg, #6b11cb97, #81adf8ff, #4ecdc4);
            color: white;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(37, 117, 252, 0.3);
        }
        
        .blog-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(37, 117, 252, 0.4);
        }
        
        .blog-button i {
            margin-left: 8px;
        }
        
        /* 动画效果 */
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }
        
        .floating {
            animation: float 4s ease-in-out infinite;
        }
    </style>
</head>
<bodydiv>
    <!-- 二次元装饰元素 -->
    <div class="anime-element element-1">(>ω<)</div>
    <div class="anime-element element-2">(◕‿◕✿)</div>
    <div class="anime-element element-3">(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧</div>
    <div class="anime-element element-4">✧⁺⸜(●′▾‵●)⸝⁺✧</div>
    
    <div class="container">
        <div class="top-decoration"></div>
        
        <div class="header">
            <div class="avatar floating"><img src="/avatar/avatar.webp" alt="冯"/></div>
            <h1 class="name">冯笑一</h1>
            <div class="title">嵌入式软件工程师 | 二次元爱好者 | 原神玩家</div>
            
            <div class="intro">
                <p>你好！我是冯笑一，一名电子信息爱好者，在这里用代码、电路和奇思妙想构建我的"数字乐园"。</p>
                <p>欢迎访问我的个人博客 <span class="highlight">https://f123.club/</span>，这里记录了我在嵌入式开发、硬件设计、物联网探索中的点滴思考与实践。</p>
                <p>如果你也痴迷于芯片的呼吸、电路的脉搏，这里或许能成为你的灵感加油站！</p>
                
                <a href="https://f123.club/" class="blog-button">
                    访问我的博客 <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>
        
        <div class="content">
            <div class="card">
                <h2 class="card-title"><i class="fas fa-id-card"></i> 联系信息</h2>
                <div class="contact-grid">
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="contact-details">
                            <div class="contact-label">电子邮箱</div>
                            <div class="contact-value">qingchunhuoli@live.com</div>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <div class="contact-details">
                            <div class="contact-label">电话</div>
                            <div class="contact-value">188-9694-7665</div>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-birthday-cake"></i>
                        </div>
                        <div class="contact-details">
                            <div class="contact-label">生日</div>
                            <div class="contact-value">1999年6月29日</div>
                        </div>
                    </div>
                    
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="contact-details">
                            <div class="contact-label">所在地</div>
                            <div class="contact-value">中国 · 苏州</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card">
                <h2 class="card-title"><i class="fas fa-heart"></i> 兴趣爱好</h2>
                <div class="hobby-grid">
                    <div class="hobby-item">
                        <div class="hobby-icon">
                            <i class="fas fa-microchip"></i>
                        </div>
                        <h3 class="hobby-name">嵌入式开发</h3>
                        <p class="hobby-desc">探索微控制器与嵌入式系统的无限可能</p>
                    </div>
                    
                    <div class="hobby-item">
                        <div class="hobby-icon">
                            <i class="fas fa-gamepad"></i>
                        </div>
                        <h3 class="hobby-name">原神</h3>
                        <p class="hobby-desc">提瓦特大陆的忠实旅行者</p>
                    </div>
                    
                    <div class="hobby-item">
                        <div class="hobby-icon">
                            <i class="fas fa-headphones"></i>
                        </div>
                        <h3 class="hobby-name">二次元文化</h3>
                        <p class="hobby-desc">动漫、漫画、游戏的深度爱好者</p>
                    </div>
                    
                    <div class="hobby-item">
                        <div class="hobby-icon">
                            <i class="fas fa-laptop-code"></i>
                        </div>
                        <h3 class="hobby-name">物联网开发</h3>
                        <p class="hobby-desc">连接物理世界与数字世界</p>
                    </div>
                </div>
            </div>
            
            <div class="card website-info">
                <h2 class="card-title"><i class="fas fa-globe"></i> 网站信息</h2>
                <p>✨ 欢迎访问我的小窝欢迎━(*｀∀´*)ノ亻! ✨</p>
                
                <div class="tech-stack"> 
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fab fa-github"></i>
                        </div>
                        <div class="tech-name">GitHub</div>
                    </div>
                    
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-paint-brush"></i>
                        </div>
                        <div class="tech-name">Reimu主题</div>
                    </div>
                    
                    <div class="tech-item">
                        <div class="tech-icon">
                            <i class="fas fa-server"></i>
                        </div>
                        <div class="tech-name">GitHub托管</div>
                    </div>
                </div>
                
                <p>本站使用 <span class="highlight">Hexo</span> 静态网站生成器构建，采用 <span class="highlight">Reimu</span> 主题，托管在 <span class="highlight">GitHub Pages</span> 平台上。</p>
                <p>博客内容主要涵盖嵌入式开发、硬件设计、物联网技术以及个人技术思考，同时也会分享一些二次元文化相关内容。</p>
            </div>
        </div>
    </div>

    <script>
        // 添加简单的悬浮动画效果
        document.querySelectorAll('.card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.classList.add('floating');
            });
            
            card.addEventListener('mouseleave', function() {
                this.classList.remove('floating');
            });
        });
    </script>
</bodydiv>
</html>
{% endraw %}

## 📌 我是谁？

- **硬核极客**  
  从焊接到开发智能家居系统，我与电子技术的故事始于童年，却永无终点。

- **开源信徒**  
  热爱分享代码和原理图，坚持用开源精神推动技术普惠。

- **跨界玩家**  
  横跨硬件与软件，从8位单片机到Linux嵌入式，从PCB设计到机器学习，拒绝被标签定义。

---

## 🔍 在这里，你能找到什么？

### 1. 嵌入式开发实战
- **ARM Cortex-M系列**  
  基于STM32、MM32的Bootloader开发、RTOS移植与低功耗优化。
  
- **硬件底层揭秘**  
  中断机制、DMA调优、外设驱动源码解析。
  
- **奇技淫巧**  
  用示波器捕捉电磁漏洞，用Python脚本自动化硬件测试。

### 2. 硬核科普与工具链
- **芯片逆向入门**  
  从拆解到逻辑分析，看懂一颗芯片的"灵魂"。
  
- **EDA工具指南**  
  立创EDA、KiCad、Altium Designer的实战技巧与避坑手册。
  
- **行业观察**  
  RISC-V生态崛起、半导体供应链危机背后的技术逻辑。

---

## 🌟 近期热门文章

1. **[MM32G0001 Bootloader开发全指南](https://f123.club/2025/03/28/%E5%9F%BA%E4%BA%8ECortex-M0%E5%86%85%E6%A0%B8%E7%9A%84Bootloader%E5%BC%80%E5%8F%91%E6%8C%87%E5%8D%97/)**  
   手把手实现Cortex-M0芯片的固件空中升级！
   
2. **[C语言|函数指针作为结构体成员实现成员操作](https://f123.club/2022/11/16/C%E8%AF%AD%E8%A8%80%E5%87%BD%E6%95%B0%E6%8C%87%E9%92%88%E4%BD%9C%E4%B8%BA%E7%BB%93%E6%9E%84%E4%BD%93%E6%88%90%E5%91%98%E5%AE%9E%E7%8E%B0%E6%88%90%E5%91%98%E6%93%8D%E4%BD%9C/)**  
   深入了解C语音机制的精妙之处。
   
3. **[基于VScode使用pyOCD进行单片机调试](https://www.f123.club/posts/pyocd-vscode-debug/)**  
   探索新型调试工具的强大功能。

---

## 🤝 加入讨论，一起玩转技术！

<center>🚀 **为什么关注这个博客？**</center>

- **拒绝纸上谈兵**  
  所有内容均经过实际项目验证，提供可复现的代码与数据。
- **垂直深耕**  
  专注电子技术领域，不做泛泛而谈的"技术搬运工"。

---

## 📬 联系与合作

| 联系方式         | 地址/ID                               |
|------------------|---------------------------------------|
| 📧 **邮箱**       | [qingchunhuoli@live.com](mailto:qingchunhuoli@live.com) |
| 💻 **GitHub**     | [MYxiaoyi](https://github.com/MYxiaoyi) |
| 📺 **哔哩哔哩**   | 搜索"MY_梦翼"                          |
| 💬 **QQ**         | 2028132607                            |



{% externalLinkCard "冯笑一小窝" "https://f123.club/" "https://f123.club/avatar/avatar.webp" %}


{% heatMapCard %}

---
{% tagRoulette "代码,电路,嵌入式,单片机,STM32,ESP32,Arduino,树莓派,物联网,机器人,电子制作,DIY,开源硬件,编程,电子设计,电子技术,电子工程师,电子爱好者,电子发烧友,电子工程师,电子爱好者,电子发烧友,电子工程师,电子爱好者,电子发烧友" "🔧" %}

<center>*—— 在这里，电路与代码交织成诗，平凡器件亦可点亮星辰。*</center>