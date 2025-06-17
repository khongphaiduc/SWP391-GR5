<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*, Models.CV" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách CV đã ứng tuyển</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>📄 Danh sách CV đã ứng tuyển</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-warning mt-3">${error}</div>
        </c:if>

        <c:if test="${not empty cvList}">
            <table class="table table-bordered mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>Vị trí</th>
                        <th>Kinh nghiệm</th>
                        <th>Học vấn</th>
                        <th>Quốc tịch</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cv" items="${cvList}">
                        <tr>
                            <td>${cv.fullName}</td>
                            <td>${cv.email}</td>
                            <td>${cv.position}</td>
                            <td>${cv.numberExp} năm</td>
                            <td>${cv.education}</td>
                            <td>${cv.nationality}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <a href="index.jsp" class="btn btn-secondary mt-3">← Quay lại</a>
    </div>
</body>
</html>
