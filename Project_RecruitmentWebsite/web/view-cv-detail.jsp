<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Models.CV" %>
<%@ page import="java.util.List, java.util.Arrays" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết CV</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f4f6f9;
                color: #333;
                margin: 0;
                padding-bottom: 50px;
            }

            h2.text-center {
                font-weight: bold;
                color: #198754;
                margin-bottom: 30px;
            }

            .card {
                border: none;
                border-radius: 12px;
                background-color: #ffffff;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
                padding: 30px;
                animation: fadeIn 0.5s ease-in-out;
            }

            .cv-layout {
                display: flex;
                flex-wrap: wrap;
                align-items: flex-start;
                gap: 30px;
            }

            .cv-photo-container {
                flex: 0 0 160px;
                text-align: center;
            }

            .cv-photo-container img {
                width: 160px;
                height: 240px; /* 4x6 tỷ lệ */
                object-fit: cover;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                cursor: pointer;
                transition: transform 0.3s;
            }

            .cv-photo-container img:hover {
                transform: scale(1.03);
            }

            .cv-info {
                flex: 1;
            }

            .cv-info p {
                font-size: 15px;
                margin-bottom: 10px;
            }

            .cv-info p strong {
                display: inline-block;
                width: 140px;
                color: #495057;
            }

            .cv-step-badge {
                font-size: 14px;
                padding: 8px 14px;
                border-radius: 20px;
                font-weight: 500;
            }

            .btn-primary {
                background-color: #0d6efd;
                border: none;
            }

            .btn-primary:hover {
                background-color: #0b5ed7;
            }

            .form-select {
                min-width: 200px;
            }

            .modal-body img {
                max-width: 100%;
                height: auto;
                border-radius: 10px;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .btn-cv-view {
                background-color: #007bff;
                color: white;
                font-weight: 600;
                padding: 5px 10px;
                border-radius: 6px;
                text-decoration: none;
                font-size: 16px;
                transition: background-color 0.3s ease, transform 0.2s ease;
                display: inline-block;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .btn-cv-view:hover {
                background-color: #0056b3;
                color: white;
                transform: translateY(-2px);
                text-decoration: none;
            }
            .cv-status-step {
                display: flex;
                flex-wrap: wrap;
                gap: 8px;
                padding-left: 0;
                list-style: none;
                align-items: center;
                font-size: 14px;
            }

            .cv-status-step .step-item {
                display: flex;
                align-items: center;
                font-weight: 500;
            }

            .cv-status-step .step-item .dot {
                height: 8px;
                width: 8px;
                border-radius: 50%;
                display: inline-block;
                margin-right: 6px;
            }

            .cv-status-step .step-item.done {
                color: #28a745;
            }

            .cv-status-step .step-item.done .dot {
                background-color: #28a745;
            }

            .cv-status-step .step-item.undone {
                color: #ccc;
            }

            .cv-status-step .step-item.undone .dot {
                background-color: #ccc;
            }

            .cv-status-step .step-item:not(:last-child)::after {
                content: '—';
                margin: 0 8px;
                color: #ccc;
            }
        </style>


        <!-- Thông báo -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-info">${sessionScope.message}</div>
            <c:remove var="message" scope="session" />
        </c:if>

        <div class="container mt-4">
            <h2 class="text-center">Chi tiết CV</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <c:if test="${not empty cv}">
                <div class="card">
                    <div class="card-body">

                        <!-- Ảnh thu nhỏ có thể phóng to -->
                        <div class="text-center mb-3">
                            <img src="${pageContext.request.contextPath}/img/${cv.fileData}" 
                                 alt="Ảnh ứng viên" 
                                 class="img-thumbnail"
                                 style="max-width: 150px; cursor: pointer;"
                                 data-bs-toggle="modal"
                                 data-bs-target="#cvImageModal_${cv.cvId}"
                                 onerror="this.src='https://via.placeholder.com/150x200?text=No+Image'">
                        </div>

                        <!-- Modal hiển thị ảnh to -->
                        <div class="modal fade" id="cvImageModal_${cv.cvId}" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-lg">
                                <div class="modal-content">
                                    <div class="modal-body text-center">
                                        <img src="${pageContext.request.contextPath}/img/${cv.fileData}" 
                                             alt="Ảnh lớn"
                                             class="img-fluid"
                                             onerror="this.src='https://via.placeholder.com/300x400?text=No+Image'">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <h5 class="card-title">${cv.fullName}</h5>
                        <p><strong>Vị trí:</strong> ${cv.position}</p>
                        <p><strong>Địa chỉ:</strong> ${cv.address}</p>
                        <p><strong>Email:</strong> ${cv.email}</p>
                        <p><strong>Kinh nghiệm:</strong> ${cv.numberExp} năm</p>
                        <p><strong>Trình độ:</strong> ${cv.education}</p>
                        <p><strong>Lĩnh vực:</strong> ${cv.field}</p>
                        <p><strong>Mức lương:</strong> ${cv.currentSalary}</p>
                        <p><strong>Ngày sinh:</strong> ${cv.birthday}</p>
                        <p><strong>Quốc tịch:</strong> ${cv.nationality}</p>
                        <p><strong>Giới tính:</strong> ${cv.gender}</p>
                        <a href="downloadCV?cvId=${cv.cvId}" 
                           class="btn btn-cv-view mt-4" 
                           target="_blank">
                            📄 Xem bản CV đã nộp
                        </a>

                        <%
    String currentStep = request.getAttribute("apply") != null
                         ? ((Models.Apply) request.getAttribute("apply")).getStep()
                         : "";

    List<String> steps = new java.util.ArrayList<>();
    steps.add("Đã nhận hồ sơ");

    Boolean isPotential = (Boolean) request.getAttribute("isPotential");
    if (isPotential != null && isPotential) {
        steps.add("CV tiềm năng");
    }

    steps.add("Đang xét duyệt");
    steps.add("Mời phỏng vấn");
    steps.add("Đã phỏng vấn");
    steps.add("Đã nhận việc");

    // Tìm index của apply.step (nếu có)
    int currentIndex = steps.indexOf(currentStep);

    // Nếu apply.step là bước trước "CV tiềm năng" nhưng đã vào potential, 
    // thì ta tăng index để đánh dấu thêm 1 bước "done"
    if (isPotential != null && isPotential && currentIndex <= steps.indexOf("Đã nhận hồ sơ")) {
        currentIndex = steps.indexOf("CV tiềm năng");  // đánh dấu đến "CV tiềm năng"
    }

    request.setAttribute("steps", steps);
    request.setAttribute("currentIndex", currentIndex);
%>



                        <ul class="cv-status-step list-inline mt-4">
                            <c:forEach var="step" items="${steps}" varStatus="status">
                                <li class="list-inline-item step-item ${status.index <= currentIndex ? 'done' : 'undone'}">
                                    <span class="dot"></span> ${step}
                                </li>
                            </c:forEach>
                        </ul>


                    </div>
                </div>

                <!-- FORM CẬP NHẬT STEP -->
                <c:if test="${not empty applyId}">

                    <c:if test="${isPotential}">
                        <form action="update-step" method="post" class="mt-3">
                            <input type="hidden" name="applyId" value="${applyId}">
                            <input type="hidden" name="cvId" value="${cv.cvId}">
                            <input type="hidden" name="jobPostId" value="${jobPostId}">
                            <div class="mb-3">
                                <label for="step" class="form-label">Cập nhật trạng thái:</label>
                                <select name="step" id="step" class="form-select w-auto d-inline">
                                    <option value="Đã nhận hồ sơ">Đã nhận hồ sơ</option>
                                    <option value="Đang xét duyệt">Đang xét duyệt</option>
                                    <option value="Mời phỏng vấn">Mời phỏng vấn</option>
                                    <option value="Đã phỏng vấn">Đã phỏng vấn</option>
                                    <option value="Đã nhận việc">Đã nhận việc</option>
                                </select>
                                <button type="submit" class="btn btn-primary btn-sm ms-2">Cập nhật</button>
                            </div>
                        </form>
                    </c:if>

                    <c:if test="${not isPotential}">
                        <div class="alert alert-warning mt-3">
                            ⚠ Bạn cần lưu CV vào danh sách tiềm năng trước khi cập nhật trạng thái.
                        </div>
                    </c:if>

                </c:if>

            </c:if>

            <a href="view-applied-cvs" class="btn btn-secondary mt-3">Quay lại danh sách</a>
        </div>

        <!-- Bootstrap Bundle JS (đảm bảo có Popper để modal hoạt động) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
