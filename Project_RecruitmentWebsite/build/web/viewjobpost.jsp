<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Job Posts</title>
    <!-- Font Awesome để dùng icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px 12px;
            text-align: center;
        }

        th {
            background-color: #f8f8f8;
            color: #444;
        }

        tr:nth-child(even) {
            background-color: #fafafa;
        }

        .action-buttons a {
            margin: 0 5px;
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
            display: inline-block;
        }

        .edit-btn {
            background-color: #4CAF50;
            color: white;
        }

        .delete-btn {
            background-color: #f44336;
            color: white;
        }

        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination a {
            margin: 0 4px;
            text-decoration: none;
            padding: 6px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            color: #333;
        }

        .pagination a:hover,
        .pagination a.current {
            background-color: #007bff;
            color: white !important;
            border-color: #007bff;
        }
    </style>
</head>
<body>
<h2>Danh sách Job Posts</h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Tiêu đề</th>
        <th>Mô tả</th>
        <th>Vị trí</th>
        <th>Địa điểm</th>
        <th>Mức lương</th>
        <th>Kinh nghiệm</th>
        <th>Loại công việc</th>
        <th>Ngày đăng</th>
        <th>Hiển thị</th>
        <th>Employer ID</th>
        <th>Danh mục</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:choose>
        <c:when test="${not empty posts}">
            <c:forEach var="job" items="${posts}">
                <tr>
                    <td>${job.jobPost_ID}</td>
                    <td>${job.title}</td>
                    <td>${job.description}</td>
                    <td>${job.position}</td>
                    <td>${job.location}</td>
                    <td>${job.offer_Min} - ${job.offer_Max}</td>
                    <td>${job.number_exp} năm</td>
                    <td>${job.typeJob}</td>
                    <td><fmt:formatDate value="${job.dayCre}" pattern="dd/MM/yyyy" /></td>
                    <td>
                        <c:choose>
                            <c:when test="${job.visible}">Có</c:when>
                            <c:otherwise>Không</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${job.employer_ID}</td>
                    <td>${job.category}</td>
                    <td class="action-buttons">
                        <a href="editJob?id=${job.jobPost_ID}" class="edit-btn">
                            <i class="fas fa-edit"></i> Sửa
                        </a>
                        <a href="deleteJob?id=${job.jobPost_ID}" class="delete-btn" onclick="return confirm('Bạn có chắc muốn xoá job này?');">
                            <i class="fas fa-trash-alt"></i> Xoá
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr><td colspan="13">Không có dữ liệu.</td></tr>
        </c:otherwise>
    </c:choose>
    </tbody>
</table>

<div class="pagination">
    <c:if test="${currentPage > 1}">
        <a href="?page=${currentPage - 1}">&laquo; Trang trước</a>
    </c:if>

    <c:forEach begin="1" end="${totalPages}" var="i">
        <a href="?page=${i}" class="<c:if test='${i == currentPage}'>current</c:if>">${i}</a>
    </c:forEach>

    <c:if test="${currentPage < totalPages}">
        <a href="?page=${currentPage + 1}">Trang sau &raquo;</a>
    </c:if>
</div>
</body>
</html>
