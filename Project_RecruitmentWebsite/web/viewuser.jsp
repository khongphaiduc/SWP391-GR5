<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Employer" %>
<%@ page import="Models.Candidate" %>
<%@ page import="Models.Service" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.DecimalFormatSymbols" %>


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
        <style>
            :root {
                --primary-color: #16a34a;
                --secondary-color: #f8fafc;
                --accent-color: #22c55e;
                --success-color: #10b981;
                --warning-color: #f59e0b;
                --danger-color: #ef4444;
                --text-primary: #1f2937;
                --text-secondary: #6b7280;
                --border-color: #e5e7eb;
                --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
                --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
                --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
                color: var(--text-primary);
                line-height: 1.6;
            }

            /* Navigation Styling */
            .navbar {
                background: rgba(255, 255, 255, 0.95) !important;
                backdrop-filter: blur(10px);
                border-bottom: 1px solid var(--border-color);
                box-shadow: var(--shadow-sm);
            }

            .navbar-brand h1 {
                background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                font-weight: 700;
            }

            .nav-link {
                font-weight: 500;
                color: var(--text-primary) !important;
                transition: all 0.3s ease;
            }

            .nav-link:hover {
                color: var(--primary-color) !important;
                transform: translateY(-1px);
            }

            /* Header Section */
            .admin-header {
                background: linear-gradient(135deg, var(--primary-color) 0%, #22c55e 100%);
                color: white;
                padding: 3rem 0;
                position: relative;
                overflow: hidden;
            }

            .admin-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
                opacity: 0.3;
            }

            .admin-header .container {
                position: relative;
                z-index: 1;
            }

            .admin-header h1 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .admin-header p {
                font-size: 1.1rem;
                opacity: 0.9;
            }

            /* Stats Cards */
            .stats-section {
                margin-top: -2rem;
                margin-bottom: 3rem;
                position: relative;
                z-index: 2;
            }

            .stats-card {
                background: white;
                border-radius: 16px;
                padding: 1.5rem;
                box-shadow: var(--shadow-md);
                border: 1px solid var(--border-color);
                transition: all 0.3s ease;
                height: 100%;
            }

            .stats-card:hover {
                transform: translateY(-4px);
                box-shadow: var(--shadow-lg);
            }

            .stats-icon {
                width: 48px;
                height: 48px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                margin-bottom: 1rem;
            }

            .stats-icon.primary {
                background: linear-gradient(135deg, var(--primary-color), #22c55e);
                color: white;
            }
            .stats-icon.success {
                background: linear-gradient(135deg, var(--success-color), #059669);
                color: white;
            }
            .stats-icon.warning {
                background: linear-gradient(135deg, var(--warning-color), #d97706);
                color: white;
            }
            .stats-icon.info {
                background: linear-gradient(135deg, var(--accent-color), #0891b2);
                color: white;
            }

            .stats-number {
                font-size: 2rem;
                font-weight: 700;
                color: var(--text-primary);
            }

            .stats-label {
                color: var(--text-secondary);
                font-weight: 500;
            }

            /* Table Section */
            .table-section {
                background: white;
                border-radius: 16px;
                box-shadow: var(--shadow-md);
                border: 1px solid var(--border-color);
                overflow: hidden;
                margin-bottom: 2rem;
            }

            .table-header {
                background: linear-gradient(135deg, #f8fafc, #f1f5f9);
                padding: 1.5rem;
                border-bottom: 1px solid var(--border-color);
            }

            .table-header h3 {
                margin: 0;
                font-weight: 600;
                color: var(--text-primary);
            }

            .table-container {
                overflow-x: auto;
            }

            .modern-table {
                margin: 0;
                font-size: 0.95rem;
            }

            .modern-table thead th {
                background: var(--secondary-color);
                color: var(--text-primary);
                font-weight: 600;
                padding: 1rem;
                border: none;
                text-transform: uppercase;
                font-size: 0.8rem;
                letter-spacing: 0.05em;
            }

            .modern-table tbody tr {
                transition: all 0.2s ease;
                border-bottom: 1px solid #f3f4f6;
            }

            .modern-table tbody tr:hover {
                background: rgba(79, 70, 229, 0.05);
                transform: scale(1.01);
            }

            .modern-table tbody td {
                padding: 1rem;
                vertical-align: middle;
                border: none;
            }

            /* Role Badges */
            .role-badge {
                padding: 0.375rem 0.75rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.025em;
            }

            .role-admin {
                background: linear-gradient(135deg, #fef3c7, #fbbf24);
                color: #92400e;
            }

            .role-user {
                background: linear-gradient(135deg, #dbeafe, #3b82f6);
                color: #1e40af;
            }

            .role-manager {
                background: linear-gradient(135deg, #d1fae5, #10b981);
                color: #065f46;
            }

            /* Action Buttons */
            .action-buttons {
                display: flex;
                gap: 0.5rem;
                justify-content: center;
            }

            .action-btn {
                width: 36px;
                height: 36px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.875rem;
                transition: all 0.3s ease;
                border: none;
                text-decoration: none;
            }

            .action-btn:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
            }

            .btn-view {
                background: linear-gradient(135deg, var(--accent-color), #22c55e);
                color: white;
            }

            .btn-edit {
                background: linear-gradient(135deg, var(--warning-color), #d97706);
                color: white;
            }

            .btn-delete {
                background: linear-gradient(135deg, var(--danger-color), #dc2626);
                color: white;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .admin-header h1 {
                    font-size: 2rem;
                }

                .stats-section {
                    margin-top: -1rem;
                }

                .action-buttons {
                    flex-direction: column;
                    gap: 0.25rem;
                }

                .action-btn {
                    width: 32px;
                    height: 32px;
                }
            }

            /* Loading Animation */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .fade-in-up {
                animation: fadeInUp 0.6s ease-out;
            }

            /* Custom Scrollbar */
            .table-container::-webkit-scrollbar {
                height: 8px;
            }

            .table-container::-webkit-scrollbar-track {
                background: #f1f5f9;
                border-radius: 4px;
            }

            .table-container::-webkit-scrollbar-thumb {
                background: var(--primary-color);
                border-radius: 4px;
            }

            .table-container::-webkit-scrollbar-thumb:hover {
                background: #3730a3;
            }
            /*css message*/
            .toast-msg {
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 25px;
                border-radius: 8px;
                font-size: 0.95rem;
                font-weight: 500;
                z-index: 9999;
                color: white;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                animation: fadeSlide 0.4s ease-in-out;
            }
            .toast-success {
                background-color: #16a34a; /* green */
            }
            .toast-error {
                background-color: #dc2626; /* red */
            }
            @keyframes fadeSlide {
                from {
                    opacity: 0;
                    transform: translateX(50px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

        </style>
    </head>
    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-light sticky-top">
            <div class="container">
                <a href="index.jsp" class="navbar-brand d-flex align-items-center">
                    <h1 class="m-0">GenZTimViec.VN</h1>
                </a>
                <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav ms-auto">
                        <a href="index.jsp" class="nav-item nav-link">Home</a>
                        <a href="about.jsp" class="nav-item nav-link">About</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Jobs</a>
                            <div class="dropdown-menu">
                                <a href="job-list.jsp" class="dropdown-item">Job List</a>
                                <a href="job-detail.jsp" class="dropdown-item">Job Detail</a>
                            </div>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                            <div class="dropdown-menu">
                                <a href="category.jsp" class="dropdown-item">Job Category</a>
                                <a href="testimonial.jsp" class="dropdown-item">Testimonial</a>
                                <a href="404.jsp" class="dropdown-item">404</a>
                            </div>
                        </div>
                        <a href="contact.jsp" class="nav-item nav-link">Contact</a>
                    </div>
                    <a href="#" class="btn btn-primary rounded-pill px-4 ms-3">
                        Post A Job <i class="fa fa-arrow-right ms-2"></i>
                    </a>
                </div>
            </div>
        </nav>

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

        <!-- User Management Table Section -->
        <div class="container pb-5">
            <div class="table-section fade-in-up">
                <div class="table-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3><i class="fas fa-users me-2"></i>User Management</h3>
                        <div class="d-flex gap-2">
                            <form action="adduser.jsp" method="get">
                                <button class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-1"></i>Add User
                                </button>
                            </form>
                        </div>
                        <div class="d-flex gap-2">
                            <!-- Search Bar -->
                            <form method="get" action="search" class="search-bar">
                                <input type="text" name="search" placeholder="Search by account name..." 
                                       value="${param.search}">
                                <i class="fas fa-search"></i>
                                <input type="hidden" name="type" value="${type}">
                                <input type="hidden" name="page" value="${currentPage}">
                            </form>
                        </div>
                    </div>
                </div>
                <form method="get" action="list" class="mb-3 d-flex justify-content-end">
                    <select name="type" onchange="this.form.submit()" class="form-select w-auto">
                        <option value="">-- Select User Type --</option>
                        <option value="employer" ${type == 'employer' ? 'selected' : ''}>Employer</option>
                        <option value="candidate" ${type == 'candidate' ? 'selected' : ''}>Candidate</option>
                    </select>
                </form>

                <div class="table-container">
                    <table class="table modern-table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag me-2"></i>ID</th>
                                <th><i class="fas fa-user me-2"></i>Account Name</th>
                                <th><i class="fas fa-envelope me-2"></i>Email</th>
                                <th><i class="fas fa-cogs me-2"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="emp" items="${employers}">
                                <tr>
                                    <td>
                                        <span class="fw-bold text-primary">#${emp.employerId}</span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-3" 
                                                 style="width: 40px; height: 40px; font-size: 0.9rem; color: white; font-weight: 600;">
                                                ${emp.nameEmployer.substring(0, 1).toUpperCase()}
                                            </div>
                                            <div>
                                                <div class="fw-bold">${emp.nameEmployer}</div>
                                                <small class="text-muted">Member since 2024</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-envelope text-muted me-2"></i>
                                            ${emp.email}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a class="action-btn btn-view" href="viewAccount?id=${emp.employerId}&type=employer" 
                                               title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a class="action-btn btn-delete" href="deleteAccount?id=${emp.employerId}&type=employer" 
                                               onclick="return confirm('Are you sure you want to delete this account?');"
                                               title="Delete">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:forEach var="can" items="${candidates}">
                                <tr>
                                    <td>
                                        <span class="fw-bold text-primary">#${can.candidateId}</span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-3" 
                                                 style="width: 40px; height: 40px; font-size: 0.9rem; font-weight: 600; color: white;">
                                                ${can.candidateName.substring(0, 1).toUpperCase()}
                                            </div>
                                            <div>
                                                <div class="fw-bold">${can.candidateName}</div>
                                                <small class="text-muted">Member since 2024</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-envelope text-muted me-2"></i>
                                            ${can.email}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a class="action-btn btn-view" href="viewAccount?id=${can.candidateId}&type=candidate" 
                                               title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a class="action-btn btn-delete" href="deleteAccount?id=${can.candidateId}&type=candidate" 
                                               onclick="return confirm('Are you sure you want to delete this account?');"
                                               title="Delete">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="d-flex justify-content-center mt-4">
                        <nav>
                            <ul class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="list?page=${currentPage - 1}&type=${type}">Previous</a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="list?page=${i}&type=${type}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="list?page=${currentPage + 1}&type=${type}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>

            <!-- Service Management Table Section -->
            <div class="table-section fade-in-up">
                <div class="table-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3><i class="fas fa-cogs me-2"></i>Service Management</h3>
                        <div class="d-flex gap-2">
                            <form action="${pageContext.request.contextPath}/page_service/addService.jsp" method="get">
                                <button class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-1"></i>Add Service
                                </button>
                            </form>


                        </div>
                        <div class="d-flex gap-2">
                            <!-- Search Bar -->
                            <form method="get" action="admin/searchService" class="search-bar">
                                <input type="text" name="search" placeholder="Search by service name..." 
                                       value="${param.search}">
                                <i class="fas fa-search"></i>
                                <input type="hidden" name="type" value="${serviceType}">
                                <input type="hidden" name="page" value="${currentServicePage}">
                            </form>
                        </div>
                    </div>
                </div>
                <form method="get" action="view-list-service" class="mb-3 d-flex justify-content-end">
                    <select name="serviceType" onchange="this.form.submit()" class="form-select w-auto">
                        <option value="">-- Select Service Type --</option>
                        <option value="premium" ${serviceType == 'premium' ? 'selected' : ''}>Premium</option>
                        <option value="standard" ${serviceType == 'standard' ? 'selected' : ''}>Standard</option>
                    </select>
                </form>

                <div class="table-container">
                    <table class="table modern-table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag me-2"></i>ID</th>
                                <th><i class="fas fa-cog me-2"></i>Service Name</th>
                                <th><i class="fas me-2"></i>Price (VNĐ) </th>
                                <th><i class="fas fa-info-circle me-2"></i>Description</th>
                                <th><i class="fas fa-tag me-2"></i>Promotion ID</th>
                                <th><i class="fas fa-clock me-2"></i>Duration</th>
                                <th><i class="fas fa-cogs me-2"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="service" items="${serviceList}">
                                <tr>
                                    <td>
                                        <span class="fw-bold text-primary">${service.serviceId}</span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-3" 
                                                 style="width: 40px; height: 40px; font-size: 0.9rem; color: white; font-weight: 600;">
                                                ${service.serviceName.substring(0, 1).toUpperCase()}
                                            </div>
                                            <div>
                                                <div class="fw-bold">${service.serviceName}</div>
                                                <small class="text-muted">Created in 2024</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <%
                                            Models.Service s = (Models.Service) pageContext.getAttribute("service");
                                            DecimalFormatSymbols symbols = new DecimalFormatSymbols();
                                            symbols.setGroupingSeparator('.');
                                            DecimalFormat formatter = new DecimalFormat("#,###", symbols);
                                            String formattedPrice = formatter.format(s.getPrice());
                                        %>
                                        <div class="d-flex align-items-center">
                                            <span class="text-muted fw-bold me-2"></span>
                                            <%= formattedPrice %> VNĐ
                                        </div>
                                    </td>

                                    <td>
                                        <div class="d-flex flex-column">
                                            <c:forEach var="item" items="${service.descriptionList}">
                                                <div class="d-flex align-items-center mb-1">
                                                    <i class="fas fa-info-circle text-muted me-2"></i>
                                                    <span>${item}</span>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </td>

                                    <td>
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-tag text-muted me-2"></i>
                                            <c:choose>
                                                <c:when test="${not empty service.promotionId}">
                                                    ${service.promotionId}
                                                </c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-clock text-muted me-2"></i>
                                            ${service.duration}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <form method="post" action="list" style="display:inline;">
                                                <input type="hidden" name="action" value="toggleVisibility"/>
                                                <input type="hidden" name="serviceId" value="${service.serviceId}"/>
                                                <input type="hidden" name="visible" value="${!service.visible}"/>
                                                <button type="submit"
                                                        class="action-btn btn-view"
                                                        title="${service.visible ? 'Ẩn dịch vụ này' : 'Hiện lại dịch vụ'}"
                                                        onclick="return confirm('Bạn có chắc chắn muốn ${service.visible ? 'ẩn' : 'hiện'} dịch vụ này?');">
                                                    <i class="fas ${service.visible ? 'fa-eye' : 'fa-eye-slash'}"></i>
                                                </button>
                                            </form>
                                            <a class="action-btn btn-edit"
                                               href="${pageContext.request.contextPath}/update-service?id=${service.serviceId}"
                                               title="Edit Service">
                                                <i class="fas fa-edit"></i>
                                            </a>

                                            <a class="action-btn btn-delete"
                                               href="delete-servicepackage?id=${service.serviceId}"
                                               onclick="return confirm('Are you sure you want to delete this service?');"
                                               title="Delete Service">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>

                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty serviceList}">
                                <tr>
                                    <td colspan="7" class="text-center">No services found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                    <div class="d-flex justify-content-center mt-4">
                        <nav>
                            <ul class="pagination">
                                <c:if test="${currentServicePage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="admin/view-list-service?page=${currentServicePage - 1}&type=${serviceType}">Previous</a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalServicePages}" var="i">
                                    <li class="page-item ${i == currentServicePage ? 'active' : ''}">
                                        <a class="page-link" href="admin/view-list-service?page=${i}&type=${serviceType}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentServicePage < totalServicePages}">
                                    <li class="page-item">
                                        <a class="page-link" href="admin/view-list-service?page=${currentServicePage + 1}&type=${serviceType}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>

            <!-- Action Menu -->
            <div class="floating-actions-v2">
                <%
                    if (session.getAttribute("username") != null && 
                        session.getAttribute("role") != null && 
                        session.getAttribute("role").equals("Admin")) {
                %>
                <div class="fab-item fab-heart" title="Admin">
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