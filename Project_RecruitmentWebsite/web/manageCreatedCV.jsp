<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Models.*" %>
<html>
    <head>
        <title>Danh sách CV</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 20px;
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
                width: 100px;
                height: 100px;
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

            .apply-btn {
                background-color: #00b386;
                color: white;
                padding: 10px 16px;
                text-decoration: none;
                border-radius: 6px;
                font-weight: bold;
                transition: background-color 0.3s;
            }

            .apply-btn:hover {
                background-color: #009e75;
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
        </style>
    </head>
    <body>
        <h2>Danh sách CV của bạn</h2>

        <%
            List<CV> cvList = (List<CV>) request.getAttribute("cvList");
            if (cvList != null && !cvList.isEmpty()) {
                for (CV cv : cvList) {
        %>
        <div class="cv-card">
            <div class="cv-info">
                <div class="cv-image">
                    <img src="viewCV?cvId=<%= cv.getCvId() %>" alt="CV Image">
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
            <a href="viewCV?cvId=<%= cv.getCvId() %>" class="apply-btn" target="_blank">
                Xem CV
            </a>
        </div>
        <%
                }
            } else {
        %>
        <p class="no-cv">Không có CV nào được tìm thấy.</p>
        <% } %>
    </body>
</html>
