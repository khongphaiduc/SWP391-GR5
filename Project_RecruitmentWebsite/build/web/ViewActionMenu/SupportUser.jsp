<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Báo cáo hỗ trợ</title>
        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Link tới file CSS riêng -->
        <link rel="stylesheet" href="./css/SupportCss.css">

    </head>
    <body>
        <!-- Animated floating icons background -->
        <div class="animated-bg-icons">
            <!-- Paper plane SVG - Màu cam nổi bật -->
            <svg class="icon1" viewBox="0 0 48 48"><g>
            <polygon points="4,44 44,24 4,4 12,24" fill="#ffa726"/><polygon points="12,24 22,24 4,44" fill="#ffd54f"/><polygon points="12,24 22,24 4,4" fill="#ffffff" opacity="0.75"/>
            </g></svg>
            <!-- Envelope SVG - Màu xanh dương -->
            <svg class="icon2" viewBox="0 0 48 48"><rect x="6" y="14" width="36" height="20" rx="3" fill="#42a5f5"/><polyline points="6,14 24,30 42,14" fill="none" stroke="#fff" stroke-width="2.5"/><rect x="6" y="14" width="36" height="20" rx="3" fill="none" stroke="#1976d2" stroke-width="2"/></svg>
            <!-- Paper plane SVG - Màu tím -->
            <svg class="icon3" viewBox="0 0 48 48"><g>
            <polygon points="4,44 44,24 4,4 12,24" fill="#ba68c8"/><polygon points="12,24 22,24 4,44" fill="#e1bee7"/><polygon points="12,24 22,24 4,4" fill="#fff" opacity="0.7"/>
            </g></svg>
            <!-- Envelope SVG - Màu đỏ hồng -->
            <svg class="icon4" viewBox="0 0 48 48"><rect x="6" y="14" width="36" height="20" rx="3" fill="#ef5350"/><polyline points="6,14 24,30 42,14" fill="none" stroke="#fff" stroke-width="2.5"/><rect x="6" y="14" width="36" height="20" rx="3" fill="none" stroke="#b71c1c" stroke-width="2"/></svg>
            <!-- Paper plane SVG - Màu xanh dương nhạt -->
            <svg class="icon5" viewBox="0 0 48 48"><g>
            <polygon points="4,44 44,24 4,4 12,24" fill="#29b6f6"/><polygon points="12,24 22,24 4,44" fill="#b3e5fc"/><polygon points="12,24 22,24 4,4" fill="#fff" opacity="0.7"/>
            </g></svg>
            <!-- Envelope SVG - Màu vàng -->
            <svg class="icon6" viewBox="0 0 48 48"><rect x="6" y="14" width="36" height="20" rx="3" fill="#ffd54f"/><polyline points="6,14 24,30 42,14" fill="none" stroke="#fff" stroke-width="2.5"/><rect x="6" y="14" width="36" height="20" rx="3" fill="none" stroke="#ffa726" stroke-width="2"/></svg>
            <!-- Paper plane SVG - Màu đỏ tươi -->
            <svg class="icon7" viewBox="0 0 48 48"><g>
            <polygon points="4,44 44,24 4,4 12,24" fill="#ef5350"/><polygon points="12,24 22,24 4,44" fill="#ffcdd2"/><polygon points="12,24 22,24 4,4" fill="#fff" opacity="0.75"/>
            </g></svg>
            <!-- Envelope SVG - Màu tím xanh -->
            <svg class="icon8" viewBox="0 0 48 48"><rect x="6" y="14" width="36" height="20" rx="3" fill="#7e57c2"/><polyline points="6,14 24,30 42,14" fill="none" stroke="#fff" stroke-width="2.5"/><rect x="6" y="14" width="36" height="20" rx="3" fill="none" stroke="#4527a0" stroke-width="2"/></svg>
        </div>
        <div class="support-form-container shadow">
            <h2 class="form-title text-center">Báo cáo sự cố / Hỗ trợ</h2>

            <form id="supportForm" action="<%= request.getContextPath() %>/SupportUser" method="post" enctype="multipart/form-data" autocomplete="off">

                <div class="mb-3">
                    <label for="subject" class="form-label">Loại Sự Cố</label>
                    <select class="form-select" id="subject" name="title" required>
                        <option value="">-- Chọn tiêu đề --</option>
                        <option>Sự cố kỹ thuật</option>
                        <option>Yêu cầu hỗ trợ</option>
                        <option>Báo lỗi giao diện</option>
                        <option>Không đổi được mật khẩu</option>
                        <option>Không Thanh Toán Được</option>
                        <option>Khác...</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="file" class="form-label">Ảnh Mô Tả Lỗi</label>
                    <input type="file" class="form-control" id="file" name="fileReport" required>
                    <div class="mb-3">
                        <label class="form-label">Ảnh của bạn:</label>
                        <div>
                            <img id="previewImage" src="#" alt="Preview" style="max-width: 100%; height: auto; display: none; border: 1px solid #ccc; padding: 5px;" />
                        </div>
                    </div>

                </div>



                <div class="mb-3">
                    <label for="message" class="form-label">Nội dung báo cáo</label>
                    <textarea class="form-control" id="message" name="content" rows="4" placeholder="Mô tả chi tiết vấn đề bạn gặp phải" required></textarea>
                </div>
                <div class="btn-action-group">
                    <button type="submit" class="btn btn-primary"><span>Gửi báo cáo</span></button>
                    <a href="<%= request.getContextPath() %>/Index" class="btn btn-cancel" id="cancelBtn"><span>Hủy</span></a>
                </div>
            </form>

            <div class="mt-3 text-muted small text-center">
                Đội ngũ hỗ trợ của GenZTimViec sẽ phản hồi bạn qua email sớm nhất có thể.
            </div>
        </div>

        <!--                  hiển thị thông báo-->
        <div id="statusReportToast" class="status-report-toast">
            <span id="statusReportMessage"><%= request.getAttribute("statusReport") != null ? request.getAttribute("statusReport") : "" %></span>
        </div>

        <script>
            // Hủy nút: làm trống form và scroll lên đầu
            document.getElementById('cancelBtn').onclick = function () {
                if (confirm('Bạn có chắc muốn hủy Report cáo không?')) {
                    document.getElementById('supportForm').reset();
                    window.scrollTo({top: 0, behavior: 'smooth'});
                }
            };
        </script>
        <script>
            document.getElementById('file').addEventListener('change', function (event) {
                const file = event.target.files[0];
                const preview = document.getElementById('previewImage');

                if (file && file.type.startsWith('image/')) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        preview.src = e.target.result;
                        preview.style.display = 'block';
                    };
                    reader.readAsDataURL(file);
                } else {
                    preview.src = '#';
                    preview.style.display = 'none';
                }
            });
        </script>

        <!--         script của thông báo -->
        <script>
            // Hàm hiển thị toast sau khi submit
            function showStatusReportToast() {
                var toast = document.getElementById('statusReportToast');
                if (!toast)
                    return;
                var message = toast.textContent || toast.innerText;
                if (!message.trim())
                    return; // Không có nội dung thì không hiện

                toast.classList.add('show');
                toast.classList.remove('hide');
                // Sau 3 giây ẩn toast
                setTimeout(function () {
                    toast.classList.remove('show');
                    toast.classList.add('hide');
                    // Optionally, xóa nội dung sau khi ẩn
                    setTimeout(function () {
                        toast.innerHTML = "";
                    }, 700);
                }, 4000);
            }

            // Chỉ hiển thị nếu có nội dung
            window.addEventListener('DOMContentLoaded', function () {
                var toast = document.getElementById('statusReportToast');
                if (toast && (toast.textContent || toast.innerText).trim()) {
                    showStatusReportToast();
                }
            });
        </script>
    </body>
</html>