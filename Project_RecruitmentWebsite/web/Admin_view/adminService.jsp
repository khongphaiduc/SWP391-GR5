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
        <!-- Service Management Table Section -->
        <div class="table-section fade-in-up">
            <div class="table-header">
                <div class="d-flex justify-content-between align-items-center">
                    <h3><i class="fas fa-cogs me-2"></i>Service Management</h3>
                    <div class="d-flex gap-2">
                        <form action="${pageContext.request.contextPath}/page_service/addService.jsp" method="get">
                            <button class="btn btn-primary btn-sm">
                                <i class="fas fa-plus me-1"></i>Add Service
                            </button>
                        </form>


                    </div>
                    
                </div>
            </div>

            <div class="table-container">
                <table class="table modern-table">
                    <thead>
                        <tr>
                            <th><i class="fas fa-hashtag me-2"></i>ID</th>
                            <th><i class="fas fa-cog me-2"></i>Service Name</th>
                            <th><i class="fas me-2"></i>Price (VNĐ) </th>
                            <th><i class="fas fa-info-circle me-2"></i>Description</th>
                            <th><i class="fas fa-tag me-2"></i>Promotion ID</th>
                            <th><i class="fas fa-clock me-2"></i>Duration</th>
                            <th><i class="fas fa-cogs me-2"></i>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="service" items="${serviceList}">
                            <tr>
                                <td>
                                    <span class="fw-bold text-primary">${service.serviceId}</span>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-3" 
                                             style="width: 40px; height: 40px; font-size: 0.9rem; color: white; font-weight: 600;">
                                            ${service.serviceName.substring(0, 1).toUpperCase()}
                                        </div>
                                        <div>
                                            <div class="fw-bold">${service.serviceName}</div>
                                            <small class="text-muted">Created in 2024</small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <%
                                        Models.Service s = (Models.Service) pageContext.getAttribute("service");
                                        double price = s.getPrice();
                                        double discount = 0;
                                        String promoCode = null;

                                        List<Models.Promotion> promos = (List<Models.Promotion>) request.getAttribute("promotions");
                                        if (s.getPromotionId() != null && promos != null) {
                                            for (Models.Promotion p : promos) {
                                                if (p.getPromotionId() == s.getPromotionId()) {
                                                    discount = p.getDiscount();
                                                    promoCode = p.getCode();
                                                    break;
                                                }
                                            }
                                        }

                                        double finalPrice = discount > 0 ? price * (1 - discount / 100.0) : price;
                                        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
                                        symbols.setGroupingSeparator('.');
                                        DecimalFormat formatter = new DecimalFormat("#,###", symbols);
                                        String formattedFinal = formatter.format(finalPrice);
                                        String formattedOriginal = formatter.format(price);
                                    %>

                                    <div class="d-flex flex-column">
                                        <% if (discount > 0) { %>
                                        <span class="text-danger fw-bold"><%= formattedFinal %> VNĐ</span>
                                        <small class="text-muted"><del><%= formattedOriginal %> VNĐ</del></small>
                                        <% } else { %>
                                        <span class="text-primary fw-bold"><%= formattedOriginal %> VNĐ</span>
                                        <% } %>
                                    </div>
                                </td>


                                <td>
                                    <div class="d-flex flex-column">
                                        <c:forEach var="item" items="${service.descriptionList}">
                                            <div class="d-flex align-items-center mb-1">
                                                <i class="fas fa-info-circle text-muted me-2"></i>
                                                <span>${item}</span>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </td>

                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-tag text-muted me-2"></i>
                                        <c:choose>
                                            <c:when test="${not empty service.promotionId}">
                                                ${service.promotionId}
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-clock text-muted me-2"></i>
                                        ${service.duration}
                                    </div>
                                </td>
                                <td>
                                    <div class="action-buttons">

                                        <form method="post" action="list" style="display:inline;">
                                            <input type="hidden" name="action" value="toggleVisibility"/>
                                            <input type="hidden" name="serviceId" value="${service.serviceId}"/>
                                            <input type="hidden" name="visible" value="${!service.visible}"/>
                                            <button type="submit"
                                                    class="action-btn btn-view"
                                                    title="${service.visible ? 'Ẩn dịch vụ này' : 'Hiện lại dịch vụ'}"
                                                    onclick="return confirm('Bạn có chắc chắn muốn ${service.visible ? 'ẩn' : 'hiện'} dịch vụ này?');">
                                                <i class="fas ${service.visible ? 'fa-eye' : 'fa-eye-slash'}"></i>
                                            </button>
                                        </form>
                                        <a class="action-btn btn-edit"
                                           href="${pageContext.request.contextPath}/update-service?id=${service.serviceId}"
                                           title="Edit Service">
                                            <i class="fas fa-edit"></i>
                                        </a>
<!--                                        <a class="action-btn btn-delete"
                                           href="${pageContext.request.contextPath}/delete-servicepackage?id=${service.serviceId}"
                                           onclick="return confirm('Are you sure you want to delete this service?');"
                                           title="Delete Service">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>-->

                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty serviceList}">
                            <tr>
                                <td colspan="7" class="text-center">No services found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>

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
                        <a href="adminService?page=<%= i %>"><%= i %></a>
                        <% } %>
                        <% } %>

                        <div class="cv-page-size-control">
                            <span>Hiển thị:</span>
                            <form action="adminService" style="display: flex; align-items: center; gap: 8px;">
                                <input type="number" name="pageSize" value="<%=pageSize%>" min="1" max="20">
                                <button type="submit">OK</button>
                            </form>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </body>
</html>
