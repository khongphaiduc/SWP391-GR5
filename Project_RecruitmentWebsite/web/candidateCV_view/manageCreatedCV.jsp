<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Models.*" %>
<html>
    <head>
        <jsp:include page="/navbar.jsp" />

        <meta charset="UTF-8">
        <title>Danh sách CV</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                
            }

            h2 {
                text-align: center;
                color: #2d2d2d;
                margin-bottom: 30px;
            }

            .cv-card {
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
                margin-bottom: 20px;
                padding: 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .cv-info {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .cv-image {
                width: 150px;
                height: 150px;
                border-radius: 8px;
                overflow: hidden;
                border: 1px solid #ddd;
            }

            .cv-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .cv-details {
                display: flex;
                flex-direction: column;
            }

            .cv-details h3 {
                margin: 0;
                font-size: 18px;
                color: #333;
            }

            .cv-details span {
                margin-top: 5px;
                font-size: 14px;
                color: #666;
            }

            .cv-actions {
                display: flex;
                flex-direction: column;
                gap: 10px;
                align-items: flex-end;
            }

            .btn {
                padding: 10px 16px;
                border-radius: 6px;
                font-weight: bold;
                text-decoration: none;
                color: white;
                transition: background-color 0.3s;
                display: inline-block;
                text-align: center;
                min-width: 90px;
            }

            .btn.view {
                background-color: #00b386;
                color: white;
            }

            .btn.view:hover {
                background-color: #009e75;
            }

            .btn.edit {
                background-color: #007bff;
                color: white;
            }

            .btn.edit:hover {
                background-color: #0056b3;
            }

            .btn.delete {
                background-color: #dc3545;
                color: white;
            }

            .btn.delete:hover {
                background-color: #c82333;
            }

            .no-cv {
                text-align: center;
                color: #999;
                font-size: 16px;
            }

            .icon {
                margin-right: 6px;
                color: #00b386;
            }

            @media (max-width: 768px) {
                .cv-card {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .cv-actions {
                    flex-direction: row;
                    justify-content: center;
                    width: 100%;
                    margin-top: 10px;
                }
            }
        </style>
    </head>
    <body>
        </br>
        <h2>Danh sách CV của bạn</h2>

        <%
            List<CV> cvList = (List<CV>) request.getAttribute("cvList");
            if (cvList != null && !cvList.isEmpty()) {
                for (CV cv : cvList) {
        %>
        <div class="cv-card">
            <div class="cv-info">
                <div class="cv-image">
                    <img src="viewCV?cvId=<%= cv.getCvId() %>" alt="File không thể preview. Click vào xem CV ">
                </div>
                <div class="cv-details">
                    <h3><i class="fas fa-user icon"></i><%= cv.getFullName() %></h3>
                    <span><i class="fas fa-briefcase icon"></i><%= cv.getPosition() %></span>
                    <span><i class="fas fa-clock icon"></i>Kinh nghiệm: <%= cv.getNumberExp() %> năm</span>
                    <span><i class="fas fa-dollar-sign icon"></i>Lương hiện tại: <%= cv.getCurrentSalary() %></span>
                    <span><i class="fas fa-birthday-cake icon"></i>Ngày sinh: <%= cv.getBirthday() %></span>
                    <span><i class="fas fa-venus-mars icon"></i>Giới tính: <%= cv.getGender() %></span>
                </div>
            </div>
            <div class="cv-actions">
                <a href="viewCV?cvId=<%= cv.getCvId() %>" class="btn view" target="_blank">Xem CV</a>
                <form method="post" action="manageCreatedCV" style="margin: 0;">
                    <input type="hidden" name="action" value="edit" />
                    <input type="hidden" name="cvId" value="<%= cv.getCvId() %>" />
                    <button type="submit" class="btn edit">Chỉnh sửa</button>
                </form>

                <form method="post" action="manageCreatedCV" style="margin: 0;" onsubmit="return confirm('Bạn có chắc chắn muốn xóa CV này?');">
                    <input type="hidden" name="action" value="delete" />
                    <input type="hidden" name="cvId" value="<%= cv.getCvId() %>" />
                    <button type="submit" class="btn delete">Xóa</button>
                </form>
            </div>
        </div>

        <%
                }
        %>
        <% Integer currentPage = (Integer) request.getAttribute("currentPage");
           Integer totalPages = (Integer) request.getAttribute("totalPages");
           if (totalPages != null && totalPages > 1) {
        %>
        <div style="text-align: center; margin-top: 30px;">
            <nav>
                <ul style="list-style: none; padding: 0; display: inline-flex; gap: 6px;">
                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <li>
                        <a href="manageCreatedCV?page=<%= i %>" style="padding: 8px 14px; border-radius: 6px;
                           background-color: <%= (i == currentPage) ? "#007bff" : "#e0e0e0" %>;
                           color: <%= (i == currentPage) ? "white" : "#333" %>;
                           text-decoration: none; font-weight: bold;">
                            <%= i %>
                        </a>
                    </li>
                    <% } %>
                </ul>
            </nav>
        </div>
        <% } %>


        <%    } else {
        %>
        <p class="no-cv">Không có CV nào được tìm thấy.</p>
        <% } %>

    </body>
</html>
