<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.time.*" %> %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <jsp:include page="/navbar.jsp" />
        <title>Điền thông tin CV</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .cv-container {
                display: flex;
                max-width: 900px;
                margin: 40px auto;
                background: #fff;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            .sidebar {
                width: 30%;
                background-color: #2e4f4f;
                color: #fff;
                padding: 20px;
            }
            .sidebar h2 {
                font-size: 24px;
                margin-bottom: 20px;
                border-bottom: 2px solid #fff;
                padding-bottom: 10px;
            }
            .main-content {
                width: 70%;
                padding: 20px;
            }
            .section-title {
                font-size: 18px;
                font-weight: bold;
                color: #2e4f4f;
                border-bottom: 2px solid #2e4f4f;
                padding-bottom: 5px;
                margin-bottom: 15px;
            }
            .form-section {
                margin-bottom: 20px;
            }
            .form-section label {
                font-weight: bold;
                color: #333;
                display: block;
                margin-bottom: 5px;
            }
            .form-section input, .form-section select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
            }
            .submit-btn {
                background-color: #2e4f4f;
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                display: block;
                margin: 20px auto;
            }
            .submit-btn:hover {
                background-color: #1a3c3c;
            }
            .upload-section {
                margin-bottom: 20px;
            }
            .sidebar .form-section label {
                color: #fff;
            }
            .sidebar .form-section input, .sidebar .form-section select {
                border: 1px solid #ccc;
            }
            .message-box {
                background-color: #e7f3e7;
                border: 1px solid #2e4f4f;
                border-radius: 4px;
                padding: 10px;
                margin-bottom: 20px;
                color: #2e4f4f;
                font-size: 14px;
                text-align: center;
            }
        </style>
        <script>
            function formatCurrencyInput(input) {
                let value = input.value.replace(/\D/g, '');
                if (value === '') {
                    input.value = '';
                    return;
                }
                input.value = new Intl.NumberFormat('vi-VN').format(value);
            }

        </script>
    </head>
    <body>

        <form action="submitCV" method="post" enctype="multipart/form-data">
            <div class="cv-container">
                <!-- Sidebar for Personal Information -->
                <div class="sidebar">
                    <!-- Profile Picture Upload at Top -->
                    <div class="form-section upload-section">
                        <label for="image">Ảnh đại diện</label>
                        <input type="file" class="form-control" id="image" name="CVFile" accept="image/*" required>
                    </div>
                    <h2>----------------</h2>
                    <div class="form-section">
                        <label for="birthday" class="form-label">Ngày sinh</label>
                        <%
                            java.time.LocalDate today = java.time.LocalDate.now();
                        %>


                        <input type="date" class="form-control" id="birthday" name="birthday" max="<%= today.toString() %>" required>
                    </div>
                    <div class="form-section">
                        <label for="gender" class="form-label">Giới tính</label>
                        <select class="form-control" id="gender" name="gender" required>
                            <option value="">-- Chọn giới tính --</option>
                            <option value="Nam">Nam</option>
                            <option value="Nữ">Nữ</option>
                            <option value="Khác">Khác</option>
                        </select>
                    </div>
                    <div class="form-section">
                        <label for="nationality" class="form-label">Quốc tịch</label>
                        <input type="text" class="form-control" id="nationality" name="nationality" placeholder="Nhập quốc tịch" required>
                    </div>
                    <div class="form-section">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email của bạn" required>
                    </div>
                    <div class="form-section">
                        <label for="address" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="address" name="address" placeholder="Nhập địa chỉ của bạn" required>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="main-content">

                    <% String message = (String) request.getAttribute("message");
            if (message != null) { %>
                    <div class="message-box"><%= message %></div>
                    <% } %>

                    <!-- Personal Information -->
                    <div class="form-section">
                        <div class="section-title">THÔNG TIN CÁ NHÂN</div>
                        <label for="fullName" class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Nhập họ và tên" required>
                    </div>

                    <!-- Career Objective -->
                    <div class="form-section">
                        <div class="section-title">MỤC TIÊU NGHỀ NGHIỆP</div>
                        <label for="position" class="form-label">Vị trí mong muốn</label>
                        <input type="text" class="form-control" id="position" name="position" placeholder="Nhập vị trí ứng tuyển" required>
                    </div>

                    <!-- Work Experience -->
                    <div class="form-section">
                        <div class="section-title">KINH NGHIỆM LÀM VIỆC</div>
                        <label for="numberExp" class="form-label">Số năm kinh nghiệm</label>
                        <input type="number" class="form-control" id="numberExp" name="numberExp" placeholder="Nhập số năm kinh nghiệm" required>
                    </div>

                    <!-- Education -->
                    <div class="form-section">
                        <div class="section-title">HỌC VẤN</div>
                        <label for="education" class="form-label">Trình độ học vấn</label>
                        <input type="text" class="form-control" id="education" name="education" placeholder="Nhập trình độ học vấn" required>
                    </div>

                    <!-- Skills -->
                    <div class="form-section">
                        <div class="section-title">KỸ NĂNG</div>
                        <label for="field" class="form-label">Lĩnh vực chuyên môn</label>
                        <input type="text" class="form-control" id="field" name="field" placeholder="Nhập lĩnh vực chuyên môn" required>
                    </div>

                    <!-- Salary -->
                    <div class="form-section">
                        <div class="section-title">MỨC LƯƠNG HIỆN TẠI</div>
                        <label for="currentSalary" class="form-label">Mức lương hiện tại (VND)</label>
                        <input type="text" class="form-control" id="currentSalary" name="currentSalary" placeholder="Nhập mức lương hiện tại" required oninput="formatCurrencyInput(this)">

                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="submit-btn">Lưu CV</button>
                    </form>
                </div>
            </div>
            <%@ include file="footer.jsp" %>
    </body>
</html>