<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                left: 0;
                top: 0;
                width: 100vw;
                height: 100vh;
                background: rgba(0,0,0,0.5);
            }
            .img-modal-content {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                position: absolute;
                left: 50%;
                top: 50%;
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
                .container {
                    padding: 18px 2vw 14px 2vw;
                }
                .main-flex {
                    gap: 20px;
                }
                .info-block {
                    width: 100%;
                    min-width: unset;
                }
                .attachment-images img {
                    max-width: 95vw;
                    max-height: 200px;
                }
                .content-frame {
                    padding: 14px 5vw 12px 5vw;
                }
            }
            @media (max-width: 700px) {
                .container {
                    padding: 8px 0 8px 0;
                    border-radius: 7px;
                }
                .attachment-images {
                    gap: 8px;
                }
                .attachment-section {
                    padding: 8px 3px 8px 3px;
                }
                .main-flex {
                    flex-direction: column;
                    gap: 0;
                }
                .content-frame {
                    padding: 8px 2vw 8px 2vw;
                }
                h2 {
                    font-size: 1.4em;
                }
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
                        <div><label>ID User:</label> <span id="report-id">${ViewDetailReprot.id}</span></div>
                        <div><label>Vai trò:</label> <span id="report-role">${ViewDetailReprot.role}</span></div>
                        <div><label>SĐT:</label> <span id="report-phone">${ViewDetailReprot.phone}</span></div>
                        <div><label>Email:</label> <span id="report-email">${Email}</span></div>
                        <div><label>Tiêu đề:</label> <span id="report-title">${ViewDetailReprot.title}</span></div>
                        <div>
                            <label>Ngày gửi:</label>
                            <span id="report-date">
                                <fmt:formatDate value="${ViewDetailReprot.dateSend}" pattern="dd/MM/yyyy"/>
                            </span>
                        </div>                 
                    </div>
                    <!-- Phản hồi cho user -->
                    <div class="response-section">
                        <h3>Phản hồi cho người gửi (Email)</h3>
                        <form action="ViewDetail" method="post">
                            <input type="text" name="emailuser" value="${Email}" style="display: none">
                            <input type="text" name="idReport" value="${idReport}" style="display: none" >
                            <label for="response-content">Nội dung phản hồi:</label>
                            <textarea name="content" id="response-content" placeholder="Nhập nội dung phản hồi..."></textarea>

                            <div style="display: flex; gap: 10px;">
                                <button type="submit" class="send-btn">Gửi</button>                                
                                <select style="background:#8bc34a"  class="send-btn" id="statusHandle" data-idreport="${idReport}">
                                    <option value="pending" ${StatusReport eq 'pending' ? 'selected' :''} >Chờ xử lý</option>
                                    <option value="reviewed"   ${StatusReport eq'reviewed' ? 'selected' :''}>Đang xử lý</option>
                                    <option value="resolved"  ${StatusReport eq'resolved' ? 'selected' :''} >Hoành Thành</option>
                                </select>
                            </div>


                            <!-- Modal loading giữa màn hình -->
                            <div id="loading-modal" style="display:none;position:fixed;z-index:9999;top:0;left:0;width:100vw;height:100vh;background:rgba(0,0,0,0.22);">
                                <div style="position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);
                                     background:#fff;padding:32px 40px;border-radius:14px;box-shadow:0 2px 24px #388e3c44;text-align:center;min-width:240px;">
                                    <span style="font-size:1.3em;font-weight:600;color:#388e3c;">Đang gửi email...<br>Vui lòng chờ ⏳</span>
                                </div>
                            </div>
                            <div id="response-msg"></div>
                        </form>
                    </div>
                </div>
                <!-- Bên phải: Ảnh + nội dung -->
                <div style="flex:1; min-width:0">

                    <div class="attachment-section">
                        <h3>Ảnh đính kèm</h3>
                        <div class="attachment-images" id="attachment-images">

                            <img  src="img/${pathImage}" alt="Ảnh đính kèm 1" onclick="showImageModal(this)">


                        </div>
                    </div>
                    <!-- Khung content rộng & to hơn -->
                    <div class="content-frame">
                        <div class="report-content" id="report-content">
                            ${ViewDetailReprot.content}
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

        <c:if test="${successSend == true}">
            <div id="success-modal" style="display:flex;position:fixed;z-index:10000;top:0;left:0;width:100vw;height:100vh;background:rgba(0,0,0,0.18);">
                <div style="position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);
                     background:#fff;padding:28px 34px;border-radius:12px;box-shadow:0 2px 12px #388e3c44;text-align:center;min-width:220px;">
                    <span style="font-size:1.2em;font-weight:600;color:#388e3c;">Gửi email thành công! 🎉</span>
                </div>
            </div>
            <script>
                setTimeout(function () {
                    document.getElementById('success-modal').style.display = 'none';
                }, 2000); // 2 giây tự ẩn
            </script>
        </c:if>

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

            document.addEventListener("DOMContentLoaded", function () {
                const form = document.querySelector("form[action='ViewDetail']");
                const loadingModal = document.getElementById("loading-modal");
                if (form) {
                    form.addEventListener("submit", function () {
                        loadingModal.style.display = "block"; // Hiện modal loading giữa màn hình
                    });
                }
            });
        </script>

        <script>
            var s = document.getElementById("statusHandle");
            var idReport = s.dataset.idreport;
            s.addEventListener('change', function () { 
                var newStatus = s.value;
                fetch("/Project_RecruitmentWebsite/setStatus?idReport=" + idReport + "&newStatus=" + newStatus)
                        .then(response => {
                            if (response.ok) {
                                alert("Cập nhật trạng thái thành công");
                                console.log('cập nhật trạng thái thành công');
                            } else {
                                alert("Cập nhật trạng thái thất bại");
                            }
                        })
                        .catch(error => console.error("Lỗi kết nối:", error));
            });
        </script>
    </body>
</html>