<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập & Đăng ký</title>
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
        // Ẩn tự động sau 4 giây
        window.addEventListener('DOMContentLoaded', function() {
            var noti = document.getElementById('notificationTab');
            if(noti) {
                setTimeout(function() {
                    // Hiệu ứng biến mất dần
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
    <input type="checkbox" id="flip" />
    <div class="container">
        <div class="flip-card">
            <!-- Đăng nhập -->
            <div class="flip-card-front">
                <h2>Đăng nhập</h2>
                <form action="${pageContext.request.contextPath}/LoginAccount" method="post" autocomplete="off">
                    <div class="form-group">
                        <label for="user">Tên đăng nhập</label>
                        <input type="text" id="user" name="username" style="width: 400px" required value="${username}">
                    </div>
                    <div class="form-group">
                        <label for="pass">Mật khẩu</label>
                        <input type="password" id="pass" style="width: 400px" name="password"  required>
                    </div>
                    <button type="submit">Đăng nhập</button>
                </form>
                <span style="display: flex; align-items: center; gap: 10px;">
                    <a style="margin-top: 10px;margin-left: 20px" href="<%= request.getContextPath() %>/forgetPassword.jsp" target="target">Quên Mật Khẩu</a>
                    <label style="margin-left: 60px" class="switch-link" for="flip">Chưa có tài khoản? <b>Đăng ký</b></label>
                </span>
            </div>
            <!-- Đăng ký -->
            <div class="flip-card-back">
                <h2>Đăng ký</h2>
                <form action="${pageContext.request.contextPath}/RegisterAccount" method="post" autocomplete="off">
                    <div class="form-group">
                        <label for="reg-user">Tên đăng nhập</label>
                        <input type="text" id="reg-user" name="username" style="width: 400px" value="${username}" required>
                    </div>
                    <div class="form-group">
                        <label for="reg-email">Email</label>
                        <input type="email" id="reg-email" name="email" style="width: 400px" value="${email}" required>
                    </div>
                    <div class="form-group">
                        <label for="reg-pass">Mật khẩu</label>
                        <input type="password" id="reg-pass" name="password1" style="width: 400px"  required>
                    </div>
                    <div class="form-group">
                        <label for="reg-pass">Nhập Lại Mật Khẩu</label>
                        <input type="password" id="reg-pass" name="password2" style="width: 400px" required>
                    </div>
                    <div class="form-group">
                        <label for="reg-pass">Hãy Cho Chúng Tôi Biết Bạn Là Ai ?</label>
                        <br>
                        <input style="margin-left: 20px" type="radio" name="role" value="Cadidate" />Candidate 
                        <input style="margin-left: 180px" type="radio" name="role" value="Employer" />Employer
                    </div>
                    <button type="submit">Đăng ký</button>
                </form>
                <div style="display: flex; align-items: center;">
                    <label style="margin-left: 100px;margin-bottom: 20px" class="switch-link" for="flip">Đã có tài khoản? <b>Đăng nhập</b></label>
                </div>
            </div>
        </div>
    </div>
</body>
</html>