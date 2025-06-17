<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="Models.*" %>
<%
    Candidate candidate = (Candidate)request.getAttribute("candidate");
%>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Hồ sơ ứng viên - Đặc biệt</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f0f7f0;
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

            .candidate-avatar {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid #4caf50;
                margin: 0 auto 20px;
                background: #f0f7f0;
            }

            .candidate-name {
                font-size: 2em;
                color: #2e7d32;
                margin-bottom: 10px;
                font-weight: 600;
            }

            .candidate-email {
                color: #666;
                font-size: 1.1em;
                margin-bottom: 25px;
            }

            .candidate-info-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
                margin-bottom: 25px;
                text-align: left;
            }

            .info-item {
                background: #f1f8e9;
                padding: 15px;
                border-radius: 8px;
                border: 1px solid #dcedc8;
            }

            .info-label {
                font-weight: 600;
                color: #388e3c;
                font-size: 0.9em;
                margin-bottom: 5px;
                display: block;
            }

            .info-value {
                color: #333;
                line-height: 1.4;
            }

            .full-width {
                grid-column: 1 / -1;
            }

            .edit-profile-btn {
                background: linear-gradient(135deg, #4caf50, #388e3c);
                color: white;
                border: none;
                padding: 14px 30px;
                border-radius: 8px;
                font-size: 1em;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .edit-profile-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
            }

            .profile-sidebar {
                display: flex;
                flex-direction: column;
                gap: 12px;
            }

            .sidebar-btn {
                background: #f1f8e9;
                border: 1px solid #dcedc8;
                padding: 16px;
                border-radius: 8px;
                text-decoration: none;
                color: #333;
                display: flex;
                align-items: center;
                gap: 12px;
                cursor: pointer;
                transition: all 0.2s ease;
                font-weight: 500;
            }

            .sidebar-btn:hover {
                background: #dcedc8;
                transform: translateX(5px);
            }

            .btn-icon {
                width: 20px;
                height: 20px;
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
                border-radius: 12px;
                width: 90%;
                max-width: 600px;
                max-height: 85vh;
                overflow-y: auto;
                position: relative;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }

            .modal-close {
                position: absolute;
                right: 15px;
                top: 15px;
                font-size: 28px;
                color: #999;
                cursor: pointer;
                font-weight: bold;
            }

            .modal-close:hover {
                color: #333;
            }

            .modal-title {
                font-size: 1.5em;
                color: #2e7d32;
                margin-bottom: 25px;
                text-align: center;
                font-weight: 600;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }

            .form-label {
                display: block;
                color: #333;
                margin-bottom: 8px;
                font-weight: 600;
                color: #388e3c;
            }

            .form-input {
                width: 100%;
                padding: 12px;
                border: 2px solid #dcedc8;
                border-radius: 6px;
                font-size: 14px;
                transition: border-color 0.3s ease;
            }

            .form-input:focus {
                outline: none;
                border-color: #4caf50;
                box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
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
                padding: 12px;
                border: 2px dashed #4caf50;
                border-radius: 6px;
                text-align: center;
                cursor: pointer;
                background: #f1f8e9;
                transition: all 0.3s ease;
            }

            .file-upload-label:hover {
                background: #dcedc8;
                border-color: #388e3c;
            }

            .avatar-preview-container {
                display: flex;
                align-items: center;
                gap: 12px;
                margin: 15px 0;
                padding: 12px;
                background: #f1f8e9;
                border-radius: 6px;
                border: 1px solid #dcedc8;
            }

            .avatar-preview-img {
                display: none;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                border: 2px solid #4caf50;
                object-fit: cover;
            }

            .avatar-filename {
                font-size: 14px;
                color: #666;
                font-weight: 500;
            }

            .save-btn {
                background: linear-gradient(135deg, #4caf50, #388e3c);
                color: white;
                border: none;
                padding: 14px;
                border-radius: 6px;
                font-size: 1em;
                cursor: pointer;
                width: 100%;
                margin-top: 20px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .save-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
            }

            .alert {
                padding: 12px;
                margin: 15px auto;
                border-radius: 6px;
                font-weight: 500;
                text-align: center;
                max-width: 600px;
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

            .age-display {
                font-size: 0.9em;
                color: #666;
                margin-top: 5px;
            }

            @media (max-width: 768px) {
                .profile-container {
                    grid-template-columns: 1fr;
                    padding: 20px;
                }

                .candidate-info-grid {
                    grid-template-columns: 1fr;
                }

                .form-row {
                    grid-template-columns: 1fr;
                }

                .modal-content {
                    width: 95%;
                    padding: 20px;
                }

                .candidate-name {
                    font-size: 1.6em;
                }
            }
        </style>
    </head>
    <body>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% String successMessage = (String) request.getAttribute("successMessage"); %>

        <% if (errorMessage != null) { %>
        <div class="alert alert-error">
            <%= errorMessage %>
        </div>
        <% } else if (successMessage != null) { %>
        <div class="alert alert-success">
            <%= successMessage %>
        </div>
        <% } %>

        <div class="profile-container">
            <div class="profile-main">
                <img class="candidate-avatar" src="viewLogo?name=<%= candidate.getCandidateName() %>" alt="Avatar" id="candidateAvatarImg" onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjEyMCIgdmlld0JveD0iMCAwIDEyMCAxMjAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIxMjAiIGhlaWdodD0iMTIwIiBmaWxsPSIjZjBmNGZmIi8+CjxjaXJjbGUgY3g9IjYwIiBjeT0iNDAiIHI9IjIwIiBmaWxsPSIjNGE5MGUyIi8+CjxwYXRoIGQ9Ik0yMCA5MEM3MCA3MCA5MCA3MCA5MCA5MEgyMFoiIGZpbGw9IiM0YTkwZTIiLz4KPC9zdmc+'">

                <h2 class="candidate-name">
                    <%= candidate.getCandidateName() != null && !candidate.getCandidateName().trim().isEmpty() ? candidate.getCandidateName() : "Chưa cập nhật" %>
                </h2>

                <p class="candidate-email">
                    <%= candidate.getEmail() != null && !candidate.getEmail().trim().isEmpty() ? candidate.getEmail() : "Chưa cập nhật email" %>
                </p>

                <div class="candidate-info-grid">
                    <div class="info-item">
                        <span class="info-label">📍 Địa chỉ</span>
                        <span class="info-value">
                            <%= candidate.getAddress() != null && !candidate.getAddress().trim().isEmpty() ? candidate.getAddress() : "Chưa cập nhật" %>
                        </span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">🎂 Ngày sinh</span>
                        <span class="info-value">
                            <% if (candidate.getBirthday() != null) { %>
                            <%= candidate.getBirthday().toString() %>
                            <div class="age-display">
                                <script>
                                        const birthDate = new Date('<%= candidate.getBirthday().toString() %>');
                                        const today = new Date();
                                        let age = today.getFullYear() - birthDate.getFullYear();
                                        const monthDiff = today.getMonth() - birthDate.getMonth();
                                        if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
                                            age--;
                                        }
                                        document.write('(' + age + ' tuổi)');
                                </script>
                            </div>
                            <% } else { %>
                            Chưa cập nhật
                            <% } %>
                        </span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">🌍 Quốc tịch</span>
                        <span class="info-value">
                            <%= candidate.getNationality() != null && !candidate.getNationality().trim().isEmpty() ? candidate.getNationality() : "Chưa cập nhật" %>
                        </span>
                    </div>

                    <div class="info-item">
                        <span class="info-label">📧 Email liên hệ</span>
                        <span class="info-value">
                            <%= candidate.getEmail() != null && !candidate.getEmail().trim().isEmpty() ? candidate.getEmail() : "Chưa cập nhật" %>
                        </span>
                    </div>
                </div>

                <button class="edit-profile-btn" onclick="openEditModal()">
                    ✏️ Chỉnh sửa thông tin cá nhân
                </button>
            </div>

            <div class="profile-sidebar">
                <a href="<%= request.getContextPath() %>/log/ChangePassword.jsp" class="sidebar-btn">
                    <svg class="btn-icon" viewBox="0 0 20 20">
                    <path fill="#4caf50" d="M10 2a4 4 0 0 1 4 4v2h1a1 1 0 0 1 1 1v9a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1v-9a1 1 0 0 1 1-1h1V6a4 4 0 0 1 4-4zm2 6V6a2 2 0 1 0-4 0v2h4zm-7 2v7h10v-7H5zm5 2a1 1 0 0 1 1 1a1 1 0 1 1-2 0a1 1 0 0 1 1-1z"/>
                    </svg>
                    Thay đổi mật khẩu
                </a>

                <button class="sidebar-btn" onclick="navigateToHome()">
                    <svg class="btn-icon" viewBox="0 0 20 20">
                    <path fill="#4caf50" d="M10 3.293l7 7V18a1 1 0 0 1-1 1h-4v-5H8v5H4a1 1 0 0 1-1-1v-7.707l7-7zm-7.707 8.707a1 1 0 0 1 0-1.414l8-8a1 1 0 0 1 1.414 0l8 8a1 1 0 0 1-1.414 1.414L17 11.414V18a3 3 0 0 1-3 3h-4a3 3 0 0 1-3-3v-6.586l-1.293 1.293a1 1 0 0 1-1.414-1.414z"/>
                    </svg>
                    Trang chủ
                </button>

                <a href="<%= request.getContextPath() %>/LogOut" class="sidebar-btn">
                    <svg class="btn-icon" viewBox="0 0 20 20">
                    <path fill="#4caf50" d="M16 13v-2h-6v-2h6V7l5 3l-5 3zm-2-8V2H2v16h12v-3h-2v1H4V4h8v1h2z"/>
                    </svg>
                    Đăng Xuất
                </a>
            </div>
        </div>

        <!-- Edit Modal -->
        <div class="edit-modal" id="profileEditModal">
            <div class="modal-content">
                <span class="modal-close" onclick="closeEditModal()">×</span>
                <h3 class="modal-title">Chỉnh sửa thông tin cá nhân</h3>

                <form action="candidateProfile" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="form-label">Tên đăng nhập</label>
                        <input type="text" name="candidateName" id="candidateNameInput" class="form-input" required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" id="candidateEmailInput" class="form-input" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Ngày sinh</label>
                            <input type="date" name="birthday" id="candidateBirthdayInput" class="form-input" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Địa chỉ</label>
                        <input type="text" name="address" id="candidateAddressInput" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Quốc tịch</label>
                        <input type="text" name="nationality" id="candidateNationalityInput" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Ảnh đại diện</label>
                        <div class="file-upload">
                            <input type="file" name="avatar" id="avatarFileInput" accept="image/*">
                            <label for="avatarFileInput" class="file-upload-label">
                                📷 Chọn ảnh đại diện từ máy tính
                            </label>
                        </div>
                        <div class="avatar-preview-container">
                            <img id="avatarPreviewImg" class="avatar-preview-img" alt="Avatar Preview">
                            <span id="avatarFilenameDisplay" class="avatar-filename"></span>
                        </div>
                    </div>

                    <button type="submit" class="save-btn">💾 Lưu thông tin</button>
                </form>
            </div>
        </div>

        <script>
            function openEditModal() {
                document.getElementById('profileEditModal').style.display = 'flex';

                // Pre-fill form with current data
                document.getElementById('candidateNameInput').value = '<%=candidate.getCandidateName() != null ? candidate.getCandidateName() : ""%>';
                document.getElementById('candidateEmailInput').value = '<%=candidate.getEmail() != null ? candidate.getEmail() : ""%>';
                document.getElementById('candidateAddressInput').value = '<%=candidate.getAddress() != null ? candidate.getAddress() : ""%>';
                document.getElementById('candidateNationalityInput').value = '<%=candidate.getNationality() != null ? candidate.getNationality() : ""%>';

            <% if (candidate.getBirthday() != null) { %>
                document.getElementById('candidateBirthdayInput').value = '<%=candidate.getBirthday().toString()%>';
            <% } %>
            }

            function closeEditModal() {
                document.getElementById('profileEditModal').style.display = 'none';
            }

            function navigateToHome() {
                window.location.href = "/Project_RecruitmentWebsite/index.jsp";
            }

            function navigateToJobs() {
                window.location.href = "/Project_RecruitmentWebsite/jobs";
            }

            function navigateToApplications() {
                window.location.href = "/Project_RecruitmentWebsite/myApplications";
            }

            // File upload preview functionality
            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('avatarFileInput').addEventListener('change', function (event) {
                    const file = event.target.files[0];
                    const preview = document.getElementById('avatarPreviewImg');
                    const filename = document.getElementById('avatarFilenameDisplay');

                    if (file) {
                        // Validate file size (max 5MB)
                        if (file.size > 5 * 1024 * 1024) {
                            alert('File quá lớn! Vui lòng chọn file nhỏ hơn 5MB.');
                            event.target.value = '';
                            return;
                        }

                        // Validate file type
                        if (!file.type.startsWith('image/')) {
                            alert('Vui lòng chọn file hình ảnh!');
                            event.target.value = '';
                            return;
                        }

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

                // Close modal when clicking outside
                document.getElementById('profileEditModal').addEventListener('click', function (event) {
                    if (event.target === this) {
                        closeEditModal();
                    }
                });

                // Handle ESC key to close modal
                document.addEventListener('keydown', function (event) {
                    if (event.key === 'Escape') {
                        closeEditModal();
                    }
                });
            });
        </script>
    </body>
</html>