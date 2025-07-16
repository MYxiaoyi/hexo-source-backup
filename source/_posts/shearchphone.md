title: 号码归属地查询
date: 2025-7-04 12:19:00
tags:  [小程序, 工具, 应用]
cover: https://pic4.zhimg.com/v2-b96eb3d286b92f5e388a7e1e94fb19f3_1440w.jpg
sponsor: true # 是否展示赞助二维码？
---

{% raw %}

<!-- 在目标网站中插入此代码 -->
<div id="phone-query-widget">
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>手机归属地查询工具</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 宿主页面样式 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        h1 {
            color: #333;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 30px;
        }
        
        .content {
            display: flex;
            gap: 30px;
        }
        
        .main-content {
            flex: 3;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .widget-container {
            flex: 1;
            min-width: 400px;
        }
        
        .instructions {
            background: #f9f9f9;
            border-left: 4px solid #e91e63;
            padding: 15px;
            margin-top: 30px;
            border-radius: 4px;
        }
        
        pre {
            background: #2c3e50;
            color: white;
            padding: 15px;
            border-radius: 4px;
            overflow-x: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>冯笑一的小工具</h1>
        
        <div class="content">
            <div class="main-content">
                <h2>工具内容</h2>
                <p>这是一个示例网站，展示如何嵌入手机归属地查询小工具而不影响页面样式。</p>
                <p>小工具使用 Shadow DOM 技术封装，确保其样式不会影响到宿主页面。</p>
                
                <div class="instructions">
                    <h3>嵌入说明</h3>
                    <p>在您网站的任何位置添加以下代码：</p>
                    <pre>
&lt;div id="phone-query-widget"&gt;&lt;/div&gt;
&lt;script src="https://your-domain.com/path/to/widget.js"&gt;&lt;/script&gt;</pre>
                </div>
            </div>
            
            <div class="widget-container">
                <!-- 小工具将在这里渲染 -->
                <div id="phone-query-widget"></div>
            </div>
        </div>
    </div>

    <script>
        // 创建Shadow DOM封装的小工具
        class PhoneQueryWidget extends HTMLElement {
            constructor() {
                super();
                this.attachShadow({ mode: 'open' });
                this.render();
            }
            
            render() {
                this.shadowRoot.innerHTML = `
                    <style>
                        /* 小工具专用样式 - 不会影响外部页面 */
                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
                        }
                        
                        :host {
                            display: block;
                            width: 100%;
                        }
                        
                        .widget-container {
                            background: linear-gradient(135deg, #ff4b5c 0%, #ff9a9e 100%);
                            border-radius: 20px;
                            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
                            padding: 30px;
                            width: 100%;
                        }
                        
                        .header {
                            text-align: center;
                            margin-bottom: 20px;
                            color: white;
                        }
                        
                        .header h2 {
                            font-size: 1.8rem;
                            margin-bottom: 10px;
                            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
                        }
                        
                        .input-group {
                            position: relative;
                            margin-bottom: 20px;
                        }
                        
                        .input-group i {
                            position: absolute;
                            left: 15px;
                            top: 50%;
                            transform: translateY(-50%);
                            color: #e91e63;
                            font-size: 20px;
                        }
                        
                        .input-group input {
                            width: 100%;
                            padding: 15px 15px 15px 50px;
                            font-size: 16px;
                            border: 2px solid #f8bbd0;
                            border-radius: 10px;
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
                            padding: 15px;
                            background: linear-gradient(to right, #e91e63, #ff4b5c);
                            border: none;
                            border-radius: 10px;
                            color: white;
                            font-size: 16px;
                            font-weight: 600;
                            cursor: pointer;
                            transition: all 0.3s ease;
                            box-shadow: 0 5px 15px rgba(233, 30, 99, 0.4);
                        }
                        
                        .btn-query:hover {
                            transform: translateY(-3px);
                            box-shadow: 0 8px 20px rgba(233, 30, 99, 0.6);
                        }
                        
                        .result-container {
                            background: rgba(255, 255, 255, 0.95);
                            border-radius: 15px;
                            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
                            padding: 25px;
                            margin-top: 20px;
                            display: none;
                        }
                        
                        .result-container.active {
                            display: block;
                        }
                        
                        .result-header {
                            display: flex;
                            align-items: center;
                            margin-bottom: 20px;
                            padding-bottom: 15px;
                            border-bottom: 2px solid #f8bbd0;
                        }
                        
                        .result-header i {
                            font-size: 24px;
                            color: #e91e63;
                            margin-right: 12px;
                        }
                        
                        .result-header h3 {
                            color: #e91e63;
                            font-size: 1.5rem;
                            font-weight: 600;
                        }
                        
                        .result-details {
                            display: grid;
                            grid-template-columns: repeat(2, 1fr);
                            gap: 15px;
                        }
                        
                        .info-card {
                            background: linear-gradient(135deg, #fff0f5 0%, #ffeef3 100%);
                            border-radius: 12px;
                            padding: 20px;
                            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.05);
                            border: 1px solid #ffdbe6;
                            position: relative;
                        }
                        
                        .info-card::before {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: 0;
                            width: 4px;
                            height: 100%;
                            background: linear-gradient(to bottom, #e91e63, #ff4b5c);
                        }
                        
                        .info-card h4 {
                            color: #e91e63;
                            font-size: 14px;
                            margin-bottom: 8px;
                            font-weight: 600;
                            opacity: 0.8;
                        }
                        
                        .info-card p {
                            color: #d81b60;
                            font-size: 18px;
                            font-weight: 700;
                        }
                        
                        .spinner {
                            display: none;
                            text-align: center;
                            margin: 25px 0;
                        }
                        
                        .spinner i {
                            font-size: 40px;
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
                            padding: 15px;
                            border-radius: 10px;
                            margin-top: 15px;
                            text-align: center;
                            font-weight: 600;
                            border-left: 4px solid #c62828;
                        }
                        
                        .footer {
                            text-align: center;
                            color: rgba(255, 255, 255, 0.85);
                            padding: 15px;
                            font-size: 0.9rem;
                            margin-top: 20px;
                        }
                        
                        /* 响应式设计 */
                        @media (max-width: 600px) {
                            .result-details {
                                grid-template-columns: 1fr;
                            }
                        }
                    </style>
                    
                    <div class="widget-container">
                        <div class="header">
                            <h2><i class="fas fa-mobile-alt"></i> 手机归属地查询</h2>
                            <p>精准查询手机号码归属地与运营商信息</p>
                        </div>
                        
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
                        
                        <div class="result-container" id="result-container">
                            <div class="result-header">
                                <i class="fas fa-info-circle"></i>
                                <h3>查询结果</h3>
                            </div>
                            
                            <div class="result-details">
                                <div class="info-card">
                                    <h4>手机号码</h4>
                                    <p id="result-phone">138****3800</p>
                                </div>
                                <div class="info-card">
                                    <h4>运营商</h4>
                                    <p id="result-operator">中国移动</p>
                                </div>
                                <div class="info-card">
                                    <h4>省份</h4>
                                    <p id="result-province">北京市</p>
                                </div>
                                <div class="info-card">
                                    <h4>城市</h4>
                                    <p id="result-city">北京市</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="footer">
                            <p>© 2025 手机归属地查询工具</p>
                        </div>
                    </div>
                `;
                
                // 初始化事件监听
                this.initEvents();
            }
            
            initEvents() {
                const shadow = this.shadowRoot;
                const phoneInput = shadow.getElementById('phone-input');
                const queryBtn = shadow.getElementById('query-btn');
                const resultContainer = shadow.getElementById('result-container');
                const spinner = shadow.getElementById('spinner');
                const errorMsg = shadow.getElementById('error-msg');
                const resultPhone = shadow.getElementById('result-phone');
                const resultOperator = shadow.getElementById('result-operator');
                const resultProvince = shadow.getElementById('result-province');
                const resultCity = shadow.getElementById('result-city');
                
                // 输入框自动格式化
                phoneInput.addEventListener('input', function() {
                    this.value = this.value.replace(/\D/g, '');
                    if (this.value.length > 11) {
                        this.value = this.value.slice(0, 11);
                    }
                });
                
                // 查询按钮点击事件
                queryBtn.addEventListener('click', () => {
                    const phone = phoneInput.value.trim();
                    
                    // 验证手机号
                    if (!phone) {
                        this.showError('请输入手机号码');
                        return;
                    }
                    
                    if (!/^1[3-9]\d{9}$/.test(phone)) {
                        this.showError('请输入有效的11位手机号码');
                        return;
                    }
                    
                    // 开始查询
                    this.startQuery(phone);
                });
                
                // 按Enter键查询
                phoneInput.addEventListener('keypress', (e) => {
                    if (e.key === 'Enter') {
                        queryBtn.click();
                    }
                });
                
                // 保存DOM引用
                this.domRefs = {
                    phoneInput,
                    queryBtn,
                    resultContainer,
                    spinner,
                    errorMsg,
                    resultPhone,
                    resultOperator,
                    resultProvince,
                    resultCity
                };
            }
            
            startQuery(phone) {
                const { resultContainer, spinner, errorMsg } = this.domRefs;
                
                // 显示加载动画
                spinner.style.display = 'block';
                resultContainer.classList.remove('active');
                errorMsg.style.display = 'none';
                
                // 使用360 API查询
                fetch(`https://cx.shouji.360.cn/phonearea.php?number=${phone}`)
                    .then(response => response.json())
                    .then(data => {
                        spinner.style.display = 'none';
                        
                        if (data.code === 0) {
                            // 更新结果
                            this.updateResults(phone, data.data);
                            // 显示结果
                            resultContainer.classList.add('active');
                        } else {
                            this.showError('未查询到该号码信息，请重试');
                        }
                    })
                    .catch(error => {
                        spinner.style.display = 'none';
                        this.showError('查询失败，请检查网络连接或稍后再试');
                        console.error('查询错误:', error);
                    });
            }
            
            updateResults(phone, data) {
                const { resultPhone, resultOperator, resultProvince, resultCity } = this.domRefs;
                
                resultPhone.textContent = this.formatPhoneNumber(phone);
                
                const province = data.province || '未知';
                const city = data.city || '未知';
                let operator = data.sp || '未知';
                
                // 标准化运营商名称
                operator = operator.replace('中国', '');
                
                resultOperator.textContent = operator;
                resultProvince.textContent = province;
                resultCity.textContent = city;
            }
            
            showError(message) {
                const { errorMsg } = this.domRefs;
                errorMsg.textContent = message;
                errorMsg.style.display = 'block';
                
                // 3秒后自动隐藏错误信息
                setTimeout(() => {
                    errorMsg.style.display = 'none';
                }, 3000);
            }
            
            formatPhoneNumber(phone) {
                return phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1****$3');
            }
        }
        
        // 注册自定义元素
        customElements.define('phone-query-widget', PhoneQueryWidget);
        
        // 在页面加载后初始化小工具
        window.addEventListener('DOMContentLoaded', () => {
            const widgetContainer = document.getElementById('phone-query-widget');
            if (widgetContainer) {
                widgetContainer.innerHTML = '';
                const widget = document.createElement('phone-query-widget');
                widgetContainer.appendChild(widget);
            }
        });
    </script>
</body>
</html>
</div>

<div id="phone-query-widget"></div>
<script src="https://myxiaoyi.github.io/path/to/widget.js"></script>

{% endraw %}