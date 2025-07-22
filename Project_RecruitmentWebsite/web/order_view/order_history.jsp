<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
    <head>
        <title>Lịch sử đơn hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f8;
                margin: 0;
                padding: 0;
            }
            h2 {
                text-align: center;
                color: #1c9c60;
                margin-top: 40px;
                font-size: 32px;
            }
            .container {
                max-width: 1200px;
                margin: 30px auto;
                padding: 0 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 2px 12px rgba(0,0,0,0.06);
                overflow: hidden;
            }
            th, td {
                padding: 14px;
                text-align: center;
                border-bottom: 1px solid #eee;
                font-size: 15px;
            }
            th {
                background-color: #1c9c60;
                color: white;
            }
            tr:hover {
                background-color: #f2f2f2;
            }
            .status {
                padding: 6px 14px;
                border-radius: 16px;
                font-weight: bold;
                text-transform: capitalize;
                display: inline-block;
            }
            .status-pending {
                background-color: #fff3cd;
                color: #ffc107;
            }
            .status-success {
                background-color: #d4edda;
                color: #28a745;
            }
            .status-expired {
                background-color: #f8d7da;
                color: #dc3545;
            }
            .delete-button {
                background-color: #e53935;
                color: white;
                padding: 6px 12px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: bold;
            }
            .delete-button:hover {
                background-color: #c62828;
            }

            .pagination {
                margin-top: 20px;
                text-align: center;
            }
            .pagination a, .pagination span {
                display: inline-block;
                padding: 8px 12px;
                margin: 0 4px;
                border-radius: 4px;
                text-decoration: none;
                font-weight: bold;
                border: 1px solid #ccc;
            }
            .pagination a:hover {
                background-color: #00c853;
                color: white;
            }
            .job-current-page {
                background-color: #00c853;
                color: white;
                border-color: #00c853;
            }
            .page-size-control {
                margin-top: 10px;
                text-align: center;
            }
            .page-size-control input {
                width: 60px;
                padding: 6px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .page-size-control button {
                padding: 6px 12px;
                margin-left: 8px;
                background: #00c853;
                border: none;
                color: white;
                border-radius: 4px;
                cursor: pointer;
            }
            .page-size-control button:hover {
                background: #00a63f;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/navbar.jsp" />
        <br>

        <h2>Lịch sử đơn hàng</h2>
        <div class="container">

            <form method="get" action="OrderHistory" style="margin-bottom: 20px; text-align: right;">
               
                <label for="fromDate">Từ ngày:</label>
                <input type="date" name="fromDate" id="fromDate" value="${param.fromDate}" onchange="this.form.submit()" />

                <label for="toDate">Đến ngày:</label>
                <input type="date" name="toDate" id="toDate" value="${param.toDate}" onchange="this.form.submit()" />
            </form>
            <c:choose>
                <c:when test="${not empty orders}">
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Dịch vụ</th>
                                <th>Ngày tạo</th>
                                <th>Thời hạn</th>
                                <th>Ngày hết hạn</th>
                                <th>Số tiền</th>
                                <th>Phương thức</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${order.serviceName}</td>
                                    <td><fmt:formatDate value="${order.date}" pattern="dd-MM-yyyy HH:mm" /></td>
                                    <td>${order.duration} ngày</td>
                                    <td><fmt:formatDate value="${order.expiredDate}" pattern="dd-MM-yyyy" /></td>
                                    <td><fmt:formatNumber value="${order.amount}" type="number" /> VND</td>
                                    <td>${order.payMethod}</td>
                                    <td><span class="status status-${order.status}">${order.status}</span></td>
                                    <td>
                                        <form action="OrderHistory" method="post" onsubmit="return confirm('Bạn có chắc muốn xoá đơn hàng này?')">
                                            <input type="hidden" name="orderId" value="${order.orderId}" />
                                            <button type="submit" class="delete-button">Xoá</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p style="text-align: center; font-size: 20px; color: gray;">Bạn chưa có đơn hàng nào.</p>
                </c:otherwise>
            </c:choose>

            <% 
                Integer currentPage = (Integer) request.getAttribute("currentPage");
                Integer totalPages = (Integer) request.getAttribute("totalPages");
                Integer pageSize = (Integer) session.getAttribute("pageSize");
                if (totalPages != null && totalPages > 1) {
            %>
            <div class="pagination">
                <% for (int i = 1; i <= totalPages; i++) { %>
                <% if (i == currentPage) { %>
                <span class="job-current-page"><%= i %></span>
                <% } else { %>
                <a href="OrderHistory?page=<%= i %>"><%= i %></a>
                <% } %>
                <% } %>
            </div>
            <div class="page-size-control">
                <form action="OrderHistory">
                    Hiển thị:
                    <input type="number" name="pageSize" value="<%=pageSize%>" min="1" max="20">
                    <button type="submit">OK</button>
                </form>
            </div>
            <% } %>
        </div>
    </body>
</html>
