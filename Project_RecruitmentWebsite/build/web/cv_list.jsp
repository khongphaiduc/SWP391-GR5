<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*, Models.CV" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách CV đã ứng tuyển</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            body {
                background-color: #f5f5f5;
                font-family: 'Roboto', sans-serif;
            }

            /* Sidebar */
            .sidebar {
                background-color: #fff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }

            .sidebar h3 {
                font-size: 16px;
                font-weight: 600;
                margin-bottom: 15px;
            }

            .sidebar .form-control {
                border-radius: 5px;
                border: 1px solid #e0e0e0;
                font-size: 14px;
                padding: 10px;
                margin-bottom: 15px;
            }

            .sidebar .form-check-label {
                font-size: 14px;
                color: #555;
            }

            .sidebar .btn-find-job {
                background-color: #28a745;
                border: none;
                color: #fff; /* Set text color to white */
                font-weight: 500;
                padding: 10px;
                border-radius: 5px;
                transition: background-color 0.3s;
            }

            .sidebar .btn-find-job:hover {
                background-color: #218838;
                color: #fff; /* Ensure text remains white on hover */
            }

            /* Main Content */
            .main-content h2 {
                font-size: 28px;
                font-weight: 700;
                margin-bottom: 20px;
            }

            .results-info {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .results-info span {
                font-size: 14px;
                color: #666;
            }

            .view-options .btn {
                font-size: 14px;
                padding: 5px 15px;
                border-radius: 5px;
                margin-left: 5px;
            }

            .view-options .btn.active {
                background-color: #28a745;
                color: #fff;
                border-color: #28a745;
            }

            /* CV Cards (Grid View) */
            .cv-card {
                background-color: #fff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                text-align: center;
                transition: transform 0.3s, box-shadow 0.3s;
                min-height: 280px; /* Fixed minimum height for uniformity */
            }

            .cv-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .cv-card img {
                width: 50px;
                height: 50px;
                margin-bottom: 15px;
            }

            .cv-card h4 {
                font-size: 16px;
                font-weight: 600;
                margin-bottom: 5px;
            }

            .cv-card p {
                font-size: 14px;
                color: #666;
                margin-bottom: 10px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis; /* Truncate long text with ellipsis */
                max-width: 100%;
            }

            .cv-card .cv-action-link {
                font-size: 17px; /* Consistent font size */
                color: #28a745;
                font-weight: 500;
                text-decoration: none;
                background: none;
                border: none; /* No border */
                padding: 5px 10px; /* Uniform padding */
                cursor: pointer;
                transition: color 0.3s;
            }

            .cv-card .cv-action-link:hover {
                color: #218838;
                text-decoration: underline;
            }

            .cv-card .button-container {
                display: flex;
                justify-content: center;
                align-items: center; /* Vertically center buttons */
                gap: 10px; /* Space between buttons */
                margin-top: 10px;
            }

            /* CV Table (List View) */
            .cv-table {
                display: none;
            }

            .cv-table.table th, .cv-table.table td {
                vertical-align: middle;
            }

            .cv-table.table-hover tbody tr:hover {
                background-color: #f1f1f1;
            }

            /* Pagination */
            .pagination .page-item .page-link {
                border-radius: 5px;
                margin: 0 5px;
                color: #333;
                border: 1px solid #e0e0e0;
            }

            .pagination .page-item.active .page-link {
                background-color: #28a745;
                border-color: #28a745;
                color: #fff;
            }

            .pagination .page-item .page-link:hover {
                background-color: #f0f0f0;
            }

            /* Search and Filter Bar */
            .search-filter-bar {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>

        <!-- Include Navbar -->
        <%@ include file="navbar.jsp" %>

        <div class="container mt-4">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3">
                    <div class="sidebar">
                        <form action="cv-list" method="get">
                            <input type="hidden" name="jobPostId" value="${jobPostId}" />
                            <h3>Tìm kiếm theo keywords</h3>
                            <input type="text" name="keyword" class="form-control" placeholder="VD: Lập Trình Viên, Hà Nội, ..." value="${param.keyword}">

                            <div class="mt-4">
                                <h3>Tìm kiếm theo địa chỉ</h3>
                                <input type="text" name="address" class="form-control" placeholder="VD: Hà Nội" value="${param.address}">
                            </div>

                            <div class="mt-4">
                                <h3>Tìm kiếm theo vị trí</h3>
                                <input type="text" name="position" class="form-control" placeholder="VD: Lập Trình Viên" value="${param.position}">
                            </div>

                            <div class="mt-4">
                                <h3>Năm kinh nghiệm</h3>
                                <input type="number" name="numberExp" class="form-control" placeholder="VD: 3" value="${param.numberExp}">
                            </div>

                            <!-- Hidden employerId -->
                            <input type="hidden" name="employerId" value="${sessionScope.employerId != null ? sessionScope.employerId : ''}">

                            <button type="submit" class="btn btn-find-job w-100 mt-4">Tìm CV</button>
                        </form>
                    </div>
                </div>         

                <!-- Trong phần MAIN CONTENT -->
                <div class="col-md-9">
                    <div class="main-content">

                        <!-- Thông báo -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-success">${message}</div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>

                        <!-- Hiển thị tiêu đề JobPost nếu có ít nhất 1 CV -->
                        <c:choose>
                            <c:when test="${not empty cvList}">
                                <c:set var="firstCV" value="${cvList[0]}" />
                                <h2>Danh sách CV đã ứng tuyển vào: ${firstCV.jobPost.title}</h2>
                            </c:when>
                            <c:otherwise>
                                <h2>Chưa có ứng viên nào ứng tuyển cho công việc này.</h2>
                            </c:otherwise>
                        </c:choose>

                        <!-- Số lượng và tùy chọn view -->
                        <c:if test="${not empty cvList}">
                            <div class="results-info">
                                <span>Số lượng: <strong>${fn:length(cvList)}</strong> CV</span>
                                <div class="view-options">
                                    <button class="btn btn-outline-secondary active" onclick="showView('grid')">Grid</button>
                                    <button class="btn btn-outline-secondary" onclick="showView('list')">List</button>
                                </div>
                            </div>
                        </c:if>

                        <!-- Grid View -->
                        <div class="row cv-grid" id="cvGrid" style="display: flex;">
                            <c:choose>
                                <c:when test="${not empty cvList}">
                                    <c:forEach var="cv" items="${cvList}">
                                        <div class="col-md-4 col-sm-6 mb-4">
                                            <div class="cv-card">
                                                <img src="img/avata.jpg" alt="CV Icon">
                                                <h4>${cv.fullName}</h4>
                                                <p>${cv.email}</p>
                                                <p>Vị trí: ${cv.position}</p>
                                                <p>Kinh nghiệm: ${cv.numberExp} năm</p>
                                                <p title="${cv.jobPost.title}">Ứng tuyển vào: ${cv.jobPost.title}</p>
                                                <div class="button-container">
                                                    <a href="view-cv-detail?cvId=${cv.cvId}" class="cv-action-link">Xem CV</a>
                                                    <form action="save-potential-cvs" method="post">
                                                        <input type="hidden" name="cvId" value="${cv.cvId}">
                                                        <button type="submit" class="cv-action-link">Lưu CV</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-12 text-center text-muted py-4">
                                        <em>Không có CV nào được ứng tuyển vào công việc này.</em>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- List View -->
                        <div class="cv-table" id="cvTable" style="display: none;">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>CV ID</th>
                                        <th>Họ tên</th>
                                        <th>Email</th>
                                        <th>Vị trí</th>
                                        <th>Kinh nghiệm</th>
                                        <th>Việc đã ứng tuyển</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty cvList}">
                                            <c:forEach var="cv" items="${cvList}">
                                                <tr>
                                                    <td>${cv.cvId}</td>
                                                    <td>${cv.fullName}</td>
                                                    <td>${cv.email}</td>
                                                    <td>${cv.position}</td>
                                                    <td>${cv.numberExp} năm</td>
                                                    <td>${cv.jobPost.title}</td>
                                                    <td>
                                                        <a href="view-cv-detail?cvId=${cv.cvId}" class="btn btn-sm btn-outline-primary">Xem chi tiết</a>
                                                        <form action="save-potential-cvs" method="post" style="display:inline;">
                                                            <input type="hidden" name="cvId" value="${cv.cvId}">
                                                            <button type="submit" class="btn btn-sm btn-outline-primary">Lưu CV</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="7" class="text-center text-muted">Không có CV nào được ứng tuyển.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <!-- Phân trang -->
                        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">-->
                        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
                        <c:if test="${totalPages >= 1}">
                            <div class="container mt-4">
                                <c:url var="baseUrl" value="cv-list" />

                                <ul class="pagination justify-content-center">
                                    <!-- Previous Page -->
                                    <c:url var="prevUrl" value="${baseUrl}">
                                        <c:param name="page" value="${currentPage - 1}" />
                                        <c:param name="jobPostId" value="${jobPostId}" />
                                        <c:if test="${not empty keyword}"><c:param name="keyword" value="${keyword}" /></c:if>
                                        <c:if test="${not empty address}"><c:param name="address" value="${address}" /></c:if>
                                        <c:if test="${not empty numberExp}"><c:param name="numberExp" value="${numberExp}" /></c:if>
                                        <c:if test="${not empty position}"><c:param name="position" value="${position}" /></c:if>
                                        <c:if test="${not empty field}"><c:param name="field" value="${field}" /></c:if>
                                    </c:url>
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="${prevUrl}" aria-label="Previous">&laquo;</a>
                                    </li>

                                    <!-- Page Numbers -->
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <c:url var="pageUrl" value="${baseUrl}">
                                            <c:param name="page" value="${i}" />
                                            <c:param name="jobPostId" value="${jobPostId}" />
                                            <c:if test="${not empty keyword}"><c:param name="keyword" value="${keyword}" /></c:if>
                                            <c:if test="${not empty address}"><c:param name="address" value="${address}" /></c:if>
                                            <c:if test="${not empty numberExp}"><c:param name="numberExp" value="${numberExp}" /></c:if>
                                            <c:if test="${not empty position}"><c:param name="position" value="${position}" /></c:if>
                                            <c:if test="${not empty field}"><c:param name="field" value="${field}" /></c:if>
                                        </c:url>
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="${pageUrl}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <!-- Next Page -->
                                    <c:url var="nextUrl" value="${baseUrl}">
                                        <c:param name="page" value="${currentPage + 1}" />
                                        <c:param name="jobPostId" value="${jobPostId}" />
                                        <c:if test="${not empty keyword}"><c:param name="keyword" value="${keyword}" /></c:if>
                                        <c:if test="${not empty address}"><c:param name="address" value="${address}" /></c:if>
                                        <c:if test="${not empty numberExp}"><c:param name="numberExp" value="${numberExp}" /></c:if>
                                        <c:if test="${not empty position}"><c:param name="position" value="${position}" /></c:if>
                                        <c:if test="${not empty field}"><c:param name="field" value="${field}" /></c:if>
                                    </c:url>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="${nextUrl}" aria-label="Next">&raquo;</a>
                                    </li>
                                </ul>
                            </div>
                        </c:if>

                    </div>
                </div>

                <!-- Scripts giữ nguyên -->
                <script>
                                        function showView(view) {
                                            const gridView = document.getElementById('cvGrid');
                                            const tableView = document.getElementById('cvTable');
                                            const gridButton = document.querySelector('.view-options button:nth-child(1)');
                                            const listButton = document.querySelector('.view-options button:nth-child(2)');

                                            if (view === 'grid') {
                                                gridView.style.display = 'flex';
                                                tableView.style.display = 'none';
                                                gridButton.classList.add('active');
                                                listButton.classList.remove('active');
                                            } else {
                                                gridView.style.display = 'none';
                                                tableView.style.display = 'block';
                                                gridButton.classList.remove('active');
                                                listButton.classList.add('active');
                                            }
                                        }
                </script>

                <!-- Thong báo -->
                <c:if test="${not empty sessionScope.toastMessage}">
                    <div id="toastMsg" class="toast-custom">${sessionScope.toastMessage}</div>
                    <script>
                        // auto hide
                        window.addEventListener("DOMContentLoaded", function () {
                            const toast = document.getElementById("toastMsg");
                            if (toast) {
                                toast.style.opacity = 1;
                                setTimeout(() => {
                                    toast.style.opacity = 0;
                                    setTimeout(() => toast.remove(), 500);
                                }, 3000);
                            }
                        });
                    </script>
                    <style>
                        .toast-custom {
                            position: fixed;
                            top: 20px;
                            right: 20px;
                            background-color: #28a745;
                            color: white;
                            padding: 12px 20px;
                            border-radius: 6px;
                            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
                            z-index: 9999;
                            opacity: 0;
                            transition: opacity 0.5s ease-in-out;
                            font-weight: bold;
                        }
                    </style>
                    <c:remove var="toastMessage" scope="session"/>
                </c:if>
                </body>
                </html>