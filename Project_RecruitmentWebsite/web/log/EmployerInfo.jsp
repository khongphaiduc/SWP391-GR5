<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="Models.*" %>
<%
    Employer employer = (Employer)request.getAttribute("employer");
%>
<html lang="vi">
    <head>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <meta charset="UTF-8">
        <title>Hồ sơ cá nhân - Đặc biệt</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f0f8f0;
                min-height: 100vh;
                padding: 20px;
            }

            .profile-container {
                max-width: 1200px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: 1fr 280px;
                gap: 20px;
                background: white;
                border-radius: 10px;
                padding: 30px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .profile-main {
                text-align: center;
            }

            .company-avatar {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #81c784;
                margin: 0 auto 20px;
            }

            .company-name {
                font-size: 1.8em;
                color: #2e7d32;
                margin-bottom: 25px;
                font-weight: 500;
            }

            .company-info-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
                margin-bottom: 25px;
                text-align: left;
            }

            .info-item {
                background: #f8fdf8;
                padding: 15px;
                border-radius: 8px;
                border: 1px solid #e8f5e8;
            }

            .info-label {
                font-weight: 500;
                color: #4caf50;
                font-size: 0.9em;
                margin-bottom: 5px;
                display: block;
            }

            .info-value {
                color: #333;
                line-height: 1.4;
            }

            .description-item {
                grid-column: 1 / -1;
            }

            .edit-profile-btn {
                background: #66bb6a;
                color: white;
                border: none;
                padding: 12px 25px;
                border-radius: 6px;
                font-size: 1em;
                cursor: pointer;
            }

            .profile-sidebar {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .sidebar-btn {
                background: #f8fdf8;
                border: 1px solid #e8f5e8;
                padding: 15px;
                border-radius: 6px;
                text-decoration: none;
                color: #333;
                display: flex;
                align-items: center;
                gap: 10px;
                cursor: pointer;
            }

            .btn-icon {
                width: 18px;
                height: 18px;
            }

            .edit-modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                align-items: center;
                justify-content: center;
            }

            .modal-content {
                background: white;
                padding: 30px;
                border-radius: 10px;
                width: 90%;
                max-width: 500px;
                max-height: 80vh;
                overflow-y: auto;
                position: relative;
            }

            .modal-close {
                position: absolute;
                right: 15px;
                top: 15px;
                font-size: 24px;
                color: #999;
                cursor: pointer;
            }

            .modal-title {
                font-size: 1.4em;
                color: #2e7d32;
                margin-bottom: 20px;
                text-align: center;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-label {
                display: block;
                color: #333;
                margin-bottom: 5px;
                font-weight: 500;
            }

            .form-input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }

            .form-input:focus {
                outline: none;
                border-color: #66bb6a;
            }

            .file-upload {
                position: relative;
                width: 100%;
            }

            .file-upload input[type=file] {
                position: absolute;
                opacity: 0;
                width: 100%;
                height: 100%;
                cursor: pointer;
            }

            .file-upload-label {
                display: block;
                padding: 10px;
                border: 1px dashed #66bb6a;
                border-radius: 4px;
                text-align: center;
                cursor: pointer;
                background: #f8fdf8;
            }

            .avatar-preview-container {
                display: flex;
                align-items: center;
                gap: 10px;
                margin: 10px 0;
                padding: 10px;
                background: #f8fdf8;
                border-radius: 4px;
            }

            .avatar-preview-img {
                display: none;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                border: 2px solid #66bb6a;
                object-fit: cover;
            }

            .avatar-filename {
                font-size: 14px;
                color: #666;
            }

            .save-btn {
                background: #66bb6a;
                color: white;
                border: none;
                padding: 12px;
                border-radius: 4px;
                font-size: 1em;
                cursor: pointer;
                width: 100%;
                margin-top: 15px;
            }

            .alert {
                padding: 12px;
                margin: 15px 0;
                border-radius: 4px;
            }

            .alert-success {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .alert-error {
                background: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            @media (max-width: 768px) {
                .profile-container {
                    grid-template-columns: 1fr;
                    padding: 20px;
                }

                .company-info-grid {
                    grid-template-columns: 1fr;
                }

                .modal-content {
                    width: 95%;
                    padding: 20px;
                }
            }
        </style>



    </head>
    <body>
        <div class="profile-container">
            <div class="profile-main">
<!--                <img class="company-avatar" src="viewLogo?name=<%= employer.getNameEmployer() %>" alt="Company Logo" id="companyLogoImg">-->
                <img class="company-avatar" src="${pageContext.request.contextPath}/img/<%= employer.getImgLogo() %>" id="companyLogoImg" alt="Chưa cập nhật" />
                <h2 class="company-name">
                    <%= employer.getNameEmployer() != null && !employer.getNameEmployer().trim().isEmpty() ? employer.getNameEmployer() : "Chưa cập nhật" %>
                </h2>
                <div class="company-info-grid">
                    <div class="info-item">
                        <span class="info-label">Email</span>
                        <span class="info-value">
                            <%= employer.getEmail() != null && !employer.getEmail().trim().isEmpty() ? employer.getEmail() : "Chưa cập nhật" %>
                        </span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Tên công ty</span>
                        <span class="info-value">
                            <%= employer.getCompanyName() != null && !employer.getCompanyName().trim().isEmpty() ? employer.getCompanyName() : "Chưa cập nhật" %>
                        </span>
                    </div>
                    <div class="info-item description-item">
                        <span class="info-label">Mô tả công ty</span>
                        <span class="info-value">
                            <%= employer.getDescription() != null && !employer.getDescription().trim().isEmpty() ? employer.getDescription() : "Chưa cập nhật" %>
                        </span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Website</span>
                        <span class="info-value">
                            <%= employer.getUrlWebsite() != null && !employer.getUrlWebsite().trim().isEmpty() ? employer.getUrlWebsite() : "Chưa cập nhật" %>
                        </span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Địa chỉ</span>
                        <span class="info-value">
                            <%= employer.getLocation() != null && !employer.getLocation().trim().isEmpty() ? employer.getLocation() : "Chưa cập nhật" %>
                        </span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Số điện thoại</span>
                        <span class="info-value">
                            <%= employer.getPhoneNumber() != null && !employer.getPhoneNumber().trim().isEmpty() ? employer.getPhoneNumber() : "Chưa cập nhật" %>
                        </span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Mã số thuế</span>
                        <span class="info-value">
                            <%= employer.getTaxCode() != null && !employer.getTaxCode().trim().isEmpty() ? employer.getTaxCode() : "Chưa cập nhật" %>
                        </span>
                    </div>
                </div>
                <button class="edit-profile-btn" onclick="openEditModal()">
                    ✏️ Chỉnh sửa thông tin
                </button>
            </div>


            <div class="profile-sidebar">
                <a href="<%= request.getContextPath() %>/log/ChangePassword.jsp" class="sidebar-btn">
                    <svg class="btn-icon" viewBox="0 0 20 20">
                    <path fill="#666" d="M10 2a4 4 0 0 1 4 4v2h1a1 1 0 0 1 1 1v9a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1v-9a1 1 0 0 1 1-1h1V6a4 4 0 0 1 4-4zm2 6V6a2 2 0 1 0-4 0v2h4zm-7 2v7h10v-7H5zm5 2a1 1 0 0 1 1 1a1 1 0 1 1-2 0a1 1 0 0 1 1-1z"/>
                    </svg>
                    Thay đổi mật khẩu
                </a>

                <a href="<%= request.getContextPath() %>/LogOut" class="sidebar-btn">
                    <svg class="btn-icon" viewBox="0 0 20 20">
                    <path fill="#666" d="M16 13v-2h-6v-2h6V7l5 3l-5 3zm-2-8V2H2v16h12v-3h-2v1H4V4h8v1h2z"/>
                    </svg>
                    Đăng Xuất
                </a>

                <button class="sidebar-btn" onclick="navigateToHome()">
                    <svg class="btn-icon" viewBox="0 0 20 20">
                    <path fill="#666" d="M10 3.293l7 7V18a1 1 0 0 1-1 1h-4v-5H8v5H4a1 1 0 0 1-1-1v-7.707l7-7zm-7.707 8.707a1 1 0 0 1 0-1.414l8-8a1 1 0 0 1 1.414 0l8 8a1 1 0 0 1-1.414 1.414L17 11.414V18a3 3 0 0 1-3 3h-4a3 3 0 0 1-3-3v-6.586l-1.293 1.293a1 1 0 0 1-1.414-1.414z"/>
                    </svg>
                    Trang chủ
                </button>
            </div>
        </div>

        <div class="edit-modal" id="profileEditModal">
            <div class="modal-content">
                <span class="modal-close" onclick="closeEditModal()">×</span>
                <h3 class="modal-title">Chỉnh sửa thông tin công ty</h3>
                <form action="employerProfile" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="form-label">Email công ty</label>
                        <input type="email" name="email" id="companyEmailInput" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Số điện thoại</label>
                        <input type="tel" name="phoneNumber" id="companyPhoneInput" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Tên công ty</label>
                        <input type="text" name="companyName" id="companyNameInput" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Mô tả công ty</label>
                        <textarea name="description" id="companyDescInput" class="form-input" rows="4" required></textarea>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Website công ty</label>
                        <input type="url" name="urlWebsite" id="companyUrlInput" class="form-input">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Địa chỉ công ty</label>
                        <input type="text" name="location" id="companyAddressInput" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Logo công ty</label>
                        <div class="file-upload">
                            <input type="file" name="file" id="logoFileInput" accept="image/*">
                            <label for="logoFileInput" class="file-upload-label">
                                Chọn ảnh logo từ máy tính
                            </label>
                        </div>
                        <div class="avatar-preview-container">
                            <img id="logoPreviewImg" class="avatar-preview-img" alt="Logo Preview">
                            <span id="logoFilenameDisplay" class="avatar-filename"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Mã số thuế</label>
                        <input type="text" name="taxCode" id="companyTaxCodeInput" class="form-input" required>
                    </div>

                    <button type="submit" class="save-btn">Lưu thông tin</button>
                </form>
            </div>
        </div>

        <script>
            function openEditModal() {
                document.getElementById('profileEditModal').style.display = 'flex';
                document.getElementById('companyEmailInput').value = '<%=employer.getEmail()%>';
                document.getElementById('companyPhoneInput').value = '<%=employer.getPhoneNumber()%>';
                document.getElementById('companyNameInput').value = '<%=employer.getCompanyName()%>';
                document.getElementById('companyDescInput').value = '<%=employer.getDescription()%>';
                document.getElementById('companyUrlInput').value = '<%=employer.getUrlWebsite()%>';
                document.getElementById('companyAddressInput').value = '<%=employer.getLocation()%>';
                document.getElementById('companyTaxCodeInput').value = '<%=employer.getTaxCode()%>';
            }

            function closeEditModal() {
                document.getElementById('profileEditModal').style.display = 'none';
            }

            function navigateToHome() {
                window.location.href = "/Project_RecruitmentWebsite/index.jsp";
            }

            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('logoFileInput').addEventListener('change', function (event) {
                    const file = event.target.files[0];
                    const preview = document.getElementById('logoPreviewImg');
                    const filename = document.getElementById('logoFilenameDisplay');

                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            preview.src = e.target.result;
                            preview.style.display = 'block';
                        }
                        reader.readAsDataURL(file);
                        filename.textContent = file.name;
                    } else {
                        preview.style.display = 'none';
                        filename.textContent = '';
                    }
                });

                document.getElementById('profileEditModal').addEventListener('click', function (event) {
                    if (event.target === this) {
                        closeEditModal();
                    }
                });
            });
        </script>
        <%
   String successMessage = (String) request.getAttribute("successMessage");
   String errorMessage = (String) request.getAttribute("errorMessage");
        %>
        <script>
            <% if (successMessage != null) { %>
            Swal.fire({
                icon: 'success',
                title: 'Thành công!',
                text: '<%= successMessage %>',
                confirmButtonText: 'OK'
            });
            <% } else if (errorMessage != null) { %>
            Swal.fire({
                icon: 'error',
                title: 'Lỗi!',
                text: '<%= errorMessage %>',
                confirmButtonText: 'OK'
            });
            <% } %>
        </script>

    </body>
</html>