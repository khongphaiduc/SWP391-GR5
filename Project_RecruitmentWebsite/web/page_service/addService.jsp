<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thêm Gói Dịch Vụ</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <style>
        body {
            background: #f8fafc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            margin-top: 60px;
            max-width: 600px;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #16a34a;
        }

        .btn-success {
            background-color: #16a34a;
            border-color: #16a34a;
        }

        .btn-success:hover {
            background-color: #15803d;
            border-color: #15803d;
        }

        .alert-danger {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="mb-4 text-center">Tạo Gói Dịch Vụ Mới</h2>

        <!-- Hiển thị thông báo nếu có -->
        <c:if test="${not empty message}">
            <div class="alert alert-danger">${message}</div>
        </c:if>

        <form method="post" action="<c:url value='/create-servicepackage'/>">
            <div class="mb-3">
                <label for="serviceName" class="form-label">Tên gói dịch vụ</label>
                <input type="text" class="form-control" id="serviceName" name="serviceName" required>
            </div>

            <div class="mb-3">
                <label for="price" class="form-label">Giá (VNĐ)</label>
                <input type="number" step="0.01" min="0" class="form-control" id="price" name="price" required>
            </div>

            <div class="mb-3">
                <label for="description" class="form-label">Mô tả (phân cách các mô tả bằng việc xuống dòng hoặc ";")</label>
                <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
            </div>

            <div class="mb-3">
                <label for="duration" class="form-label">Thời lượng (Tháng)</label>
                <input type="number" min="1" class="form-control" id="duration" name="duration" required>
            </div>

            <div class="mb-3">
                <label for="promotionId" class="form-label">Mã khuyến mãi (nếu có)</label>
                <input type="number" min="1" class="form-control" id="promotionId" name="promotionId">
            </div>

            <div class="d-flex justify-content-between">
                <a href="<c:url value='/list?type=service'/>" class="btn btn-secondary">Quay lại</a>
                <button type="submit" class="btn btn-success">Tạo Gói Dịch Vụ</button>
            </div>
        </form>
    </div>

    <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
</body>
</html>
