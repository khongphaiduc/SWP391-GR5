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
            .order-list {
                max-width: 1000px;
                margin: 30px auto;
                padding: 0 20px;
            }
            .order-card {
                background-color: white;
                border-radius: 12px;
                padding: 25px;
                margin-bottom: 25px;
                box-shadow: 0 2px 12px rgba(0,0,0,0.06);
                display: flex;
                align-items: center;
                justify-content: space-between;
                flex-wrap: wrap;
            }
            .order-info {
                flex: 1 1 70%;
            }
            .order-info h3 {
                margin: 0 0 10px 0;
                color: #1c9c60;
                font-size: 24px;
            }
            .order-info p {
                margin: 6px 0;
                color: #333;
                font-size: 16px;
                line-height: 1.6;
            }
            .order-status {
                flex: 1 1 25%;
                text-align: right;
            }
            .status {
                display: inline-block;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 15px;
                font-weight: bold;
                text-transform: capitalize;
            }
            .status-success {
                background-color: #d4edda;
                color: #28a745;
            }
            .status-pending {
                background-color: #fff3cd;
                color: #ffc107;
            }
            .status-expired {
                background-color: #f8d7da;
                color: #dc3545;
            }
            .label-icon {
                margin-right: 10px;
                color: #1c9c60;
                font-size: 17px;
            }

            .job-pagination-wrapper {
                background: white;
                padding: 20px;
                border-radius: 8px;
                border: 1px solid #e0e0e0;
                margin-top: 20px;
            }

            .job-pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                flex-wrap: wrap;
            }

            .job-pagination a, .job-pagination span {
                padding: 8px 12px;
                border-radius: 4px;
                text-decoration: none;
                font-weight: 500;
                min-width: 40px;
                text-align: center;
                transition: all 0.3s ease;
            }

            .job-pagination a {
                background: #f8f9fa;
                color: #2c3e50;
                border: 1px solid #e0e0e0;
            }

            .job-pagination a:hover {
                background: #00c853;
                color: white;
            }

            .job-current-page {
                background: #00c853;
                color: white;
            }

            .job-page-size-control {
                display: flex;
                align-items: center;
                gap: 8px;
                margin-left: 20px;
                padding-left: 20px;
                border-left: 1px solid #e0e0e0;
            }

            .job-page-size-control input {
                width: 60px;
                padding: 6px 8px;
                border: 1px solid #e0e0e0;
                border-radius: 4px;
                text-align: center;
            }

            .job-page-size-control button {
                padding: 6px 12px;
                background: #00c853;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
            }

            .job-page-size-control button:hover {
                background: #00a63f;
            }

        </style>
    </head>
    <body>
        <jsp:include page="/navbar.jsp" />
        <br/>
        <h2>Lịch sử đơn hàng</h2>

        <div class="order-list">
            <c:choose>
                <c:when test="${not empty orders}">
                    <c:forEach var="order" items="${orders}">
                        <div class="order-card">
                            <div class="order-info">
                                <h3>${order.serviceName}</h3>
                                <p><i class="fas fa-calendar label-icon"></i><strong>Ngày tạo đơn:</strong> <fmt:formatDate value="${order.date}" pattern="dd-MM-yyyy HH:mm" /></p>
                                <p><i class="fas fa-clock label-icon"></i><strong>Thời hạn dịch vụ:</strong> ${order.duration} ngày</p>
                                <p><i class="fas fa-hourglass-end label-icon"></i><strong>Ngày hết hạn:</strong> <fmt:formatDate value="${order.expiredDate}" pattern="dd-MM-yyyy" /></p>
                                <p><i class="fas fa-money-bill-wave label-icon"></i><strong>Số tiền:</strong> <fmt:formatNumber value="${order.amount}" type="number" /></p>
                                <p><i class="fas fa-credit-card label-icon"></i><strong>Thanh toán:</strong> ${order.payMethod}</p>
                            </div>
                            <div class="order-status">
                                <span class="status status-${order.status}">${order.status}</span>
                                <form action="OrderHistory" method="post" style="margin-top: 10px;">
                                    <input type="hidden" name="orderId" value="${order.orderId}" />
                                    <button type="submit" onclick="return confirm('Bạn có chắc muốn xoá đơn hàng này?')" 
                                            style="background-color: #e53935; border: none; color: white; padding: 6px 12px;
                                            border-radius: 6px; cursor: pointer; font-weight: bold; margin-top: 8px;">
                                        Xoá
                                    </button>
                                </form>
                            </div>

                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="text-align: center; font-size: 20px; color: gray;">Bạn chưa có đơn hàng nào.</p>
                </c:otherwise>
            </c:choose>
        </div>
        <% 
            Integer currentPage = (Integer) request.getAttribute("currentPage");
            Integer totalPages = (Integer) request.getAttribute("totalPages");
            Integer pageSize = (Integer) session.getAttribute("pageSize");
            if (totalPages != null && totalPages > 1) {
        %>
        <div class="job-pagination-wrapper">
            <div class="job-pagination">
                <% for (int i = 1; i <= totalPages; i++) { %>
                <% if (i == currentPage) { %>
                <span class="job-current-page"><%= i %></span>
                <% } else { %>
                <a href="OrderHistory?page=<%= i %>"><%= i %></a>
                <% } %>
                <% } %>

                <div class="job-page-size-control">
                    <span>Hiển thị:</span>
                    <form action="OrderHistory" style="display: flex; align-items: center; gap: 8px;">
                        <input type="number" name="pageSize" value="<%=pageSize%>" min="1" max="20">
                        <button type="submit">OK</button>
                    </form>
                </div>
            </div>
        </div>
        <% } %>
    </body>
</html>
