<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Service" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<Service> services = (List<Service>) request.getAttribute("services");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Top Jobs</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap" rel="stylesheet">

        <!-- Bootstrap & Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

        <!-- Custom Style -->
        <style>
            body {
                font-family: 'Heebo', sans-serif;
                background-color: #f0fbf6;
                ;
            }
            /* Set navbar height to exactly 75px */
            .navbar {
                height: 75px;
                min-height: 75x;
                padding-top: 0;
                padding-bottom: 0;
                align-items: center;
            }

            /* Align brand (logo) vertically */
            .navbar .navbar-brand {
                display: flex;
                align-items: center;
                height: 100%;
                padding: 0;
                margin-left: 1rem;
            }

            /* Align nav links vertically */
            .navbar .nav-link {
                display: flex;
                align-items: center;
                height: 75px;
            }


            .navbar-brand h1 {
                font-family: 'Inter', sans-serif;
                font-weight: 700;
                font-size: 40px;
                color: #00b67a;
            }

            .navbar-light .nav-link {
                font-weight: 500;
                font-size: 15px;
                color: #333;
            }

            .navbar-light .nav-link.active,
            .navbar-light .nav-link:hover,
            .navbar-light .nav-link:focus {
                color: #00b67a;
            }

            .btn-primary {
                background-color: #00b67a;
                border: none;
                font-weight: 600;
                font-size: 20px;
            }

            .btn-primary:hover {
                background-color: #009f6b;
            }

            .job-section {
                padding: 60px 20px;
            }

            .job-card {
                border: none;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                transition: all 0.3s ease-in-out;
                height: 100%;
            }

            .job-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 30px rgba(0,0,0,0.12);
            }

            .card-header {
                background-color: #1D2D3C;
                color: white;
                font-weight: 700;
                font-size: 1.1rem;
                padding: 1rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-top-left-radius: 12px;
                border-top-right-radius: 12px;
            }

            .card-header.vip-max {
                background-color: #1D2D3C;
            }
            .card-header.vip-plus {
                background-color: #0C413D;
            }
            .card-header.pro {
                background-color: #112E70;
            }
            .card-header.eco {
                background-color: #1E3643;
            }

            .badge-vip {
                background-color: #00C28C;
                font-size: 0.65rem;
                font-weight: 600;
                padding: 4px 8px;
                border-radius: 12px;
            }

            .card-price {
                color: #28a745;
                font-weight: 700;
                font-size: 1.7rem;
            }

            .card-subtext {
                font-size: 0.8rem;
                color: #888;
            }

            .card-features {
                text-align: left;
                padding: 0;
                list-style: none;
            }

            .card-features li {
                margin-bottom: 0.5rem;
                font-size: 0.92rem;
                color: #222;
            }

            .card-features i {
                color: #00C28C;
                margin-right: 0.6rem;
            }

            .btn-consult {
                background-color: #00C28C;
                color: white;
                font-weight: 600;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 6px;
            }

            .btn-consult:hover {
                background-color: #00a57c;
            }

            .feature-title {
                font-weight: 600;
                font-size: 1rem;
                color: #333;
                margin-top: 1.2rem;
                margin-bottom: 0.8rem;
            }
            /* Hover: Giữ màu xám như mặc định Bootstrap */
            .dropdown-menu .dropdown-item:hover {
                background-color: #e9ecef;  /* màu xám nhạt */
                color: #212529;              /* màu chữ mặc định */
            }

            /* Focus: Đổi sang màu xanh lá cây */
            .dropdown-menu .dropdown-item:focus {
                background-color: #00b67a;
                color: white;
            }


            @media (min-width: 992px) {
                .py-lg-14 {
                    padding-top: 1.4rem !important;
                    padding-bottom: 1.4rem !important;
                }
                .navbar .dropdown-menu {

                    display: block;
                    opacity: 0;
                    visibility: hidden;
                    transform: translateY(10px);
                    transition: opacity 0.5s ease, transform 0.5s ease;
                    pointer-events: none;
                }

                .navbar .dropdown:hover .dropdown-menu {
                    opacity: 1;
                    visibility: visible;
                    transform: translateY(0);
                    pointer-events: auto;
                }

                .navbar .dropdown-toggle::after {
                    transition: transform 0.5s ease;
                }

                .navbar .dropdown:hover .dropdown-toggle::after {
                    transform: rotate(180deg);
                }
            }


        </style>
    </head>
    <body>

        <!-- Navbar trực tiếp -->
        <% String role = (String) session.getAttribute("role"); %>

        <nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
            <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand d-flex align-items-center px-4">
                <h1 class="m-0">GenZTimViec.<span style="color:#00b67a">VN</span></h1>
            </a>
            <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto px-4 d-flex gap-3">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="nav-item nav-link active">HOME</a>
                    <a href="about.jsp" class="nav-item nav-link">ABOUT</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">JOBS</a>
                        <div class="dropdown-menu">
                            <a href="job-list.jsp" class="dropdown-item">Job List</a>
                            <a href="job-detail.jsp" class="dropdown-item">Job Detail</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">PAGES</a>
                        <div class="dropdown-menu">
                            <a href="category.jsp" class="dropdown-item">Job Category</a>
                            <a href="testimonial.jsp" class="dropdown-item">Testimonial</a>
                            <a href="404.jsp" class="dropdown-item">404</a>
                        </div>
                    </div>

                    <% if ("Candidate".equals(role)) { %>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Quản lý CV</a>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/submitCV" class="dropdown-item">Tạo CV</a>
                            <a href="${pageContext.request.contextPath}/manageCreatedCV" class="dropdown-item">Quản lý CV đã tạo</a>
                            <a href="${pageContext.request.contextPath}/CandidateApplyList" class="dropdown-item">Đơn tuyển</a>
                        </div>
                    </div>
                    <% } else if ("Employer".equals(role)) { %>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">FOR EMPLOYER</a>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/manageCreatedJob" class="dropdown-item">Quản lý tin tuyển</a>
                            <a href="${pageContext.request.contextPath}/view-applied-cvs" class="dropdown-item">Quản lý CV</a>
                            <a href="${pageContext.request.contextPath}/potential-cvs" class="dropdown-item">CV Tiềm Năng</a>
                            <a href="${pageContext.request.contextPath}/service-for-emp" class="dropdown-item">Dịch Vụ</a>
                        </div>
                    </div>
                    <% } %>

                    <a href="contact.jsp" class="nav-item nav-link">CONTACT</a>
                </div>

                <a href="${pageContext.request.contextPath}/createJob"
                   class="btn btn-primary rounded-0 px-lg-5 py-lg-14 d-none d-lg-block btn-navbar">
                    Đăng tin tuyển dụng <i class="fa fa-arrow-right ms-2"></i>
                </a>
            </div>
        </nav>

        <div class="container job-section">
            <h2 class="text-center fw-bold">Gói dịch vụ</h2>
            <p class="text-center text-muted mb-5">Đăng tin tuyển dụng Hiệu suất cao</p>
            <div class="row row-cols-1 row-cols-md-4 g-4">    
                <c:forEach var="s" items="${services}">
                    <!-- TOP MAX -->
                    <div class="col">
                        <div class="card job-card">
                            <div class="card-header vip-max">
                                ${s.serviceName} <span class="badge-vip">VIP</span>
                            </div>
                            <div class="card-body text-center">
                                <%
                                  Models.Service sObj = (Models.Service) pageContext.getAttribute("s");
                                  java.text.DecimalFormatSymbols symbols = new java.text.DecimalFormatSymbols();
                                  symbols.setGroupingSeparator('.');
                                  java.text.DecimalFormat formatter = new java.text.DecimalFormat("#,###", symbols);
                                  String formattedPrice = formatter.format(sObj.getPrice());
                                %>
                                <div class="card-price"><%= formattedPrice %> VNĐ</div>

                                <div class="card-subtext mb-3">* Giá trên chưa bao gồm VAT</div>
                                <form action="${pageContext.request.contextPath}/ajaxServlet" method="post">
                                    <input type="hidden" name="totalBill" value="${s.price}" />
                                    <input type="hidden" name="language" value="vn" />
                                    <button type="submit" class="btn btn-consult w-100 mb-3">Chọn mua dịch vụ</button>
                                </form>

                                <div class="feature-title">QUYỀN LỢI ĐẶC BIỆT</div>
                                <ul class="card-features">
                                    <c:forEach var="item" items="${s.descriptionList}">
                                        <li style="display: flex; align-items: start; gap: 8px;">
                                            <div style="width: 20px;">
                                                <i class="fa fa-check "></i>
                                            </div>
                                            <div style="flex: 1;">${item}</div>
                                        </li>
                                    </c:forEach>


                                </ul>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- JS (optional for Bootstrap) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
