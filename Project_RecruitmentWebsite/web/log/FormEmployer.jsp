<%-- 
    Document   : FormEmployer
    Created on : Jun 15, 2025, 1:21:47 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Recruitment Platform</title>
    <link rel="stylesheet" href="../css/FormEmployerCSS.css">
    <!-- Google Fonts (optional, for similar look) -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap" rel="stylesheet">
    <!-- Font Awesome for icons (optional) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
<div class="container">
    <div class="form-section">
        <h1>
            Chào mừng <span class="highlight">GenZTimViec</span>
        </h1>
        <h2>Đến với Smart Recruitment Platform</h2>
        <p class="subtitle">
            Vui lòng điền các thông tin nhà tuyển dụng bên dưới để chúng tôi hỗ trợ bạn tốt hơn:
        </p>
        <div class="progress-bar">
            <div class="step active">
                <span class="circle"><i class="fa fa-check"></i></span>
                <span class="label">Thông tin nhà tuyển dụng</span>
            </div>

        </div>
        <form action="<%= request.getContextPath() %>/RegisterWithGoogle" method="post" id="recruiter-form">
            <h3>Thông tin nhà tuyển dụng</h3>
            <div class="form-group">
                <label for="fullname">Họ và tên <span class="required">*</span></label>
                <div class="input-icon">
                    <i class="fa fa-user"></i>
                    <input type="text" id="fullname" name="fullname"  placeholder="Tên nhà tuyển dụng" required>
                </div>
            </div>
            <div class="form-group">
                <label for="phone">Số điện thoại cá nhân <span class="required">*</span></label>
                <div class="input-icon">
                    <i class="fa fa-phone"></i>
                    <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại cá nhân" required>
                </div>
            </div>
            <div class="form-group">
                <label for="company">Công ty <span class="required">*</span></label>
                <div class="input-icon">
                    <i class="fa fa-building"></i>
                    <input type="text" id="company" name="company" placeholder="Nhập tên công ty" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group location-group">
                    <label for="province">Địa điểm làm việc <span class="required">*</span></label>
                    <div class="input-icon">
                        <i class="fa fa-map-marker-alt"></i>
                        <select id="province" name="location" required>
                            <option value="">Chọn tỉnh/thành phố</option>
                            <option value="Hà Nội">Hà Nội</option>
                            <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                            <option value="Đà Nẵng">Đà Nẵng</option>
                            <!-- Add more as needed -->
                        </select>
                    </div>
                </div>
<!--                <div class="form-group location-group">
                    <label for="district">Quận/ huyện</label>
                    <div class="input-icon">
                        <i class="fa fa-map"></i>
                        <select id="district" name="district" disabled>
                            <option value="">Chọn quận/huyện</option>
                        </select>
                    </div>
                </div>-->
            </div>
            <button type="submit" class="submit-btn">
               Hoàn Tất Thông Tin 
            </button>
        </form>
    </div>
    <div class="image-section">
        <img src="https://img2.thuthuatphanmem.vn/uploads/2019/01/26/hinh-anh-dep-ve-tuyen-dung-nhan-vien_012646405.jpg" style="border-radius: 15px" alt="Recruitment Illustration" />
        
    </div>
</div>
<script src="script.js"></script>
</body>
</html>
