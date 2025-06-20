
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <title>Chat với đội ngũ hỗ trợ</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/chatWithAdminCss.css">
    </head>
    <body>
        <a id="idUser" data-id="${idUser}" style="display: none"></a>
        <a id="nameUser" data-name="${username}" style="display: none"></a>
        <div class="chat-container">
            <header class="chat-header">
                <img src="https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/1/26/874469/Son-Tung-Dep-Trai-5..jpg" alt="Support" class="chat-logo">
                <span style="display: flex;justify-content: center">Đội ngũ hỗ trợ</span>
            </header>
            <a style="display: none" id="dataInfor" data-info="${infoUser.picture}"></a>    
            <div class="chat-body" id="chatBody">
                <div class="message support">
                    <div class="avatar"></div>
                    <div class="content">Xin chào! Đây là tin nhắn tự động</div>
                </div>
                <div class="message support">
                    <div class="avatar"></div>
                    <div class="content">Vui lòng trờ đợi để kết nối với nhân viên hỗ trợ cho bạn</div>
                </div>
            </div>
            <form class="chat-input-area" id="chatForm" autocomplete="off">
                <input type="text" id="chatInput" placeholder="Nhập tin nhắn..." autocomplete="off" required>
                <button type="submit">
                    <svg width="20" height="20" fill="none" viewBox="0 0 24 24">
                    <path d="M2 21L23 12L2 3V10L17 12L2 14V21Z" fill="currentColor"/>
                    </svg>
                </button>
            </form>
        </div>
        <script>
            const  IgmageUser = document.getElementById('dataInfor').dataset.info;
            const iduser = document.getElementById('idUser').dataset.id;
            const nameuser = document.getElementById('nameUser').dataset.name;
            const SUPPORT_USERNAME = 'ducadmin'; // Đảm bảo đúng với username support

            const websocket = new WebSocket("ws://" + window.location.host + "/Project_RecruitmentWebsite/websocket_Chat");

            websocket.onopen = function () {  //  thằng này chạy đúng 1 lần lúc connect với Websocket 
                websocket.send(JSON.stringify({
                    type: 'register',
                    username: nameuser
                }));
                console.log("Kết nối WebSocket thành công");
            };

            const chatForm = document.getElementById('chatForm');
            const chatbody = document.getElementById('chatBody');
            const contentchat = document.getElementById('chatInput');

            chatForm.addEventListener('submit', function (event) {
                event.preventDefault();
                const message = contentchat.value.trim();
                if (message === "")
                    return;

                const div = document.createElement('div');
                div.classList.add('message', 'user');
                div.innerHTML = `<div class="avatar"></div><div class="content">` + message + `</div>`;
                chatbody.appendChild(div);

                websocket.send(JSON.stringify({
                    type: 'private',
                    to: SUPPORT_USERNAME,
                    message: message,
                    image:  IgmageUser
                }));

                contentchat.value = '';
                chatbody.scrollTop = chatbody.scrollHeight;
            });

            websocket.onmessage = function (event) {
                let data;
                try {
                    data = JSON.parse(event.data);
                } catch (e) {
                    data = {from: '', message: event.data};
                }
                // Chỉ nhận tin nhắn từ support hoặc hệ thống
                if (data.from && data.from !== nameuser) {
                    const div = document.createElement('div');
                    div.classList.add('message', data.from === 'system' ? 'support' : 'support');
                    div.innerHTML = `<div class="avatar"></div><div class="content">` + data.message + `</div>`;
                    chatbody.appendChild(div);
                    chatbody.scrollTop = chatbody.scrollHeight;
                }
            };
        </script>
    </body>
</html>