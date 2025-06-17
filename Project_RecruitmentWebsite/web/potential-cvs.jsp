<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*, Models.CV" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách CV Tiềm Năng</title>
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

            .cv-card .button-container {
                display: flex;
                justify-content: center;
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
                        <form action="SearchCVsServlet" method="get">
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

                <!-- Main Content -->
                <div class="col-md-9">
                    <div class="main-content">
                        <h2>Danh sách CV Tiềm Năng</h2>
                        <div class="results-info">
                            <span>Hiển thị ${startIndex + 1} đến ${endIndex} của ${totalCVs} CV</span>
                            <div class="view-options">
                                <button class="btn btn-outline-secondary active" onclick="showView('grid')">Grid</button>
                                <button class="btn btn-outline-secondary" onclick="showView('list')">List</button>
                            </div>
                        </div>

                        <!-- Grid View -->
                        <div class="row cv-grid" id="cvGrid">
                            <c:choose>
                                <c:when test="${not empty potentialCVs}">
                                    <c:forEach var="cv" items="${potentialCVs}">
                                        <div class="col-md-4 col-sm-6 mb-4">
                                            <div class="cv-card">
                                                <img src="img/avata.jpg" alt="CV Icon">
                                                <h4>${cv.fullName}</h4>
                                                <p>${cv.email}</p>
                                                <p>Vị trí: ${cv.position}</p>
                                                <p>Kinh nghiệm: ${cv.numberExp} năm</p>
                                                <p title="${cv.jobPost.title}">Ứng tuyển vào: ${cv.jobPost.title}</p>  <!--honner chuột sẽ hiện thông báo title-->
                                                <div class="button-container">
                                                    <a href="view-cv-detail?cvId=${cv.cvId}" class="btn btn-sm btn-success">Xem</a>
                                                    <form action="remove-potential-cv" method="post" style="display:inline;">
                                                        <input type="hidden" name="cvId" value="${cv.cvId}">
                                                        <button type="submit" class="btn btn-sm btn-danger">Xoá</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-12 text-center">
                                        <p>Chưa có CV nào được lưu là tiềm năng.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- List View -->
                        <div class="cv-table" id="cvTable">
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
                                        <c:when test="${not empty potentialCVs}">
                                            <c:forEach var="cv" items="${potentialCVs}">
                                                <tr>
                                                    <td>${cv.cvId}</td>
                                                    <td>${cv.fullName}</td>
                                                    <td>${cv.email}</td>
                                                    <td>${cv.position}</td>
                                                    <td>${cv.numberExp} năm</td>
                                                    <td>Ứng tuyển vào: ${cv.jobPost.title}</td>
                                                    <td>
                                                        <a href="view-cv-detail?cvId=${cv.cvId}" class="btn btn-sm btn-success">Xem</a>
                                                        <form action="remove-potential-cv" method="post" style="display:inline;">
                                                            <input type="hidden" name="cvId" value="${cv.cvId}">
                                                            <button type="submit" class="btn btn-sm btn-danger">Xoá</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="7" class="text-center">Chưa có CV nào được lưu là tiềm năng.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation">
                                <ul class="pagination justify-content-center mt-4">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="potential-cvs?page=${currentPage - 1}" aria-label="Previous">
                                                <span aria-hidden="true">«</span>
                                            </a>
                                        </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="potential-cvs?page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="potential-cvs?page=${currentPage + 1}" aria-label="Next">
                                                <span aria-hidden="true">»</span>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap 5 JS and Popper.js -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX+vR+Vc4jQkC+hVqc2pM8ODewa9" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
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
        <c:if test="${not empty sessionScope.message}">
            <div id="toastMsg" class="toast-custom">${sessionScope.message}</div>
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
            <c:remove var="message" scope="session"/>
        </c:if>
    </body>
</html>