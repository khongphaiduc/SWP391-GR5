<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Report</title>
    <link href="https://fonts.googleapis.com/css?family=Quicksand:400,600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #43a047;
            --primary-dark: #388e3c;
            --primary-light: #e8f5e9;
            --danger: #e53935;
            --warning: #fbc02d;
            --gray: #e0e0e0;
        }
        body {
            font-family: 'Quicksand', Arial, sans-serif;
            background: var(--primary-light);
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1400px; /* Tăng chiều rộng tổng */
            margin: 44px auto;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 4px 40px #388e3c22;
            padding: 48px 56px 42px 56px; /* Tăng padding */
        }
        h2 {
            color: var(--primary-dark);
            text-align: left;
            letter-spacing: 1px;
            margin-bottom: 36px;
            margin-top: 0;
            font-size: 2.3em; /* To hơn */
        }
        .main-flex {
            display: flex;
            gap: 48px;
            align-items: flex-start;
        }
        .info-block {
            width: 440px;
            min-width: 330px;
            flex-shrink: 0;
        }
        .report-info {
            margin-bottom: 22px;
        }
        .report-info label {
            font-weight: 600;
            color: var(--primary);
            display: inline-block;
            width: 120px;
            font-size: 1.13em;
        }
        .report-info span,
        .report-info div {
            color: #222;
            font-weight: 500;
            font-size: 1.14em;
        }
        /* Khung content (nội dung báo cáo) - CSS mới */
        .content-frame {
            background: #fafdff;
            border: 2.5px solid var(--primary-light);
            border-radius: 16px;
            box-shadow: 0 4px 28px #c8e6c955;
            padding: 38px 48px 36px 48px; /* To hơn */
            margin-bottom: 30px;
            margin-top: 18px;
            position: relative;
            min-height: 160px;
        }
        .content-frame:before {
            content: "Nội dung báo cáo";
            position: absolute;
            top: -21px;
            left: 26px;
            background: #fff;
            color: var(--primary-dark);
            font-weight: 700;
            padding: 0 16px;
            font-size: 1.23em;
            letter-spacing: 0.5px;
            border-radius: 8px;
            box-shadow: 0 2px 10px #e8f5e9cc;
        }
        .report-content {
            font-size: 1.37em; /* To hơn */
            color: #333;
            line-height: 1.7;
            padding: 0;
            background: none;
            border-radius: 0;
            margin: 0;
        }
        /* Ảnh đính kèm chiếm chiều rộng lớn */
        .attachment-section {
            background: #fafdff;
            border: 1.5px solid var(--primary-light);
            border-radius: 12px;
            padding: 22px 28px 16px 28px;
            margin-bottom: 32px;
        }
        .attachment-section h3 {
            margin: 0 0 13px 0;
            color: var(--primary-dark);
            font-size: 1.21em;
        }
        .attachment-images {
            display: flex;
            gap: 24px;
            flex-wrap: wrap;
        }
        .attachment-images img {
            max-width: 420px;
            max-height: 320px;
            border-radius: 10px;
            border: 1.5px solid var(--gray);
            object-fit: cover;
            box-shadow: 0 1px 14px #c8e6c944;
            cursor: pointer;
            transition: transform 0.16s;
        }
        .attachment-images img:hover {
            transform: scale(1.06);
            border: 2px solid var(--primary-dark);
        }
        /* Modal xem ảnh lớn */
        .img-modal {
            display: none;
            position: fixed;
            z-index: 20;
            left: 0; top: 0; width: 100vw; height: 100vh;
            background: rgba(0,0,0,0.5);
        }
        .img-modal-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: absolute;
            left: 50%; top: 50%;
            transform: translate(-50%,-50%);
            background: #fff;
            border-radius: 12px;
            padding: 24px 20px 14px 20px;
            max-width: 95vw;
            max-height: 90vh;
        }
        .img-modal-content img {
            max-width: 80vw;
            max-height: 70vh;
            border-radius: 8px;
        }
        .img-modal-content button {
            margin-top: 16px;
            background: var(--primary-dark);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 8px 26px;
            font-size: 1em;
            cursor: pointer;
            font-weight: 600;
        }
        .response-section {
            margin-top: 32px;
            background: #fafdff;
            border: 1.5px solid var(--primary-light);
            padding: 28px 30px 24px 30px;
            border-radius: 13px;
        }
        .response-section h3 {
            color: var(--primary-dark);
            font-size: 1.18em;
            margin-bottom: 15px;
        }
        .response-section label {
            font-weight: 600;
            color: var(--primary);
            font-size: 1.13em;
        }
        .response-section textarea {
            width: 100%;
            min-height: 100px;
            border-radius: 8px;
            border: 1.2px solid var(--gray);
            font-family: inherit;
            font-size: 1.12em;
            padding: 12px;
            margin: 10px 0 20px 0;
            outline: none;
            resize: vertical;
        }
        .send-btn {
            background: linear-gradient(90deg, var(--primary) 60%, #8bc34a 100%);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 12px 40px;
            font-size: 1.13em;
            font-weight: 600;
            cursor: pointer;
            margin-top: 7px;
            transition: background 0.16s;
        }
        .send-btn:hover {
            background: linear-gradient(90deg, var(--primary-dark) 60%, var(--primary) 100%);
        }
        .msg-success {
            color: var(--primary-dark);
            padding: 8px 0 0 0;
            font-size: 1.13em;
        }
        .msg-error {
            color: var(--danger);
            padding: 8px 0 0 0;
            font-size: 1.13em;
        }
        @media (max-width: 1100px) {
            .container { padding: 18px 2vw 14px 2vw; }
            .main-flex { gap: 20px; }
            .info-block { width: 100%; min-width: unset; }
            .attachment-images img { max-width: 95vw; max-height: 200px; }
            .content-frame { padding: 14px 5vw 12px 5vw; }
        }
        @media (max-width: 700px) {
            .container { padding: 8px 0 8px 0; border-radius: 7px; }
            .attachment-images { gap: 8px; }
            .attachment-section { padding: 8px 3px 8px 3px; }
            .main-flex { flex-direction: column; gap: 0; }
            .content-frame { padding: 8px 2vw 8px 2vw; }
            h2 { font-size: 1.4em; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Chi tiết Report</h2>
        <div class="main-flex">
            <!-- Bên trái: Thông tin -->
            <div class="info-block">
                <div class="report-info">
                    <div><label>ID:</label> <span id="report-id">${ElementViewDetail.id}</span></div>
                    <div><label>Vai trò:</label> <span id="report-role">${ElementViewDetail.role}</span></div>
                    <div><label>SĐT:</label> <span id="report-phone">${ElementViewDetail.phone}</span></div>
                    <div><label>Email:</label> <span id="report-email">ptrungduc1011@gmail.com</span></div>
                    <div><label>Tiêu đề:</label> <span id="report-title">${ElementViewDetail.title}</span></div>
                    <div><label>Ngày gửi:</label> <span id="report-date">${ElementViewDetail.dateSend}</span></div>
                </div>
                <!-- Phản hồi cho user -->
                <div class="response-section">
                    <h3>Phản hồi cho người gửi (Email)</h3>
                    <form onsubmit="return sendEmailResponse();">
                        <label for="response-content">Nội dung phản hồi:</label>
                        <textarea id="response-content" placeholder="Nhập nội dung phản hồi..."></textarea>
                        <button type="submit" class="send-btn">Gửi phản hồi</button>
                        <div id="response-msg"></div>
                    </form>
                </div>
            </div>
            <!-- Bên phải: Ảnh + nội dung -->
            <div style="flex:1; min-width:0">
                <!-- Ảnh đính kèm -->
                <div class="attachment-section">
                    <h3>Ảnh đính kèm</h3>
                    <div class="attachment-images" id="attachment-images">
                        <!-- Thay src thành link ảnh thực tế từ backend -->
                        <img src="${pathImage}" alt="Ảnh đính kèm 1" onclick="showImageModal(this)">
                        <h1>${pathImage}</h1>
                        <!-- Thêm nhiều ảnh nếu có -->
                    </div>
                </div>
                <!-- Khung content rộng & to hơn -->
                <div class="content-frame">
                    <div class="report-content" id="report-content">
                        ${ElementViewDetail.content}
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal xem ảnh lớn -->
    <div class="img-modal" id="img-modal" onclick="closeImageModal()">
        <div class="img-modal-content" onclick="event.stopPropagation()">
            <img id="modal-img" src="" alt="Ảnh phóng to">
            <button onclick="closeImageModal()">Đóng</button>
        </div>
    </div>

    <script>
        // Modal ảnh
        function showImageModal(img) {
            document.getElementById('modal-img').src = img.src;
            document.getElementById('img-modal').style.display = 'flex';
        }
        function closeImageModal() {
            document.getElementById('img-modal').style.display = 'none';
            document.getElementById('modal-img').src = '';
        }

        // Gửi phản hồi cho user bằng email (giả lập)
        function sendEmailResponse() {
            var content = document.getElementById('response-content').value.trim();
            var msgDiv = document.getElementById('response-msg');
            msgDiv.textContent = '';
            if (content.length === 0) {
                msgDiv.textContent = 'Vui lòng nhập nội dung phản hồi.';
                msgDiv.className = 'msg-error';
                return false;
            }
            // TODO: AJAX gửi phản hồi về server để gửi email cho user
            setTimeout(function() {
                msgDiv.textContent = 'Đã gửi phản hồi đến email của người dùng!';
                msgDiv.className = 'msg-success';
                document.getElementById('response-content').value = '';
            }, 600);
            return false;
        }
    </script>
</body>
</html>