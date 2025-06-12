<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.CV" %>
<%@page import="java.time.*" %> 

<%
    CV cv = (CV) request.getAttribute("editedCV");
%>
<html>
    <head>
        <jsp:include page="/navbar.jsp" />
        <meta charset="UTF-8">
        <title>Chỉnh sửa CV</title>
        <style>
            .cv-item-preview {
                width: 80px;
                height: 100px;
                border-radius: 8px;
                overflow: hidden;
                border: 3px solid rgba(255,255,255,0.3);
                float: right;
                margin-left: 20px;
            }

            .cv-item-preview img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

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
                font-size: 18px;
                margin: 20px 0;
                border-bottom: 2px solid #fff;
                padding-bottom: 10px;
                text-transform: uppercase;
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
                text-transform: uppercase;
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
                font-weight: normal;
            }
            .sidebar .form-section input, .sidebar .form-section select {
                border: 1px solid #ccc;
            }
        </style>
    </head>
    <body>
        <form action="viewCV" method="post" enctype="multipart/form-data">

            <div class="cv-container">
                <!-- Sidebar for Personal Information -->
                <div class="sidebar">
                    <!-- Profile Picture Upload at Top -->
                    <div class="form-section upload-section">
                        <label for="image">Ảnh đại diện</label>
                        <input type="file" id="image" name="CVFile">
                        <div class="cv-item-preview">
                            <img src="viewCV?cvId=<%= cv.getCvId() %>" alt="CV Preview" onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAiIGhlaWdodD0iMTAwIiB2aWV3Qm94PSIwIDAgODAgMTAwIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8cmVjdCB3aWR0aD0iODAiIGhlaWdodD0iMTAwIiBmaWxsPSIjZjhmOWZhIi8+CjxwYXRoIGQ9Ik00MCA1MEwyNSA2MEw1NSA2MFoiIGZpbGw9IiNkZGQiLz4KPHN2Zz4K'">
                        </div>
                    </div>
                    <h2>THÔNG TIN CÁ NHÂN</h2>
                    <div class="form-section">
                        <label for="birthday">Ngày sinh</label>
                        <%
                           java.time.LocalDate today = java.time.LocalDate.now();
                        %>
                        <input type="date" id="birthday" name="birthday" value="<%= cv.getBirthday() %>" max="<%= today.toString() %>" required>
                    </div>
                    <div class="form-section">
                        <label for="gender">Giới tính</label>
                        <select id="gender" name="gender" required>
                            <option value="Nam" <%= "Nam".equals(cv.getGender()) ? "selected" : "" %>>Nam</option>
                            <option value="Nữ" <%= "Nữ".equals(cv.getGender()) ? "selected" : "" %>>Nữ</option>
                            <option value="Khác" <%= "Khác".equals(cv.getGender()) ? "selected" : "" %>>Khác</option>
                        </select>
                    </div>
                    <div class="form-section">
                        <label for="nationality">Quốc tịch</label>
                        <input type="text" id="nationality" name="nationality" value="<%= cv.getNationality() %>" placeholder="Nhập quốc tịch (VD: Việt Nam)" required>
                    </div>
                    <div class="form-section">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="<%= cv.getEmail() %>" placeholder="Nhập email (VD: ten@example.com)" required>
                    </div>
                    <div class="form-section">
                        <label for="address">Địa chỉ</label>
                        <input type="text" id="address" name="address" value="<%= cv.getAddress() %>" placeholder="Nhập địa chỉ (VD: 123 Đường ABC, Quận 1)" required>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="main-content">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="cvId" value="<%= cv.getCvId() %>">

                    <!-- Personal Information -->
                    <div class="form-section">
                        <div class="section-title">HỌ VÀ TÊN</div>
                        <label for="fullName">Họ và tên</label>
                        <input type="text" id="fullName" name="fullName" value="<%= cv.getFullName() %>" placeholder="Nhập họ và tên (VD: Nguyễn Văn A)" required>
                    </div>

                    <!-- Career Objective -->
                    <div class="form-section">
                        <div class="section-title">MỤC TIÊU NGHỀ NGHIỆP</div>
                        <label for="position">Vị trí mong muốn</label>
                        <input type="text" id="position" name="position" value="<%= cv.getPosition() %>" placeholder="Nhập vị trí ứng tuyển (VD: Nhân viên kinh doanh)" required>
                    </div>

                    <!-- Work Experience -->
                    <div class="form-section">
                        <div class="section-title">KINH NGHIỆM LÀM VIỆC</div>
                        <label for="numberExp">Số năm kinh nghiệm</label>
                        <input type="number" id="numberExp" min=0 name="numberExp" value="<%= cv.getNumberExp() %>" placeholder="Nhập số năm kinh nghiệm (VD: 2)" required>
                    </div>

                    <!-- Education -->
                    <div class="form-section">
                        <div class="section-title">HỌC VẤN</div>
                        <label for="education">Trình độ học vấn</label>
                        <input type="text" id="education" name="education" value="<%= cv.getEducation() %>" placeholder="Nhập trình độ học vấn (VD: Cử nhân Kinh tế)" required>
                    </div>

                    <!-- Skills -->
                    <div class="form-section">
                        <div class="section-title">KỸ NĂNG</div>
                        <label for="field">Lĩnh vực chuyên môn</label>
                        <input type="text" id="field" name="field" value="<%= cv.getField() %>" placeholder="Nhập lĩnh vực chuyên môn (VD: Kỹ năng bán hàng, giao tiếp)" required>
                    </div>

                    <!-- Salary -->
                    <div class="form-section">
                        <div class="section-title">MỨC LƯƠNG HIỆN TẠI</div>
                        <label for="currentSalary">Mức lương hiện tại (VND)</label>
                        <input type="number" min="0" step="0.01" id="currentSalary" name="currentSalary" value="<%= cv.getCurrentSalary() %>" placeholder="Nhập mức lương hiện tại (VD: 10000000)" required>
                    </div>


                </div>


            </div>
            <!-- Submit Button -->
            <button type="submit" class="submit-btn">Lưu thay đổi</button>
        </form>
    </body>
</html>