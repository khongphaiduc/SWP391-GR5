<%-- 
    Document   : adminService
    Created on : 16 Jul 2025, 23:36:54
    Author     : PC
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Models.Employer" %>
<%@ page import="Models.Candidate" %>
<%@ page import="Models.Service" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.DecimalFormatSymbols" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Service Management</title>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/style.css"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/adminDashboard.css"/>
    </head>
    <body>
        <!-- Navigation -->
        <jsp:include page="/navbar.jsp" />
        <!-- ======================== Promotion Management Section ========================= -->
        <div class="table-section fade-in-up mt-5">
            <div class="table-header mb-3">
                <div class="d-flex justify-content-between align-items-center">
                    <h3><i class="fas fa-gift me-2"></i>Promotion Management</h3>
                </div>
            </div>

            <!-- Message -->
            <c:if test="${not empty promotionMessage}">
                <div class="alert alert-success">${promotionMessage}</div>
            </c:if>
            <c:if test="${not empty promotionError}">
                <div class="alert alert-danger">${promotionError}</div>
            </c:if>

            <!-- Form Add Promotion -->
            <form method="post" action="list" class="row g-3 align-items-end mb-4">
                <input type="hidden" name="action" value="addPromotion" />
                <div class="col-md-3">
                    <label class="form-label">Promotion Code</label>
                    <input type="text" name="code" class="form-control" required />
                </div>
                <div class="col-md-2">
                    <label class="form-label">Discount (%)</label>
                    <input type="number" name="discount" step="0.01" class="form-control" required />
                </div>
                <div class="col-md-3">
                    <label class="form-label">Start Date</label>
                    <input type="date" name="dateStart" class="form-control" required />
                </div>
                <div class="col-md-3">
                    <label class="form-label">End Date</label>
                    <input type="date" name="dateEnd" class="form-control" required />
                </div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-success w-100">
                        <i class="fas fa-plus"></i>
                    </button>
                </div>
            </form>

            <!-- TABLE: List Promotions -->
            <div class="table-container">
                <table class="table modern-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Code</th>
                            <th>Discount</th>
                            <th>Start</th>
                            <th>End</th>
                            <th>Created</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="promo" items="${promotions}">
                            <tr>
                                <td>${promo.promotionId}</td>
                                <td>${promo.code}</td>
                                <td>${promo.discount}%</td>
                                <td>${promo.dateStart}</td>
                                <td>${promo.dateEnd}</td>
                                <td>${promo.dateCreated}</td>
                                <td>
                                    <!-- UPDATE: Open modal -->
                                    <button type="button" class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                            data-bs-target="#editPromoModal${promo.promotionId}">
                                        <i class="fas fa-edit"></i>
                                    </button>

                                    <!-- DELETE: Form to separate servlet -->
                                    <form method="post" action="${pageContext.request.contextPath}/delete-promotion"
                                          style="display:inline;" onsubmit="return confirm('Xác nhận xoá khuyến mãi này?');">
                                        <input type="hidden" name="promotionId" value="${promo.promotionId}" />
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty promotions}">
                            <tr><td colspan="7" class="text-center">No promotions available.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <!-- MODALS (Tách riêng) -->
            <c:forEach var="promo" items="${promotions}">
                <div class="modal fade" id="editPromoModal${promo.promotionId}" tabindex="-1"
                     aria-labelledby="editPromoLabel${promo.promotionId}" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <form method="post" action="${pageContext.request.contextPath}/update-promotion" class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editPromoLabel${promo.promotionId}">Chỉnh sửa khuyến mãi</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                            </div>
                            <div class="modal-body row g-3">
                                <input type="hidden" name="promotionId" value="${promo.promotionId}" />

                                <div class="col-md-6">
                                    <label class="form-label">Mã khuyến mãi</label>
                                    <input type="text" name="code" class="form-control" value="${promo.code}" required />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Giảm giá (%)</label>
                                    <input type="number" name="discount" class="form-control" value="${promo.discount}"
                                           step="0.01" min="0" max="100" required />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Ngày bắt đầu</label>
                                    <input type="date" name="dateStart" class="form-control"
                                           value="${fn:substring(promo.dateStart, 0, 10)}" required />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Ngày kết thúc</label>
                                    <input type="date" name="dateEnd" class="form-control"
                                           value="${fn:substring(promo.dateEnd, 0, 10)}" required />
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save me-1"></i> Cập nhật
                                </button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                            </div>
                        </form>
                    </div>
                </div>
            </c:forEach>

            <% 
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer pageSize = (Integer) session.getAttribute("pageSize");
    if (totalPages != null && totalPages > 1) {
            %>
            <div class="cv-pagination-wrapper">
                <div class="cv-pagination">
                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <% if (i == currentPage) { %>
                    <span class="cv-current-page"><%= i %></span>
                    <% } else { %>
                    <a href="adminPromotion?page=<%= i %>"><%= i %></a>
                    <% } %>
                    <% } %>

                    <div class="cv-page-size-control">
                        <span>Hiển thị:</span>
                        <form action="adminPromotion" style="display: flex; align-items: center; gap: 8px;">
                            <input type="number" name="pageSize" value="<%=pageSize%>" min="1" max="20">
                            <button type="submit">OK</button>
                        </form>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <!-- Scripts -->
    <script src="js/bootstrap.bundle.min.js"></script>
    <script>
                                              document.addEventListener('DOMContentLoaded', function () {
                                              // Animate stats on scroll
                                              const statsCards = document.querySelectorAll('.stats-card');
                                                      const observer = new IntersectionObserver((entries) => {
                                                      entries.forEach(entry => {
                                                      if (entry.isIntersecting) {
                                                      entry.target.style.animationDelay = Math.random() * 100 + 'ms';
                                                              entry.target.classList.add('fade-in-up');
                                                      }
                                                      });
                                                      });
                                                      statsCards.forEach(card => {
                                                      observer.observe(card);
                                                      });
                                                      // Enhanced delete confirmation for both tables
                                                      document.querySelectorAll('.btn-delete').forEach(btn => {
                                              btn.addEventListener('click', function (e) {
                                              e.preventDefault();
                                                      const name = this.closest('tr').querySelector('td:nth-child(2) .fw-bold')?.textContent || 'this item';
                                                      const isService = this.closest('.table-section').querySelector('h3').textContent.includes('Service');
                                                      const confirmMessage = isService
                                                      ? `Are you sure you want to delete the service "${name}"?\n\nThis action cannot be undone and will permanently remove all associated data.`
                                                      : `Are you sure you want to delete the account "${name}"?\n\nThis action cannot be undone and will permanently remove all associated data.`;
                                                      if (confirm(confirmMessage)) {
                                              window.location.href = this.href;
                                              }
                                              });
                                                      );
                                                      // Add tooltips for better UX
                                                      const tooltipTriggerList = document.querySelectorAll('[title]');
                                                      tooltipTriggerList.forEach(triggerEl => {
                                                      new bootstrap.Tooltip(triggerEl);
                                                      });
                                              });
    </script>
    <c:if test="${not empty message}">
        <div id="toast-message" class="toast-msg ${messageType == 'success' ? 'toast-success' : 'toast-error'}">
            ${message}
        </div>
        <script>
                    setTimeout(function () {
                    document.getElementById('toast-message').style.display = 'none';
                    }, 3000);
        </script>
        <%-- Xóa thông báo khỏi session sau khi hiển thị nếu bạn dùng session (ở đây dùng request.setAttribute nên không cần) --%>
    </c:if>
</body>
</html>
