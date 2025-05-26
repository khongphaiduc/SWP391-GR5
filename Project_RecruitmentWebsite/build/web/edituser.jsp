<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <head>
        <title>Edit Account</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
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

        <style>
            .btn-submit {
                background: linear-gradient(90deg, #7B42F6 0%, #B01EFF 100%);
                color: #fff;
                font-weight: 600;
                border-radius: 24px;
                padding: 12px 32px;
                font-size: 18px;
                box-shadow: 0 2px 16px 0 rgba(123,66,246,0.11);
                transition: background 0.2s, box-shadow 0.2s, transform 0.15s;
                text-decoration: none;
                letter-spacing: 0.6px;
            }

            .btn-submit:hover {
                background: linear-gradient(90deg, #B01EFF 0%, #7B42F6 100%);
                color: #fff;
                transform: translateY(-2px) scale(1.04);
                box-shadow: 0 8px 24px 0 rgba(123,66,246,0.16);
            }

            .form-container {
                padding: 40px;
                background-color: #f9f9f9;
                border-radius: 8px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                max-width: 600px;
                margin: 0 auto;
            }
        </style>
    </head>

    <body>
        <div class="container-xxl bg-white p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->

            <!-- Navbar Start -->
            <nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
                <a href="index.html" class="navbar-brand d-flex align-items-center text-center py-0 px-4 px-lg-5">
                    <h1 class="m-0 text-primary">GenZTimViec.VN</h1>
                </a>
            </nav>
            <!-- Navbar End -->

            <!-- Edit Account Form Start -->
            <div class="container py-5">
                <h2 class="text-center mb-5">Edit Account</h2>

                <div class="form-container">
                    <!-- Form sửa thông tin tài khoản -->
                    <form action="editAccount" method="post">
                        <!-- Hidden field để gửi Account_ID không đổi -->
                        <input type="hidden" name="id" value="${account.accountId}"> <!-- ID tài khoản -->

                        <!-- Username -->
                        <div class="mb-4">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" id="username" name="username" class="form-control" value="${account.accountName}" required>
                        </div>

                        <!-- Password -->
                        <div class="mb-4">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" id="password" name="password" class="form-control" value="${account.passwordHash}" required>
                        </div>

                        <!-- Email -->
                        <div class="mb-4">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" id="email" name="email" class="form-control" value="${account.email}" required>
                        </div>

                        <!-- Role -->
                        <div class="mb-4">
                            <label for="role" class="form-label">Role</label>
                            <select id="role" name="role" class="form-select" required>
                                <option value="Admin" <c:if test="${account.role eq 'Admin'}">selected</c:if>>Admin</option>
                                <option value="User" <c:if test="${account.role eq 'User'}">selected</c:if>>User</option>

                            </select>
                        </div>

                        <!-- Submit button -->
                        <div class="mb-4">
                            <button type="submit" class="btn btn-submit w-100">Update Account</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- Edit Account Form End -->

            <!-- Footer Start -->
            <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
                <div class="container py-5">
                    <div class="row g-5">
                        <div class="col-lg-3 col-md-6">
                            <h5 class="text-white mb-4">Company</h5>
                            <a class="btn btn-link text-white-50" href="">About Us</a>
                            <a class="btn btn-link text-white-50" href="">Contact Us</a>
                            <a class="btn btn-link text-white-50" href="">Our Services</a>
                            <a class="btn btn-link text-white-50" href="">Privacy Policy</a>
                            <a class="btn btn-link text-white-50" href="">Terms & Condition</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End -->
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>
</html>
