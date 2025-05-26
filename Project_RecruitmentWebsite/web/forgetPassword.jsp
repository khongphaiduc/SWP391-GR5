<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #eafbf1 0%, #d6f5e3 100%);
            display: flex;
            height: 100vh;
            justify-content: center;
            align-items: center;
            margin: 0;
        }
        .forgot-password-container {
            background: #fff;
            padding: 32px 24px;
            border-radius: 14px;
            box-shadow: 0 4px 24px rgba(46, 204, 113, 0.13);
            width: 340px;
            animation: slideDown 0.7s cubic-bezier(.87,-.41,.19,1.44);
            transition: box-shadow 0.3s;
            border: 1.5px solid #b6e2c6;
        }
        .forgot-password-container:hover {
            box-shadow: 0 8px 32px rgba(39, 174, 96, 0.18);
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-32px) scale(0.96);}
            to   { opacity: 1; transform: translateY(0) scale(1);}
        }
        .forgot-password-container h2 {
            margin-top: 0;
            color: #eafbf1;
            text-align: center;
            letter-spacing: 1px;
        }
        .forgot-password-container p {
            color: #4e6e5d;
            text-align: center;
            margin-bottom: 24px;
        }
        .input-group {
            margin-bottom: 18px;
        }
        .input-group label {
            display: block;
            color: #d6f5e3;
            margin-bottom: 6px;
            font-weight: 500;
        }
        .input-group input {
            width: 100%;
            padding: 10px 8px;
            border: 1.5px solid #b6e2c6;
            border-radius: 7px;
            font-size: 15px;
            transition: border-color 0.25s, box-shadow 0.25s;
            background: #f8fefb;
        }
        .input-group input:focus {
            border-color: #2ecc71;
            outline: none;
            box-shadow: 0 0 0 2px #77e6a53a;
            background: #f1fdf7;
        }
        .forgot-password-container button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(90deg, #43e97b 0%, #38f9d7 100%);
            color: #fff;
            border: none;
            border-radius: 7px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 8px;
            font-weight: 600;
            transition: background 0.2s, transform 0.1s;
            box-shadow: 0 2px 8px rgba(39, 174, 96, 0.13);
            position: relative;
            overflow: hidden;
        }
        .forgot-password-container button:active {
            background: linear-gradient(90deg, #34e89e 20%, #69f0c7 100%);
            transform: scale(0.97);
        }
        .forgot-password-container button.loading {
            pointer-events: none;
            color: transparent;
        }
        .forgot-password-container button.loading::after {
            content: "";
            position: absolute;
            left: 50%;
            top: 50%;
            width: 22px;
            height: 22px;
            margin: -11px 0 0 -11px;
            border: 3px solid #e8f8ef;
            border-top: 3px solid #27ae60;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }
        @keyframes spin {
            to { transform: rotate(360deg);}
        }
        .back-login {
            display: block;
            text-align: center;
            margin-top: 18px;
            color: #27ae60;
            text-decoration: none;
            font-size: 15px;
            transition: color 0.2s;
        }
        .back-login:hover {
            color: #145a32;
            text-decoration: underline;
        }
        .message {
            background: #eafbf1;
            color: #219150;
            padding: 10px 14px;
            border-radius: 6px;
            text-align: center;
            margin-bottom: 16px;
            font-size: 15px;
            display: none;
        }
        .message.success {
            background: #d8fbe5;
            color: #1ca93b;
        }
        .message.error {
            background: #ffeaea;
            color: #d11a2a;
        }
        /* --- Custom notification styles --- */
        .custom-status-toast {
            margin: 18px auto 0 auto;
            background: #d8fbe5;
            color: #1ca93b;
            border: 1.5px solid #a3e1c2;
            padding: 15px 25px;
            border-radius: 8px;
            font-size: 16px;
            box-shadow: 0 4px 24px rgba(46,204,113,0.17);
            min-width: 200px;
            max-width: 90vw;
            text-align: center;
            animation: toastIn 0.5s cubic-bezier(.87,-.41,.19,1.44);
        }
        .custom-status-toast.error {
            background: #ffeaea;
            color: #d11a2a;
            border-color: #ffcccc;
        }
        @keyframes toastIn {
            from { opacity:0; transform: translateY(0, -15px) scale(0.97);}
            to   { opacity:1; transform: translateY(0, 0) scale(1);}
        }
    </style>
</head>
<body>

    
    <div class="forgot-password-container">
        <h2>Quên mật khẩu?</h2>
        <p>Nhập email bạn đã đăng ký để reset lại mật khẩu từ hệ thống</p>
        <div class="message" id="message"></div>
        <form action="GetForgetPassword"  method="post" id="forgotForm" autocomplete="off">
            <div class="input-group">
                <label for="email">Email</label>
                <input name="email" type="email" id="email" placeholder="Nhập email của bạn" required>
            </div>
            <button type="submit" id="submitBtn">Gửi liên kết đặt lại mật khẩu</button>
        </form>
        
        <!-- Custom status toast notification dưới form -->
        <% if (request.getAttribute("status") != null && !((String)request.getAttribute("status")).isEmpty()) {
            String status = (String)request.getAttribute("status");
            String statusType = "success";
            if (status.toLowerCase().contains("thất bại") || status.toLowerCase().contains("lỗi") || status.toLowerCase().contains("không")) {
                statusType = "error";
            }
        %>
            <div id="statusToast" class="custom-status-toast <%= statusType %>">
                <%= status %>
            </div>
            <script>
                setTimeout(function() {
                    var toast = document.getElementById('statusToast');
                    if (toast) toast.style.display = 'none';
                }, 5000);
            </script>
        <% } %>
        <a class="back-login" href="log/login.jsp">Quay lại đăng nhập</a>
    </div>
</body>
</html>