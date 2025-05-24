<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <jsp:include page="navbar.jsp" />

        <title>Điền thông tin CV</title>
        <!-- Bootstrap -->
        <!--        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">-->
        <style>
            body {
                background-color: #f8f9fa;
            }
            .cv-form {
                max-width: 700px;
                margin: 80px auto;
                background: #ffffff;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0px 4px 20px rgba(0,0,0,0.1);
            }
            .form-title {
                font-size: 24px;
                font-weight: 700;
                margin-bottom: 30px;
                color: #198754;
            }
            img {
                max-width: 150px;
                border-radius: 12px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>

        <div class="container cv-form">
            <div class="text-center">
                <div class="form-title">Điền thông tin CV của bạn</div>
                <% String message = (String) request.getAttribute("message");
                if (message != null) { %>
                <p><%= message %></p>
                <% } %>
            </div>

            <form action="submitCV" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="fullName" class="form-label">Họ và tên</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Nhập họ và tên" required>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" id="address" name="address" placeholder="Nhập địa chỉ của bạn">
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email của bạn">
                </div>
                <div class="mb-3">
                    <label for="position" class="form-label">Vị trí mong muốn</label>
                    <input type="text" class="form-control" id="position" name="position" placeholder="Nhập vị trí ứng tuyển">
                </div>
                <div class="mb-3">
                    <label for="numberExp" class="form-label">Số năm kinh nghiệm</label>
                    <input type="number" class="form-control" id="numberExp" name="numberExp" placeholder="Nhập số năm kinh nghiệm">
                </div>
                <div class="mb-3">
                    <label for="education" class="form-label">Trình độ học vấn</label>
                    <input type="text" class="form-control" id="education" name="education" placeholder="Nhập trình độ học vấn">
                </div>
                <div class="mb-3">
                    <label for="field" class="form-label">Lĩnh vực chuyên môn</label>
                    <input type="text" class="form-control" id="field" name="field" placeholder="Nhập lĩnh vực chuyên môn">
                </div>
                <div class="mb-3">
                    <label for="currentSalary" class="form-label">Mức lương hiện tại (VND)</label>
                    <input type="number" step="0.01" class="form-control" id="currentSalary" name="currentSalary" placeholder="Nhập mức lương hiện tại">
                </div>
                <div class="mb-3">
                    <label for="birthday" class="form-label">Ngày sinh</label>
                    <input type="date" class="form-control" id="birthday" name="birthday">
                </div>
                <div class="mb-3">
                    <label for="nationality" class="form-label">Quốc tịch</label>
                    <input type="text" class="form-control" id="nationality" name="nationality" placeholder="Nhập quốc tịch">
                </div>
                <div class="mb-3">
                    <label for="gender" class="form-label">Giới tính</label>
                    <select class="form-control" id="gender" name="gender">
                        <option value="">-- Chọn giới tính --</option>
                        <option value="Nam">Nam</option>
                        <option value="Nữ">Nữ</option>
                        <option value="Khác">Khác</option>
                    </select>
                </div>

                <div class="container upload-form">
                    <div class="form-title text-center text-success">Tải lên các file</div>

                    <div class="mb-3">
                        <label for="image" class="form-label">Chọn file</label>
                        <input type="file" class="form-control" id="image" name="CVFile" accept="image/*" required>
                    </div>

                </div

                <div class="text-center">
                    <button type="submit" class="btn btn-success px-5">Lưu CV</button>
                </div>

            </form>
        </div>
        <%@ include file="footer.jsp" %>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
