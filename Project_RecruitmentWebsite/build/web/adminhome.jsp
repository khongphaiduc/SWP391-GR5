<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh; /* Đảm bảo trang chiếm toàn bộ chiều cao màn hình */
            margin: 0;
            background-color: #f8f9fa; /* Màu nền nhẹ nhàng */
        }
        .button-container {
            text-align: center;
        }
        .button-row {
            margin-bottom: 20px; /* Khoảng cách giữa các hàng nút */
        }
        .btn-custom {
            margin: 10px; /* Khoảng cách giữa các nút */
            width: 180px; /* Chiều rộng cố định cho các nút */
            height: 60px; /* Chiều cao cố định cho các nút */
            font-size: 1.2em;
            display: inline-flex; /* Để căn giữa icon và text */
            align-items: center; /* Căn giữa theo chiều dọc */
            justify-content: center; /* Căn giữa theo chiều ngang */
            border-radius: 30px; /* Bo tròn nút */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
            transition: all 0.3s ease; /* Hiệu ứng chuyển động khi hover */
        }
        .btn-custom:hover {
            transform: translateY(-3px); /* Nhảy nhẹ lên khi hover */
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15); /* Đổ bóng đậm hơn */
        }
        /* Tùy chỉnh màu sắc cho từng nút */
        .btn-primary-custom {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
        }
        .btn-success-custom {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
        }
        .btn-warning-custom {
            background-color: #ffc107;
            border-color: #ffc107;
            color: #212529; /* Màu chữ đen cho nền vàng */
        }
        .btn-danger-custom {
            background-color: #dc3545;
            border-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>
 <div class="button-container">
        <div class="button-row">
            <a href="list" class="btn btn-custom btn-primary-custom">
                <i class="fas fa-users mr-2"></i> View User
            </a>
            <a href="adduser.jsp" class="btn btn-custom btn-success-custom">
                <i class="fas fa-user-plus mr-2"></i> Add Admin
            </a>
        </div>
        <div class="button-row">
            <a href="listjobpost" class="btn btn-custom btn-warning-custom">
                <i class="fas fa-cog mr-2"></i> View JobPost 
            </a>
            <a href="delete" class="btn btn-custom btn-danger-custom">
                <i class="fas fa-trash-alt mr-2"></i> Chức năng 4
            </a>
        </div>
    </div>  

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>