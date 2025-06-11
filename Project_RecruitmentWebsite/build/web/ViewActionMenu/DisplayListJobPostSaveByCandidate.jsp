<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách JobPost đã lưu</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="./css/SaveJobPostcss.css">
        <link rel="stylesheet" href="../css/phantrangcss.css"/>
        <!--        Style Action Menu-->


        <style>
            .floating-actions-v2 {
                position: fixed;
                bottom: 32px;
                left: 24px;
                z-index: 9999;
                display: flex;
                flex-direction: column;
                gap: 16px;
                align-items: flex-start;
            }
            .fab-item {
                display: flex;
                align-items: center;
                gap: 8px;
                background: rgba(255,255,255,0.97);
                border-radius: 18px;
                box-shadow: 0 8px 32px 0 rgba(20,184,102,0.10), 0 1.5px 8px #1976d211;
                padding: 3px 8px 3px 3px;
                transition: box-shadow 0.18s, transform 0.14s;
            }
            .fab-item:hover {
                box-shadow: 0 12px 32px 0 rgba(20,184,102,0.22), 0 3px 16px #1976d222;
                transform: translateY(-3px) scale(1.03);
            }
            .fab-btn {
                background: linear-gradient(135deg, #38ef7d 60%, #11998e 100%);
                border: none;
                border-radius: 50%;
                box-shadow: 0 2px 12px #14b86633;
                width: 48px;
                height: 48px;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                cursor: pointer;
                transition: background 0.13s, box-shadow 0.13s, transform 0.13s;
                outline: none;
            }
            .fab-btn:active {
                transform: scale(0.95);
            }
            .fab-btn i {
                font-size: 1.45rem;
                color: #fff;
                transition: color .17s;
            }
            .fab-label {
                color: #11998e;
                font-size: 1.04rem;
                font-weight: 600;
                letter-spacing: 0.03em;
                padding: 0 10px;
                border-radius: 10px;
                background: linear-gradient(90deg, #e2fdeb 60%, #e0f7fa 100%);
                margin-left: 2px;
            }
            .fab-heart .fab-btn {
                background: linear-gradient(135deg, #ff4d6d 70%, #14b866 100%);
                box-shadow: 0 2px 14px #ff4d6d22;
            }
            .fab-heart .fab-btn.filled i {
                color: #ff4d6d;
                text-shadow: 0 2px 8px #ff4d6d22, 0 0px 2px #fff;
            }
            .fab-badge {
                position: absolute;
                top: -7px;
                right: -7px;
                background: #14b866;
                color: #fff;
                font-size: 0.93rem;
                font-weight: 700;
                border-radius: 50%;
                min-width: 24px;
                height: 24px;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 2px solid #fff;
                box-shadow: 0 1.5px 5px #14b86622;
                z-index: 2;
            }
            .fab-heart .fab-badge {
                background: #ff4d6d;
            }
            @media (max-width: 600px) {
                .floating-actions-v2 {
                    left: 7px;
                    bottom: 10px;
                    gap: 12px;
                }
                .fab-btn {
                    width: 42px;
                    height: 42px;
                }
                .fab-label {
                    font-size: 0.95rem;
                    padding: 0 6px;
                }
                .fab-badge {
                    min-width: 20px;
                    height: 20px;
                    font-size: 0.87rem;
                }
            }
        </style>
        <style>
            .fab-item {
                position: relative;
            }
            .fab-hover-label {
                display: none;
                position: absolute;
                left: 60px;
                top: 50%;
                transform: translateY(-50%);
                background: #fff;
                color: #11998e;
                font-weight: 600;
                font-size: 1.02rem;
                padding: 5px 16px;
                border-radius: 9px;
                box-shadow: 0 3px 16px #1976d211;
                white-space: nowrap;
                z-index: 10000;
                pointer-events: none;
                opacity: 0;
                transition: opacity 0.17s, left 0.17s;
            }
            .fab-item:hover .fab-hover-label,
            .fab-item:focus-within .fab-hover-label {
                display: block;
                opacity: 1;
                left: 60px;
            }
            @media (max-width: 600px) {
                .fab-hover-label {
                    left: 45px;
                    font-size: 0.95rem;
                    padding: 4px 10px;
                }
            }
            /*            css thông báo*/

            .custom-toast {
                position: fixed;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%) scale(0.97);
                min-width: 200px;
                max-width: 350px;
                width: auto;
                background: #fff;
                color: #222;
                font-weight: 700;
                font-size: 1.14rem;
                border-radius: 16px;
                box-shadow: 0 12px 40px #2bdbb855, 0 2px 10px #1976d244;
                z-index: 11000;
                padding: 32px 38px 32px 36px;
                display: flex;
                align-items: center;
                gap: 20px;
                opacity: 0;
                pointer-events: none;
                transition: all 0.55s cubic-bezier(.23,1.18,.82,0.97);
            }
            .custom-toast.show {
                opacity: 1;
                pointer-events: auto;
                transform: translate(-50%, -50%) scale(1);
            }
            .toast-success {
                border-left: 7px solid #3ec56b;
                background: linear-gradient(90deg, #eafaf3 80%, #d7f5e3 100%);
            }
            .toast-error {
                border-left: 7px solid #ff4d6d;
                background: linear-gradient(90deg, #fff0f3 80%, #ffe8e6 100%);
            }
            .toast-anim-icon {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 58px;
                height: 58px;
                flex-shrink: 0;
                margin-right: 8px;
                position: relative;
            }
            .checkmark, .crossmark {
                width: 52px;
                height: 52px;
                display: block;
            }
            .checkmark-circle, .crossmark-circle {
                stroke: #3ec56b;
                stroke-width: 4;
                stroke-dasharray: 166;
                stroke-dashoffset: 166;
                stroke-linecap: round;
                animation: draw-circle 0.5s ease-out forwards;
            }
            .crossmark-circle {
                stroke: #ff4d6d;
                animation: draw-circle-red 0.5s ease-out forwards;
            }
            .checkmark-check {
                stroke: #3ec56b;
                stroke-width: 5;
                stroke-linecap: round;
                stroke-linejoin: round;
                stroke-dasharray: 48;
                stroke-dashoffset: 48;
                animation: draw-check 0.35s 0.5s cubic-bezier(.65,.05,.36,1) forwards;
            }
            .crossmark-cross {
                stroke: #ff4d6d;
                stroke-width: 5;
                stroke-linecap: round;
                stroke-dasharray: 36 36;
                stroke-dashoffset: 36;
                animation: draw-cross 0.28s 0.5s cubic-bezier(.65,.05,.36,1) forwards;
            }
            @keyframes draw-circle {
                to {
                    stroke-dashoffset: 0;
                }
            }
            @keyframes draw-circle-red {
                to {
                    stroke-dashoffset: 0;
                }
            }
            @keyframes draw-check {
                to {
                    stroke-dashoffset: 0;
                }
            }
            @keyframes draw-cross {
                to {
                    stroke-dashoffset: 0;
                }
            }
            .toast-close {
                background: none;
                border: none;
                font-size: 2rem;
                color: #199c89;
                cursor: pointer;
                outline: none;
                margin-left: 15px;
                margin-right: 0;
                transition: color 0.18s;
                position: absolute;
                top: 12px;
                right: 20px;
            }
            .toast-close:hover {
                color: #e74c3c;
            }
            @media (max-width:600px) {
                .custom-toast {
                    min-width: 0;
                    width: 95vw;
                    font-size: 1rem;
                    padding: 18px 12px 18px 8px;
                    left: 50%;
                    top: 15%;
                    transform: translate(-50%, 0%) scale(1);
                }
                .toast-close {
                    right: 4px;
                    top: 7px;
                    font-size: 1.4rem;
                }
                .toast-anim-icon {
                    width: 40px;
                    height: 40px;
                }
                .checkmark, .crossmark {
                    width: 36px;
                    height: 36px;
                }
            }



        </style>

        <style>
            .support-popup {
                position: fixed;
                left: 90px;
                bottom: 32px;
                width: 350px;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 8px 32px 0 rgba(20,184,102,0.13), 0 1.5px 8px #1976d211;
                z-index: 10001;
                animation: fadeInFabDropdown 0.22s;
            }
            @keyframes fadeInFabDropdown {
                from {
                    opacity: 0;
                    transform: translateY(30px) scale(0.97);
                }
                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                }
            }
            .support-popup-body {
                padding: 12px 0;
                display: flex;
                flex-direction: column;
                gap: 5px;
            }
            .support-popup-link {
                display: flex;
                align-items: center;
                gap: 13px;
                padding: 14px 22px;
                color: #1a9e7c;
                text-decoration: none;
                background: none;
                font-size: 1.08rem;
                border-bottom: 1px solid #f1f1f1;
                transition: background 0.12s, color 0.12s;
                font-weight: 500;
            }
            .support-popup-link:last-child {
                border-bottom: none;
            }
            .support-popup-link:hover {
                background: #eafaf2;
                color: #0a8e65;
            }
            @media (max-width:600px) {
                .support-popup {
                    width: 95vw;
                    left: 2vw;
                    bottom: 12px;
                }
                .support-popup-header {
                    padding: 12px 10px 10px 10px !important;
                }
                .support-popup-link {
                    padding: 10px 10px;
                    font-size: 1rem;
                }
            }
        </style>

        <!--    End Action Menu-->
        <style>
            .fab-item {
                position: relative;
            }
            .fab-hover-label {
                display: none;
                position: absolute;
                left: 60px;
                top: 50%;
                transform: translateY(-50%);
                background: #fff;
                color: #11998e;
                font-weight: 600;
                font-size: 1.02rem;
                padding: 5px 16px;
                border-radius: 9px;
                box-shadow: 0 3px 16px #1976d211;
                white-space: nowrap;
                z-index: 10000;
                pointer-events: none;
                opacity: 0;
                transition: opacity 0.17s, left 0.17s;
            }
            .fab-item:hover .fab-hover-label,
            .fab-item:focus-within .fab-hover-label {
                display: block;
                opacity: 1;
                left: 60px;
            }
            @media (max-width: 600px) {
                .fab-hover-label {
                    left: 45px;
                    font-size: 0.95rem;
                    padding: 4px 10px;
                }
            }

            /*            end css thong bao*/
        </style>




    </head>
    <body>

        <header class="main-header shadow-sm">
            <nav class="navbar navbar-expand-lg py-3">
                <div class="container">
                    <a class="navbar-brand d-flex align-items-center" href="#">
                        <span class="brand-icon rounded-circle me-2 d-flex align-items-center justify-content-center">
                            <i class="bi bi-briefcase-fill"></i>
                        </span>
                        <span class="fw-bold brand-title">GenZTimViec</span>
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent"
                            aria-controls="navbarContent" aria-expanded="false" aria-label="Menu">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarContent">

                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-lg-center">

                            <li class="nav-item">
                                <a class="nav-link" href="/Project_RecruitmentWebsite/Index"><i class="bi bi-house-door"></i> Trang chủ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="searchListJobPost"><i class="bi bi-briefcase"></i> Việc làm</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/log/profile.jsp"><i class="bi bi-person-circle"></i> Tài khoản</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
        <!-- Header End -->


        <div class="container py-5">
            <div class="row g-4">

                <!-- Hiện thị list  -->

                <c:forEach var="s" items="${listJobPostSave}">

                    <div class="col-md-6 col-lg-4">
                        <div class="card cv-card h-100 shadow border-0">
                            <div class="card-body">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="job-logo-wrap me-3">
                                        <img src="./img/logpmtp.png" alt="MTP" class="job-logo">  
                                    </div>
                                    <div>
                                        <div class="cv-title">${s.title} <i class="bi bi-patch-check-fill text-success" title="Tin xác thực"></i></div>
                                        <span class="badge cv-badge mb-1"> ${s.company}</span>
                                        <div class="cv-date"><i class="bi bi-geo-alt"></i> ${s.location} · <i class="bi bi-calendar2-check"></i> Ngày Lưu ${s.dayCre}</div>
                                    </div>
                                </div>
                                <div class="cv-description mb-2">
                                    ${s.description}
                                </div>
                            </div>
                            <div class="card-footer bg-transparent border-0 d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="badge bg-light text-success"><i class="bi bi-fire text-danger"></i> Hot Job</span>
                                </div>
                                <div>
                                    <a href="#" class="btn btn-gradient me-2 btn-sm"><i class="bi bi-eye"></i> Xem chi tiết</a>
                                    <a href="DeleteJobPostSaved?idJobPost=${s.saveIdJobPost}" target="_self" class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"> Xóa</i></a>
                                </div>

                            </div>
                        </div>
                    </div>

                </c:forEach>


                <!--             thông báo-->
                <c:if test="${remove == true}">

                    <c:choose>
                        <c:when test="${check == true}">
                            <div id="status1-message" class="custom-toast toast-success">
                                <span class="toast-anim-icon">
                                    <!-- Animated checkmark SVG -->
                                    <svg class="checkmark" viewBox="0 0 52 52">
                                    <circle class="checkmark-circle" cx="26" cy="26" r="25" fill="none"/>
                                    <path class="checkmark-check" fill="none" d="M14 27l7 7 17-17"/>
                                    </svg>
                                </span>
                                <span>Xóa Thành Công</span>

                            </div>
                            <% session.removeAttribute("status1"); %>
                        </c:when>
                        <c:otherwise>
                            <div id="status1-message" class="custom-toast toast-error">
                                <span class="toast-anim-icon">
                                    <!-- Animated cross SVG -->
                                    <svg class="crossmark" viewBox="0 0 52 52">
                                    <circle class="crossmark-circle" cx="26" cy="26" r="25" fill="none"/>
                                    <path class="crossmark-cross" fill="none" d="M17 17 35 35 M35 17 17 35"/>
                                    </svg>
                                </span>
                                <span> Đã xảy ra lỗi ! Vui lòng thử lại.</span>

                            </div>
                        </c:otherwise>
                    </c:choose>

                    <% session.removeAttribute("remove"); %>

                </c:if>

                <!--                 thống báo end -->


                <!--                   hiển thị thông tin nếu list rỗng -->
                <c:if test="${statuss!=null}" >
                    <h3 style="display: flex;justify-content: center ;color: #14b866">Bạn Chưa Lưu JobPost Nào !</h3>
                    <img src="./img/memeEmty.png" width="300" height="700" style="border-radius: 100px"/>
                </c:if>

            </div>

            <!--            hiển thị Action Menu-->
            <div class="floating-actions-v2">
                <div class="fab-item fab-heart" title="Việc làm yêu thích">
                    <a href="<%= request.getContextPath() %>/DisplayListJobPostSaveOfCandidate" target="_self" id="favorite-btn-v2" class="fab-btn" >
                        <i class="bi bi-heart-fill"></i>
                        <c:if test="${username!=null}">
                            <span class="fab-badge" id="favorite-count-v2"> ${numberJobPost}</span>
                        </c:if>

                    </a>
                    <span class="fab-hover-label">Danh sách việc làm đã lưu</span>
                </div>
                <div class="fab-item" title="Góp ý">
                    <a  href="<%= request.getContextPath() %>/ViewActionMenu/Feedback.jsp" target="_self" class="fab-btn">
                        <i class="bi bi-chat-dots"></i>
                    </a>
                    <span class="fab-hover-label">Góp ý GenZTimViec</span>
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
                        <a class="support-popup-link" href="SupportUser" target="_blank">
                            <i class="bi bi-envelope-paper"></i> Yêu cầu hỗ trợ
                        </a>
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
                            Tổng đài: <span style="color:#24963F; font-weight:600;">9999999 nhé các ngài </span>
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



            <!--            Phần phân trang -->
            <div class="d-flex justify-content-center mt-4">
                <nav>
                    <ul class="pagination">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="DisplayListJobPostSaveOfCandidate?page=${currentPage - 1}">&laquo; Trước</a>
                            </li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="DisplayListJobPostSaveOfCandidate?page=${i}"> ${i} </a>
                            </li>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="DisplayListJobPostSaveOfCandidate?page=${currentPage + 1}">Sau &raquo;</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
            <!--            Phần phân trang -->

        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!--     thông báo -->
        <script>
                function hideStatusToast() {
                    const elem = document.getElementById('status1-message');
                    if (elem) {
                        elem.classList.remove('show');
                        setTimeout(() => elem.style.display = 'none', 550);
                    }
                }
                document.addEventListener("DOMContentLoaded", function () {
                    const statusElem = document.getElementById('status1-message');
                    if (statusElem) {
                        statusElem.classList.add('show');
                        setTimeout(() => hideStatusToast(), 1000);
                    }
                });
        </script>
    </body>
</html>