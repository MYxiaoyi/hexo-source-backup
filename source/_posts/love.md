title: 情侣小游戏
date: 2025-07-13 17:49:32
cover: https://upload-bbs.miyoushe.com/upload/2024/02/14/292762008/f0cb3676199b75980959b7d972a0771f_384819317620854048.jpg?x-oss-process=image/resize,s_600/quality,q_80/auto-orient,0/interlace,1/format,jpg
sponsor: false # 是否展示赞助二维码？
categories: 技术分享,开源项目,工具
---

{% raw %}
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>宝贝专属心动小游戏乐园</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=Dancing+Script:wght@700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Ma Shan Zheng', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #5a3e36;
            min-height: 100vh;
            overflow-x: hidden;
            padding: 20px 10px;
            position: relative;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            position: relative;
            z-index: 10;
        }
        
        header {
            text-align: center;
            padding: 15px 0 25px;
            position: relative;
        }
        
        .title {
            font-size: 2.5rem;
            color: #e84393;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 5px;
            letter-spacing: 3px;
        }
        
        .subtitle {
            font-size: 1.2rem;
            color: #6d214f;
            margin-bottom: 20px;
        }
        
        .heart-divider {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 15px 0;
        }
        
        .heart-divider i {
            color: #e84393;
            margin: 0 5px;
            font-size: 1.2rem;
        }
        
        /* 游戏卡片 */
        .games-container {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .game-card {
            background: rgba(255, 255, 255, 0.85);
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255, 255, 255, 0.3);
        }
        
        .game-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
        }
        
        .game-header {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            border-bottom: 2px dashed #f8a5c2;
            padding-bottom: 10px;
        }
        
        .game-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(45deg, #e84393, #fd79a8);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 1.5rem;
            color: white;
            box-shadow: 0 4px 8px rgba(232, 67, 147, 0.3);
        }
        
        .game-title {
            font-size: 1.6rem;
            color: #e84393;
        }
        
        /* 心情日记 */
        .mood-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 15px;
        }
        
        .mood-btn {
            flex: 1;
            min-width: 70px;
            padding: 8px 5px;
            border-radius: 15px;
            border: none;
            background: #f8a5c2;
            color: white;
            font-family: inherit;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
        }
        
        .mood-btn:hover {
            transform: scale(1.05);
        }
        
        .mood-btn.selected {
            background: #e84393;
            box-shadow: 0 0 0 3px white, 0 0 0 6px #f8a5c2;
        }
        
        .diary-input {
            width: 100%;
            padding: 12px;
            border-radius: 15px;
            border: 2px solid #f8a5c2;
            background: rgba(255, 255, 255, 0.7);
            margin: 10px 0;
            min-height: 100px;
            font-family: inherit;
            font-size: 1rem;
        }
        
        .diary-input:focus {
            outline: none;
            border-color: #e84393;
        }
        
        .save-btn {
            background: linear-gradient(45deg, #e84393, #fd79a8);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            font-size: 1.1rem;
            cursor: pointer;
            display: block;
            margin: 15px auto 0;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(232, 67, 147, 0.3);
        }
        
        .save-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 7px 18px rgba(232, 67, 147, 0.4);
        }
        
        /* 老虎机 */
        .slot-machine {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 20px 0;
        }
        
        .slot {
            width: 70px;
            height: 70px;
            background: linear-gradient(45deg, #6a89cc, #4a69bd);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
            box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.2), 0 5px 10px rgba(0, 0, 0, 0.1);
            border: 3px solid #4a69bd;
        }
        
        .pull-btn {
            background: linear-gradient(45deg, #4a69bd, #1e3799);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-size: 1.1rem;
            cursor: pointer;
            display: block;
            margin: 20px auto 10px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(74, 105, 189, 0.3);
        }
        
        .pull-btn:hover {
            transform: scale(1.05);
        }
        
        .slot-result {
            text-align: center;
            font-size: 1.3rem;
            color: #1e3799;
            margin: 15px 0;
            min-height: 40px;
        }
        
        /* 在线空调 */
        .ac-control {
            text-align: center;
            margin: 20px 0;
        }
        
        .ac-display {
            width: 200px;
            height: 200px;
            background: linear-gradient(45deg, #00cec9, #0984e3);
            border-radius: 20px;
            margin: 0 auto 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            font-size: 1.5rem;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
        }
        
        .ac-display::before {
            content: "";
            position: absolute;
            width: 100%;
            height: 100%;
            background: repeating-linear-gradient(
                transparent,
                transparent 20px,
                rgba(255, 255, 255, 0.1) 22px,
                rgba(255, 255, 255, 0.1) 24px
            );
        }
        
        .temperature {
            font-size: 4rem;
            font-weight: bold;
            margin: 10px 0;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .ac-controls {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 15px;
        }
        
        .ac-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: none;
            background: #0984e3;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        /* 星座运势 */
        .horoscope {
            text-align: center;
        }
        
        .zodiac-select {
            width: 100%;
            padding: 12px;
            border-radius: 15px;
            border: 2px solid #f8a5c2;
            background: rgba(255, 255, 255, 0.7);
            font-family: inherit;
            font-size: 1rem;
            margin: 10px 0 20px;
            color: #5a3e36;
        }
        
        .zodiac-select:focus {
            outline: none;
            border-color: #e84393;
        }
        
        .horoscope-result {
            background: rgba(255, 255, 255, 0.7);
            border-radius: 15px;
            padding: 15px;
            margin-top: 15px;
            min-height: 150px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border: 2px dashed #f8a5c2;
        }
        
        .fortune-text {
            font-size: 1.2rem;
            line-height: 1.6;
        }
        
        .lucky-stars {
            font-size: 1.8rem;
            margin: 15px 0;
            color: gold;
        }
        
        /* 更多游戏 */
        .game-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 15px;
        }
        
        .mini-game {
            background: rgba(255, 255, 255, 0.8);
            border-radius: 20px;
            padding: 20px 15px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border: 2px solid rgba(255, 255, 255, 0.3);
            cursor: pointer;
        }
        
        .mini-game:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        
        .mini-game i {
            font-size: 2.5rem;
            color: #e84393;
            margin-bottom: 10px;
        }
        
        .mini-game h3 {
            font-size: 1.3rem;
            color: #e84393;
        }
        
        footer {
            text-align: center;
            padding: 20px 0 10px;
            color: #6d214f;
            font-size: 0.9rem;
        }
        
        /* 装饰元素 */
        .floating {
            position: absolute;
            z-index: 1;
            animation: floating 3s infinite ease-in-out;
        }
        
        .heart {
            color: rgba(232, 67, 147, 0.4);
            font-size: 2rem;
        }
        
        @keyframes floating {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
            100% { transform: translateY(0px); }
        }
        
        /* 响应式设计 */
        @media (max-width: 480px) {
            .title {
                font-size: 2rem;
            }
            .game-title {
                font-size: 1.4rem;
            }
            .slot {
                width: 60px;
                height: 60px;
                font-size: 1.7rem;
            }
            .ac-display {
                width: 180px;
                height: 180px;
            }
        }
        
        /* 新增游戏样式 */
        .game-detail {
            display: none;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            padding: 20px;
            margin-top: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .game-content {
            padding: 15px;
        }
        
        .back-btn {
            background: linear-gradient(45deg, #00cec9, #0984e3);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 15px;
            display: block;
            margin-left: auto;
        }
        
        .love-calculator {
            text-align: center;
        }
        
        .name-inputs {
            display: flex;
            gap: 10px;
            margin: 15px 0;
        }
        
        .name-input {
            flex: 1;
            padding: 10px;
            border-radius: 15px;
            border: 2px solid #f8a5c2;
            background: rgba(255, 255, 255, 0.7);
            font-family: inherit;
            font-size: 1rem;
        }
        
        .love-result {
            margin: 20px 0;
            font-size: 1.3rem;
        }
        
        .love-percentage {
            font-size: 3rem;
            font-weight: bold;
            color: #e84393;
            margin: 10px 0;
        }
        
        .love-message {
            font-size: 1.2rem;
            color: #6d214f;
        }
        
                .memory-game-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin: 20px 0;
            perspective: 1000px;
        }

        .memory-card {
            width: 100%;
            aspect-ratio: 1/1;
            border-radius: 15px;
            position: relative;
            transform-style: preserve-3d;
            cursor: pointer;
            transition: transform 0.5s ease;
        }

        .memory-card-face {
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 15px;
            backface-visibility: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .memory-card-front {
            background: linear-gradient(45deg, #a18cd1, #fbc2eb);
        }

        .memory-card-back {
            background: linear-gradient(45deg, #ffecd2, #fcb69f);
            transform: rotateY(180deg);
        }

        .memory-card.flipped {
            transform: rotateY(180deg);
        }

        .memory-card.matched .memory-card-back {
            box-shadow: 0 0 15px rgba(232, 67, 147, 0.5);
            filter: brightness(1.1);
        }

        .memory-result {
            text-align: center;
            font-size: 1.3rem;
            margin: 15px 0;
            min-height: 40px;
        }
        
        .dessert-options {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin: 20px 0;
        }
        
        .dessert-option {
            background: rgba(255, 255, 255, 0.7);
            border-radius: 15px;
            padding: 20px 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid #f8a5c2;
        }
        
        .dessert-option:hover {
            transform: scale(1.05);
            background: rgba(248, 165, 194, 0.2);
        }
        
        .dessert-option i {
            font-size: 2.5rem;
            color: #e84393;
            margin-bottom: 10px;
        }
        
        .dessert-result {
            text-align: center;
            margin: 20px 0;
            font-size: 1.2rem;
            min-height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }
        
        .kiss-counter {
            font-size: 3rem;
            color: #e84393;
            margin: 10px 0;
            font-weight: bold;
        }
        
        .kiss-btn {
            background: linear-gradient(45deg, #e84393, #fd79a8);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-size: 1.1rem;
            cursor: pointer;
            margin: 10px auto;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(232, 67, 147, 0.3);
        }
        
        .kiss-btn:hover {
            transform: scale(1.05);
        }
        
        .fortune-cookie {
            width: 150px;
            height: 100px;
            background: #f3e5ab;
            border-radius: 0 50% 50% 50%;
            margin: 0 auto 20px;
            position: relative;
            transform: rotate(45deg);
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            cursor: pointer;
        }
        
        .fortune-cookie:before {
            content: "";
            position: absolute;
            width: 80%;
            height: 20px;
            background: #d4c690;
            border-radius: 10px;
            transform: rotate(-45deg);
        }
        
        .fortune-cookie-text {
            transform: rotate(-45deg);
            font-size: 1.5rem;
            color: #5a3e36;
        }
        
        .fortune-message {
            text-align: center;
            margin-top: 20px;
            font-size: 1.2rem;
            min-height: 80px;
        }
        
        .compatibility-images {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 20px 0;
        }
        
        .compatibility-image {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            overflow: hidden;
            background: linear-gradient(45deg, #ff9a9e, #fad0c4);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
        }
        
        .compatibility-arrow {
            display: flex;
            align-items: center;
            font-size: 2rem;
            color: #e84393;
        }
    </style>
</head>
<body>
    <!-- 飘动的心形装饰 -->
    <div class="floating" style="top: 5%; left: 10%;">
        <i class="fas fa-heart heart"></i>
    </div>
    <div class="floating" style="top: 15%; right: 15%;">
        <i class="fas fa-heart heart"></i>
    </div>
    <div class="floating" style="bottom: 10%; left: 20%;">
        <i class="fas fa-heart heart"></i>
    </div>
    <div class="floating" style="bottom: 15%; right: 10%;">
        <i class="fas fa-heart heart"></i>
    </div>
    
    <div class="container">
        <header>
            <h1 class="title">❤️ 心动小游戏乐园 ❤️</h1>
            <p class="subtitle">专属于韩思宇的甜蜜互动空间</p>
            <div class="heart-divider">
                <i class="fas fa-heart"></i>
                <i class="fas fa-heart"></i>
                <i class="fas fa-heart"></i>
            </div>
        </header>
        
        <div class="games-container">
            <!-- 心情日记本 -->
            <div class="game-card">
                <div class="game-header">
                    <div class="game-icon">
                        <i class="fas fa-book"></i>
                    </div>
                    <h2 class="game-title">心情日记本</h2>
                </div>
                <p>记录今天的点点滴滴，分享你的心情~</p>
                
                <div class="mood-container">
                    <button class="mood-btn" data-mood="happy">😊 开心</button>
                    <button class="mood-btn" data-mood="excited">😆 兴奋</button>
                    <button class="mood-btn" data-mood="calm">😌 平静</button>
                    <button class="mood-btn" data-mood="tired">😴 疲惫</button>
                </div>
                
                <textarea class="diary-input" placeholder="今天发生了什么有趣的事情呢？"></textarea>
                
                <button class="save-btn" id="save-diary">
                    <i class="fas fa-save"></i> 保存心情日记
                </button>
            </div>
            
            <!-- 老虎机抽奖 -->
            <div class="game-card">
                <div class="game-header">
                    <div class="game-icon">
                        <i class="fas fa-dice"></i>
                    </div>
                    <h2 class="game-title">幸运老虎机</h2>
                </div>
                <p>试试今天的运气，赢取特别奖励！</p>
                
                <div class="slot-machine">
                    <div class="slot" id="slot1">🍓</div>
                    <div class="slot" id="slot2">🍒</div>
                    <div class="slot" id="slot3">🍋</div>
                </div>
                
                <div class="slot-result" id="slot-result">等待抽奖...</div>
                
                <button class="pull-btn" id="pull-lever">
                    <i class="fas fa-hand-point-down"></i> 拉杆抽奖
                </button>
            </div>
            
            <!-- 在线空调 -->
            <div class="game-card">
                <div class="game-header">
                    <div class="game-icon">
                        <i class="fas fa-wind"></i>
                    </div>
                    <h2 class="game-title">在线小空调</h2>
                </div>
                <p>热了吗？打开空调凉爽一下吧！</p>
                
                <div class="ac-control">
                    <div class="ac-display">
                        <div>当前温度</div>
                        <div class="temperature" id="temp">26°C</div>
                        <div>舒适模式</div>
                    </div>
                    
                    <div class="ac-controls">
                        <button class="ac-btn" id="temp-down">－</button>
                        <button class="ac-btn" id="ac-power">
                            <i class="fas fa-power-off"></i>
                        </button>
                        <button class="ac-btn" id="temp-up">＋</button>
                    </div>
                </div>
            </div>
            
            <!-- 星座运势 -->
            <div class="game-card">
                <div class="game-header">
                    <div class="game-icon">
                        <i class="fas fa-star"></i>
                    </div>
                    <h2 class="game-title">星座运势</h2>
                </div>
                <p>看看星星们今天想对你说什么？</p>
                
                <div class="horoscope">
                    <select class="zodiac-select" id="zodiac">
                        <option value="">选择你的星座</option>
                        <option value="aries">白羊座 ♈</option>
                        <option value="taurus">金牛座 ♉</option>
                        <option value="gemini">双子座 ♊</option>
                        <option value="cancer">巨蟹座 ♋</option>
                        <option value="leo">狮子座 ♌</option>
                        <option value="virgo">处女座 ♍</option>
                        <option value="libra">天秤座 ♎</option>
                        <option value="scorpio">天蝎座 ♏</option>
                        <option value="sagittarius">射手座 ♐</option>
                        <option value="capricorn">摩羯座 ♑</option>
                        <option value="aquarius">水瓶座 ♒</option>
                        <option value="pisces">双鱼座 ♓</option>
                    </select>
                    
                    <button class="save-btn" id="check-fortune">
                        <i class="fas fa-crystal-ball"></i> 查看今日运势
                    </button>
                    
                    <div class="horoscope-result" id="fortune-result">
                        <p class="fortune-text">选择星座查看今日运势</p>
                    </div>
                </div>
            </div>
            
            <!-- 更多游戏 -->
            <div class="game-card">
                <div class="game-header">
                    <div class="game-icon">
                        <i class="fas fa-plus-circle"></i>
                    </div>
                    <h2 class="game-title">更多小游戏</h2>
                </div>
                <p>点击图标开启更多有趣游戏！</p>
                
                <div class="game-grid" id="mini-game-grid">
                    <div class="mini-game" data-game="love-calculator">
                        <i class="fas fa-heart"></i>
                        <h3>爱情计算器</h3>
                    </div>
                    <div class="mini-game" data-game="memory-game">
                        <i class="fas fa-brain"></i>
                        <h3>记忆挑战</h3>
                    </div>
                    <div class="mini-game" data-game="dessert-fortune">
                        <i class="fas fa-cookie-bite"></i>
                        <h3>甜品占卜</h3>
                    </div>
                    <div class="mini-game" data-game="kiss-counter">
                        <i class="fas fa-kiss-wink-heart"></i>
                        <h3>亲亲计数器</h3>
                    </div>
                    <div class="mini-game" data-game="fortune-cookie">
                        <i class="fas fa-cookie"></i>
                        <h3>幸运饼干</h3>
                    </div>
                    <div class="mini-game" data-game="compatibility">
                        <i class="fas fa-people-arrows"></i>
                        <h3>默契测试</h3>
                    </div>
                </div>
                
                <!-- 爱情计算器 -->
                <div id="love-calculator" class="game-detail">
                    <div class="game-content">
                        <h3>❤️ 爱情计算器 ❤️</h3>
                        <p>计算你们之间的爱情指数</p>
                        
                        <div class="name-inputs">
                            <input type="text" class="name-input" id="name1" placeholder="你的名字">
                            <input type="text" class="name-input" id="name2" placeholder="TA的名字">
                        </div>
                        
                        <button class="save-btn" id="calculate-love">
                            <i class="fas fa-heart"></i> 计算爱情指数
                        </button>
                        
                        <div class="love-result">
                            <div class="love-percentage" id="love-percentage">0%</div>
                            <div class="love-message" id="love-message">输入名字查看你们的缘分</div>
                        </div>
                    </div>
                    <button class="back-btn">返回游戏列表</button>
                </div>
                
                <!-- 记忆挑战 -->
                <div id="memory-game" class="game-detail">
                    <div class="game-content">
                        <h3>🧠 记忆挑战 🧠</h3>
                        <p>记住卡片位置，找到所有配对！</p>
                        
                        <div class="memory-game-container" id="memory-game-container"></div>
                        
                        <div class="memory-result" id="memory-result">点击卡片开始游戏</div>
                        
                        <button class="save-btn" id="restart-memory">
                            <i class="fas fa-redo"></i> 重新开始
                        </button>
                    </div>
                    <button class="back-btn">返回游戏列表</button>
                </div>
                
                <!-- 甜品占卜 -->
                <div id="dessert-fortune" class="game-detail">
                    <div class="game-content">
                        <h3>🍰 甜品占卜 🍰</h3>
                        <p>选择你喜欢的甜品，看看今天的运势</p>
                        
                        <div class="dessert-options">
                            <div class="dessert-option" data-dessert="cake">
                                <i class="fas fa-birthday-cake"></i>
                                <div>蛋糕</div>
                            </div>
                            <div class="dessert-option" data-dessert="icecream">
                                <i class="fas fa-ice-cream"></i>
                                <div>冰淇淋</div>
                            </div>
                            <div class="dessert-option" data-dessert="chocolate">
                                <i class="fas fa-candy-cane"></i>
                                <div>巧克力</div>
                            </div>
                            <div class="dessert-option" data-dessert="cookie">
                                <i class="fas fa-cookie"></i>
                                <div>饼干</div>
                            </div>
                        </div>
                        
                        <div class="dessert-result" id="dessert-result">
                            请选择一种甜品进行占卜
                        </div>
                    </div>
                    <button class="back-btn">返回游戏列表</button>
                </div>
                
                <!-- 亲亲计数器 -->
                <div id="kiss-counter" class="game-detail">
                    <div class="game-content">
                        <h3>💋 亲亲计数器 💋</h3>
                        <p>记录你们今天的甜蜜亲亲次数</p>
                        
                        <div class="kiss-counter" id="kiss-count">0</div>
                        
                        <button class="kiss-btn" id="add-kiss">
                            <i class="fas fa-kiss-wink-heart"></i> 亲亲 +1
                        </button>
                        
                        <button class="kiss-btn" id="reset-kiss">
                            <i class="fas fa-redo"></i> 重置计数
                        </button>
                        
                        <div style="margin-top: 20px; font-size: 1.1rem;">
                            <p>今天也要多多亲亲哦 😘</p>
                        </div>
                    </div>
                    <button class="back-btn">返回游戏列表</button>
                </div>
                
                <!-- 幸运饼干 -->
                <div id="fortune-cookie" class="game-detail">
                    <div class="game-content">
                        <h3>🍪 幸运饼干 🍪</h3>
                        <p>点击饼干获取今日专属幸运签</p>
                        
                        <div class="fortune-cookie" id="fortune-cookie">
                            <div class="fortune-cookie-text">?</div>
                        </div>
                        
                        <div class="fortune-message" id="fortune-message">
                            点击饼干获取你的幸运签
                        </div>
                    </div>
                    <button class="back-btn">返回游戏列表</button>
                </div>
                
                <!-- 默契测试 -->
                <div id="compatibility" class="game-detail">
                    <div class="game-content">
                        <h3>👫 默契测试 👫</h3>
                        <p>看看你们有多了解彼此</p>
                        
                        <div class="compatibility-images">
                            <div class="compatibility-image">👩</div>
                            <div class="compatibility-arrow">❤️</div>
                            <div class="compatibility-image">👨</div>
                        </div>
                        
                        <div class="love-result">
                            <div class="love-percentage" id="compatibility-percentage">0%</div>
                            <div class="love-message" id="compatibility-message">测试你们的默契程度</div>
                        </div>
                        
                        <button class="save-btn" id="test-compatibility">
                            <i class="fas fa-heart"></i> 测试默契
                        </button>
                    </div>
                    <button class="back-btn">返回游戏列表</button>
                </div>
            </div>
        </div>
        
        <footer>
            <p>❤️ 专属于你的心动空间 ❤️</p>
            <p>每一天都因你而甜蜜 | 设计：冯笑一</p>
        </footer>
    </div>

    <script>
        // 心情日记功能
        const moodButtons = document.querySelectorAll('.mood-btn');
        const diaryInput = document.querySelector('.diary-input');
        const saveDiaryBtn = document.getElementById('save-diary');
        
        let selectedMood = '';
        
        moodButtons.forEach(button => {
            button.addEventListener('click', () => {
                moodButtons.forEach(btn => btn.classList.remove('selected'));
                button.classList.add('selected');
                selectedMood = button.dataset.mood;
            });
        });
        
        saveDiaryBtn.addEventListener('click', () => {
            if (!selectedMood) {
                alert('请先选择一种心情哦~');
                return;
            }
            
            if (diaryInput.value.trim() === '') {
                alert('请写点今天的心情故事吧~');
                return;
            }
            
            // 这里实际应用中应该保存到本地存储或服务器
            alert('心情日记已保存！\n\n心情: ' + 
                  document.querySelector('.mood-btn.selected').textContent + 
                  '\n内容: ' + diaryInput.value);
            
            // 重置表单
            moodButtons.forEach(btn => btn.classList.remove('selected'));
            diaryInput.value = '';
            selectedMood = '';
        });
        
        // 老虎机功能
        const slots = ['🍎', '🍊', '🍇', '🍓', '🍒', '🍋', '🍉', '🍑', '🍍', '🥝'];
        const slotElements = [document.getElementById('slot1'), 
                            document.getElementById('slot2'), 
                            document.getElementById('slot3')];
        const slotResult = document.getElementById('slot-result');
        const pullLeverBtn = document.getElementById('pull-lever');
        
        function spinSlot(slotElement) {
            let count = 0;
            const maxSpins = 20 + Math.floor(Math.random() * 10);
            const interval = setInterval(() => {
                slotElement.textContent = slots[Math.floor(Math.random() * slots.length)];
                count++;
                if (count > maxSpins) {
                    clearInterval(interval);
                }
            }, 100);
        }
        
        pullLeverBtn.addEventListener('click', () => {
            // 重置结果
            slotResult.textContent = "旋转中...";
            pullLeverBtn.disabled = true;
            
            // 旋转每个老虎机
            slotElements.forEach(slot => spinSlot(slot));
            
            // 等待所有老虎机停止后显示结果
            setTimeout(() => {
                const results = [
                    slotElements[0].textContent,
                    slotElements[1].textContent,
                    slotElements[2].textContent
                ];
                
                // 检查是否中奖
                if (results[0] === results[1] && results[1] === results[2]) {
                    slotResult.innerHTML = "🎉 恭喜！大奖！获得甜蜜之吻 💋";
                } else if (results[0] === results[1] || results[1] === results[2]) {
                    slotResult.innerHTML = "🎊 恭喜！小奖！获得爱的拥抱 🤗";
                } else {
                    slotResult.textContent = "😊 感谢参与！明天再来试试吧~";
                }
                
                pullLeverBtn.disabled = false;
            }, 3000);
        });
        
        // 在线空调功能
        const tempDisplay = document.getElementById('temp');
        const tempDownBtn = document.getElementById('temp-down');
        const tempUpBtn = document.getElementById('temp-up');
        const acPowerBtn = document.getElementById('ac-power');
        
        let currentTemp = 26;
        let isPowerOn = true;
        
        function updateAC() {
            tempDisplay.textContent = currentTemp + "°C";
            acPowerBtn.innerHTML = isPowerOn ? '<i class="fas fa-power-off"></i>' : '<i class="fas fa-power-off" style="color:#ddd"></i>';
            acPowerBtn.style.background = isPowerOn ? "#0984e3" : "#95afc0";
        }
        
        tempDownBtn.addEventListener('click', () => {
            if (!isPowerOn) return;
            if (currentTemp > 16) {
                currentTemp--;
                updateAC();
            }
        });
        
        tempUpBtn.addEventListener('click', () => {
            if (!isPowerOn) return;
            if (currentTemp < 30) {
                currentTemp++;
                updateAC();
            }
        });
        
        acPowerBtn.addEventListener('click', () => {
            isPowerOn = !isPowerOn;
            updateAC();
        });
        
        // 初始化空调
        updateAC();
        
        // 星座运势功能
        const zodiacSelect = document.getElementById('zodiac');
        const fortuneResult = document.getElementById('fortune-result');
        const checkFortuneBtn = document.getElementById('check-fortune');
        
        const fortunes = [
            "今天会有意外惊喜！保持开放心态迎接新机会。",
            "感情运势上升，适合表达心意或约会。",
            "工作上有突破性进展，抓住机会展现能力。",
            "注意健康管理，适当休息放松很重要。",
            "财运亨通，但需谨慎处理投资决策。",
            "人际关系运势上升，适合拓展社交圈。",
            "今天适合独处思考，会有新的领悟。",
            "可能会遇到旧友，重温美好回忆。",
            "尝试新事物会带来意想不到的收获。",
            "保持耐心，好事正在慢慢向你靠近。"
        ];
        
        const luckyStars = ["⭐", "⭐⭐", "⭐⭐⭐", "⭐⭐⭐⭐", "⭐⭐⭐⭐⭐"];
        
        checkFortuneBtn.addEventListener('click', () => {
            if (!zodiacSelect.value) {
                alert('请先选择你的星座哦~');
                return;
            }
            
            const zodiacName = zodiacSelect.options[zodiacSelect.selectedIndex].text;
            const randomFortune = fortunes[Math.floor(Math.random() * fortunes.length)];
            const randomStars = luckyStars[Math.floor(Math.random() * luckyStars.length)];
            
            fortuneResult.innerHTML = `
                <h3>${zodiacName} 今日运势</h3>
                <p class="fortune-text">${randomFortune}</p>
                <div class="lucky-stars">幸运指数: ${randomStars}</div>
                <p>${getZodiacTip(zodiacSelect.value)}</p>
            `;
        });
        
        function getZodiacTip(zodiac) {
            const tips = {
                aries: "今日幸运色：红色，适合主动出击！",
                taurus: "今日幸运色：绿色，享受美食会带来好运。",
                gemini: "今日幸运色：黄色，多与人交流会带来机会。",
                cancer: "今日幸运色：银色，家庭会给你温暖的力量。",
                leo: "今日幸运色：金色，展现你的领导魅力吧！",
                virgo: "今日幸运色：蓝色，注重细节会带来成功。",
                libra: "今日幸运色：粉色，平衡是你今天的关键词。",
                scorpio: "今日幸运色：紫色，直觉会引导你正确方向。",
                sagittarius: "今日幸运色：橙色，冒险精神会带来惊喜。",
                capricorn: "今日幸运色：棕色，务实的态度会得到回报。",
                aquarius: "今日幸运色：青色，创新思维会解决难题。",
                pisces: "今日幸运色：海蓝色，艺术会激发你的灵感。"
            };
            
            return tips[zodiac] || "保持积极心态，今天会是美好的一天！";
        }
        
        // 新增游戏功能
        const miniGames = document.querySelectorAll('.mini-game');
        const gameDetails = document.querySelectorAll('.game-detail');
        const backButtons = document.querySelectorAll('.back-btn');
        
        // 显示游戏详情
        miniGames.forEach(game => {
            game.addEventListener('click', () => {
                const gameId = game.dataset.game;
                document.getElementById('mini-game-grid').style.display = 'none';
                document.getElementById(gameId).style.display = 'block';
            });
        });
        
        // 返回游戏列表
        backButtons.forEach(button => {
            button.addEventListener('click', () => {
                gameDetails.forEach(detail => {
                    detail.style.display = 'none';
                });
                document.getElementById('mini-game-grid').style.display = 'grid';
            });
        });
        
        // 爱情计算器
        const calculateLoveBtn = document.getElementById('calculate-love');
        const lovePercentage = document.getElementById('love-percentage');
        const loveMessage = document.getElementById('love-message');
        
        calculateLoveBtn.addEventListener('click', () => {
            const name1 = document.getElementById('name1').value.trim();
            const name2 = document.getElementById('name2').value.trim();
            
            if (!name1 || !name2) {
                alert('请输入两个名字~');
                return;
            }
            
            // 生成随机爱情指数（60-100%）
            const percentage = Math.floor(Math.random() * 41) + 60;
            lovePercentage.textContent = `${percentage}%`;
            
            // 根据百分比显示不同消息
            if (percentage >= 90) {
                loveMessage.innerHTML = "天作之合！你们是命中注定的一对 ❤️";
            } else if (percentage >= 75) {
                loveMessage.innerHTML = "非常般配！你们的爱情会越来越甜蜜 💕";
            } else {
                loveMessage.innerHTML = "有发展潜力！多相处会让感情升温 🌹";
            }
        });
        
        // 记忆挑战游戏
        // 记忆挑战游戏
        const memoryContainer = document.getElementById('memory-game-container');
        const memoryResult = document.getElementById('memory-result');
        const restartMemoryBtn = document.getElementById('restart-memory');

        const memorySymbols = ['❤️', '🌟', '🎁', '💋', '🌸', '🎈', '🍭', '🌈'];
        let memoryCards = [];
        let flippedCards = [];
        let matchedPairs = 0;

        function initMemoryGame() {
            memoryContainer.innerHTML = '';
            memoryCards = [...memorySymbols, ...memorySymbols];
            flippedCards = [];
            matchedPairs = 0;
            memoryResult.textContent = "点击卡片开始游戏";

            // 洗牌
            for (let i = memoryCards.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * (i + 1));
                [memoryCards[i], memoryCards[j]] = [memoryCards[j], memoryCards[i]];
            }

            // 创建卡片
            memoryCards.forEach((symbol, index) => {
                const card = document.createElement('div');
                card.classList.add('memory-card');
                card.dataset.index = index;
                card.dataset.symbol = symbol;
                
                // 卡片正面（默认图标）
                const front = document.createElement('div');
                front.classList.add('memory-card-face', 'memory-card-front');
                front.textContent = '❓'; // 默认图标
                
                // 卡片背面（实际图形）
                const back = document.createElement('div');
                back.classList.add('memory-card-face', 'memory-card-back');
                back.textContent = symbol;
                
                card.appendChild(front);
                card.appendChild(back);
                card.addEventListener('click', flipMemoryCard);
                memoryContainer.appendChild(card);
            });
        }

        function flipMemoryCard() {
            if (flippedCards.length < 2 && !this.classList.contains('flipped')) {
                this.classList.add('flipped');
                flippedCards.push(this);

                if (flippedCards.length === 2) {
                    setTimeout(checkMatch, 500);
                }
            }
        }

        function checkMatch() {
            const card1 = flippedCards[0];
            const card2 = flippedCards[1];

            if (card1.dataset.symbol === card2.dataset.symbol) {
                card1.classList.add('matched');
                card2.classList.add('matched');
                matchedPairs++;

                if (matchedPairs === memorySymbols.length) {
                    memoryResult.innerHTML = "🎉 恭喜！你完成了挑战！";
                } else {
                    memoryResult.textContent = `已匹配: ${matchedPairs}/${memorySymbols.length}`;
                }
            } else {
                // 翻回正面时移除flipped类
                setTimeout(() => {
                    card1.classList.remove('flipped');
                    card2.classList.remove('flipped');
                }, 500);
            }

            flippedCards = [];
        }

        // 初始化游戏
        restartMemoryBtn.addEventListener('click', initMemoryGame);
        //initMemoryGame();
        
        // 甜品占卜
        const dessertOptions = document.querySelectorAll('.dessert-option');
        const dessertResult = document.getElementById('dessert-result');
        
        dessertOptions.forEach(option => {
            option.addEventListener('click', () => {
                const dessert = option.dataset.dessert;
                let message = "";
                
                switch (dessert) {
                    case 'cake':
                        message = "🍰 蛋糕代表甜蜜生活！今天会有令人开心的小惊喜，记得留意身边的美好事物哦~";
                        break;
                    case 'icecream':
                        message = "🍦 冰淇淋代表清凉心情！今天适合放松自己，做些让自己开心的事情，别太劳累~";
                        break;
                    case 'chocolate':
                        message = "🍫 巧克力代表浪漫爱情！今天感情运势上升，适合表达心意或安排甜蜜约会~";
                        break;
                    case 'cookie':
                        message = "🍪 饼干代表温馨日常！今天适合与家人朋友共度美好时光，享受简单的小幸福~";
                        break;
                }
                
                dessertResult.innerHTML = message;
            });
        });
        
        // 亲亲计数器
        const kissCount = document.getElementById('kiss-count');
        const addKissBtn = document.getElementById('add-kiss');
        const resetKissBtn = document.getElementById('reset-kiss');
        let kissCounter = 0;
        
        addKissBtn.addEventListener('click', () => {
            kissCounter++;
            kissCount.textContent = kissCounter;
            
            // 添加动画效果
            kissCount.style.transform = 'scale(1.2)';
            setTimeout(() => {
                kissCount.style.transform = 'scale(1)';
            }, 300);
        });
        
        resetKissBtn.addEventListener('click', () => {
            kissCounter = 0;
            kissCount.textContent = kissCounter;
        });
        
        // 幸运饼干
        const fortuneCookie = document.querySelector('.fortune-cookie');
        const fortuneMessage = document.getElementById('fortune-message');
        
        const fortuneMessages = [
            "今天会有意想不到的好运降临！",
            "微笑是最好的化妆品，今天多笑笑吧~",
            "你的善良会带来美好的回报",
            "勇敢表达你的心意，会有惊喜结果",
            "小小的举动会带来大大的幸福",
            "今天适合尝试新事物，会有意外收获",
            "你的魅力值今天爆表！",
            "放松心情，享受当下的美好时光",
            "给爱的人一个拥抱，温暖彼此",
            "美好的事情正在向你走来"
        ];
        
        fortuneCookie.addEventListener('click', () => {
            const randomIndex = Math.floor(Math.random() * fortuneMessages.length);
            fortuneMessage.textContent = fortuneMessages[randomIndex];
            
            // 添加动画效果
            fortuneCookie.style.transform = 'rotate(10deg)';
            setTimeout(() => {
                fortuneCookie.style.transform = 'rotate(0deg)';
            }, 200);
        });
        
        // 默契测试
        const testCompatibilityBtn = document.getElementById('test-compatibility');
        const compatibilityPercentage = document.getElementById('compatibility-percentage');
        const compatibilityMessage = document.getElementById('compatibility-message');
        
        testCompatibilityBtn.addEventListener('click', () => {
            // 生成随机默契指数（70-100%）
            const percentage = Math.floor(Math.random() * 31) + 70;
            compatibilityPercentage.textContent = `${percentage}%`;
            
            // 根据百分比显示不同消息
            if (percentage >= 90) {
                compatibilityMessage.innerHTML = "心灵相通！你们真是天生一对 ❤️";
            } else if (percentage >= 80) {
                compatibilityMessage.innerHTML = "非常默契！彼此了解程度很高 💕";
            } else {
                compatibilityMessage.innerHTML = "默契不错！多交流会更加了解彼此 🌹";
            }
        });
        
        // 初始化记忆游戏
        initMemoryGame();
    </script>
</body>
</html>
{% endraw %}


![360X360/bg_xinhai_360.png](https://tc.z.wiki/autoupload/f/pCwQSduTrK74xeM6D4jdFJO7Q2ZCk-TPg9YW4bt5tjGyl5f0KlZfm6UsKj-HyTuv/20250715/QOWX/360X360/bg_xinhai_360.png)