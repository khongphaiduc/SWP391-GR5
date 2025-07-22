<%-- 
    Document   : DetailFinancial
    Created on : Jul 20, 2025, 1:58:18 AM
    Author     : Admin
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lịch Sử Mua Hàng</title>
        <!-- Bootstrap CSS CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #e8f8ee;
            }
            .table-history {
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,128,0,0.07);
                overflow: hidden;
                border: 2px solid #43a047;
            }
            .table th {
                background-color: #43a047;
                color: #fff;
                font-weight: 500;
                border-bottom: 2px solid #388e3c;
            }
            .table td {
                border-top: 1px solid #b9f6ca;
            }
            h2 {
                color: #388e3c;
                font-weight: bold;
                text-shadow: 0 1px 8px #c8e6c9;
            }
            .company-name {
                font-size: 1.25rem;
                color: #43a047;
                font-weight: 500;
                margin-bottom: 1rem;
                text-align: center;
            }
            .table-striped>tbody>tr:nth-of-type(odd)>* {
                background-color: #e8f5e9 !important;
            }
            .table-hover>tbody>tr:hover>td {
                background: #c8e6c9;
                transition: background 0.2s;
            }
            .btn-green {
                background: #43a047;
                color: #fff;
                border: none;
                border-radius: 20px;
                padding: 6px 18px;
                font-weight: 500;
            }
            .btn-green:hover {
                background: #388e3c;
                color: #fff;
            }
        </style>
    </head>
    <body>
        <div class="container py-5">
            <h2 class="mb-4 text-center">Lịch sử giao dịch của công ty  ${CompanyName}</h2>

            <div class="table-responsive table-history">
                <table class="table table-bordered table-striped table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Dịch Vụ</th>
                            <th>Giá Tiền</th>
                            <th>Phương Thức Thanh Toán</th>
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${ListHistory}">
                            <tr>                
                                <td>${loop.index + 1}</td> 
                                <td>${s.nameService}</td>
                                <td><fmt:formatNumber value="${s.amount}" type="currency" currencySymbol="₫" groupingUsed="true" /></td>
                                <td>${s.payMethod}</td>
                                <td>${s.date}</td>
                                <td>${s.during}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="mt-4 text-center">
                <button id="exportfile" class="btn btn-green">Export Excel</button>
            </div>
        </div>
        <!-- Bootstrap JS CDN (optional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


        <script>

            var exprot = document.getElementById('exportfile');
            exprot.addEventListener('click', function () {
                fetch("/Project_RecruitmentWebsite/ExportExcelHistory")
                        .then(response => {
                            if (response.status === 200) {
                                window.location.href = "/Project_RecruitmentWebsite/ExportExcelHistory";
                                showExportToast(true, "Xuất Excel thành công");
                            } else {
                                showExportToast(false, "Xuất Excel thất bại, vui lòng thử lại sau");
                            }
                        });
            });

        </script>


    </body>
</html>