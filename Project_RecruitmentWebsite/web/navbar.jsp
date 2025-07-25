<%-- 
    Document   : navbar
    Created on : May 22, 2025, 10:05:01 AM
    Author     : PC
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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


<%String role = (String) session.getAttribute("role");%>

<%if("Admin".equals(role)){%>
<nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">

    <a href="Index" class="navbar-brand d-flex align-items-center text-center py-0 px-4 px-lg-5">
        <h1 class="m-0 text-primary">GenZTimViec.VN</h1>
    </a>
    <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-0">
            <a href="list" class="nav-item nav-link active">Tạo tài khoản quản lý</a>
            <a href="StatictisData" class="nav-item nav-link" >Thống kê Tổng Quan</a>
            <a href="TableFinancial" class="nav-item nav-link" >Báo Cáo</a>
            <a href="adminService" class="nav-item nav-link" >Dịch vụ</a>
<!--            <a href="adminPromotion" class="nav-item nav-link">Khuyến mại</a>-->
            <a href="notificationServlet" class="nav-item nav-link">Thông báo</a>
            <a href="DisplayListReport" class="nav-item nav-link">Quản lý feedback</a>

        </div>
    </div>
</nav>
<%}else{%>
<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">

    <a href="Index" class="navbar-brand d-flex align-items-center text-center py-0 px-4 px-lg-5">
        <h1 class="m-0 text-primary">GenZTimViec.VN</h1>
    </a>
    <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-0">
            <a href="index.jsp" class="nav-item nav-link active">TRANG CHỦ</a>
            <a href="about.jsp" class="nav-item nav-link" target="_blank" title="...">CHI TIẾT</a>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">VIỆC LÀM</a>
                <div class="dropdown-menu rounded-0 m-0">
                    <a href="searchListJobPost" class="dropdown-item">Danh sách việc làm</a>
                </div>
            </div>

            <%if("Candidate".equals(role)){%>
            <div class="nav-item dropdown">

                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Quản lý CV</a>
                <div class="dropdown-menu rounded-0 m-0">
                    <a href="${pageContext.request.contextPath}/submitCV" class="dropdown-item">Tạo CV</a>
                    <a href="${pageContext.request.contextPath}/manageCreatedCV" class="dropdown-item">Quản lý CV đã tạo</a> 
                    <a href="${pageContext.request.contextPath}/CandidateApplyList" class="dropdown-item" >Đơn tuyển</a>

                </div>
            </div>


            <%}else if("Employer".equals(role)){%>                      
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Nhà tuyển dụng</a>
                <div class="dropdown-menu rounded-0 m-0">
                    <a href="${pageContext.request.contextPath}/manageCreatedJob" class="dropdown-item">Quản lý tin tuyển</a> 
                    <a href="${pageContext.request.contextPath}/view-applied-cvs" class="dropdown-item">Quản lý CV</a> 
                    <a href="${pageContext.request.contextPath}/potential-cvs" class="dropdown-item">Cv tiềm năng</a> 
                    <a href="${pageContext.request.contextPath}/service-for-emp" class="dropdown-item">Dịch Vụ</a>
                    <a href="${pageContext.request.contextPath}/OrderHistory" class="dropdown-item">Lịch sử giao dịch</a>

                </div>
            </div>
            <%}%>

            <a href="contact.jsp" class="nav-item nav-link">Contact</a>
        </div>
        <a href="${pageContext.request.contextPath}/createJob" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">Đăng tin tuyển dụng<i class="fa fa-arrow-right ms-3"></i></a>
    </div>
</nav>
<%}%>
<!-- Navbar End -->

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/wow/wow.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>