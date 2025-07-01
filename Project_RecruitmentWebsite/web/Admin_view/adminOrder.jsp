<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Order List</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: white;
            min-height: 100vh;
            padding: 20px;
            color: #2e7d32;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(46, 125, 50, 0.2);
            padding: 30px;
            backdrop-filter: blur(10px);
        }

        h2 {
            text-align: center;
            color: #1b5e20;
            font-size: 2.5em;
            margin-bottom: 30px;
            text-shadow: 2px 2px 4px rgba(46, 125, 50, 0.1);
            position: relative;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, #4caf50, #81c784);
            border-radius: 2px;
        }

        .table-wrapper {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(46, 125, 50, 0.15);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            font-size: 14px;
        }

        th {
            background: linear-gradient(135deg, #4caf50 0%, #66bb6a 100%);
            color: white;
            padding: 18px 12px;
            text-align: center;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border: none;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        th:first-child {
            border-top-left-radius: 12px;
        }

        th:last-child {
            border-top-right-radius: 12px;
        }

        td {
            padding: 15px 12px;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
            transition: all 0.3s ease;
            color: #2e7d32;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:nth-child(even) {
            background-color: #f1f8e9;
        }

        tbody tr:hover {
            background: linear-gradient(90deg, #e8f5e8, #c8e6c9);
            transform: scale(1.01);
            box-shadow: 0 3px 10px rgba(46, 125, 50, 0.1);
        }

        /* Status styling */
        td:nth-child(11) {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.5px;
        }

        /* Price and Amount styling */
        td:nth-child(7), td:nth-child(9) {
            font-weight: 600;
            color: #2e7d32;
        }

        /* Email styling */
        td:nth-child(4) {
            color: #388e3c;
            font-style: italic;
        }

        /* Company name styling */
        td:nth-child(3) {
            font-weight: 600;
            color: #1b5e20;
        }

        /* Service name styling */
        td:nth-child(6) {
            background: linear-gradient(90deg, #a5d6a7, #81c784);
            color: #1b5e20;
            font-weight: 500;
            border-radius: 6px;
        }

        /* Date styling */
        td:last-child {
            font-family: monospace;
            font-size: 12px;
            color: #558b2f;
        }

        /* Responsive design */
        @media (max-width: 1200px) {
            .container {
                padding: 20px;
            }
            
            table {
                font-size: 12px;
            }
            
            th, td {
                padding: 10px 8px;
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 10px;
            }
            
            .container {
                padding: 15px;
            }
            
            h2 {
                font-size: 2em;
                margin-bottom: 20px;
            }
            
            table {
                font-size: 11px;
            }
            
            th, td {
                padding: 8px 6px;
            }
        }

        /* Animation for table loading */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .table-wrapper {
            animation: fadeInUp 0.8s ease-out;
        }

        /* Scrollbar styling */
        .table-wrapper::-webkit-scrollbar {
            height: 8px;
        }

        .table-wrapper::-webkit-scrollbar-track {
            background: #f1f8e9;
            border-radius: 4px;
        }

        .table-wrapper::-webkit-scrollbar-thumb {
            background: linear-gradient(90deg, #4caf50, #66bb6a);
            border-radius: 4px;
        }

        .table-wrapper::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(90deg, #388e3c, #4caf50);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>📋 Order Management List</h2>
        <div class="table-wrapper">
            <table>
                <thead>
                <tr>
                    <th>🆔 Order ID</th>
                    <th>👤 Employer</th>
                    <th>🏢 Company</th>
                    <th>📧 Email</th>
                    <th>📞 Phone</th>
                    <th>🛠️ Service</th>
                    <th>💰 Price</th>
                    <th>⏱️ Duration</th>
                    <th>💵 Amount</th>
                    <th>💳 Pay Method</th>
                    <th>📊 Status</th>
                    <th>📅 Date</th>
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
                        <td>$${o.service.price}</td>
                        <td>${o.service.duration} days</td>
                        <td>${o.amount}</td>
                        <td>${o.payMethod}</td>
                        <td>${o.status}</td>
                        <td><fmt:formatDate value="${o.date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>