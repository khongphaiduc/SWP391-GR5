<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Models.Candidate" %>
<%@ page import="java.time.*" %>
<%
    Candidate candidate = (Candidate) request.getAttribute("candidate");
    LocalDate today = LocalDate.now();
    LocalDate maxDate = today.minusYears(18);
    LocalDate minDate = today.minusYears(65);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <jsp:include page="/navbar.jsp" />
    <title>Điền thông tin CV</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }
        .cv-container { display: flex; max-width: 900px; margin: 40px auto; background: #fff; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); }
        .sidebar { width: 30%; background-color: #2e4f4f; color: #fff; padding: 20px; }
        .main-content { width: 70%; padding: 20px; }
        .section-title { font-size: 18px; font-weight: bold; color: #2e4f4f; border-bottom: 2px solid #2e4f4f; padding-bottom: 5px; margin-bottom: 15px; }
        .form-section { margin-bottom: 20px; }
        .form-section label { font-weight: bold; color: #333; display: block; margin-bottom: 5px; }
        .form-section input, .form-section select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        .submit-btn { background-color: #2e4f4f; color: #fff; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; display: block; margin: 20px auto; }
        .submit-btn:hover { background-color: #1a3c3c; }
        .upload-section { margin-bottom: 20px; }
        .sidebar .form-section label { color: #fff; }
        .sidebar .form-section input, .sidebar .form-section select { border: 1px solid #ccc; }
        .message-box { background-color: #e7f3e7; border: 1px solid #2e4f4f; border-radius: 4px; padding: 10px; margin-bottom: 20px; color: #2e4f4f; font-size: 14px; text-align: center; }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById('avatar-file').addEventListener('change', function (event) {
                const file = event.target.files[0];
                const preview = document.getElementById('avatar-preview');
                const filename = document.getElementById('avatar-filename');
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        preview.src = e.target.result;
                        preview.style.display = 'block';
                    }
                    reader.readAsDataURL(file);
                    filename.innerText = file.name;
                } else {
                    preview.style.display = 'none';
                    filename.innerText = '';
                }
            });
        });
    </script>
</head>
<body>
    <form action="submitCV" method="post" enctype="multipart/form-data">
        <div class="cv-container">
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="form-section upload-section">
                    <label for="avatar-file">Ảnh đại diện</label>
                    <input type="file" id="avatar-file" name="CVFile" required>
                    <div style="display:flex;align-items:center;gap:7px;margin:8px 0;">
                        <img id="avatar-preview" src="" alt="Preview" style="display:none;width:60px;height:60px;border-radius:50%;border:2px solid #eee;">
                        <span id="avatar-filename" style="font-size:0.95em;color:#ccc;"></span>
                    </div>
                </div>
                <div class="form-section">
                    <label for="birthday">Ngày sinh</label>
                    <input type="date" id="birthday" name="birthday"
                           min="<%= minDate %>" max="<%= maxDate %>"
                           value="<%= (candidate != null && candidate.getBirthday() != null) ? candidate.getBirthday().toString() : "" %>" required>
                </div>
                <div class="form-section">
                    <label for="gender">Giới tính</label>
                    <select id="gender" name="gender" required>
                        <option value="">-- Chọn giới tính --</option>
                        <option value="Nam">Nam</option>
                        <option value="Nữ">Nữ</option>
                        <option value="Khác">Khác</option>
                    </select>
                </div>
                <div class="form-section">
                    <label for="nationality">Quốc tịch</label>
                    <input type="text" id="nationality" name="nationality" value="<%= candidate != null ? candidate.getNationality() : "" %>" required>
                </div>
                <div class="form-section">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="<%= candidate != null ? candidate.getEmail() : "" %>" required>
                </div>
                <div class="form-section">
                    <label for="address">Địa chỉ</label>
                    <input type="text" id="address" name="address" value="<%= candidate != null ? candidate.getAddress() : "" %>" required>
                </div>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <% String message = (String) request.getAttribute("message");
                   if (message != null) { %>
                <div class="message-box"><%= message %></div>
                <% } %>

                <div class="form-section">
                    <div class="section-title">THÔNG TIN CÁ NHÂN</div>
                    <label for="fullName">Họ và tên</label>
                    <input type="text" id="fullName" name="fullName" required>
                </div>

                <div class="form-section">
                    <div class="section-title">MỤC TIÊU NGHỀ NGHIỆP</div>
                    <label for="position">Vị trí mong muốn</label>
                    <input type="text" id="position" name="position" required>
                </div>

                <div class="form-section">
                    <div class="section-title">KINH NGHIỆM LÀM VIỆC</div>
                    <label for="numberExp">Số năm kinh nghiệm</label>
                    <input type="number" id="numberExp" name="numberExp" min="0" max="65" required>
                </div>

                <div class="form-section">
                    <div class="section-title">HỌC VẤN</div>
                    <label for="education">Trình độ học vấn</label>
                    <input type="text" id="education" name="education" required>
                </div>

                <div class="form-section">
                    <div class="section-title">KỸ NĂNG</div>
                    <label for="field">Lĩnh vực chuyên môn</label>
                    <input type="text" id="field" name="field" required>
                </div>

                <div class="form-section">
                    <div class="section-title">MỨC LƯƠNG HIỆN TẠI</div>
                    <label for="currentSalary">Mức lương hiện tại (VND)</label>
                    <input type="number" id="currentSalary" name="currentSalary" min="0" step="1000" required>
                </div>

                <button type="submit" class="submit-btn">Lưu CV</button>
            </div>
        </div>
    </form>
    <%@ include file="footer.jsp" %>
</body>
</html>
