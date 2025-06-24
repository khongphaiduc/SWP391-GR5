<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Đăng nhập & Đăng ký</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,800" rel="stylesheet">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/logCSS.css">
        <script>
            // Ẩn tự động sau 4 giây
            window.addEventListener('DOMContentLoaded', function () {
                var noti = document.getElementById('notificationTab');
                if (noti) {
                    setTimeout(function () {
                        // Hiệu ứng biến mất dần
                        noti.style.transition = "opacity 0.5s";
                        noti.style.opacity = "0";
                        setTimeout(function () {
                            if (noti)
                                noti.style.display = "none";
                        }, 500);
                    }, 4000);
                }
            });
        </script>
    </head>
    <body> 
        <div class="container" id="container">
            <div class="form-container sign-up-container">
                <form id="signupForm" action="${pageContext.request.contextPath}/RegisterAccount" method="post" autocomplete="off">
                    <h1>Tạo tài khoản</h1>
                    <div class="input-row">
                        <input type="text" placeholder="Tên người dùng" name="username"   value="${username}" required />
                    </div>
                    <div class="input-row">
                        <input type="email" placeholder="Email"  name="email" value="${email}" required />
                    </div>
                    <!-- Số điện thoại: có cả input-row và phone-container, ban đầu ẩn đi -->
                    <div class="input-row phone-container" id="phoneContainer" style="display: none;">
                        <input type="tel" id="phoneInput" name="employerPhone" placeholder="Số điện thoại" pattern="[0-9]{10,15}" />
                    </div>
                    <div class="input-row">
                        <input type="password" id="password" name="password1" placeholder="Mật khẩu" required />
                    </div>
                    <div class="input-row">
                        <input type="password" id="confirmPassword"  name="password2" placeholder="Nhập lại mật khẩu" required />
                    </div>
                    <div class="input-row role-select-container">

                        <select id="role" name="role" required>
                            <option value="" disabled selected>Chọn vai trò</option>
                            <option value="candidate">Ứng viên</option>
                            <option value="employer">Nhà tuyển dụng</option>
                        </select>

                    </div>
                    <div id="passwordError" class="error-message" style="display:none;">Mật khẩu không trùng khớp!</div>
                    <button type="submit">Đăng ký</button>
                </form>
            </div>
            <div class="form-container sign-in-container">
                <form action="${pageContext.request.contextPath}/LoginAccount" method="post" autocomplete="off">
                    <h1>Đăng nhập</h1>
                    <div class="input-row">
                        <input type="text" placeholder="Tên Đăng Nhập" required  name="username" value="${username}"/>
                    </div>
                    <div class="input-row">
                        <input type="password" placeholder="Mật khẩu" name="password" required />
                    </div>
                    <button type="submit">Đăng nhập</button>
                    <a id="loginGoogle" target="_blank" style="background: #fff; color: #444; border: 1.5px solid #41a94c; margin-top: 10px; padding: 7px;border-radius: 10px ;text-decoration: none"
                       href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/Project_RecruitmentWebsite/LogWithGoogle&response_type=code&client_id=780846937780-ahb5qprjgmul2n1filj1haul2lssonk2.apps.googleusercontent.com&approval_prompt=force" >
                        <img src="https://developers.google.com/identity/images/g-logo.png" style="width:20px; vertical-align:middle; margin-right:8px;"> 
                        Đăng nhập bằng Google
                    </a>
                    <div class="input-row" style="justify-content: flex-end; margin-top: 10px; margin-bottom: 0;">
                        <a href="<%= request.getContextPath() %>/forgetPassword.jsp"  target="target" class="forgot-password-link">Quên mật khẩu?</a>
                    </div>
                </form>
            </div>

            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1 style="margin-right:100px">Chào mừng trở lại!</h1>
                        <p style="margin-right:60px">Nếu đã có tài khoản, hãy đăng nhập ở đây</p>
                        <button style="margin-top:70px ; margin-right:80px" class="ghost" id="signIn">Đăng nhập</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1 style="margin-left:70px">Xin chào, bạn mới!</h1>
                        <p style="margin-left :50px">Chưa có tài khoản? Đăng ký ngay để bắt đầu</p>
                        <button style="margin-top:80px" class="ghost" id="signUp">Đăng ký</button>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${status!=null}">
            <div class="notification-tab" id="notificationTab">
                <span>${status}</span>
            </div>
        </c:if>
        <script>
            // Chuyển form
            const signUpButton = document.getElementById('signUp');
            const signInButton = document.getElementById('signIn');
            const container = document.getElementById('container');

            if (signUpButton && signInButton && container) {
                signUpButton.addEventListener('click', () => {
                    container.classList.add('right-panel-active');
                });
                signInButton.addEventListener('click', () => {
                    container.classList.remove('right-panel-active');
                });
            }

            // Hiện/ẩn số điện thoại khi chọn Employer
            const roleSelect = document.getElementById('role');
            const phoneContainer = document.getElementById('phoneContainer');
            const phoneInput = document.getElementById('phoneInput');

            roleSelect.addEventListener('change', function () {
                if (this.value === 'employer') {
                    phoneContainer.style.display = 'flex'; // dùng flex để giống input-row
                    phoneInput.required = true;
                } else {
                    phoneContainer.style.display = 'none';
                    phoneInput.required = false;
                    phoneInput.value = '';
                }
            });

            //http://14.225.205.73:8080/Project_RecruitmentWebsite/

            // Kiểm tra mật khẩu trùng khớp
            const signupForm = document.getElementById('signupForm');
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            const passwordError = document.getElementById('passwordError');

            signupForm.addEventListener('submit', function (e) {
                if (password.value !== confirmPassword.value) {
                    passwordError.style.display = 'block';
                    e.preventDefault();
                    confirmPassword.focus();
                } else {
                    passwordError.style.display = 'none';
                }
            });

            confirmPassword.addEventListener('input', function () {
                if (password.value === confirmPassword.value) {
                    passwordError.style.display = 'none';
                }
            });
        </script>
    </body>
</html>