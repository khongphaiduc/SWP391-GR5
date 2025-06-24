<%-- 
    Document   : IconActionMenu
    Created on : Jun 23, 2025, 4:04:12 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="img/favicon.ico" rel="icon">
        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap" rel="stylesheet">
        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
           
        <link href="<%= request.getContextPath() %>/css/ActionMenuCSS.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    </head>
    <body>


        <div class="floating-actions-v2">

            <%
            // Kiểm tra session và vai trò Admin
            if (session.getAttribute("username") != null && 
                session.getAttribute("role") != null && 
                session.getAttribute("role").equals("Admin")) {
            %>
            <div class="fab-item fab-heart" title="Admin Dashboard">
                <a href="<%= request.getContextPath() %>/adminhome.jsp" target="_self" id="favorite-btn-v2" class="fab-btn">
                    <i class="bi bi-gear-fill"></i>
                    <c:if test="${username != null}">
                        <span class="fab-badge" id="favorite-count-v2">${numberJobPost}</span>
                    </c:if>
                </a>
                <span class="fab-hover-label">Admin</span>
            </div>
            <%
                }
            %>
            <div class="fab-item fab-heart" title="Việc làm yêu thích">
                <a href="<%= request.getContextPath() %>/DisplayListJobPostSaveOfCandidate" target="_self" id="favorite-btn-v2" class="fab-btn" >
                    <i class="bi bi-heart-fill"></i>
                </a>
                <span class="fab-hover-label">Danh sách việc làm đã lưu</span>
            </div>
            <div class="fab-item" title="Góp ý">
                <a  href="<%= request.getContextPath() %>/ViewActionMenu/FeedbackAndReport.jsp" target="_self" class="fab-btn">
                    <i class="bi bi-envelope-fill"></i>
                </a>
                <span class="fab-hover-label">Báo Cáo và Góp ý</span>
            </div>

            <div class="fab-item" title="Tin Nhắn">

                <c:if test="${role eq 'Admin'}">
                    <a  href="<%= request.getContextPath() %>/WebSocket_Chat_User/ChatWithUser.jsp" target="_blank" class="fab-btn">
                        <i class="bi bi-chat-dots"></i>
                    </a>
                    <span class="fab-hover-label">Hệ Thông Chat Với User </span>
                </c:if>


                <c:if test="${role!='Admin' && role !=null}">
                    <a  href="<%= request.getContextPath() %>/WebSocket_Chat_TeamSupport/ChatWithSupportTeam.jsp" target="_blank" class="fab-btn">
                        <i class="bi bi-chat-dots"></i>
                    </a>
                    <span class="fab-hover-label">Vào Phòng Chat</span>
                </c:if>

                <c:if test="${role==null}">
                    <a  href="<%= request.getContextPath() %>/log/login.jsp" target="_self" class="fab-btn">
                        <i class="bi bi-chat-dots"></i>
                    </a>

                </c:if>


            </div>

            <div class="fab-item" title="Hỗ trợ" style="z-index:10000;">
                <button class="fab-btn" id="openSupportPanel" type="button">
                    <i class="bi bi-headset"></i>
                </button>
                <span class="fab-hover-label">Hỗ trợ</span>
            </div>

            <div class="support-popup" id="supportPopup" style="display:none;">
                <div class="support-popup-header d-flex align-items-center justify-content-between" style="background: #15c564; color:#fff; padding: 18px 18px 13px 18px; border-radius: 12px 12px 0 0;">
                    <div>
                        <div style="font-size:1.18rem; font-weight:700;">Trung tâm hỗ trợ </div>
                        <div class="d-flex align-items-center mt-2">
                            <img src="https://genk.mediacdn.vn/thumb_w/640/139269124445442048/2024/6/1/photo-1-17168606131071257137350-1717278776106716631383.jpg" alt="avatar" class="rounded-circle" style="width:38px; height:38px; object-fit:cover; margin-right:10px;">
                            <div>
                                <div style="font-weight:600;">Sơn Tùng MTP</div>
                                <div style="font-size:0.97rem;">GenZTimViec thường phản hồi trong vòng 24h</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="support-popup-body">
                    <!--                        <a class="support-popup-link" href="#" target="_blank">
                                                <i class="bi bi-person"></i> Hướng dẫn quản lý tài khoản
                                            </a>-->
                    <a class="support-popup-link" href="#" target="_blank">
                        <i class="bi bi-question-circle"></i> Các câu hỏi thường gặp
                    </a>
                    <!--                        <a class="support-popup-link" href="SupportUser" target="_blank">
                                                <i class="bi bi-file-earmark-text"></i>Gửi Report
                                            </a>-->
                    <a class="support-popup-link" href="#" id="contactButton">
                        <i class="bi bi-telephone"></i> Liên hệ GenZTimViec
                    </a>
                </div>
            </div>
        </div>

        <!--                       Sub Action Menu -->

        <!-- hiển thị thong tin liên hệ -->
        <div id="contactModal" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.4);">
            <div style="background:#fff; border-radius:10px; max-width:600px; margin:100px auto; padding:24px 16px 16px 16px; position:relative; box-shadow:0 2px 8px rgba(0,0,0,0.2);">
                <div style="text-align:center;">
                    <div style="color:#24963F; font-weight:600; font-size:20px; margin-bottom:8px;">Liên hệ</div>
                    <div style="font-weight:500; color:#222; margin-bottom:8px;">
                        GenZTimViec cam kết sẽ xử lý các vấn đề của bạn trong vòng tối đa 24h.
                    </div>
                    <div style="margin-bottom:8px;">
                        Tổng đài: <span style="color:#24963F; font-weight:600;">999999 nhé cái ngài </span>
                        <span style="color:#24963F;">(Giờ hành chính)</span>
                    </div>
                    <div style="margin-bottom:8px;">
                        Trong trường hợp không liên lạc được, vui lòng gửi hỗ trợ tới email: <br>
                        <a href="mailto:hotro@genztimviec.vn" style="color:#24963F; font-weight:600;">hotro@genztimviec.vn</a>
                    </div>
                    <div style="margin-bottom:16px;">
                        Xin cảm ơn!
                    </div>
                    <button id="closeModalBtn" style="padding: 8px 24px; border:none; background:#E4E6EB; border-radius:6px; font-size:16px; cursor:pointer;">Đóng lại</button>
                </div>
            </div>
        </div>
        <script>
            const supportBtn = document.getElementById("openSupportPanel");
            const supportPopup = document.getElementById("supportPopup");
            const closeBtn = document.getElementById("closeSupportPanel");

            supportBtn.onclick = function (e) {
                // Toggle panel
                if (supportPopup.style.display === "block") {
                    supportPopup.style.display = "none";
                } else {
                    supportPopup.style.display = "block";
                }
            };

            // Đóng popup khi bấm nút X
            closeBtn.onclick = function () {
                supportPopup.style.display = "none";
            };

            // Đóng popup khi click ra ngoài panel
            document.addEventListener('mousedown', function (e) {
                if (
                        supportPopup.style.display === "block" &&
                        !supportPopup.contains(e.target) &&
                        !supportBtn.contains(e.target)
                        ) {
                    supportPopup.style.display = "none";
                }
            });
        </script>

        <script>
// Show modal on click
            document.getElementById('contactButton').onclick = function (e) {
                e.preventDefault();
                document.getElementById('contactModal').style.display = 'block';
            };
// Hide modal on close
            document.getElementById('closeModalBtn').onclick = function () {
                document.getElementById('contactModal').style.display = 'none';
            };
// Optional: hide modal when clicking outside the modal box
            document.getElementById('contactModal').onclick = function (event) {
                if (event.target === this) {
                    this.style.display = 'none';
                }
            };
        </script>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    </body>
</html>
