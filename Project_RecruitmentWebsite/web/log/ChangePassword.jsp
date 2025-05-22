<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đổi mật khẩu</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/changePassword.css">
    <script>
        window.onload = function() {
            var statusBox = document.getElementById('statusBox');
            if (statusBox) {
                setTimeout(function() {
                    statusBox.style.opacity = '0';
                    setTimeout(function() {
                        statusBox.style.display = 'none';
                    }, 400);
                }, 4000);
            }
        };
    </script>
</head>
<body>
<div class="container">
    <h2>Đổi mật khẩu</h2>
    <form action="<%= request.getContextPath() %>/UserChangePassword" method="post">
        <label for="oldPassword">Mật khẩu cũ:</label>
        <input type="password" id="oldPassword" name="oldPassword" required>

        <label for="newPassword">Mật khẩu mới:</label>
        <input type="password" id="newPassword" name="newPassword" required>

        <label for="confirmPassword">Nhập lại mật khẩu mới:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required>

        <div class="button-row">
            <button type="submit">Đổi mật khẩu</button>
            <a class="back-link" href="<%= request.getContextPath() %>/index.jsp">Quay lại trang chủ</a>
        </div>
    </form>

    <% if (request.getAttribute("status") != null) { %>
        <div id="statusBox" class="status-box">
            <%= request.getAttribute("status") %>
        </div>
    <% } %>
</div>
</body>
</html>