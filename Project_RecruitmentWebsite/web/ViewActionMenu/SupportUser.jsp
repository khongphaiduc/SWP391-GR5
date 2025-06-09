<%-- 
    Document   : SupportUser
    Created on : Jun 4, 2025, 11:24:56 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Báo cáo hỗ trợ</title>
        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
            <form>
                <div class="mb-3">
                    <label for="fullname" class="form-label">Họ và tên</label>
                    <input type="text" class="form-control" id="fullname" placeholder="Nhập họ và tên của bạn" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email liên hệ</label>
                    <input type="email" class="form-control" id="email" placeholder="Nhập email của bạn" required>
                </div>
                <div class="mb-3">
                    <label for="subject" class="form-label">Tiêu đề báo cáo</label>
                    <select class="form-select" id="subject" required>
                        <option value="">-- Chọn tiêu đề --</option>
                        <option>Sự cố kỹ thuật</option>
                        <option>Yêu cầu hỗ trợ</option>
                        <option>Báo lỗi giao diện</option>
                        <option>Đề xuất tính năng mới</option>
                        <option>Khác...</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="message" class="form-label">Nội dung báo cáo</label>
                    <textarea class="form-control" id="message" rows="4" placeholder="Mô tả chi tiết vấn đề bạn gặp phải" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary w-100"><span>Gửi báo cáo</span></button>
            </form>
            <div class="mt-3 text-muted small text-center">
                Đội ngũ hỗ trợ của GenZTimViec sẽ phản hồi bạn qua email sớm nhất có thể.
            </div>
        </div>
        <!-- Bootstrap JS (nếu cần) -->
        <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> -->
    </body>
</html>