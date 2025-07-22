<%-- 
    Document   : notification
    Created on : 21 Jul 2025, 17:06:16
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.util.*, Models.Notification" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%
    List<Notification> notifications = (List<Notification>) request.getAttribute("notifications");
%>


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Thông báo</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            .container {
                padding: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }
            th {
                background-color: #f8f9fa;
            }
            input, select, textarea {
                padding: 8px;
                margin-right: 10px;
                width: 200px;
            }
            .action-btn {
                padding: 6px 10px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }
            .edit-btn {
                background-color: #ffc107;
                color: black;
            }
            .delete-btn {
                background-color: #dc3545;
                color: white;
            }
            .form-row {
                margin-bottom: 15px;
            }
            .form-row label {
                display: inline-block;
                width: 120px;
            }
            .add-btn {
                background-color: #198754;
                color: white;
                padding: 8px 15px;
                border-radius: 5px;
                border: none;
            }
            .cv-pagination-wrapper {
                background: white;
                padding: 24px;
                border-radius: 16px;
                box-shadow: 0 4px 16px rgba(46, 79, 79, 0.08);
                margin-top: 30px;
                border: 1px solid rgba(46, 79, 79, 0.1);
            }

            .cv-pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 12px;
                flex-wrap: wrap;
            }

            .cv-pagination a, .cv-pagination span {
                padding: 10px 16px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
                min-width: 44px;
                text-align: center;
            }

            .cv-pagination a {
                background: #f8f9fa;
                color: #333;
                border: 1px solid #e9ecef;
            }

            .cv-pagination a:hover {
                background: #2e4f4f; /* Dark green */
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(46, 79, 79, 0.2);
            }

            .cv-pagination .cv-current-page {
                background: linear-gradient(135deg, #2e4f4f, #1a3c3c);
                color: white;
                box-shadow: 0 4px 12px rgba(46, 79, 79, 0.3);
            }

            .cv-page-size-control {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-left: 20px;
                padding-left: 20px;
                border-left: 2px solid #e9ecef;
            }

            .cv-page-size-control input {
                width: 60px;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 6px;
                text-align: center;
                font-weight: 500;
            }

            .cv-page-size-control button {
                padding: 8px 16px;
                background: linear-gradient(135deg, #2e4f4f, #1a3c3c); /* Dark green gradient */
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .cv-page-size-control button:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(46, 79, 79, 0.3);
            }

            .action-btn {
                text-decoration: none;
                color: #007bff;
                padding: 5px;
                font-size: 14px;
            }
            .action-btn:hover {
                text-decoration: underline;
            }
            .edit-btn i,
            .delete-btn i {
                margin-right: 5px;
            }

        </style>
    </head>
    <body>
        <jsp:include page="/navbar.jsp" />
        <div class="container">
            <h2>Quản lý Thông báo</h2>

            <%
    Notification editing = (Notification) request.getAttribute("editingNotification");
    boolean isEditing = editing != null;
            %>

            <form action="notificationServlet" method="post">
                <input type="hidden" name="action" value="<%= isEditing ? "edit" : "create" %>"/>
                <c:if test="${editingNotification != null}">
                    <input type="hidden" name="id" value="${editingNotification.id}" />
                </c:if>

                <div class="form-row">
                    <label for="title">Tiêu đề:</label>
                    <input type="text" name="title" id="title" value="<c:out value='${editingNotification.title}'/>" required>
                </div>
                <div class="form-row">
                    <label for="content">Nội dung:</label>
                    <textarea name="content" id="content" rows="3" style="width: 400px;" required><c:out value='${editingNotification.content}'/></textarea>
                </div>
                <div class="form-row">
                    <label for="roleTarget">Đối tượng:</label>
                    <select name="roleTarget" id="roleTarget" required>
                        <option value="All" ${editingNotification.roleTarget == 'All' ? 'selected' : ''}>Tất cả</option>
                        <option value="Admin" ${editingNotification.roleTarget == 'Admin' ? 'selected' : ''}>Admin</option>
                        <option value="Employer" ${editingNotification.roleTarget == 'Employer' ? 'selected' : ''}>Employer</option>
                        <option value="Candidate" ${editingNotification.roleTarget == 'Candidate' ? 'selected' : ''}>Candidate</option>
                    </select>
                </div>

                <button type="submit" class="add-btn">
                    <i class="fas fa-<%= isEditing ? "save" : "plus" %>"></i> <%= isEditing ? "Cập nhật" : "Tạo mới" %>
                </button>
            </form>


            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tiêu đề</th>
                        <th>Nội dung</th>
                        <th>Đối tượng</th>
                        <th>Thời gian tạo</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="n" items="${notifications}">
                        <tr>
                            <td>${n.id}</td>
                            <td>${n.title}</td>
                            <td>${n.content}</td>
                            <td>${n.roleTarget}</td>
                            <td><fmt:formatDate value="${n.createdAt}" pattern="dd/MM/yyyy" /></td>
                            <td>
                                <!-- SỬA -->
                                <form action="notificationServlet" method="get" style="display:inline;">
                                    <input type="hidden" name="action" value="edit" />
                                    <input type="hidden" name="id" value="${n.id}" />
                                    <button type="submit" class="action-btn edit-btn" style="border:none; background:none; cursor:pointer;">
                                        <i class="fas fa-pen"></i> Sửa
                                    </button>
                                </form>

                                <!-- XOÁ -->
                                <form action="notificationServlet" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc muốn xóa thông báo này?');">
                                    <input type="hidden" name="action" value="delete" />
                                    <input type="hidden" name="id" value="${n.id}" />
                                    <button type="submit" class="action-btn delete-btn" style="border:none; background:none; cursor:pointer;">
                                        <i class="fas fa-trash"></i> Xóa
                                    </button>
                                </form>

                            </td>
                        </tr>
                    </c:forEach>
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
                    <a href="notificationServlet?page=<%= i %>"><%= i %></a>
                    <% } %>
                    <% } %>

                    <div class="cv-page-size-control">
                        <span>Hiển thị:</span>
                        <form action="notificationServlet" style="display: flex; align-items: center; gap: 8px;">
                            <input type="number" name="pageSize" value="<%=pageSize%>" min="1" max="20">
                            <button type="submit">OK</button>
                        </form>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </body>
</html>
