<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Danh sách CV đã ứng tuyển</title>
</head>
<body>

<h2>Danh sách CV đã ứng tuyển</h2>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>Họ tên</th>
        <th>Email</th>
        <th>Vị trí</th>
        <th>Kinh nghiệm</th>
        <th>Trình độ</th>
    </tr>
    <c:forEach var="cv" items="${cvList}">
        <tr>
            <td>${cv.fullName}</td>
            <td>${cv.email}</td>
            <td>${cv.position}</td>
            <td>${cv.numberExp} năm</td>
            <td>${cv.education}</td>
        </tr>
    </c:forEach>
</table>

<!-- Phân trang -->
<div style="margin-top: 20px;">
    <c:if test="${totalPage > 1}">
        <c:forEach var="i" begin="1" end="${totalPage}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <strong>[${i}]</strong>
                </c:when>
                <c:otherwise>
                    <a href="view-sapplied-cvs?page=${i}">[${i}]</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </c:if>
</div>

</body>
</html>
