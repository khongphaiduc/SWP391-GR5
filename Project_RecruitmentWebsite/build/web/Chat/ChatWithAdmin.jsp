<%-- 
    Document   : ChatWithAdmin  
    Created on : Jun 16, 2025, 1:16:20 PM
    Author     : Admin b
--%>

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
        <div class="chat-container">
            <header class="chat-header">
                <img src="https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/1/26/874469/Son-Tung-Dep-Trai-5..jpg" alt="Support" class="chat-logo">
                <span>Đội ngũ hỗ trợ</span>
            </header>

            <a  href="#"  data-userId="${idUser}" style="text-decoration: none;"> </a>
            <a  href="#"  data-userRole="${role}" style="text-decoration: none;"> </a>

            <div class="chat-body" id="chatBody">
                <!--                 chat bên thằng support-->
                <div class="message support">
                    <div class="avatar"></div>
                    <div class="content">
                        Xin chào! Đây là tin nhắn tự động
                    </div>
                </div>
                <!--                  chat bên thằng user-->
                <div class="message user">
                    <div class="avatar"></div>
                    <div class="content">
                        ô la
                    </div>
                </div>

            </div>
            <form class="chat-input-area" id="chatForm" autocomplete="off">
                <input type="text" id="chatInput" placeholder="Nhập tin nhắn..." autocomplete="off">
                <button type="submit">
                    <svg width="20" height="20" fill="none" viewBox="0 0 24 24">
                    <path d="M2 21L23 12L2 3V10L17 12L2 14V21Z" fill="currentColor"/>
                    </svg>
                </button>
            </form>
        </div>

        <script>

            const dividUser = document.querySelector('[data-userId]');
            const dividRole = document.querySelector('[data-userRole]');
            const idUser = dividUser.getAttribute('data-userId');
            const idRole = dividRole.getAttribute('data-userRole');
            const chatForm = document.getElementById('chatForm');
            const chatInput = document.getElementById('chatInput');
            const chatBody = document.getElementById('chatBody');
            console.log("thằng id" + idUser);
            console.log("thằng role " + idRole);
            chatForm.addEventListener('submit', function (e) {
                e.preventDefault();
                const msg = chatInput.value.trim();
                if (!msg)
                    return;
                // Gửi message lên server
                fetch('/Project_RecruitmentWebsite/SendMessage', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: "senderId=" + idUser +
                            "&senderRole=" + idRole +
                            "&receiverId=1&receiverRole=Admin" +
                            "&content=" + encodeURIComponent(msg)
                }).then(s => {

                    if (s.ok) {
                        console.log('ok');
                    } else {
                        console.log('fail');
                    }
                    chatInput.value = '';
                });


            });

        </script>


        <script>
            var lastId = 0;
            setInterval(function () {

                fetch('/Project_RecruitmentWebsite/GetMessages', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: "senderID=" + idUser +
                            "&reciverID=1&Message_ID=" + lastId
                }).then(js => js.json())
                        .then(messages => {
                            messages.forEach(s => {

                                if (s.messageID > lastId) {
                                    const div = document.createElement('div');
                                    div.className = (s.senderID === idUser) ? 'message user' : 'message support';
                                    div.innerHTML = `
                <div class="avatar"></div>
                <div class="content">` + s.content + `</div>`;

                                    chatBody.appendChild(div);


                                    lastId = s.messageID;


                                    chatBody.scrollTop = chatBody.scrollHeight;
                                }
                            });
                        });

            }, 1000);


        </script>
    </body>
</html>