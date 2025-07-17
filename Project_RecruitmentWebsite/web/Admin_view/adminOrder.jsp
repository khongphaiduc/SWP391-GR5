<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
    <head>
        <title>Lịch sử đơn hàng</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f5f5;
                color: #2e7d32;
                padding: 30px;
            }

            .container {
                max-width: 1200px;
                margin: auto;
                background: #ffffff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 128, 0, 0.1);
            }

            h2 {
                text-align: center;
                color: #1b5e20;
                margin-bottom: 30px;
                font-size: 2em;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 15px;
            }

            th, td {
                border: 1px solid #e0e0e0;
                padding: 12px;
                text-align: center;
            }

            th {
                background-color: #66bb6a;
                color: white;
                text-transform: uppercase;
                font-weight: bold;
            }



            /*        .status-success {
                        color: green;
                        font-weight: bold;
                    }
            
                    .status-pending {
                        color: orange;
                        font-weight: bold;
                    }
            
                    .status-expired {
                        color: red;
                        font-weight: bold;
                    }
            
                    .actions a {
                        margin: 0 5px;
                        padding: 6px 12px;
                        border-radius: 5px;
                        text-decoration: none;
                        font-weight: bold;
                        font-size: 0.9em;
                    }
            
                    .view-btn {
                        background-color: #42a5f5;
                        color: white;
                    }
            
                    .delete-btn {
                        background-color: #e53935;
                        color: white;
                    }
            
                    .total-row {
                        font-weight: bold;
                        background-color: #e8f5e9;
                    }*/
        </style>
    </head>
    <body>
        <jsp:include page="/navbar.jsp" />
        <br/>


        <form method="get" action="adminOrder" style="margin-bottom: 20px; text-align: right;">
            <label for="serviceId">Dịch vụ:</label>
            <select name="serviceId" id="serviceId" onchange="this.form.submit()">
                <option value="">--</option>
                <c:forEach var="s" items="${services}">
                    <option value="${s.serviceId}" ${param.serviceId == s.serviceId ? 'selected' : ''}>
                        ${s.serviceName}
                    </option>
                </c:forEach>
            </select>
            <label for="year">Năm:</label>
            <select name="year" id="year" onchange="this.form.submit()">
                <option value="">--</option>
                <c:forEach var="y" begin="2022" end="2025">
                    <option value="${y}" ${param.year == y ? 'selected' : ''}>${y}</option>
                </c:forEach>
            </select>
            <label for="month">Tháng:</label>
            <select name="month" id="month" onchange="this.form.submit()">
                <option value="">--</option>
                <c:forEach var="i" begin="1" end="12">
                    <option value="${i}" ${param.month == i ? 'selected' : ''}>${i}</option>
                </c:forEach>
            </select>

            
        </form>

        <div class="container">
            <h2>Lịch sử đơn hàng</h2>

            <c:choose>
                <c:when test="${not empty orders}">
                    <table>
                        <c:set var="total" value="0" />
                           <c:forEach var="o" items="${orders}">
                                <c:set var="total" value="${total + o.amount}" />
                            </c:forEach>
                           <tr class="total-row">
                                <td colspan="8" style="text-align: right;">Tổng cộng:</td>
                                <td colspan="5" style="text-align: left;">
                                    <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/> VNĐ
                                </td>
                            </tr>
                        <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Nhà tuyển dụng</th>
                                <th>Công ty</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Dịch vụ</th>
                                <th>Thời hạn</th>
                                <th>Thanh toán</th>
                                <th>Phương thức</th>
                                <th>Trạng thái</th>
                                <th>Ngày đặt</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                            <c:forEach var="o" items="${orders}">
                                <tr>
                                    <td>${o.orderId}</td>
                                    <td>${o.employer.nameEmployer}</td>
                                    <td>${o.employer.companyName}</td>
                                    <td>${o.employer.email}</td>
                                    <td>${o.employer.phoneNumber}</td>
                                    <td>${o.service.serviceName}</td>
                                    <td>${o.service.duration} ngày</td>
                                    <td><fmt:formatNumber value="${o.amount}" type="number" groupingUsed="true"/> VNĐ</td>
                                    <td>${o.payMethod}</td>
                                    <td class="status-${o.status}">${o.status}</td>
                                    <td><fmt:formatDate value="${o.date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td class="actions">
                                        <a style="color:red" href="deleteOrder?orderId=${o.orderId}" class="delete-btn" onclick="return confirm('Bạn có chắc muốn xóa đơn này?')">Xóa</a>
                                        <a href="downloadOrder?orderId=${o.orderId}" class="delete-btn" target="_blank" >Xem</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr class="total-row">
                                <td colspan="8" style="text-align: right;">Tổng cộng:</td>
                                <td colspan="5" style="text-align: left;">
                                    <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/> VNĐ
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p style="text-align: center; font-size: 1.2em; color: gray;">Bạn chưa có đơn hàng nào.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
