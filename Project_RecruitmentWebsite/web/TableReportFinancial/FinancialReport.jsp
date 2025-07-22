<%-- 
    Document   : FinancialReport
    Created on : Jul 19, 2025, 4:57:35 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Bảng kê DS Khách Hàng</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Google Fonts for clean look -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <!-- Remix Icon CDN -->
        <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
        <jsp:include page="/navbar.jsp" />
        <style>
            body {
                font-family: 'Inter', Arial, sans-serif;
                background: linear-gradient(135deg, #d4ffe1 0%, #8ccf92 100%);
                min-height: 100vh;
                color: #222;
                padding: 0 !important;
            }
            .header-bar {
                background: linear-gradient(90deg, #249a5d 0%, #43b86a 100%);
                border-radius: 0 0 28px 28px;
                padding: 1.1rem 0 0.3rem 0 !important;
                box-shadow: 0 6px 32px rgba(67,233,123,0.16);
                margin-bottom: 2.5rem;
            }
            .header-bar h3 {
                color: #fff;
                font-weight: 700;
                letter-spacing: 1px;
                text-shadow: 0 2px 8px rgba(36,154,93,0.13);
                margin-bottom: .2rem !important;
                font-size: 2rem !important;
            }
            .header-bar .subtitle {
                color: #eafff5;
                font-size: 1rem !important;
                font-weight: 500;
            }
            .filter-panel {
                background: #fff;
                border-radius: 22px;
                box-shadow: 0 6px 32px rgba(36,154,93,0.10), 0 1.5px 8px rgba(67,233,123,0.04);
                padding: 2rem 2.5rem 1.5rem 2.5rem;
                margin-bottom: 2.5rem;
                border: 1px solid #b8eabba;
                position: relative;
                z-index: 2;
            }
            .filter-row {
                display: flex;
                align-items: flex-end;
                gap: 32px;
                flex-wrap: wrap;
                justify-content: flex-start;
            }
            .filter-row .form-group {
                min-width: 220px;
                flex: 1;
            }
            .form-label {
                font-weight: 600;
                color: #249a5d;
                margin-bottom: 0.5rem;
                font-size: 1.04rem;
            }
            .form-control {
                border-radius: 12px;
                font-size: 1.05rem;
                border: 1px solid #b8eabba;
                box-shadow: none;
                transition: border .2s;
                background: #f7fcf7;
            }
            .form-control:focus {
                border-color: #249a5d;
                box-shadow: 0 0 0 2px rgba(36,154,93,0.10);
            }
            .filter-actions {
                display: flex;
                align-items: flex-end;
                gap: 16px;
            }
            .btn-search-custom {
                min-width: 170px;
                height: 46px;
                font-size: 1.1rem;
                font-weight: 700;
                background: linear-gradient(90deg,#249a5d 0%,#43b86a 100%);
                color: #fff;
                border: none;
                border-radius: 14px;
                margin-top: 30px;
                display: inline-flex;
                align-items: center;
                gap: 7px;
                box-shadow: 0 3px 20px rgba(36,154,93,0.13);
                position: relative;
                overflow: hidden;
                transition: background 0.2s, box-shadow 0.2s;
            }
            .btn-search-custom:hover, .btn-search-custom:focus {
                background: linear-gradient(90deg,#43b86a 0%,#249a5d 100%);
                color: #fff;
                box-shadow: 0 8px 24px rgba(36,154,93,0.19);
            }
            .btn-search-custom:active:after {
                opacity: 1;
            }
            .export-btn {
                padding: .7rem 1.6rem;
                font-size: 1.07rem;
                font-weight: 700;
                background: linear-gradient(90deg,#249a5d 0%,#43b86a 100%);
                border-radius: 14px;
                border: none;
                color: #fff;
                box-shadow: 0 3px 16px rgba(36,154,93,0.14);
                transition: background .2s, box-shadow .2s;
                display: inline-flex;
                align-items: center;
                gap: 7px;
                margin-top: 30px;
            }
            .export-btn:hover, .export-btn:focus {
                background: linear-gradient(90deg,#43b86a 0%,#249a5d 100%);
                color: #fff;
                box-shadow: 0 8px 24px rgba(36,154,93,0.19);
            }
            .table-responsive {
                background: #fff;
                border-radius: 22px;
                box-shadow: 0 6px 32px rgba(36,154,93,0.10), 0 2px 8px rgba(36,154,93,0.03);
                padding: 2rem 1.3rem;
                margin-bottom: 2rem;
                border: 1px solid #b8eabba;
                position: relative;
                z-index: 1;
            }
            .table {
                border-radius: 22px !important;
                overflow: hidden;
                box-shadow: 0 1px 6px rgba(36,154,93,0.05);
            }
            .table thead th {
                background: linear-gradient(90deg,#249a5d 0%,#43b86a 100%);
                color: #fff;
                font-weight: 700;
                font-size: 1.09rem;
                border-bottom: none;
                letter-spacing: 0.3px;
                text-align: center;
                border-top: none;
            }
            .table tbody td {
                vertical-align: middle;
                font-size: 1.04rem;
                color: #333;
                border-top: 1px solid #b8eabba;
                text-align: center;
                background: #f7fcf7;
            }
            .table tfoot th {
                background: #eafff5;
                color: #249a5d;
                font-size: 1.09rem;
                font-weight: 700;
                border-top: 2px solid #b8eabba;
                text-align: right;
            }
            .action-btns {
                display: flex;
                gap: 0.6rem;
                justify-content: center;
            }
            .btn-outline-success {
                border: 1.5px solid #249a5d;
                color: #249a5d;
                background: #ebfff3;
                border-radius: 10px;
                font-weight: 600;
                font-size: .99rem;
                display: flex;
                align-items: center;
                gap: 6px;
                transition: background .18s, color .18s, border .18s;
            }
            .btn-outline-success i {
                font-size: 1.1em;
            }
            .btn-outline-success:hover, .btn-outline-success:focus {
                background: #249a5d;
                color: #fff;
                border-color: #43b86a;
            }
            /* Modern scrollbar */
            ::-webkit-scrollbar {
                width: 8px;
                background: #eafff5;
                border-radius: 8px;
            }
            ::-webkit-scrollbar-thumb {
                background: #b8eabba;
                border-radius: 8px;
            }
            /* Toast notification styles */
            .export-toast {
                position: fixed;
                top: 32px;
                right: 32px;
                z-index: 9999;
                min-width: 280px;
                max-width: 420px;
                background: linear-gradient(90deg,#ffffcc 0%,#ffffcc 100%);
                color: #00ff00;
                font-weight: 600;
                padding: 1rem 1.5rem;
                border-radius: 1.1rem;
                box-shadow: 0 4px 32px rgba(36,154,93,0.18);
                font-size: 1.15rem;
                display: flex;
                align-items: center;
                gap: 0.7rem;
                opacity: 0;
                pointer-events: none;
                transform: translateY(-15px);
                transition: opacity 0.24s, transform 0.24s;
            }
            .export-toast.show {
                opacity: 1;
                pointer-events: auto;
                transform: translateY(0);
            }
            .export-toast.error {
                background: linear-gradient(90deg,#e74c3c 0%,#d35400 100%);
                box-shadow: 0 4px 32px rgba(231,76,60,0.13);
            }
            .export-toast .ri-checkbox-circle-line {
                font-size: 1.25em;
                color: #eafff5;
            }
            .export-toast .ri-close-circle-line {
                font-size: 1.25em;
                color: #fff7e6;
            }
            @media (max-width:991px) {
                .header-bar {
                    padding: .7rem 0 .2rem 0 !important;
                }
                .header-bar h3 {
                    font-size: 1.3rem !important;
                }
                .header-bar .subtitle {
                    font-size: .97rem !important;
                }
                .filter-row,
                .filter-actions {
                    flex-direction: column !important;
                    gap: 18px;
                }
                .btn-search-custom, .export-btn {
                    margin: 16px 0 0 0;
                    width: 100%;
                }
                .filter-panel, .table-responsive {
                    padding: 1.25rem .75rem;
                }
            }
            @media (max-width:600px){
                .export-toast {
                    right: 12px;
                    left: 12px;
                    min-width: unset;
                    max-width: unset;
                    font-size: 1rem;
                    padding: .8rem 1rem;
                }
            }
        </style>
    </head>

    <body>

        <div class="header-bar text-center">
            <h3><i class="ri-shopping-bag-3-line me-2"></i>Bảng kê danh sách khách hàng GenZTimViec.vn</h3>
        </div>

        <div class="container mb-4">
            <!-- Filter & Info -->
            <div class="filter-panel shadow-sm">
                <form action="TableFinancial" method="get" class="filter-row" style="width:100%;">
                    <div class="form-group">
                        <label for="fromDate" class="form-label">Từ ngày</label>
                        <input type="date"  id="fromDate" name="dateStart" class="form-control" value="${dateStart}">
                    </div>
                    <div class="form-group">
                        <label for="toDate" class="form-label">Đến ngày</label>
                        <input type="date" id="toDate" name="dateEnd" class="form-control" value="${dateEnd}">
                    </div>
                    <div class="form-group">
                        <label for="salesType" class="form-label">Mã Số Thuế</label>
                        <input type="text" id="salesType" name="codeTax" class="form-control" value="${codeTax}" placeholder="Nhập mã số thuế">
                    </div>
                    <div class="filter-actions">
                        <input type="submit" class="btn-search-custom" value="Tìm Kiếm">
                        <button id="exportfile" type="button" class="btn export-btn"><i class="ri-file-excel-2-line"></i> Export Excel</button>
                    </div>
                </form>
            </div>

            <!-- Tổng cộng nằm trên bảng -->
            <div class="d-flex justify-content-end mb-2">
                <div class="px-4 py-2 rounded bg-white border" style="font-weight:700; color:#249a5d; font-size:1.12rem;">
                    Tổng cộng: 
                    <fmt:formatNumber value="${TotalTable}" type="currency" currencySymbol="₫" groupingUsed="true" />
                </div>
            </div>

            <!-- Sales Table -->
            <div class="table-responsive">
                <table class="table table-bordered align-middle">
                    <thead>
                        <tr>
                            <th style="width:40px;">STT</th>
                            <th>Tên Công Ty</th>                      
                            <th style="width:200px;">Tổng Số Tiền</th>
                            <th style="width:200px;">Số lượng dịch vụ</th>
                            <th style="width:170px;">Chi Tiết</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${ListFinancial}">
                            <tr>
                                <td>${s.no}</td>
                                <td>${s.name}</td>
                                <td><fmt:formatNumber value="${s.total}" type="currency" currencySymbol="₫" groupingUsed="true" /></td>
                                <td>${s.numberService}</td>
                                <td>
                                    <div class="action-btns">
                                        <button class="btn btn-outline-success btn-sm">
                                            <a target="_blank" href="HistoryFinancial?dateStart=${dateStart}&dateEnd=${dateEnd}&idemployer=${s.employerId}" class="ri-eye-line">Lịch sử</a>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- Toast notification -->
        <div id="exportToast" class="export-toast" style="display:none;">
            <i class="ri-checkbox-circle-line"></i>
            <span id="exportToastMsg">Xuất Excel thành công</span>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Hàm hiển thị thông báo xuất file thành công/thất bại
            function showExportToast(success = true, msg = "") {
                var toast = document.getElementById('exportToast');
                var msgSpan = document.getElementById('exportToastMsg');
                var icon = toast.querySelector('i');
                if (success) {
                    toast.classList.remove('error');
                    icon.className = "ri-checkbox-circle-line";
                    msgSpan.textContent = msg || "Xuất Excel thành công";
                } else {
                    toast.classList.add('error');
                    icon.className = "ri-close-circle-line";
                    msgSpan.textContent = msg || "Xuất Excel thất bại, vui lòng thử lại sau";
                }
                toast.style.display = "flex";
                setTimeout(function () {
                    toast.classList.add('show');
                }, 30);
                setTimeout(function () {
                    toast.classList.remove('show', 'error');
                    toast.style.display = "none";
                }, 2200);
            }

            var exprot = document.getElementById('exportfile');
            exprot.addEventListener('click', function () {
                fetch("/Project_RecruitmentWebsite/ExportExcelFinancial")
                        .then(response => {
                            if (response.status === 200) {
                                window.location.href = "/Project_RecruitmentWebsite/ExportExcelFinancial";
                                showExportToast(true, "Xuất Excel thành công");
                            } else {
                                showExportToast(false, "Xuất Excel thất bại, vui lòng thử lại sau");
                            }
                        });
            });
        </script>
    </body>
</html>