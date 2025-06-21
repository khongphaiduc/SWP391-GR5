<%-- 
    Document   : adduser
    Created on : Jun 9, 2025, 2:21:01 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Người Dùng</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/logincss.css">
    <style>
        .notification-tab {
            position: fixed;
            top: 18px;
            left: 50%;
            transform: translateX(-50%);
            min-width: 410px;
            max-width: 560px;
            width: fit-content;
            padding: 22px 36px 22px 36px;
            background: linear-gradient(90deg, #fff6da 0%, #ffe3e3 100%);
            color: #d35400;
            border: 2px solid #faad7d;
            border-radius: 16px;
            box-shadow: 0 4px 18px -7px #b48c6f55;
            font-size: 1.13rem;
            font-weight: 600;
            z-index: 9999;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            gap: 24px;
            animation: slideDownFade 0.7s cubic-bezier(0.23, 1.15, 0.69, 0.99);
            opacity: 1;
        }
        @keyframes slideDownFade {
            from {
                opacity: 0;
                transform: translateX(-50%) translateY(-60px);
            }
            to {
                opacity: 1;
                transform: translateX(-50%) translateY(0);
            }
        }
        .notification-tab span {
            flex: 1;
            text-align: left;
            word-break: break-word;
        }
    </style>
    <script>
        window.addEventListener('DOMContentLoaded', function() {
            var noti = document.getElementById('notificationTab');
            if(noti) {
                setTimeout(function() {
                    noti.style.transition = "opacity 0.5s";
                    noti.style.opacity = "0";
                    setTimeout(function() {
                        if(noti) noti.style.display = "none";
                    }, 500);
                }, 4000);
            }
        });
    </script>
</head>
<body>
    <c:if test="${not empty status}">
        <div class="notification-tab" id="notificationTab">
            <span>${status}</span>
        </div>
    </c:if>
    <div class="background-overlay"></div>
    <div class="container">
        <div class="flip-card">
            <div class="flip-card-front">
                <h2>Thêm Admin Mới</h2>
                <form action="addAdmin" method="post" autocomplete="off">
                    <div class="form-group">
                        <label for="add-user">Tên đăng nhập</label>
                        <input type="text" id="add-user" name="username" style="width: 400px" value="" required>
                    </div>
               
                    <div class="form-group">
                        <label for="add-pass">Mật khẩu</label>
                        <input type="password" id="add-pass" name="password1" style="width: 400px" required>
                    </div>
                     <div class="form-group">
                        <label for="add-pass">Mật khẩu</label>
                        <input type="password" id="add-pass" name="password2" style="width: 400px" required>
                    </div>
                
                    <button type="submit">Thêm</button>
                </form>
                <div style="display: flex; justify-content: center;">
                    <a style="margin-top: 20px;" href="list">Quay lại Dashboard</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>