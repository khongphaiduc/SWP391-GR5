<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Models.Promotion" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    Promotion promo = (Promotion) request.getAttribute("promotion");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật khuyến mãi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <h2 class="text-center mb-4">Cập nhật khuyến mãi</h2>

        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="update-promotion" method="post" class="bg-white p-4 rounded shadow-sm">
            <input type="hidden" name="promotionId" value="${promotion.promotionId}" />

            <div class="mb-3">
                <label class="form-label">Mã khuyến mãi</label>
                <input type="text" name="code" class="form-control" value="${promotion.code}" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Giảm giá (%)</label>
                <input type="number" name="discount" class="form-control" step="0.01" min="0" max="100"
                       value="${promotion.discount}" required />
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Ngày bắt đầu</label>
                    <input type="date" name="dateStart" class="form-control"
                           value="${fn:substring(promotion.dateStart, 0, 10)}" required />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Ngày kết thúc</label>
                    <input type="date" name="dateEnd" class="form-control"
                           value="${fn:substring(promotion.dateEnd, 0, 10)}" required />
                </div>
            </div>

            <div class="d-flex justify-content-between">
                <a href="list" class="btn btn-secondary">Quay lại danh sách</a>
                <button type="submit" class="btn btn-success">Lưu thay đổi</button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
