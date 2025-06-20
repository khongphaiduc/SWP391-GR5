<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Support Chat Interface</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            /* ... giữ nguyên CSS như trước ... */
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
                overflow: hidden;
                background: linear-gradient(to right, #e3f0ff 0%, #f7f7f7 100%);
            }
            .chat-container {
                height: 95vh;
                margin: 20px auto;
                border-radius: 18px;
                background: #fff;
                box-shadow: 0 4px 24px rgba(0,0,0,0.09);
                display: flex;
            }
            .row.h-100 {
                flex: 1;
                display: flex;
                height: 100%;
                margin: 0;
            }
            .col-9, .col-3 {
                height: 100%;
            }
            .col-9 {
                display: flex;
                flex-direction: column;
                padding: 0;
            }
            .user-list {
                background: #f5f8fa;
                height: 100%;
                display: flex;
                flex-direction: column;
            }
            .chat-sidebar-header {
                padding: 1rem;
                background: #f1f4fa;
                border-bottom: 1px solid #ddd;
            }
            .user-list-scroll {
                flex: 1;
                overflow-y: auto;
                scrollbar-width: none;
                -ms-overflow-style: none;
            }
            .user-list-scroll::-webkit-scrollbar {
                display: none;
            }
            .user-item {
                padding: 12px;
                display: flex;
                align-items: center;
                gap: 10px;
                cursor: pointer;
                transition: background 0.2s;
            }
            .user-item:hover, .user-item.active {
                background: #e3f0ff;
            }
            .sidebar-footer {
                text-align: center;
                font-size: 0.9rem;
                color: #777;
                padding: 0.5rem;
                background: #f1f4fa;
                border-top: 1px solid #ddd;
            }
            .user-status {
                font-size: 0.8rem;
            }
            .avatar {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                object-fit: cover;
            }
            .chat-box {
                flex: 1;
                display: flex;
                flex-direction: column;
                height: 100%;
            }
            .chat-header, .chat-input-area {
                background: #f1f4fa;
                padding: 1rem;
                flex-shrink: 0;
                border-bottom: 1px solid #ddd;
            }
            .chat-messages {
                flex: 1;
                overflow-y: auto;
                padding: 1rem;
                background: #fafdff;
                scroll-behavior: smooth;
                scrollbar-width: none;
                -ms-overflow-style: none;
            }
            .chat-messages::-webkit-scrollbar {
                display: none;
            }
            .chat-message {
                display: flex;
                align-items: flex-end;
                margin-bottom: 18px;
                gap: 8px;
            }
            .chat-message.sent {
                justify-content: flex-end;
            }
            .chat-message.received {
                justify-content: flex-start;
            }
            .msg-bubble {
                padding: 12px 18px;
                border-radius: 20px;
                max-width: 60%;
                min-width: fit-content;
                word-break: break-word;
                white-space: normal;
                font-size: 1rem;
            }
            .sent-bubble {
                background: #4f8cff;
                color: white;
            }
            .received-bubble {
                background: #e4e9f7;
                color: black;
            }
            .msg-time {
                font-size: 0.75rem;
                color: #666;
                margin-top: 4px;
            }
            .user-item .unread-dot {
                width: 10px;
                height: 10px;
                background: #f44336;
                border-radius: 50%;
                display: inline-block;
                margin-left: 5px;
            }
        </style>
    </head>
    <body>
        <a id="nameSupport" data-name="ducadmin" style="display:none"></a>
        <div class="container chat-container">
            <div class="row h-100 w-100">
                <div class="col-3 user-list p-0">
                    <div class="chat-sidebar-header d-flex align-items-center">
                        <i class="bi bi-people me-2 fs-5 text-primary"></i>
                        <strong>Danh sách khách hàng</strong>
                    </div>
                    <div class="user-list-scroll" id="userList">
                        <!-- Danh sách khách sẽ render ở đây -->
                    </div>
                    <div class="sidebar-footer">
                        <i class="bi bi-headset text-primary me-1"></i> Hỗ trợ 24/7
                    </div>
                </div>
                <div class="col-9">
                    <div class="chat-box">
                        <div class="chat-header d-flex align-items-center" id="chatHeader">
                            <img src="https://cmcts.com.vn/media/data/users/doi-ngu-nhan-vien-giau-kinh-nghiem.jpg" class="avatar me-2" id="chatHeaderAvatar">
                            <div>
                                <strong id="chatHeaderName" >Chọn khách hàng để chat</strong><br>
                                <small class="text-success" id="chatHeaderStatus"></small>
                            </div>
                        </div>

                        <a style="display: none" id="dataInfor" data-info="${infoUser.picture}"></a>    
                        
                        <div class="chat-messages" id="chatMessages">
                            <div style="text-align:center;color:#aaa;margin-top:2em;">Chọn khách hàng bên trái để bắt đầu chat</div>


                            <!--                            gửi đi -->
                            <div class="chat-message sent ">
                                <div>
                                    <div class="msg-bubble sent-bubble"> alo </div>
                                    <div class="msg-time text-end">12</div>
                                </div>
                            </div>

                            <!--                                  nhận đến-->

                            <div class="chat-message received">
                                <div>
                                    <div class="msg-bubble  received-bubble">em chào anh đưc</div>
                                    <div class="msg-time text-end ">123</div>
                                </div>
                            </div>

                        </div>

                        <div class="chat-input-area">
                            <form class="d-flex gap-2" id="inputform">
                                <input type="text" id="chatInput" class="form-control rounded-pill" placeholder="Nhập tin nhắn..." autocomplete="off" required disabled>
                                <button class="btn btn-primary rounded-circle" type="submit" disabled>
                                    <i class="bi bi-send"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            const  IgmageUser = document.getElementById('dataInfor').dataset.info;  
            let users = []; // Tự động thêm user khi nhận message
            let conversations = {}; // { userId: [ {from, message, time}, ... ] }         // lưu lại  cuộc chat riêng của từng  thằng user
            let unread = {}; // { userId: true/false }                : dùng để dánh dấu xem tin nhắn đã xem hay chưa 
            let currentUser = null;  // đại  diện cho đang làm việc với khác hàng nào 

            const nameSupport = document.getElementById('nameSupport').dataset.name || "ducadmin";   // tên thằng  support  
            const userListDiv = document.getElementById('userList');                         // danh sách khách hàng cần phản  hồi 
            const chatMessagesDiv = document.getElementById('chatMessages');
            const chatHeaderName = document.getElementById('chatHeaderName');
            const chatHeaderAvatar = document.getElementById('chatHeaderAvatar');
            const chatHeaderStatus = document.getElementById('chatHeaderStatus');
            const chatInput = document.getElementById('chatInput');              // tin nhắn gửi đi
            const inputForm = document.getElementById('inputform');              // form gửi tin nhắn
            const sendBtn = inputForm.querySelector('button');


            //hiện thị danh sách các khách hàng nhắn tin tới cho thằng support 
            function renderUserList() {
                userListDiv.innerHTML = '';
                users.forEach(user => {
                    const div = document.createElement('div');
                    div.className = 'user-item' + (currentUser === user.id ? ' active' : '');
                    div.dataset.userid = user.id;
                    div.innerHTML = `
                        <img src="` + user.avatar + `" class="avatar">
                        <div>
                            <div class="fw-bold">` + user.name + `</div>
                            <div class="user-status text-success">
                                <i class="bi bi-dot"></i> Online
            ${unread[user.id] ? '<span class="unread-dot"></span>' : ''}
                            </div>
                        </div>
                    `;
                    div.onclick = () => selectUser(user.id);
                    userListDiv.appendChild(div);
                });
            }

            function selectUser(userId) {
                currentUser = userId;
                unread[userId] = false;  // khi support chọn thì đánh dấu lại là đã đọc
                renderUserList();
                renderChatHeader();
                renderChatMessages();
                chatInput.disabled = false;
                sendBtn.disabled = false;
                chatInput.focus(); //Khi chạy đoạn đó, con trỏ (caret) sẽ tự động nhảy vào ô nhập tin nhắn.
            }

            function renderChatHeader() {
                const user = users.find(u => u.id === currentUser);
                if (!user)
                    return;
                chatHeaderAvatar.src = user.avatar;
                chatHeaderName.textContent = user.name;
                chatHeaderStatus.innerHTML = `<i class="bi bi-dot"></i> Đang hoạt động`;
            }


            // đoạn chat
            function renderChatMessages() {
                chatMessagesDiv.innerHTML = '';
                if (!currentUser) {
                    chatMessagesDiv.innerHTML = '<div style="text-align:center;color:#aaa;margin-top:2em;">Chọn khách hàng bên trái để bắt đầu chat ??</div>';
                    chatInput.disabled = true;
                    sendBtn.disabled = true;
                    return;
                }
                const msgs = conversations[currentUser] || [];
                msgs.forEach(msg => {
                    const isSent = msg.from === nameSupport; // ✅ ĐÚNG
                    console.log("content:", msg.message);
                    let html;

                    if (isSent) {
                        //  support  là người gửi
                        html = `
                <div class="chat-message sent">
                    <div>
                        <div class="msg-bubble sent-bubble">` + msg.message + `</div>
                    
                    </div>
                </div>
            `;
                    } else {
                        //  Khi user khác là người gửi
                        html = `
                <div class="chat-message received">
                    <div>
                        <div class="msg-bubble received-bubble">` + msg.message + `</div>
                      
                    </div>
                </div>
            `;
                    }

                    chatMessagesDiv.insertAdjacentHTML('beforeend', html);
                });
                chatMessagesDiv.scrollTop = chatMessagesDiv.scrollHeight;
            }


            function getAvatar(userId) {
                const u = users.find(u => u.id === userId);
                return u ? u.avatar : 'https://randomuser.me/api/portraits/lego/1.jpg';
            }


            // gửi lại cho thằng user
            inputForm.addEventListener('submit', function (event) {
                event.preventDefault();
                const text = chatInput.value.trim();
                if (!text || !currentUser)
                    return;

                if (!conversations[currentUser])
                    conversations[currentUser] = [];
                conversations[currentUser].push({from: nameSupport, message: text, time: getTimeNow()});

                if (websocket.readyState === WebSocket.OPEN) {
                    websocket.send(JSON.stringify({
                        type: 'private',
                        to: currentUser,
                        message: text
                    }));
                }

                chatInput.value = '';
                renderChatMessages();
            });

            function getTimeNow() {
                const d = new Date();
                return d.getHours().toString().padStart(2, '0') + ':' + d.getMinutes().toString().padStart(2, '0');
            }

            const websocket = new WebSocket("ws://" + window.location.host + "/Project_RecruitmentWebsite/websocket_Chat");

            websocket.onopen = function () {
                websocket.send(JSON.stringify({
                    type: 'register',
                    username: nameSupport
                }));
                console.log("Kết nối WebSocket thành công cho support");
            };


            // nhận tin  nhắn tới từ user
            websocket.onmessage = function (event) {
                let data;
                try {
                    data = JSON.parse(event.data);
                } catch (e) {
                    data = {from: null, message: event.data};
                }
                const fromUser = data.from;      // xem thằng nào gửi 
                const message = data.message; // lấy đoạn hội thoại của thằng gửi 
                const image = data.image;    // lấy ảnh thằng user
                if (fromUser && fromUser !== nameSupport) {
                    // Nếu user chưa có trong danh sách thì thêm vào
                    if (!users.some(u => u.id === fromUser)) {
                        users.push({
                            id: fromUser,
                            name: fromUser,
                            avatar:  image
                        });
                        renderUserList();  // kiểm tra nếu chưa có trong users thì reder lại 
                    }
                    if (!conversations[fromUser])
                        conversations[fromUser] = [];   // kiểm tra xem có tồn tại đoạn trò chuyện trước đó không nếu không thì tao 1 object mới đê lưu
                    conversations[fromUser].push({from: fromUser, message: message, time: getTimeNow()});
                    if (currentUser === fromUser) {
                        renderChatMessages();  // nếu thằng gửi và thằng mà support đang chat là cùng 1 thằng thì nó render lại 
                    } else {
                        unread[fromUser] = true;
                        renderUserList();   // còn không thì đánh dấu lại  chưa đọc và render lại listUser
                    }
                }
            };

            websocket.onerror = function (err) {
                console.error("WebSocket lỗi:", err);
            };

            websocket.onclose = function () {
                console.warn("WebSocket đã đóng.");
            };

            renderUserList();
            renderChatMessages();
        </script>
    </body>
</html>