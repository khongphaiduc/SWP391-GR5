<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Lịch sử đơn hàng</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f9f9f9;
            color: #2e7d32;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: auto;
        }

        h2 {
            text-align: center;
            color: #1b5e20;
            font-size: 2.5em;
            margin-bottom: 30px;
        }

        .card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 128, 0, 0.1);
            margin-bottom: 20px;
            padding: 20px 25px;
            transition: all 0.3s ease;
            position: relative;
        }

        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 128, 0, 0.15);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-weight: bold;
            font-size: 1.1em;
            color: #388e3c;
        }

        .card-body {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 10px;
            font-size: 0.95em;
            color: #2e7d32;
        }

        .card-body div {
            margin: 4px 0;
        }

        .card-status {
            position: absolute;
            top: 20px;
            right: 25px;
            font-weight: bold;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            text-transform: uppercase;
        }

        .status-success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #66bb6a;
        }

        .status-pending {
            background-color: #fff8e1;
            color: #f9a825;
            border: 1px solid #ffeb3b;
        }

        .status-expired {
            background-color: #ffebee;
            color: #c62828;
            border: 1px solid #ef5350;
        }
    </style>
</head>
<body>
    <jsp:include page="/navbar.jsp" />
    <br/>
<div class="container">
    <h2>🧾 Lịch sử đơn hàng</h2>

    <c:choose>
        <c:when test="${not empty orders}">
            <c:forEach var="o" items="${orders}">
                <div class="card">
                    <div class="card-header">
                        Mã đơn: #${o.orderId}
                        <div class="card-status status-${o.status}">
                            <c:choose>
                                <c:when test="${o.status eq 'success'}">✔ Hoàn tất</c:when>
                                <c:when test="${o.status eq 'pending'}">⏳ Chờ xử lý</c:when>
                                <c:when test="${o.status eq 'expired'}">❌ Hết hạn</c:when>
                                <c:otherwise>${o.status}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="card-body">
                        <div><strong>👤 Nhà tuyển dụng:</strong> ${o.employer.nameEmployer}</div>
                        <div><strong>🏢 Công ty:</strong> ${o.employer.companyName}</div>
                        <div><strong>📧 Email:</strong> <a href="mailto:${o.employer.email}">${o.employer.email}</a></div>
                        <div><strong>📞 Số điện thoại:</strong> ${o.employer.phoneNumber}</div>
                        <div><strong>🛠️ Dịch vụ:</strong> ${o.service.serviceName}</div>
                        <div><strong>💰 Giá:</strong> ${o.service.price}</div>
                        <div><strong>⏱️ Thời hạn:</strong> ${o.service.duration} ngày</div>
                        <div><strong>💵 Tổng tiền:</strong> $${o.amount}</div>
                        <div><strong>💳 Phương thức:</strong> ${o.payMethod}</div>
                        <div><strong>📅 Ngày đặt:</strong> <fmt:formatDate value="${o.date}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p style="text-align: center; font-size: 1.2em; color: gray;">Bạn chưa có đơn hàng nào.</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
