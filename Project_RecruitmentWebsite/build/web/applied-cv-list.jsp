<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*, Models.CV" %>
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
                font-weight: 500;
                padding: 10px;
                border-radius: 5px;
                transition: background-color 0.3s;
            }

            .sidebar .btn-find-job:hover {
                background-color: #218838;
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
            }

            .cv-card .details-link {
                font-size: 20px;
                color: #28a745;
                font-weight: 500;
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
                            <h3>Search by Keywords</h3>
                            <input type="text" name="keyword" class="form-control" placeholder="E.g. Front-end Developer" value="${param.keyword}">

                            <div class="mt-4">
                                <h3>Search by Location</h3>
                                <input type="text" name="address" class="form-control" placeholder="Search Location" value="${param.address}">
                            </div>

                            <div class="mt-4">
                                <h3>Search by Position</h3>
                                <input type="text" name="position" class="form-control" placeholder="Position" value="${param.position}">
                            </div>

                            <div class="mt-4">
                                <h3>Years of Experience</h3>
                                <input type="number" name="numberExp" class="form-control" placeholder="e.g. 3" value="${param.numberExp}">
                            </div>

                            <!-- Hidden employerId (nếu cần gửi qua form) -->
                            <input type="hidden" name="employerId" value="${sessionScope.employerId != null ? sessionScope.employerId : ''}">

                            <button type="submit" class="btn btn-find-job w-100 mt-4">Find CV</button>
                        </form>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-md-9">
                    <div class="main-content">
                        <h2>Danh sách CV đã ứng tuyển vào công ty</h2>

                        <!-- Search and Filter Bar -->
                        <!--                        <div class="search-filter-bar">
                                                    <form action="SearchCVsServlet" method="get" class="row g-3">
                                                         Hidden input for employerId 
                                                        <input type="hidden" name="employerId" value="${sessionScope.employerId != null ? sessionScope.employerId : ''}">
                        
                                                        <div class="col-md-4">
                                                            <input type="text" name="address" class="form-control" placeholder="Search by address" value="${param.address != null ? param.address : ''}">
                                                        </div>
                                                        <div class="col-md-3">
                                                            <select name="position" class="form-select">
                                                                <option value="">Tất cả vị trí</option>
                                                                <option value="Web Dev" ${param.position == 'Web Dev' ? 'selected' : ''}>Web Dev</option>
                                                                <option value="Tester" ${param.position == 'Tester' ? 'selected' : ''}>Tester</option>
                                                                <option value="Designer" ${param.position == 'Designer' ? 'selected' : ''}>Designer</option>
                                                                <option value="Manager" ${param.position == 'Manager' ? 'selected' : ''}>Manager</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <select name="numberExp" class="form-select">
                                                                <option value="">Tất cả kinh nghiệm</option>
                                                                <option value="1" ${param.numberExp == '1' ? 'selected' : ''}>0-2 năm</option>
                                                                <option value="2" ${param.numberExp == '2' ? 'selected' : ''}>2-5 năm</option>
                                                                <option value="3" ${param.numberExp == '3' ? 'selected' : ''}>5+ năm</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
                                                        </div>
                                                    </form>
                                                </div>-->


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
                                <c:when test="${not empty appliedCVs}">
                                    <c:forEach var="cv" items="${appliedCVs}">
                                        <div class="col-md-4 col-sm-6 mb-4">
                                            <div class="cv-card">
                                                <img src="img/avata.jpg" alt="CV Icon">
                                                <h4>${cv.fullName}</h4>
                                                <p>${cv.email}</p>
                                                <p>Vị trí: ${cv.position}</p>
                                                <p>Kinh nghiệm: ${cv.numberExp} năm</p>
                                                <a href="view-cv-detail?cvId=${cv.cvId}" class="details-link">Xem chi tiết</a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-12 text-center">
                                        <p>Không có CV nào được ứng tuyển.</p>
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
                                        <th>Chi tiết</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty appliedCVs}">
                                            <c:forEach var="cv" items="${appliedCVs}">
                                                <tr>
                                                    <td>${cv.cvId}</td>
                                                    <td>${cv.fullName}</td>
                                                    <td>${cv.email}</td>
                                                    <td>${cv.position}</td>
                                                    <td>${cv.numberExp} năm</td>
                                                    <td><a href="view-cv-detail?cvId=${cv.cvId}" class="btn btn-sm btn-outline-primary">Xem chi tiết</a></td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6" class="text-center">Không có CV nào được ứng tuyển.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation" class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <!-- Previous Button -->
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="SearchCVsServlet?page=${currentPage - 1}&address=${param.address}&position=${param.position}&numberExp=${param.numberExp}">Trước</a>
                                    </li>
                                    <!-- Page Numbers -->
                                    <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}"/>
                                    <c:set var="endPage" value="${currentPage + 2 <= totalPages ? currentPage + 2 : totalPages}"/>
                                    <c:if test="${startPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="SearchCVsServlet?page=1&address=${param.address}&position=${param.position}&numberExp=${param.numberExp}">1</a>
                                        </li>
                                        <c:if test="${startPage > 2}">
                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                            </c:if>
                                        </c:if>
                                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="SearchCVsServlet?page=${i}&address=${param.address}&position=${param.position}&numberExp=${param.numberExp}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${endPage < totalPages}">
                                        <c:if test="${endPage < totalPages - 1}">
                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                            </c:if>
                                        <li class="page-item">
                                            <a class="page-link" href="SearchCVsServlet?page=${totalPages}&address=${param.address}&position=${param.position}&numberExp=${param.numberExp}">${totalPages}</a>
                                        </li>
                                    </c:if>
                                    <!-- Next Button -->
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="SearchCVsServlet?page=${currentPage + 1}&address=${param.address}&position=${param.position}&numberExp=${param.numberExp}">Tiếp</a>
                                    </li>
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
    </body>
</html>