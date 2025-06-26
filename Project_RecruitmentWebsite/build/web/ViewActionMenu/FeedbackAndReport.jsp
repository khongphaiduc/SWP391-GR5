<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Ticket và Feedback</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700&display=swap">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/FeedBackCSS.css">
    </head>
    <body>
        <jsp:include page="/IconActionMenu.jsp" />

        <div class="animated-bg"></div>
        <div class="feedback-container">
            <div class="feedback-title">
                <span class="icon-rot"><i class="bi bi-chat-dots"></i></span>
                Tạo ticket yêu cầu hỗ trợ và feedback
            </div>
            <div class="feedback-desc">
                Chúng tôi luôn lắng nghe và phản hổi cho bạn một cách sớm nhất 
            </div>
            <form action="<%= request.getContextPath() %>/FeebBackAndSupport" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="title" class="form-label">Tiêu đề</label>
                    <select name="titel" class="form-select" id="title" required>
                        <option value="" selected disabled>Chọn chủ đề</option>
                        <option value="Góp ý tính năng">Góp ý tính năng</option>
                        <option value="Báo lỗi">Ý Kiến Về Giao Diện</option>
                        <option value="Góp ý tính năng">Lỗi Thanh Toán</option>
                        <option value="Báo lỗi">Lỗi Không Tạo Được CV</option>
                        <option value="Báo lỗi">Service không hoạt động</option>
                        <option value="Khác">Khác</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="phone" class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                    <input type="tel" name="phone" class="form-control" id="phone" required placeholder="Nhập số điện thoại của bạn" pattern="[0-9]{10,15}">
                </div>

                <div class="mb-3">
                    <label for="fileReport" class="form-label">Ảnh mô tả <span class="text-danger">*</span></label>
                    <div class="custom-file-input-wrapper">
                        <input type="file" name="fileReport" id="fileReport" class="custom-file-input" required accept="image/jpeg,image/png,image/gif,image/webp" onchange="validateFIle(this)">
                        <label for="fileReport" class="custom-file-label" id="fileLabel">
                            <i class="bi bi-cloud-upload"></i> Chọn hoặc kéo ảnh vào đây
                        </label>
                        <img src="" id="previewImg" class="preview-img" style="display:none;" alt="Ảnh xem trước">
                    </div>
                    <div class="form-text text-muted">Hỗ trợ: JPG, PNG, GIF, WEBP. Dung lượng tối đa 5MB.</div>
                </div>

                <div class="mb-3">
                    <label for="content" class="form-label" >Nội dung chi tiết <span class="text-danger">*</span></label>
                    <textarea name="content" class="form-control" id="feedback" rows="4" required placeholder="Vui lòng mô tả chi tiết góp ý, vấn đề hoặc đề xuất cải thiện..."></textarea>
                </div>

                <div class="d-flex gap-3 mt-2">
                    <a  href="<%= request.getContextPath() %>/Index" target="_self" class="btn-cancel flex-grow-1" style="text-decoration: none ;display: flex;justify-content: center">
                        <span class="btn-wave"></span>
                        <i class="bi bi-x-circle me-1"></i> Hủy
                    </a>
                    <button type="submit" class="btn-green flex-grow-1">
                        <span class="btn-wave"></span>
                        <i class="bi bi-send-fill me-1"></i> Gửi 
                    </button>
                </div>
                <div class="feedback-note">
                    <i class="bi bi-lightbulb"></i>
                    Ý kiến của bạn hôm nay là thành quả của chúng tôi ngày mai.<br>
                    <span class="small">Chăm sóc khách hàng của chúng tôi sẽ liên hệ với bạn sớm nhất và gửi phản hồi qua email </span>
                </div>
            </form>
            <% String statusSendFeedback = (String) request.getAttribute("statusReport");
           if (statusSendFeedback != null && !statusSendFeedback.trim().isEmpty()) { %>
            <div class="feedback-status-tab" id="feedbackStatusTab">
                <i class="bi bi-info-circle-fill"></i>
                <%= statusSendFeedback %>
            </div>
            <% } %>
        </div>
        <script>
            window.addEventListener('DOMContentLoaded', function () {
                var tab = document.getElementById('feedbackStatusTab');
                if (tab) {
                    setTimeout(function () {
                        tab.classList.add('show');
                    }, 200);
                    setTimeout(function () {
                        tab.classList.remove('show');
                        tab.classList.add('hide');
                    }, 3200);
                }

                // Xem trước ảnh khi chọn file
                const fileInput = document.getElementById('fileReport');   // file user gửi lên 
                const previewImg = document.getElementById('previewImg');       // xem file user gửi lên
                const fileLabel = document.getElementById('fileLabel'); 
                fileInput.addEventListener('change', function (e) {
                    if (fileInput.files && fileInput.files[0]) {               //fileInput.files là 1 thuộc tính của thẻ input return về FileList mà user đẫ chọn
                        const file = fileInput.files[0];
                        const reader = new FileReader();  // FileReader dùng để đọc nội dung ảnh và chuyển sang dạng base64
                        reader.onload = function (ev) {
                            previewImg.src = ev.target.result;
                            previewImg.style.display = 'block';
                            fileLabel.innerText = file.name;   // dùng để hiện tên mà ảnh user gửi lên UI
                        };
                        reader.readAsDataURL(file);
                    } else {
                        previewImg.src = '';
                        previewImg.style.display = 'none';
                        fileLabel.innerHTML = '<i class="bi bi-cloud-upload"></i> Chọn hoặc kéo ảnh vào đây';
                    }
                });
            });

            function validateFIle(input) {
                const myFile = input.files[0];
                const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
                if (!allowedTypes.includes(myFile.type)) {
                    alert("Chỉ được phép upload hình ảnh (.jpg, .png, .gif, .webp).");
                    input.value = "";
                    document.getElementById('previewImg').style.display = 'none';
                    document.getElementById('fileLabel').innerHTML = '<i class="bi bi-cloud-upload"></i> Chọn hoặc kéo ảnh vào đây';
                } else if (myFile.size > 5 * 1024 * 1024) {
                    alert("Dung lượng ảnh không vượt quá 5MB.");
                    input.value = "";
                    document.getElementById('previewImg').style.display = 'none';
                    document.getElementById('fileLabel').innerHTML = '<i class="bi bi-cloud-upload"></i> Chọn hoặc kéo ảnh vào đây';
                }
            }
        </script>
    </body>
</html>