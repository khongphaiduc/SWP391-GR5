<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <title>Chat với đội ngũ hỗ trợ GenZTimViec.Vn</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/chatWithAdminCss.css">
    </head>
    <body>
         <jsp:include page="/IconActionMenu.jsp" />
        <a id="idUser" data-id="${idUser}" style="display: none"></a>
        <a id="nameUser" data-name="${username}" style="display: none"></a>
        <div class="chat-container">
            <header class="chat-header">
                <img src="https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/1/26/874469/Son-Tung-Dep-Trai-5..jpg" alt="Support" class="chat-logo">
                <span style="display: flex;justify-content: center">Chat với đội ngũ hỗ trợ GenZTimViec.Vn</span>
            </header>
            <a style="display: none" id="dataInfor" data-info="${infoUser.picture}"></a>    
            <div class="chat-body" id="chatBody">
                <div class="message support" id="1">

                </div>
                <div class="message support" id="2">

                </div>
                <div class="message support" id="3">

                </div>
                <div class="message support" id="4">

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
            const IgmageUser = document.getElementById('dataInfor').dataset.info;
            const iduser = document.getElementById('idUser').dataset.id;
            const nameuser = document.getElementById('nameUser').dataset.name;
            const SUPPORT_USERNAME = 'ducadmin';
            const SUPPORT_AVATAR = "https://5sfashion.vn/storage/upload/images/ckeditor/4KG2VgKFDJWqdtg4UMRqk5CnkJVoCpe5QMd20Pf7.jpg";

            const websocket = new WebSocket("ws://" + window.location.host + "/Project_RecruitmentWebsite/websocket_Chat");

            websocket.onopen = function () {
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
                div.innerHTML = `<img class="avatar" src="` + IgmageUser + `" alt="User avatar" onerror="this.src='/images/user-avatar.png'"><div class="content">` + message + `</div>`;
                chatbody.appendChild(div);

                websocket.send(JSON.stringify({
                    type: 'private',
                    to: SUPPORT_USERNAME,
                    message: message,
                    image: IgmageUser
                }));

                contentchat.value = '';
                chatbody.scrollTop = chatbody.scrollHeight;
            });

            websocket.onmessage = function (event) {
                let data;
                try {
                    data = JSON.parse(event.data);
                } catch (e) {
                    data = {from: '', message: event.data, image: ''};
                }
                // Chỉ nhận tin nhắn từ support hoặc hệ thống
                if (data.from && data.from !== nameuser) {
                    const div = document.createElement('div');
                    div.classList.add('message', 'support');
                    div.innerHTML = `<img class="avatar" src="` + data.image + `" alt="Support avatar"><div class="content">` + data.message + `</div>`;
                    chatbody.appendChild(div);
                    chatbody.scrollTop = chatbody.scrollHeight;
                }
            };
        </script>
        
<!--        lưu vào database-->
        <script>
            
            
            
            
            
            
            
            
            
            
        </script>
        
        
        
        
<!--        tin nhắn tự động-->
        <script>

            const thongbao1 = document.getElementById('1');
            const thongbao2 = document.getElementById('2');
            const thongbao3 = document.getElementById('3');
            const thongbao4 = document.getElementById('4');
            setTimeout(function () {
                thongbao1.innerHTML = `<img class="avatar" src="https://5sfashion.vn/storage/upload/images/ckeditor/4KG2VgKFDJWqdtg4UMRqk5CnkJVoCpe5QMd20Pf7.jpg" alt="Support avatar">
                    <div class="content">Xin chào! Đây là tin nhắn tự động</div>`
            }, 1000);


            setTimeout(function () {
                thongbao2.innerHTML = `  <img class="avatar" src="https://5sfashion.vn/storage/upload/images/ckeditor/4KG2VgKFDJWqdtg4UMRqk5CnkJVoCpe5QMd20Pf7.jpg" alt="Support avatar">
                    <div class="content">Hãy gửi lời chào tới đội ngũ hỗ trợ để chúng tôi có thể kết nối với bạn</div>`
            }, 2500);

            setTimeout(function () {
                thongbao3.innerHTML = `  <img class="avatar" src="https://5sfashion.vn/storage/upload/images/ckeditor/4KG2VgKFDJWqdtg4UMRqk5CnkJVoCpe5QMd20Pf7.jpg" alt="Support avatar">
                    <div class="content">Cuộc hội thoại này sẽ không được lưu lại , vui lòng chỉ đóng khi vấn để của bạn đã được giải quyết .</div>`
            }, 4500);

            setTimeout(function () {
                thongbao4.innerHTML = `  <img class="avatar" src="https://5sfashion.vn/storage/upload/images/ckeditor/4KG2VgKFDJWqdtg4UMRqk5CnkJVoCpe5QMd20Pf7.jpg" alt="Support avatar">
                    <div class="content">Chúc Bạn Một Ngày Tốt Lành Xin Cảm Ơn.</div>`
            }, 5500);




        </script>
    </body>
</html>