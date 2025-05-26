<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Hồ sơ cá nhân - Đặc biệt</title>
        <link rel="stylesheet"  href="<%= request.getContextPath() %>/css/profilecss.css" >
    </head>
    <body>
        <div class="profile-background"></div>
        <div class="profile-container">
            <div class="profile-main">
                <div class="avatar-glow">
                    <img class="profile-avatar" src="../img/avata.jpg" alt="avatar" id="avatar-img">
                    <button class="edit-avatar-btn" onclick="showAvatarModal()">✏️</button>
                </div>
                <h2 id="user-name">Phạm Trung Đức</h2>
                <div class="info-list" id="info-list">
                    <div><span class="info-label">Email:</span> <span id="user-email">Phạm Trung Đức</span></div>
                    <div><span class="info-label">Số điện thoại:</span> <span id="user-phone">9999999</span></div>
                    <div><span class="info-label">Ngày sinh:</span> <span id="user-birth">//////</span></div>
                    <div><span class="info-label">Giới tính:</span> <span id="user-gender">Nam</span></div>
                    <div><span class="info-label">Địa chỉ:</span> <span id="user-address">nnnnn</span></div>
                    <div><span class="info-label">Vai trò:</span> <span id="user-role">Developer</span></div>
                </div>
                <button class="edit-info-btn" onclick="showEditModal()">Chỉnh sửa thông tin</button>
                <p class="bio" id="user-bio">“Tôi không đi theo số đông, tôi khác biệt Sơn Tùng-MTP”</p>
            </div>
            <div class="profile-sidebar">

                <button onclick="showAvatarModal()">
                    <span class="icon">
                        <svg width="20" height="20" viewBox="0 0 20 20"><path fill="#fff" d="M17.7 6.29a1 1 0 0 0 0-1.41l-2.58-2.58a1 1 0 0 0-1.41 0l-8.08 8.08A1 1 0 0 0 5.5 11v2.5a1 1 0 0 0 1 1H9a1 1 0 0 0 .71-.29l8.08-8.08zM6.5 12.5V11.91l7.08-7.08.59.59-7.08 7.08H6.5zm8.79-8.79l.59.59-1.18 1.18-.59-.59 1.18-1.18z"/></svg>
                    </span>
                    Thay đổi Avatar
                </button>

                <a  href="<%= request.getContextPath() %>/log/ChangePassword.jsp"  >
                    <button>
                        <span class="icon">
                            <svg width="20" height="20" viewBox="0 0 20 20">
                            <path fill="#fff" d="M10 2a4 4 0 0 1 4 4v2h1a1 1 0 0 1 1 1v9a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1v-9a1 1 0 0 1 1-1h1V6a4 4 0 0 1 4-4zm2 6V6a2 2 0 1 0-4 0v2h4zm-7 2v7h10v-7H5zm5 2a1 1 0 0 1 1 1a1 1 0 1 1-2 0a1 1 0 0 1 1-1z"/>
                            </svg>
                        </span>
                        Thay đổi mật khẩu
                    </button>
                </a>

          




                <a  href="<%= request.getContextPath() %>/LogOut"  >
                    <button class="logout-btn" >
                        <span style="width: 95px" class="icon">
                            <svg width="30" height="20" viewBox="0 0 20 20"><path fill="#fff" d="M16 13v-2h-6v-2h6V7l5 3l-5 3zm-2-8V2H2v16h12v-3h-2v1H4V4h8v1h2z"/></svg>
                        </span>
                        Đăng Xuất
                    </button>
                </a>

                <button class="home-btn" onclick="goHome()">
                    <span class="icon">
                        <svg width="20" height="20" viewBox="0 0 20 20"><path fill="#fff" d="M10 3.293l7 7V18a1 1 0 0 1-1 1h-4v-5H8v5H4a1 1 0 0 1-1-1v-7.707l7-7zm-7.707 8.707a1 1 0 0 1 0-1.414l8-8a1 1 0 0 1 1.414 0l8 8a1 1 0 0 1-1.414 1.414L17 11.414V18a3 3 0 0 1-3 3h-4a3 3 0 0 1-3-3v-6.586l-1.293 1.293a1 1 0 0 1-1.414-1.414z"/></svg>
                    </span>
                    Trang chủ
                </button>

            </div>
        </div>



        <!-- Modal Chỉnh sửa thông tin -->
        <div class="modal" id="edit-modal">
            <div class="modal-content">
                <span class="close" onclick="closeEditModal()">&times;</span>
                <h3>Chỉnh sửa thông tin cá nhân</h3>
                <form onsubmit="saveInfo(event)">
                    <label>Họ tên</label>
                    <input type="text" id="edit-name" required>
                    <label>Email</label>
                    <input type="email" id="edit-email" required>
                    <label>Số điện thoại</label>
                    <input type="text" id="edit-phone" required>
                    <label>Ngày sinh</label>
                    <input type="date" id="edit-birth" required>
                    <label>Giới tính</label>
                    <select id="edit-gender">
                        <option value="Nam">Nam</option>
                        <option value="Nữ">Nữ</option>
                        <option value="Khác">Khác</option>
                    </select>
                    <label>Địa chỉ</label>
                    <input type="text" id="edit-address" required>
                    <label>Vai trò</label>
                    <input type="text" id="edit-role" required>
                    <label>Bio</label>
                    <textarea id="edit-bio" rows="2"></textarea>
                    <button type="submit" class="modal-btn">Lưu thông tin</button>
                </form>
            </div>
        </div>

        <!-- Modal Đổi avatar (Chọn file local) -->
        <div class="modal" id="avatar-modal">
            <div class="modal-content">
                <span class="close" onclick="closeAvatarModal()">&times;</span>
                <h3>Đổi ảnh đại diện</h3>
                <form onsubmit="changeAvatar(event)">
                    <label>Chọn ảnh mới từ máy tính</label>
                    <input type="file" id="avatar-file" accept="image/*" required>
                    <div style="display:flex;align-items:center;gap:7px;margin:8px 0;">
                        <img id="avatar-preview" src="" alt="Preview" style="display:none;width:60px;height:60px;border-radius:50%;border:2px solid #eee;">
                        <span id="avatar-filename" style="font-size:0.95em;color:#888;"></span>
                    </div>
                    <button type="submit" class="modal-btn">Cập nhật ảnh</button>
                </form>
            </div>
        </div>

        <script>
            // Modal Password


            // Modal Edit Info
            function showEditModal() {
                document.getElementById('edit-modal').style.display = 'flex';
                document.getElementById('edit-name').value = document.getElementById('user-name').childNodes[0].nodeValue.trim();
                document.getElementById('edit-email').value = document.getElementById('user-email').innerText;
                document.getElementById('edit-phone').value = document.getElementById('user-phone').innerText;
                document.getElementById('edit-birth').value = formatDateForInput(document.getElementById('user-birth').innerText);
                document.getElementById('edit-gender').value = document.getElementById('user-gender').innerText;
                document.getElementById('edit-address').value = document.getElementById('user-address').innerText;
                document.getElementById('edit-role').value = document.getElementById('user-role').innerText;
                document.getElementById('edit-bio').value = document.getElementById('user-bio').innerText;
            }
            function closeEditModal() {
                document.getElementById('edit-modal').style.display = 'none';
            }
            function saveInfo(e) {
                e.preventDefault();
                document.getElementById('user-name').childNodes[0].nodeValue = document.getElementById('edit-name').value;
                document.getElementById('user-email').innerText = document.getElementById('edit-email').value;
                document.getElementById('user-phone').innerText = document.getElementById('edit-phone').value;
                document.getElementById('user-birth').innerText = formatDateForDisplay(document.getElementById('edit-birth').value);
                document.getElementById('user-gender').innerText = document.getElementById('edit-gender').value;
                document.getElementById('user-address').innerText = document.getElementById('edit-address').value;
                document.getElementById('user-role').innerText = document.getElementById('edit-role').value;
                document.getElementById('user-bio').innerText = document.getElementById('edit-bio').value;
                closeEditModal();
            }
            function formatDateForInput(d) {
                const s = d.split('/');
                if (s.length === 3)
                    return `${s[2]}-${s[1].padStart(2,'0')}-${s[0].padStart(2,'0')}`;
                            return "";
                        }
                        function formatDateForDisplay(d) {
                            const s = d.split('-');
                            if (s.length === 3)
                                return `${s[2]}/${s[1]}/${s[0]}`;
                                        return "";
                                    }

                                    // Modal Avatar - Chọn file local
                                    function showAvatarModal() {
                                        document.getElementById('avatar-modal').style.display = 'flex';
                                        document.getElementById('avatar-file').value = '';
                                        document.getElementById('avatar-preview').style.display = 'none';
                                        document.getElementById('avatar-filename').innerText = '';
                                    }
                                    function closeAvatarModal() {
                                        document.getElementById('avatar-modal').style.display = 'none';
                                    }
                                    function changeAvatar(e) {
                                        e.preventDefault();
                                        const fileInput = document.getElementById('avatar-file');
                                        if (fileInput.files && fileInput.files[0]) {
                                            const reader = new FileReader();
                                            reader.onload = function (e) {
                                                document.getElementById('avatar-img').src = e.target.result;
                                                closeAvatarModal();
                                            };
                                            reader.readAsDataURL(fileInput.files[0]);
                                        }
                                    }
                                    // Xem trước avatar khi chọn file
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

                                    // Trang chủ
                                    function goHome() {
                                        window.location.href = "/Project_RecruitmentWebsite/index.jsp";
                                    }
        </script>
    </body>
</html>