<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập & Đăng ký</title>
    <link rel="stylesheet" href="../css/logincss.css">
</head>
<body>
      <div class="background-overlay"></div>
    <input type="checkbox" id="flip" />
    <div class="container">
        <div class="flip-card">
            <!-- Đăng nhập -->
            <div class="flip-card-front">
                <h2>Đăng nhập</h2>
                <form action="loginServlet" method="post" autocomplete="off">
                    <div class="form-group">
                        <label for="user">Tên đăng nhập</label>
                        <input type="text" id="user" name="username"  style="width: 400px" required>
                    </div>
                    <div class="form-group">
                        <label for="pass">Mật khẩu</label>
                        <input type="password" id="pass" style="width: 400px" name="password" required>
                    </div>
                    <button type="submit">Đăng nhập</button>
                </form>
                <label class="switch-link" for="flip">Chưa có tài khoản? <b>Đăng ký</b></label>
            </div>
            <!-- Đăng ký -->
            <div class="flip-card-back">
                <h2>Đăng ký</h2>
                <form action="registerServlet" method="post" autocomplete="off">
                    <div class="form-group">
                        <label for="reg-user">Tên đăng nhập</label>
                        <input type="text" id="reg-user" name="username"   style="width: 400px" required>
                    </div>
                    <div class="form-group">
                        <label for="reg-email">Email</label>
                        <input type="email" id="reg-email" name="email"  style="width: 400px" required>
                    </div>
                    <div class="form-group">
                        <label for="reg-pass">Mật khẩu</label>
                        <input type="password" id="reg-pass" name="password"   style="width: 400px" required>
                    </div>
                     <div class="form-group">
                        <label for="reg-pass">Nhập Lại Mật Khẩu</label>
                        <input type="password" id="reg-pass" name="password"   style="width: 400px" required>
                    </div>
                    <button type="submit">Đăng ký</button>
                </form>
                <label class="switch-link" for="flip">Đã có tài khoản? <b>Đăng nhập</b></label>
            </div>
        </div>
    </div>
</body>
</html>