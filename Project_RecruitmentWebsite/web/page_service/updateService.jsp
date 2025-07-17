<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Cập Nhật Gói Dịch Vụ</title>
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
                border-color: #2563eb;
            }

            .btn-primary {
                background-color: #2563eb;
                border-color: #2563eb;
            }

            .btn-primary:hover {
                background-color: #1e40af;
                border-color: #1e40af;
            }

            .alert-success {
                background-color: #d1fae5;
                color: #065f46;
                border: 1px solid #34d399;
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
            <h2 class="mb-4 text-center">Cập Nhật Gói Dịch Vụ</h2>

            <!-- Hiển thị thông báo -->
            <c:if test="${not empty message}">
                <div class="alert ${messageType eq 'success' ? 'alert-success' : 'alert-danger'}">
                    ${message}
                </div>
            </c:if>

            <form method="post" action="<c:url value='/update-service'/>">
                <input type="hidden" name="serviceId" value="${service.serviceId}"/>

                <div class="mb-3">
                    <label for="serviceName" class="form-label">Tên gói dịch vụ</label>
                    <input type="text" class="form-control" id="serviceName" name="serviceName" value="${service.serviceName}" required>
                </div>

                <div class="mb-3">
                    <label for="price" class="form-label">Giá (VNĐ)</label>
                    <input type="number" step="0.01" min="0" class="form-control" id="price" name="price" value="${service.price}" required>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả (dùng ; hoặc xuống dòng để phân tách)</label>
                    <textarea class="form-control" id="description" name="description" rows="3" required><c:out value="${service.description}" /></textarea>
                </div>


                <div class="mb-3">
                    <label for="duration" class="form-label">Thời lượng (Ngày)</label>
                    <input type="number" min="1" class="form-control" id="duration" name="duration" value="${service.duration}" required>
                </div>

                <div class="mb-3">
                    <label for="promotionId" class="form-label">Mã khuyến mãi (nếu có)</label>
                    <input type="number" min="1" class="form-control" id="promotionId" name="promotionId" value="${service.promotionId}">
                </div>

                <div class="d-flex justify-content-between">
                    <a href="${pageContext.request.contextPath}/adminService" class="btn btn-secondary">Quay lại</a>
                    <button type="submit" class="btn btn-primary">Cập Nhật</button>
                </div>
            </form>
        </div>

        <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
    </body>
</html>
