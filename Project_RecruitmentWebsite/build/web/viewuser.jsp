<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Employer" %>
<%@ page import="Models.Candidate" %>
<%@ page import="Models.Service" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.DecimalFormatSymbols" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>




<%
    List<Employer> employers = (List<Employer>) request.getAttribute("employers");
    List<Candidate> candidates = (List<Candidate>) request.getAttribute("candidates");
    List<Service> services = (List<Service>) request.getAttribute("service");
%>
<%
    // Kiểm tra session
    if (session.getAttribute("username") == null || session.getAttribute("role") == null || !session.getAttribute("role").equals("Admin")) {
        response.sendRedirect("log/login.jsp"); // Chuyển hướng về trang đăng nhập nếu chưa đăng nhập hoặc không phải admin
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Admin Dashboard - GenZTimViec.VN</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/style.css"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/adminDashboard.css"/>
    </head>
    <body>
        <!-- Navigation -->
        <jsp:include page="/navbar.jsp" />

        <%String role = (String) session.getAttribute("role");%>

        <!-- Header Section -->
        <div class="admin-header">
            <div class="container text-center">
                <h1 class="fade-in-up">Admin Dashboard</h1>
                <p class="fade-in-up">Manage users and monitor system activity</p>
            </div>
        </div>

        <!-- Stats Section -->
        <div class="container stats-section">
            <div class="row g-4">
                <div class="col-lg-4 col-md-4">
                    <div class="stats-card fade-in-up">
                        <div class="stats-icon primary">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stats-number">${totalUsers}</div>
                        <div class="stats-label">Total Users</div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4">
                    <div class="stats-card fade-in-up">
                        <div class="stats-icon warning">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <div class="stats-number">${totalCan}</div>
                        <div class="stats-label">Candidates</div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4">
                    <div class="stats-card fade-in-up">
                        <div class="stats-icon warning">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <div class="stats-number">${totalEmp}</div>
                        <div class="stats-label">Employers</div>
                    </div>
                </div>
            </div>
        </div>


        <c:if test="${not empty status}">
            <div class="notification-tab" id="notificationTab">
                <span>${status}</span>
            </div>
        </c:if>
        <div class="background-overlay"></div>
        <div class="container">
            <div class="admin-add-form">
                <h2>Thêm Admin Mới</h2>
                <form action="addAdmin" method="post" autocomplete="off">
                    <div class="form-group">
                        <label for="add-user">Tên đăng nhập</label>
                        <input type="text" id="add-user" name="username" required>
                    </div>

                    <div class="form-group">
                        <label for="add-pass1">Mật khẩu</label>
                        <input type="password" id="add-pass1" name="password1" required>
                    </div>

                    <div class="form-group">
                        <label for="add-pass2">Nhập lại mật khẩu</label>
                        <input type="password" id="add-pass2" name="password2" required>
                    </div>

                    <button type="submit">Thêm</button>
                </form>
            </div>
        </div>



        <!-- Scripts -->
        <script src="js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Animate stats on scroll
                const statsCards = document.querySelectorAll('.stats-card');
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.style.animationDelay = Math.random() * 100 + 'ms';
                            entry.target.classList.add('fade-in-up');
                        }
                    });
                });

                statsCards.forEach(card => {
                    observer.observe(card);
                });

                // Enhanced delete confirmation for both tables
                document.querySelectorAll('.btn-delete').forEach(btn => {
                    btn.addEventListener('click', function (e) {
                        e.preventDefault();
                        const name = this.closest('tr').querySelector('td:nth-child(2) .fw-bold')?.textContent || 'this item';
                        const isService = this.closest('.table-section').querySelector('h3').textContent.includes('Service');
                        const confirmMessage = isService
                                ? `Are you sure you want to delete the service "${name}"?\n\nThis action cannot be undone and will permanently remove all associated data.`
                                : `Are you sure you want to delete the account "${name}"?\n\nThis action cannot be undone and will permanently remove all associated data.`;
                        if (confirm(confirmMessage)) {
                            window.location.href = this.href;
                        }
                    });
                });

                // Add tooltips for better UX
                const tooltipTriggerList = document.querySelectorAll('[title]');
                tooltipTriggerList.forEach(triggerEl => {
                    new bootstrap.Tooltip(triggerEl);
                });
            });
        </script>
        <c:if test="${not empty message}">
            <div id="toast-message" class="toast-msg ${messageType == 'success' ? 'toast-success' : 'toast-error'}">
                ${message}
            </div>
            <script>
                setTimeout(function () {
                    document.getElementById('toast-message').style.display = 'none';
                }, 3000);
            </script>
            <%-- Xóa thông báo khỏi session sau khi hiển thị nếu bạn dùng session (ở đây dùng request.setAttribute nên không cần) --%>
        </c:if>

    </body>
</html>