<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Models.CV" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết CV</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Chi tiết CV</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty cv}">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">${cv.fullName}</h5>
                    <p class="card-text"><strong>Vị trí:</strong> ${cv.position}</p>
                    <p class="card-text"><strong>Địa chỉ:</strong> ${cv.address}</p>
                    <p class="card-text"><strong>Email:</strong> ${cv.email}</p>
                    <p class="card-text"><strong>Kinh nghiệm:</strong> ${cv.numberExp} năm</p>
                    <p class="card-text"><strong>Trình độ:</strong> ${cv.education}</p>
                    <p class="card-text"><strong>Lĩnh vực:</strong> ${cv.field}</p>
                    <p class="card-text"><strong>Mức lương:</strong> ${cv.currentSalary}</p>
                    <p class="card-text"><strong>Ngày sinh:</strong> ${cv.birthday}</p>
                    <p class="card-text"><strong>Quốc tịch:</strong> ${cv.nationality}</p>
                    <p class="card-text"><strong>Giới tính:</strong> ${cv.gender}</p>
                </div>
            </div>
        </c:if>
        <a href="${pageContext.request.contextPath}/view-applied-cvs" class="btn btn-primary mt-3">Quay lại</a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>