<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách Report - Giao diện Gọn Gàng & Căn Giữa</title>
        <link href="https://fonts.googleapis.com/css?family=Quicksand:400,600&display=swap" rel="stylesheet">
         <jsp:include page="/navbar.jsp" />
        <style>
            :root {
                --primary: #43a047;
                --primary-dark: #388e3c;
                --primary-light: #e8f5e9;
                --text-title: #2e7d32;
                --table-head-bg: #e8f5e9;
                --table-border: #c8e6c9;
                --table-row-hover: #f1f8e9;
                --pending-bg: #fffde7;
                --pending-text: #fbc02d;
                --reviewed-bg: #fffde7;
                --reviewed-text: #fbc02d;
                --resolved-bg: #e8f5e9;
                --resolved-text: #388e3c;
            }
            body {
                font-family: 'Quicksand', Arial, sans-serif;
                background: var(--primary-light);
                margin: 0;
                padding: 32px 0;
            }
            h1 {
                text-align: center;
                color: var(--primary);
                margin-bottom: 18px;
                font-weight: 600;
                letter-spacing: 1px;
                font-size: 1.7rem;
                margin-top: 24px;
            }
            .filter-bar {
                max-width: 1500px;
                margin: 0 auto 18px auto;
                display: flex;
                gap: 18px;
                justify-content: flex-end;
                align-items: center;
                padding: 0 12px;
                flex-wrap: wrap;
            }
            .filter-bar label {
                font-weight: 500;
                color: var(--text-title);
                margin-right: 5px;
            }
            .filter-bar input, .filter-bar select {
                font-family: 'Quicksand', Arial, sans-serif;
                padding: 8px 12px;
                border: 1px solid var(--table-border);
                border-radius: 6px;
                font-size: 1.08em;
                background: #fafdff;
                outline: none;
                min-width: 130px;
            }
            .filter-bar select {
                min-width: 130px;
            }
            .table-container {
                max-width: 1500px;
                margin: 0 auto;
                background: #ffffff;
                padding: 28px 18px 38px 18px;
                border-radius: 18px;
                box-shadow: 0 4px 26px rgba(67, 160, 71, 0.12);
            }
            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                font-size: 1.16em;
                table-layout: fixed;
            }
            th, td {
                padding: 18px 14px;
                text-align: center;
                vertical-align: middle;
                white-space: nowrap;
            }
            th {
                background: var(--table-head-bg);
                color: var(--primary);
                font-weight: 600;
                border-bottom: 2.5px solid var(--table-border);
                font-size: 1.09em;
            }
            td {
                background: #fff;
                border-bottom: 1.5px solid var(--table-border);
                transition: background 0.2s;
            }
            tr:hover td {
                background: var(--table-row-hover);
            }
            th:first-child, td:first-child {
                width: 60px;
                min-width: 50px;
                max-width: 70px;
                padding-left: 6px;
                padding-right: 6px;
                font-weight: 700;
                font-size: 1em;
            }
            th:nth-child(2), td:nth-child(2) {
                width: 90px;
                min-width: 65px;
                max-width: 100px;
                padding-left: 6px;
                padding-right: 6px;
                font-size: 1em;
            }
            .status-select {
                min-width: 135px;
                padding: 6px 10px 6px 10px;
                border-radius: 8px;
                border: 1.5px solid var(--table-border);
                font-family: inherit;
                font-size: 1em;
                font-weight: 600;
                outline: none;
                transition: border 0.18s, background 0.18s, color 0.18s;
                background: #f8fff8;
                color: var(--primary-dark);
            }
            .status-select:focus {
                border: 2px solid var(--primary);
            }
            .detail-btn {
                padding: 8px 23px;
                background: linear-gradient(90deg, var(--primary) 60%, #8bc34a 100%);
                color: #fff;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-size: 1.1em;
                transition: background 0.2s, transform 0.1s;
                box-shadow: 0 2px 6px rgba(67, 160, 71, 0.12);
            }
            .detail-btn:hover {
                background: linear-gradient(90deg, var(--primary-dark) 60%, var(--primary) 100%);
                transform: translateY(-1px) scale(1.04);
            }
            tbody tr {
                border-bottom: 10px solid var(--primary-light);
            }
            td:not(:last-child), th:not(:last-child) {
                border-right: 1.5px solid var(--table-border);
            }
            .date-cell {
                min-width: 110px;
                white-space: nowrap;
                font-variant-numeric: tabular-nums;
                font-family: 'Quicksand', Arial, sans-serif;
                color: black;
                letter-spacing: 1px;
                background: #f1f8e9;
                border-radius: 8px;
                padding: 8px 10px;
                display: inline-block;
                font-weight: 600;
                font-size: 0.98em;
            }
            td:nth-child(5) {
                white-space: normal;
                word-break: break-word;
                max-width: 380px;
            }
            .tr-reviewed td, .tr-reviewed {
                background: #ffff00 !important;
            }
            .tr-resolved td, .tr-resolved {
                background: #00cc00 !important;
            }
            @media (max-width: 1300px) {
                .table-container, .filter-bar {
                    max-width: 100vw;
                    padding: 6px;
                    border-radius: 7px;
                }
                th, td {
                    padding: 9px 5px;
                    font-size: 1em;
                }
                .date-cell {
                    min-width: 90px;
                    font-size: 0.95em;
                }
                .status-select {
                    min-width: 90px;
                    padding: 5px 10px;
                }
                td:nth-child(5) {
                    max-width: 200px;
                }
                th:nth-child(2), td:nth-child(2) {
                    min-width: 50px;
                    max-width: 70px;
                }
            }
            @media (max-width: 700px) {
                .filter-bar {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 8px;
                }
                .table-container {
                    padding: 0;
                }
                table, thead, tbody, th, td, tr {
                    display: block;
                }
                thead {
                    display: none;
                }
                tr {
                    margin-bottom: 15px;
                    box-shadow: 0 2px 8px #c8e6c9;
                    border-radius: 7px;
                    overflow: hidden;
                }
                td {
                    position: relative;
                    padding-left: 46%;
                    background: #fff;
                    border: none;
                    border-bottom: 1px solid var(--primary-light);
                    text-align: left;
                    white-space: normal !important;
                }
                td:before {
                    position: absolute;
                    left: 10px;
                    top: 9px;
                    width: 39%;
                    white-space: nowrap;
                    color: var(--primary);
                    font-weight: 600;
                }
                td:nth-of-type(1):before { content: "ID"; }
                td:nth-of-type(2):before { content: "Vai trò"; }
                td:nth-of-type(3):before { content: "Phone"; }
                td:nth-of-type(4):before { content: "Tiêu đề"; }
                td:nth-of-type(5):before { content: "Nội dung"; }
                td:nth-of-type(6):before { content: "Ngày gửi"; }
                td:nth-of-type(7):before { content: "Trạng thái"; }
                td:nth-of-type(8):before { content: "Chi tiết"; }
                td:nth-child(5) {
                    max-width: 100vw;
                }
                th:nth-child(2), td:nth-child(2) {
                    min-width: 50px;
                    max-width: 70px;
                }
                .tr-reviewed td, .tr-reviewed {
                    background: #fffde7 !important;
                }
                .tr-resolved td, .tr-resolved {
                    background: #e8f5e9 !important;
                }
            }
            /* Phân trang */
            .pagination {
                display: flex;
                list-style: none;
                padding: 0;
                justify-content: center;
                margin-top: 24px;
            }
            .pagination .page-item {
                margin: 0 2px;
            }
            .pagination .page-link {
                color: var(--primary);
                background: #fff;
                border: 1.2px solid var(--primary);
                padding: 7px 13px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 600;
                transition: background 0.18s, color 0.18s;
            }
            .pagination .page-item.active .page-link,
            .pagination .page-link:hover {
                background: var(--primary);
                color: #fff;
            }
        </style>
      
    </head>
    
    <body>
       
        <div class="filter-bar" style="margin-top: 20px">
            <form method="get" action="DisplayListReport">
                <label for="filter-date">Ngày gửi:</label>
                <input type="date" id="filter-date" name="date" max="2999-12-31" value="${sessionScope.date}" onchange="this.form.submit()">
                <input type="hidden" name="phone" value="${sessionScope.phone}" />
                <input type="hidden" name="status" value="${sessionScope.status}" />
            </form>
            <form method="get" action="DisplayListReport">
                <label for="filter-phone">Số điện thoại:</label>
                <input type="text" id="filter-phone" value="${sessionScope.phone}" name="phone" placeholder="Nhập SĐT...">
                <input type="hidden" name="date" value="${sessionScope.date}" />
                <input type="hidden" name="status" value="${sessionScope.status}" />
                <input type="submit" style="display:none">
            </form>
            <form method="get" action="DisplayListReport">
                <label for="filter-status">Trạng thái:</label>
                <select id="filter-status" name="status" onchange="this.form.submit()">
                    <option value="">Tất cả</option>
                    <option value="pending" ${sessionScope.status eq 'pending' ? 'selected' : ''}>Pending</option>
                    <option value="reviewed" ${sessionScope.status eq 'reviewed' ? 'selected' : ''}>Reviewed</option>
                    <option value="resolved" ${sessionScope.status eq 'resolved' ? 'selected' : ''}>Resolved</option>
                </select>
                <input type="hidden" name="phone" value="${sessionScope.phone}" />
                <input type="hidden" name="date" value="${sessionScope.date}" />
            </form>
        </div>
        <div class="table-container">
            <table id="report-table">
                <thead>
                    <tr>
                        <th>ID User</th>
                        <th>Vai trò</th>
                        <th>Phone</th>
                        <th>Tiêu đề</th>
                        <th>Nội dung</th>
                        <th>Ngày gửi</th>
                        <th>Trạng thái</th>
                        <th>Chi tiết</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${listReport}">
                        <tr>
                            <td>${s.id}</td>
                            <td>${s.role}</td>
                            <td>${s.phone}</td>
                            <td>${s.title}</td>
                            <td>${s.content}</td>
                            <td><span class="date-cell">
                                <fmt:formatDate value="${s.dateSend}" pattern="MM/dd/yyyy"/>
                                </span></td>
                            <td>
                                <select class="status-select" data-idreport="${s.feedBackReportId}">
                                    <option value="pending" ${s.status eq 'pending' ? 'selected' :''} >Chờ xử lý</option>
                                    <option value="reviewed" ${s.status eq 'reviewed' ? 'selected' :''}>Đang xử lý</option>
                                    <option value="resolved" ${s.status eq 'resolved' ? 'selected' :''}>Hoàn Thành</option>
                                </select>
                            </td>
                            <td><a href="ViewDetail?idReport=${s.feedBackReportId}" target="_blank" class="detail-btn">Xem</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div id="modal" style="display:none;position:fixed;top:0;left:0;width:100vw;height:100vh;z-index:10;background:rgba(0,0,0,0.20);">
            <div style="background:#fff;border-radius:14px;max-width:460px;margin:7% auto 0;padding:36px 34px;box-shadow:0 8px 40px #388e3c22;position:relative;">
                <div id="modal-content" style="color:var(--primary);text-align:center;font-size:1.13em;"></div>
                <button onclick="closeModal()" style="margin-top:30px;padding:10px 36px;background:var(--primary);color:#fff;border:none;border-radius:8px;cursor:pointer;font-size:1.05em;">Đóng</button>
            </div>
        </div>
        <div class="d-flex justify-content-center mt-4">
            <nav>
                <ul class="pagination">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link"
                               href="DisplayListReport?page=${currentPage - 1}&date=${sessionScope.date}&phone=${sessionScope.phone}&status=${sessionScope.status}">&laquo; Trước</a>
                        </li>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link"
                               href="DisplayListReport?page=${i}&date=${sessionScope.date}&phone=${sessionScope.phone}&status=${sessionScope.status}"> ${i} </a>
                        </li>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link"
                               href="DisplayListReport?page=${currentPage + 1}&date=${sessionScope.date}&phone=${sessionScope.phone}&status=${sessionScope.status}">Sau &raquo;</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
            
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const statusSelects = document.querySelectorAll('.status-select');
                function updateRowBg(select) {
                    const tr = select.closest('tr');
                    tr.classList.remove("tr-reviewed", "tr-resolved");
                    if (select.value === "reviewed") {
                        tr.classList.add("tr-reviewed");
                    } else if (select.value === "resolved") {
                        tr.classList.add("tr-resolved");
                    }
                }
                statusSelects.forEach(select => {
                    updateRowBg(select);
                    select.addEventListener('change', function () {
                        const idReport = this.getAttribute("data-idreport");
                        const newStatus = this.value;
                        updateRowBg(this);
                        fetch("setStatus?idReport=" + idReport + "&newStatus=" + newStatus)
                            .then(response => {
                                if (response.ok) {
                                    alert("Cập nhật trạng thái thành công");
                                } else {
                                    alert("Cập nhật trạng thái thất bại");
                                }
                            })
                            .catch(error => console.error("Lỗi kết nối:", error));
                    });
                });
            });
        </script>
    </body>
</html>