<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Gửi Feedback cho Đội Ngũ Phát Triển</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700&display=swap">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/FeedBackCSS.css">
    </head>
    <body>
        <div class="animated-bg"></div>
        <div class="feedback-container">
            <div class="feedback-title">
                <span class="icon-rot"><i class="bi bi-chat-dots"></i></span>
                Gửi ý kiến đóng góp tới GenZTimViec
            </div>
            <div class="feedback-desc">
                Chúng tôi luôn lắng nghe mọi phản hồi để cải thiện sản phẩm tốt hơn!
            </div>
            <form action="<%= request.getContextPath() %>/FeedBackSV" method="post">
                <div class="mb-3">
                    <label for="title" class="form-label">Tiêu đề</label>
                    <select name="titel" class="form-select" id="title" required>
                        <option value="" selected disabled>Chọn tiêu đề phản hồi</option>
                        <option value="Góp ý tính năng">Góp ý tính năng</option>
                        <option value="Báo lỗi">Ý Kiến Về Giao Diện</option>
                        <option value="Khác">Khác</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="feedback" class="form-label">Nội dung chi tiết <span class="text-danger">*</span></label>
                    <textarea name="content" class="form-control" id="feedback" rows="4" required placeholder="Vui lòng mô tả chi tiết góp ý, vấn đề hoặc đề xuất cải thiện..."></textarea>
                </div>
                <div class="d-flex gap-3 mt-2">
                    <a  href="<%= request.getContextPath() %>/Index" target="_self" class="btn-cancel flex-grow-1" style="text-decoration: none ;display: flex;justify-content: center">
                        <span class="btn-wave"></span>
                        <i class="bi bi-x-circle me-1"></i> Hủy
                    </a>
                    <button type="submit" class="btn-green flex-grow-1">
                        <span class="btn-wave"></span>
                        <i class="bi bi-send-fill me-1"></i> Gửi Feedback
                    </button>
                </div>
                <div class="feedback-note">
                    <i class="bi bi-lightbulb"></i>
                    Ý kiến của bạn hôm nay là thành quả của chúng tôi ngày mai.<br>
                    <span class="small">Chúng tôi sẽ phản hồi bạn sớm nhất qua email.</span>
                </div>
            </form>
            <!-- Tab trạng thái gửi feedback -->
            <%
                String statusSendFeedback = (String) request.getAttribute("statusSendFeedback");
                if (statusSendFeedback != null && !statusSendFeedback.trim().isEmpty()) {
            %>
            <div class="feedback-status-tab" id="feedbackStatusTab">
                <i class="bi bi-info-circle-fill"></i>
                <%= statusSendFeedback %>
            </div>
            <%
                }
            %>
        </div>
        <script>
            window.addEventListener('DOMContentLoaded', function () {
                var tab = document.getElementById('feedbackStatusTab');
                if (tab) {
                    // Bước 1: Slide xuống giữa màn hình
                    setTimeout(function () {
                        tab.classList.add('show');
                    }, 200); // delay nhỏ cho mượt

                    // Bước 2: Dừng 3 giây rồi ẩn đi
                    setTimeout(function () {
                        tab.classList.remove('show');
                        tab.classList.add('hide');
                    }, 3200); // 200ms hiệu ứng + 3000ms hiển thị
                }
            });
        </script>
    </body>
</html>