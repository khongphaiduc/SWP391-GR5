<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.CV" %>
<%
    CV cv = (CV) request.getAttribute("editedCV");
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chỉnh sửa CV</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f4f4f4;
                padding: 20px;
            }

            form {
                max-width: 600px;
                margin: auto;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-top: 10px;
                font-weight: bold;
            }

            input, select {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            button {
                margin-top: 20px;
                padding: 10px;
                width: 100%;
                background-color: #00b386;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
            }

            button:hover {
                background-color: #009e75;
            }
        </style>
    </head>
    <body>
        <form action="viewCV" method="post">
            <h2>Chỉnh sửa CV</h2>

            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="cvId" value="<%= cv.getCvId() %>">

            <label>Họ tên:</label>
            <input type="text" name="fullName" value="<%= cv.getFullName() %>" required>

            <label>Địa chỉ:</label>
            <input type="text" name="address" value="<%= cv.getAddress() %>" required>

            <label>Email:</label>
            <input type="email" name="email" value="<%= cv.getEmail() %>" required>

            <label>Vị trí ứng tuyển:</label>
            <input type="text" name="position" value="<%= cv.getPosition() %>" required>

            <label>Kinh nghiệm (năm):</label>
            <input type="number" name="numberExp" value="<%= cv.getNumberExp() %>" required>

            <label>Học vấn:</label>
            <input type="text" name="education" value="<%= cv.getEducation() %>" required>

            <label>Lĩnh vực:</label>
            <input type="text" name="field" value="<%= cv.getField() %>" required>

            <label>Lương hiện tại:</label>
            <input type="number" name="currentSalary" step="0.01" value="<%= cv.getCurrentSalary() %>" required>

            <label>Ngày sinh:</label>
            <input type="date" name="birthday" value="<%= cv.getBirthday() %>" required>

            <label>Quốc tịch:</label>
            <input type="text" name="nationality" value="<%= cv.getNationality() %>" required>

            <label>Giới tính:</label>
            <select name="gender" required>
                <option value="Nam" <%= "Nam".equals(cv.getGender()) ? "selected" : "" %>>Nam</option>
                <option value="Nữ" <%= "Nữ".equals(cv.getGender()) ? "selected" : "" %>>Nữ</option>
                <option value="Khác" <%= "Khác".equals(cv.getGender()) ? "selected" : "" %>>Khác</option>
            </select>
            <div class="container upload-form">
                <div class="form-title text-center text-success">Tải lên các file</div>

                <div class="mb-3">
                    <label for="image" class="form-label">Chọn file</label>
                    <input type="file" class="form-control" id="image" name="CVFile" accept="image/*" required>
                </div>

            </div>
            <button type="submit">Lưu thay đổi</button>
        </form>
    </body>
</html>
