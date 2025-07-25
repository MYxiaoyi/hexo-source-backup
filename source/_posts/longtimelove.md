---
title: 恋爱倒计时
date: 2023-09-15 12:15:02
cover: https://upload-bbs.miyoushe.com/upload/2024/02/14/292762008/f0cb3676199b75980959b7d972a0771f_384819317620854048.jpg?x-oss-process=image/resize,s_600/quality,q_80/auto-orient,0/interlace,1/format,jpg
sponsor: false # 是否展示赞助二维码？
---

{% raw %}
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>❤️ 恋爱时光 ❤️</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
        }
        
        /* 装饰元素 */
        .heart, .snowflake, .star {
            position: absolute;
            font-size: 24px;
            animation: float 8s infinite ease-in-out;
            z-index: 0;
        }
        
        .heart { color: rgba(255, 0, 0, 0.5); }
        .snowflake { color: rgba(173, 216, 230, 0.7); }
        .star { color: rgba(255, 255, 0, 0.7); }
        
        /* 动画 */
        @keyframes float {
            0% { transform: translateY(0) rotate(0deg); opacity: 0; }
            10% { opacity: 1; }
            90% { opacity: 1; }
            100% { transform: translateY(-100vh) rotate(360deg); opacity: 0; }
        }
        
        @keyframes twinkle {
            0% { opacity: 0.3; transform: scale(0.8); }
            100% { opacity: 1; transform: scale(1.2); }
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        @keyframes slideIn {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        /* 密码保护容器 */
        .password-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 500px;
            width: 90%;
            z-index: 10;
            position: relative;
            animation: slideIn 1s ease-out;
            backdrop-filter: blur(10px);
        }
        
        .password-container h1 {
            color: #e84393;
            margin-bottom: 25px;
            font-size: 2.8rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .password-container p {
            color: #6c5ce7;
            margin-bottom: 30px;
            font-size: 1.2rem;
            line-height: 1.6;
        }
        
        .couple-names {
            font-size: 1.8rem;
            color: #ff6b6b;
            font-weight: bold;
            margin: 20px 0;
            letter-spacing: 2px;
        }
        
        .password-input {
            position: relative;
            margin: 30px 0;
        }
        
        .password-input input {
            width: 100%;
            padding: 18px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 15px;
            font-size: 1.1rem;
            outline: none;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .password-input input:focus {
            border-color: #6c5ce7;
            box-shadow: 0 5px 15px rgba(108, 92, 231, 0.2);
        }
        
        .password-input i {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #a29bfe;
            cursor: pointer;
        }
        
        .submit-btn {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            border: none;
            padding: 18px 40px;
            border-radius: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            width: 100%;
            margin-top: 10px;
        }
        
        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
        }
        
        .hint {
            margin-top: 25px;
            color: #00b894;
            font-size: 0.95rem;
            font-style: italic;
        }
        
        .error-message {
            color: #ff7675;
            margin-top: 15px;
            font-weight: 500;
            height: 20px;
        }
        
        /* 主内容容器 */
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.85);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
            display: none;
            animation: fadeIn 1s ease-out;
        }
        
        .header {
            text-align: center;
            padding: 30px 20px;
            margin-bottom: 30px;
            position: relative;
        }
        
        .header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80%;
            height: 2px;
            background: linear-gradient(90deg, transparent, #ff6b6b, transparent);
        }
        
        .title {
            font-size: 3.5rem;
            margin-bottom: 15px;
            color: #e84393;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .subtitle {
            font-size: 1.2rem;
            color: #6c5ce7;
            font-weight: 500;
        }
        
        .start-date {
            font-size: 1.1rem;
            color: #00b894;
            margin-top: 10px;
            font-weight: 500;
        }
        
        .counter-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 15px;
            margin: 40px 0;
            animation: pulse 2s infinite;
        }
        
        .counter-box {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            border-radius: 15px;
            padding: 20px 15px;
            min-width: 130px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }
        
        .counter-box:hover {
            transform: translateY(-10px);
        }
        
        .counter-value {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 5px;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
        }
        
        .counter-label {
            font-size: 1rem;
            opacity: 0.9;
        }
        
        .events-section {
            margin-top: 50px;
            padding: 20px;
        }
        
        .section-title {
            text-align: center;
            font-size: 2.2rem;
            margin-bottom: 30px;
            color: #e84393;
            position: relative;
            display: inline-block;
            left: 50%;
            transform: translateX(-50%);
            padding: 0 20px;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, #fd79a8, #a29bfe, #55efc4);
            border-radius: 3px;
        }
        
        .lovetimeline {
            position: relative;
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 0;
        }
        
        .lovetimeline::before {
            content: '';
            position: absolute;
            top: 0;
            bottom: 0;
            width: 4px;
            background: linear-gradient(to bottom, #fd79a8, #a29bfe, #55efc4);
            left: 50%;
            margin-left: -2px;
            border-radius: 10px;
        }
        
        .lovetimeline-item {
            position: relative;
            margin-bottom: 50px;
            width: 50%;
            animation: slideIn 0.8s ease-out;
        }
        
        .lovetimeline-item:nth-child(odd) {
            left: 0;
            padding-right: 70px;
            text-align: right;
        }
        
        .lovetimeline-item:nth-child(even) {
            left: 50%;
            padding-left: 70px;
        }
        
        .lovetimeline-content {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .lovetimeline-content:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }
        
        .lovetimeline-item:nth-child(odd) .lovetimeline-content::after {
            content: '';
            position: absolute;
            top: 20px;
            right: -15px;
            border-style: solid;
            border-width: 10px 0 10px 15px;
            border-color: transparent transparent transparent white;
        }
        
        .lovetimeline-item:nth-child(even) .lovetimeline-content::after {
            content: '';
            position: absolute;
            top: 20px;
            left: -15px;
            border-style: solid;
            border-width: 10px 15px 10px 0;
            border-color: transparent white transparent transparent;
        }
        
        .lovetimeline-date {
            font-weight: 600;
            color: #6c5ce7;
            margin-bottom: 10px;
            display: block;
            font-size: 1.1rem;
        }
        
        .lovetimeline-title {
            font-size: 1.4rem;
            margin-bottom: 10px;
            color: #e84393;
        }
        
        .days-after {
            font-size: 0.95rem;
            color: #00b894;
            font-weight: 500;
        }
        
        .icon2 {
            position: absolute;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #fd79a8, #a29bfe);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
        }
        
        .lovetimeline-item:nth-child(odd) .icon2 {
            right: -25px;
            top: 0;
        }
        
        .lovetimeline-item:nth-child(even) .icon2 {
            left: -25px;
            top: 0;
        }
        
        .footer {
            text-align: center;
            padding: 30px;
            margin-top: 30px;
            color: #6c5ce7;
            font-size: 1.1rem;
            font-weight: 500;
        }
        
        /* 响应式设计 */
        @media (max-width: 768px) {
            .password-container {
                padding: 30px;
            }
            
            .password-container h1 {
                font-size: 2.2rem;
            }
            
            .title {
                font-size: 2.5rem;
            }
            
            .counter-box {
                min-width: 100px;
                padding: 15px 10px;
            }
            
            .counter-value {
                font-size: 2rem;
            }
            
            .lovetimeline::before {
                left: 30px;
            }
            
            .lovetimeline-item {
                width: 100%;
                padding-left: 80px !important;
                padding-right: 20px !important;
                left: 0 !important;
                text-align: left !important;
            }
            
            .lovetimeline-item:nth-child(even) .icon2,
            .lovetimeline-item:nth-child(odd) .icon2 {
                left: 5px;
                right: auto;
            }
            
            .lovetimeline-item:nth-child(even) .lovetimeline-content::after,
            .lovetimeline-item:nth-child(odd) .lovetimeline-content::after {
                left: -15px;
                right: auto;
                border-width: 10px 15px 10px 0;
                border-color: transparent white transparent transparent;
            }
        }
        
        @media (max-width: 480px) {
            .password-container {
                padding: 20px;
            }
            
            .password-container h1 {
                font-size: 1.8rem;
            }
            
            .couple-names {
                font-size: 1.4rem;
            }
            
            .title {
                font-size: 2rem;
            }
            
            .counter-box {
                min-width: 80px;
                padding: 12px 8px;
            }
            
            .counter-value {
                font-size: 1.6rem;
            }
            
            .counter-label {
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>
    <!-- 密码保护界面 -->
    <div class="password-container" id="password-container">
        <h1>❤️ 恋爱时光 ❤️</h1>
        <p>这是一份特别的恋爱记录，只属于我们两个人</p>
        
        <div class="couple-names">
            ❄️ 冯笑一 & 韩思宇 🌟
        </div>
        
        <p>请输入密码查看我们的恋爱时光记录</p>
        
        <div class="password-input">
            <input type="password" id="password" placeholder="请输入我们的密码" autocomplete="off">
            <i class="fas fa-lock"></i>
        </div>
        
        <button class="submit-btn" onclick="checkPassword()">
            <i class="fas fa-heart"></i> 进入恋爱时光
        </button>
        
        <div class="error-message" id="error-message"></div>
        
        <div class="hint">
            提示：密码是(8位数字)
        </div>
    </div>
    
    <!-- 主内容容器 -->
    <div class="container" id="main-content">
        <div class="header">
            <h1 class="title">❄️ 冯笑一 ❤️ 韩思宇 🌟</h1>
            <p class="subtitle">记录我们的美好时光</p>
            <p class="start-date">起始时间: 2023年9月15日</p>
        </div>
        
        <div class="counter-container">
            <div class="counter-box">
                <div class="counter-value" id="years">0</div>
                <div class="counter-label">年</div>
            </div>
            <div class="counter-box">
                <div class="counter-value" id="months">0</div>
                <div class="counter-label">月</div>
            </div>
            <div class="counter-box">
                <div class="counter-value" id="days">0</div>
                <div class="counter-label">天</div>
            </div>
            <div class="counter-box">
                <div class="counter-value" id="hours">0</div>
                <div class="counter-label">小时</div>
            </div>
            <div class="counter-box">
                <div class="counter-value" id="minutes">0</div>
                <div class="counter-label">分钟</div>
            </div>
            <div class="counter-box">
                <div class="counter-value" id="seconds">0</div>
                <div class="counter-label">秒</div>
            </div>
        </div>
        
        <div class="events-section">
            <h2 class="section-title">我们的美好回忆</h2>
            
            <div class="lovetimeline" id="lovetimeline">
                <!-- 时间轴内容将通过JS动态生成 -->
            </div>
        </div>
        
        <div class="footer">
            ❤️ 每一天都比前一天更爱你 ❤️
        </div>
    </div>

    <script>
        // 创建装饰元素
        function createDecorations() {
            const body = document.querySelector('body');
            const types = ['heart', 'snowflake', 'star'];
            const emojis = {
                heart: ['❤️', '💖', '💗', '💘', '💝'],
                snowflake: ['❄️', '🌨️', '🌬️'],
                star: ['🌟', '⭐', '✨', '💫']
            };
            
            for (let i = 0; i < 30; i++) {
                const type = types[Math.floor(Math.random() * types.length)];
                const deco = document.createElement('div');
                deco.className = type;
                
                const emojiSet = emojis[type];
                deco.textContent = emojiSet[Math.floor(Math.random() * emojiSet.length)];
                
                deco.style.left = `${Math.random() * 100}vw`;
                deco.style.top = `${Math.random() * 100}vh`;
                deco.style.animationDelay = `${Math.random() * 5}s`;
                deco.style.fontSize = `${Math.random() * 20 + 15}px`;
                
                body.appendChild(deco);
            }
        }
        
        // 更新恋爱计时器
        function updateTimer() {
            const startDate = new Date('2023-09-15T00:00:00');
            const now = new Date();
            
            const diff = now - startDate;
            
            const years = Math.floor(diff / (1000 * 60 * 60 * 24 * 365));
            const months = Math.floor(diff / (1000 * 60 * 60 * 24 * 30.44)) % 12;
            const days = Math.floor(diff / (1000 * 60 * 60 * 24)) % 30;
            const hours = Math.floor(diff / (1000 * 60 * 60)) % 24;
            const minutes = Math.floor(diff / (1000 * 60)) % 60;
            const seconds = Math.floor(diff / 1000) % 60;
            
            document.getElementById('years').textContent = years;
            document.getElementById('months').textContent = months;
            document.getElementById('days').textContent = days;
            document.getElementById('hours').textContent = hours.toString().padStart(2, '0');
            document.getElementById('minutes').textContent = minutes.toString().padStart(2, '0');
            document.getElementById('seconds').textContent = seconds.toString().padStart(2, '0');
        }
        
        // 渲染时间轴事件
        function renderlovetimeline() {
            const events = [
                { title: '第1次表白👩‍❤️‍👨', start: '2023-09-15' },
                { title: '第1次牵手🤝&拥抱💏', start: '2023-10-01' },
                { title: '第1次约会🎉', start: '2023-10-01' },
                { title: '第1次去海边🏖', start: '2023-10-02' },
                { title: '第1次一起睡觉💤', start: '2023-10-28' },
                { title: '一起逛街🛒', start: '2023-12-03' },
                { title: '第1次一起过生日🎂', start: '2023-12-31' },
                { title: '一起跨年💏', start: '2024-01-01' },
                { title: '一起看电影🎞🎞', start: '2024-12-30' }
            ];
            
            const lovetimeline = document.getElementById('lovetimeline');
            const startDate = new Date('2023-09-15');
            
            // 按日期排序
            events.sort((a, b) => new Date(a.start) - new Date(b.start));
            
            events.forEach((event, index) => {
                const eventDate = new Date(event.start);
                const diffTime = eventDate - startDate;
                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                
                const lovetimelineItem = document.createElement('div');
                lovetimelineItem.className = 'lovetimeline-item';
                
                const icon = document.createElement('div');
                icon.className = 'icon2';
                icon.innerHTML = getEventIcon(event.title);
                
                const content = document.createElement('div');
                content.className = 'lovetimeline-content';
                
                const date = document.createElement('span');
                date.className = 'lovetimeline-date';
                date.textContent = formatDate(eventDate);
                
                const title = document.createElement('h3');
                title.className = 'lovetimeline-title';
                title.textContent = event.title;
                
                const daysAfter = document.createElement('p');
                daysAfter.className = 'days-after';
                daysAfter.textContent = `恋爱第 ${diffDays} 天`;
                
                content.appendChild(date);
                content.appendChild(title);
                content.appendChild(daysAfter);
                
                lovetimelineItem.appendChild(icon);
                lovetimelineItem.appendChild(content);
                
                lovetimeline.appendChild(lovetimelineItem);
            });
        }
        
        // 根据事件标题获取图标
        function getEventIcon(title) {
            if (title.includes('表白')) return '💘';
            if (title.includes('牵手') || title.includes('拥抱')) return '💑';
            if (title.includes('约会')) return '💞';
            if (title.includes('海边')) return '🌊';
            if (title.includes('睡觉')) return '🛌';
            if (title.includes('逛街')) return '👫';
            if (title.includes('电影')) return '🎬';
            if (title.includes('生日')) return '🎂';
            if (title.includes('跨年')) return '🎆';
            return '❤️';
        }
        
        // 格式化日期
        function formatDate(date) {
            const year = date.getFullYear();
            const month = date.getMonth() + 1;
            const day = date.getDate();
            return `${year}年${month}月${day}日`;
        }
        
        // 检查密码
        function checkPassword() {
            const password = document.getElementById('password').value;
            const errorMessage = document.getElementById('error-message');
            
            // 正确密码是恋爱纪念日 20230915
            if (password === '20230915') {
                // 隐藏密码容器
                document.getElementById('password-container').style.display = 'none';
                // 显示主内容
                document.getElementById('main-content').style.display = 'block';
                // 渲染时间轴
                renderlovetimeline();
                // 创建装饰元素
                createDecorations();
                // 开始计时器
                setInterval(updateTimer, 1000);
            } else {
                errorMessage.textContent = '密码错误，请再试一次！';
                // 添加抖动效果
                document.getElementById('password').classList.add('shake');
                setTimeout(() => {
                    document.getElementById('password').classList.remove('shake');
                }, 500);
            }
        }
        
        // 初始化
        document.addEventListener('DOMContentLoaded', () => {
            // 添加输入框的回车事件
            document.getElementById('password').addEventListener('keypress', (e) => {
                if (e.key === 'Enter') {
                    checkPassword();
                }
            });
            
            
            
            // 添加抖动动画
            const style = document.createElement('style');
            style.textContent = `
                .shake {
                    animation: shake 0.5s;
                    border-color: #ff7675 !important;
                }
                
                @keyframes shake {
                    0% { transform: translateX(0); }
                    25% { transform: translateX(-10px); }
                    50% { transform: translateX(10px); }
                    75% { transform: translateX(-10px); }
                    100% { transform: translateX(0); }
                }
            `;
            document.head.appendChild(style);
        });
    </script>
</body>
</html>
{% endraw %}