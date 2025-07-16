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
    <title>手机号码归属地查询</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        bodydiv {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            padding: 20px;
        }
        
        .phone-query-container {
            width: 100%;
            max-width: 500px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            padding: 30px;
            position: relative;
            overflow: hidden;
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }
        
        .header h1 {
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 8px;
            font-weight: 700;
        }
        
        .header p {
            color: #7f8c8d;
            font-size: 16px;
        }
        
        .header::after {
            content: '';
            display: block;
            width: 80px;
            height: 4px;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            border-radius: 2px;
            margin: 15px auto 0;
        }
        
        .input-group {
            position: relative;
            margin-bottom: 30px;
        }
        
        .input-group input {
            width: 100%;
            padding: 18px 20px;
            font-size: 18px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            outline: none;
            transition: all 0.3s ease;
            padding-left: 55px;
        }
        
        .input-group input:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }
        
        .input-group i {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #7f8c8d;
            font-size: 22px;
        }
        
        .btn-query {
            width: 100%;
            padding: 18px;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            letter-spacing: 1px;
            box-shadow: 0 5px 15px rgba(106, 17, 203, 0.4);
        }
        
        .btn-query:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(106, 17, 203, 0.6);
        }
        
        .btn-query:active {
            transform: translateY(1px);
        }
        
        .result-container {
            margin-top: 30px;
            padding: 25px;
            background: #f8f9fa;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            display: none;
        }
        
        .result-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e9ecef;
        }
        
        .result-header i {
            font-size: 24px;
            color: #3498db;
            margin-right: 15px;
        }
        
        .result-header h2 {
            color: #2c3e50;
            font-size: 22px;
            font-weight: 600;
        }
        
        .result-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .info-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }
        
        .info-card:hover {
            transform: translateY(-5px);
        }
        
        .info-card h3 {
            color: #7f8c8d;
            font-size: 14px;
            margin-bottom: 10px;
            font-weight: 500;
        }
        
        .info-card p {
            color: #2c3e50;
            font-size: 18px;
            font-weight: 600;
        }
        
        .spinner {
            display: none;
            text-align: center;
            margin: 20px 0;
        }
        
        .spinner i {
            font-size: 40px;
            color: #3498db;
            animation: spin 1s linear infinite;
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
            margin-top: 20px;
            text-align: center;
            font-weight: 500;
        }
        
        .footer {
            margin-top: 25px;
            text-align: center;
            color: #7f8c8d;
            font-size: 14px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        
        .footer a {
            color: #3498db;
            text-decoration: none;
        }
        
        .footer a:hover {
            text-decoration: underline;
        }
        
        /* 运营商颜色标识 */
        .mobile { color: #e74c3c; }
        .unicom { color: #3498db; }
        .telecom { color: #2ecc71; }
        .other { color: #9b59b6; }
        
        /* 响应式设计 */
        @media (max-width: 600px) {
            .phone-query-container {
                padding: 20px;
            }
            
            .result-details {
                grid-template-columns: 1fr;
            }
            
            .header h1 {
                font-size: 24px;
            }
            
            .input-group input {
                padding: 15px 15px 15px 50px;
                font-size: 16px;
            }
        }
    </style>
</head>
<bodydiv>
    <div class="phone-query-container">
        <div class="header">
            <h1><i class="fas fa-mobile-alt"></i> 手机号码归属地查询</h1>
            <p>精准查询手机号归属地与运营商信息</p>
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
                <h2>查询结果</h2>
            </div>
            <div class="result-details">
                <div class="info-card">
                    <h3>手机号码</h3>
                    <p id="result-phone">13800138000</p>
                </div>
                <div class="info-card">
                    <h3>运营商</h3>
                    <p id="result-operator" class="mobile">中国移动</p>
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
        </div>
        
        <div class="footer">
            <p>手机号码归属地查询 | 仅供查询参考</p>
        </div>
    </div>
</bodydiv>

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
                resultContainer.style.display = 'none';
                errorMsg.style.display = 'none';
                
                // 使用360 API查询
                fetch(`https://cx.shouji.360.cn/phonearea.php?number=${phone}`)
                    .then(response => response.json())
                    .then(data => {
                        spinner.style.display = 'none';
                        
                        if (data.code === 0) {
                            // 更新结果
                            resultPhone.textContent = formatPhoneNumber(phone);
                            
                            const province = data.data.province || '未知';
                            const city = data.data.city || '未知';
                            let operator = data.data.sp || '未知';
                            
                            // 标准化运营商名称
                            operator = operator.replace('中国', '');
                            
                            // 设置运营商颜色
                            resultOperator.className = '';
                            if (operator.includes('移动')) {
                                resultOperator.classList.add('mobile');
                            } else if (operator.includes('联通')) {
                                resultOperator.classList.add('unicom');
                            } else if (operator.includes('电信')) {
                                resultOperator.classList.add('telecom');
                            } else {
                                resultOperator.classList.add('other');
                            }
                            
                            resultOperator.textContent = operator;
                            resultProvince.textContent = province;
                            resultCity.textContent = city;
                            
                            // 显示结果
                            resultContainer.style.display = 'block';
                        } else {
                            showError('未查询到该号码信息，请重试');
                        }
                    })
                    .catch(error => {
                        spinner.style.display = 'none';
                        showError('查询失败，请检查网络连接或稍后再试');
                        console.error('查询错误:', error);
                    });
            }
            
            // 显示错误信息
            function showError(message) {
                errorMsg.textContent = message;
                errorMsg.style.display = 'block';
                resultContainer.style.display = 'none';
                
                // 3秒后自动隐藏错误信息
                setTimeout(() => {
                    errorMsg.style.display = 'none';
                }, 3000);
            }
            
            // 格式化手机号显示
            function formatPhoneNumber(phone) {
                return phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1 $2 $3');
            }
            
            // 页面加载时自动聚焦输入框
            phoneInput.focus();
        });
    </script>
</div>
</html>
</div>
{% endraw %}