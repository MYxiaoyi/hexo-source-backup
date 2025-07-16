title: 号码归属地查询
date: 2025-7-04 12:19:00
tags:  [小程序, 工具, 应用]
cover: https://pic4.zhimg.com/v2-b96eb3d286b92f5e388a7e1e94fb19f3_1440w.jpg
sponsor: true # 是否展示赞助二维码？
categories: 技术分享,开源项目,工具
---

{% raw %}

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>手机归属地查询工具</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        bodydiv {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            background: linear-gradient(135deg, #ff4b5c 0%, #ff9a9e 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            width: 100%;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 30px;
        }
        
        header {
            text-align: center;
            padding: 20px;
            color: white;
            animation: fadeInDown 0.8s ease;
        }
        
        header h1 {
            font-size: 2.8rem;
            margin-bottom: 10px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }
        
        header p {
            font-size: 1.2rem;
            max-width: 600px;
            margin: 0 auto;
            opacity: 0.9;
        }
        
        .main-content {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .query-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            padding: 40px;
            width: 100%;
            max-width: 500px;
            animation: fadeInLeft 0.8s ease;
            transition: transform 0.3s ease;
        }
        
        .query-card:hover {
            transform: translateY(-10px);
        }
        
        .card-title {
            text-align: center;
            margin-bottom: 30px;
            color: #e91e63;
            font-size: 1.8rem;
            position: relative;
            padding-bottom: 15px;
        }
        
        .card-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(to right, #ff4b5c, #e91e63);
            border-radius: 2px;
        }
        
        .input-group {
            position: relative;
            margin-bottom: 30px;
            /* 确保父容器宽度设置正确，例如设置一个宽度或者继承父级宽度 */
            width: 100%; /* 添加这一行确保宽度约束 */
        }

        .input-group i {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #e91e63;
            font-size: 22px;
            z-index: 1; /* 确保图标在输入框之上 */
        }

        .input-group input {
            box-sizing: border-box; /* 关键修复 */
            width: 100%;
            padding: 18px 18px 18px 50px; /* 上 右 下 左，左侧内边距调整为50px */
            cursor: pointer;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
            font-size: 18px;
            border: 2px solid #f8bbd0;
            border-radius: 12px;
            outline: none;
            transition: all 0.3s ease;
            background: #fff;
            color: #333;
        }

        .input-group input:focus {
            border-color: #e91e63;
            box-shadow: 0 0 0 3px rgba(233, 30, 99, 0.2);
        }
        
        .btn-query {
            width: 100%;
            padding: 18px;
            background: linear-gradient(to right, #e91e63, #ff4b5c);
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            letter-spacing: 1px;
            box-shadow: 0 5px 15px rgba(233, 30, 99, 0.4);
            position: relative;
            overflow: hidden;
        }
        
        .btn-query:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(233, 30, 99, 0.6);
        }
        
        .btn-query:active {
            transform: translateY(1px);
        }
        
        .btn-query::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -60%;
            width: 40%;
            height: 200%;
            background: rgba(255, 255, 255, 0.2);
            transform: rotate(30deg);
            transition: all 0.6s;
        }
        
        .btn-query:hover::after {
            left: 120%;
        }
        
        .result-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            padding: 40px;
            width: 100%;
            max-width: 500px;
            animation: fadeInRight 0.8s ease;
            display: none;
        }
        
        .result-container.active {
            display: block;
        }
        
        .result-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f8bbd0;
        }
        
        .result-header i {
            font-size: 28px;
            color: #e91e63;
            margin-right: 15px;
        }
        
        .result-header h2 {
            color: #e91e63;
            font-size: 1.8rem;
            font-weight: 600;
        }
        
        .result-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .info-card {
            background: linear-gradient(135deg, #fff0f5 0%, #ffeef3 100%);
            border-radius: 15px;
            padding: 25px 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            border: 1px solid #ffdbe6;
            position: relative;
            overflow: hidden;
        }
        
        .info-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }
        
        .info-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: linear-gradient(to bottom, #e91e63, #ff4b5c);
        }
        
        .info-card h3 {
            color: #e91e63;
            font-size: 16px;
            margin-bottom: 10px;
            font-weight: 600;
            opacity: 0.8;
        }
        
        .info-card p {
            color: #d81b60;
            font-size: 20px;
            font-weight: 700;
        }
        
        .spinner {
            display: none;
            text-align: center;
            margin: 30px 0;
        }
        
        .spinner i {
            font-size: 50px;
            color: #e91e63;
            animation: spin 1.5s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .error-message {
            display: none;
            background: #ffebee;
            color: #c62828;
            padding: 18px;
            border-radius: 12px;
            margin-top: 20px;
            text-align: center;
            font-weight: 600;
            border-left: 4px solid #c62828;
        }
        
        .history-section {
            margin-top: 30px;
            padding-top: 25px;
            border-top: 2px dashed #f8bbd0;
        }
        
        .history-section h3 {
            color: #e91e63;
            margin-bottom: 15px;
            font-size: 1.3rem;
        }
        
        .history-list {
            max-height: 200px;
            overflow-y: auto;
        }
        
        .history-item {
            background: #fff0f5;
            padding: 12px 15px;
            border-radius: 10px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            border: 1px solid #ffdbe6;
        }
        
        .history-phone {
            font-weight: 600;
            color: #e91e63;
        }
        
        .history-location {
            color: #d81b60;
        }
        
        footer {
            text-align: center;
            color: rgba(255, 255, 255, 0.85);
            padding: 20px;
            font-size: 1rem;
            animation: fadeInUp 0.8s ease;
        }
        
        /* 动画效果 */
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes fadeInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        
        @keyframes fadeInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        
        /* 响应式设计 */
        @media (max-width: 768px) {
            .main-content {
                flex-direction: column;
                align-items: center;
            }
            
            .query-card, .result-container {
                max-width: 100%;
                padding: 30px 20px;
            }
            
            header h1 {
                font-size: 2.2rem;
            }
            
            .result-details {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<bodydiv>
    <div class="container">
        <header>
            <h1><i class="fas fa-mobile-alt"></i> 手机归属地查询</h1>
            <p>精准查询手机号码归属地、运营商及地理位置信息</p>
        </header>
        
        <div class="main-content">
            <div class="query-card">
                <h2 class="card-title">查询手机归属地</h2>
                
                <div class="input-group">
                    <i class="fas fa-phone"></i>
                    <input type="tel" id="phone-input" placeholder="请输入11位手机号码" maxlength="11">
                </div>
                
                <button class="btn-query" id="query-btn">
                    <i class="fas fa-search"></i> 立即查询
                </button>
                
                <div class="spinner" id="spinner">
                    <i class="fas fa-spinner"></i>
                </div>
                
                <div class="error-message" id="error-msg"></div>
            </div>
            
            <div class="result-container" id="result-container">
                <div class="result-header">
                    <i class="fas fa-info-circle"></i>
                    <h2>查询结果</h2>
                </div>
                
                <div class="result-details">
                    <div class="info-card">
                        <h3>手机号码</h3>
                        <p id="result-phone">138****3800</p>
                    </div>
                    <div class="info-card">
                        <h3>运营商</h3>
                        <p id="result-operator">中国移动</p>
                    </div>
                    <div class="info-card">
                        <h3>省份</h3>
                        <p id="result-province">北京市</p>
                    </div>
                    <div class="info-card">
                        <h3>城市</h3>
                        <p id="result-city">北京市</p>
                    </div>
                </div>
                
                <div class="history-section">
                    <h3><i class="fas fa-history"></i> 最近查询记录</h3>
                    <div class="history-list" id="history-list">
                        <div class="history-item">
                            <span class="history-phone">138****5678</span>
                            <span class="history-location">北京·移动</span>
                        </div>
                        <div class="history-item">
                            <span class="history-phone">159****1234</span>
                            <span class="history-location">上海·联通</span>
                        </div>
                        <div class="history-item">
                            <span class="history-phone">186****9876</span>
                            <span class="history-location">广州·电信</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <footer>
            <p>© 2023 手机归属地查询工具 | 数据来源于360手机归属地API | 仅供查询参考</p>
        </footer>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const phoneInput = document.getElementById('phone-input');
            const queryBtn = document.getElementById('query-btn');
            const resultContainer = document.getElementById('result-container');
            const spinner = document.getElementById('spinner');
            const errorMsg = document.getElementById('error-msg');
            const resultPhone = document.getElementById('result-phone');
            const resultOperator = document.getElementById('result-operator');
            const resultProvince = document.getElementById('result-province');
            const resultCity = document.getElementById('result-city');
            const historyList = document.getElementById('history-list');
            
            // 存储查询历史
            let queryHistory = [];
            
            // 输入框自动格式化
            phoneInput.addEventListener('input', function() {
                this.value = this.value.replace(/\D/g, '');
                if (this.value.length > 11) {
                    this.value = this.value.slice(0, 11);
                }
            });
            
            // 查询按钮点击事件
            queryBtn.addEventListener('click', function() {
                const phone = phoneInput.value.trim();
                
                // 验证手机号
                if (!phone) {
                    showError('请输入手机号码');
                    return;
                }
                
                if (!/^1[3-9]\d{9}$/.test(phone)) {
                    showError('请输入有效的11位手机号码');
                    return;
                }
                
                // 开始查询
                startQuery(phone);
            });
            
            // 按Enter键查询
            phoneInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    queryBtn.click();
                }
            });
            
            // 开始查询
            function startQuery(phone) {
                // 显示加载动画
                spinner.style.display = 'block';
                resultContainer.classList.remove('active');
                errorMsg.style.display = 'none';
                
                // JSONP 回调函数名（确保唯一性）
                const callbackName = `jsonpCallback_${Date.now()}`;
                
                // 创建 script 元素
                const script = document.createElement('script');
                
                // 设置 JSONP 请求
                script.src = `https://cx.shouji.360.cn/phonearea.php?number=${phone}&callback=${callbackName}`;
                
                // 处理 JSONP 响应
                window[callbackName] = function(data) {
                    // 清理
                    document.body.removeChild(script);
                    delete window[callbackName];
                    
                    spinner.style.display = 'none';
                    
                    if (data.code === 0) {
                        // 更新结果
                        resultPhone.textContent = formatPhoneNumber(phone);
                        
                        const province = data.data.province || '未知';
                        const city = data.data.city || '未知';
                        let operator = data.data.sp || '未知';
                        
                        // 标准化运营商名称
                        operator = operator.replace('中国', '');
                        
                        resultOperator.textContent = operator;
                        resultProvince.textContent = province;
                        resultCity.textContent = city;
                        
                        // 添加到查询历史
                        addToHistory(phone, `${province}·${operator}`);
                        
                        // 显示结果
                        resultContainer.classList.add('active');
                    } else {
                        showError('未查询到该号码信息，请重试');
                    }
                };
            
            // 显示错误信息
            function showError(message) {
                errorMsg.textContent = message;
                errorMsg.style.display = 'block';
                
                // 3秒后自动隐藏错误信息
                setTimeout(() => {
                    errorMsg.style.display = 'none';
                }, 3000);
            }
            
            // 格式化手机号显示
            function formatPhoneNumber(phone) {
                return phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1****$3');
            }
            
            // 添加到查询历史
            function addToHistory(phone, location) {
                // 添加到历史数组
                queryHistory.unshift({
                    phone: phone,
                    location: location,
                    timestamp: new Date()
                });
                
                // 只保留最近的5条记录
                if (queryHistory.length > 5) {
                    queryHistory.pop();
                }
                
                // 更新历史列表
                updateHistoryList();
            }
            
            // 更新历史列表
            function updateHistoryList() {
                historyList.innerHTML = '';
                
                queryHistory.forEach(item => {
                    const historyItem = document.createElement('div');
                    historyItem.className = 'history-item';
                    historyItem.innerHTML = `
                        <span class="history-phone">${formatPhoneNumber(item.phone)}</span>
                        <span class="history-location">${item.location}</span>
                    `;
                    historyList.appendChild(historyItem);
                });
            }
            
            // 页面加载时自动聚焦输入框
            phoneInput.focus();
            
            // 添加一些示例历史记录
            addToHistory('13800138000', '北京·移动');
            addToHistory('15912345678', '上海·联通');
            addToHistory('18698765432', '广州·电信');
        });
    </script>
</bodydiv>
</html>

{% endraw %}