<%-- 
    Document   : manageCreatedJob
    Created on : May 29, 2025, 10:43:55 AM
    Author     : PC
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Models.*" %>
<html>
    <head>
        <jsp:include page="/navbar.jsp" />
        <meta charset="UTF-8">
        <title>Danh sách tin tuyển dụng</title>
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

            .job-card {
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
                margin-bottom: 20px;
                margin-left: 20px;
                margin-right: 20px;
                padding: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .job-details {
                flex: 1;
            }

            .job-details h3 {
                margin: 0 0 8px;
                font-size: 20px;
                color: #333;
            }

            .job-details span {
                display: block;
                font-size: 14px;
                color: #555;
                margin-bottom: 4px;
            }

            .job-actions {
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
            }

            .btn.view:hover {
                background-color: #009e75;
            }

            .btn.edit {
                background-color: #007bff;
            }

            .btn.edit:hover {
                background-color: #0056b3;
            }

            .btn.delete {
                background-color: #dc3545;
            }

            .btn.delete:hover {
                background-color: #c82333;
            }

            .no-job {
                text-align: center;
                color: #999;
                font-size: 16px;
            }

            @media (max-width: 768px) {
                .job-card {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .job-actions {
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
        <h2>Danh sách tin tuyển dụng của bạn</h2>

        <%
            List<JobPost> jobList = (List<JobPost>) request.getAttribute("jobList");
            if (jobList != null && !jobList.isEmpty()) {
                for (JobPost job : jobList) {
        %>
        <div class="job-card">
            <div class="job-details">
                <h3><i class="fas fa-briefcase icon"></i> <%= job.getTitle() %></h3>
                <span><i class="fas fa-building icon"></i> Công ty: <%= job.getCompapy() %></span>

                <span><i class="fas fa-sitemap icon"></i> Ngành nghề: <%= job.getCategory() %></span>

                <span><i class="fas fa-map-marker-alt icon"></i> Địa điểm: <%= job.getLocation() %></span>
                <span><i class="fas fa-money-bill-wave icon"></i> Mức lương: <%= job.getOffer_Min() %> - <%= job.getOffer_Max() %></span>
                <span><i class="fas fa-user-tie icon"></i> Vị trí: <%= job.getPosition() %></span>
<!--                <span><i class="fas fa-calendar icon"></i> Ngày đăng: <%= job.getDayCre() %></span>-->
                <span><i class="fas fa-hourglass icon"></i> Kinh nghiệm yêu cầu: <%= job.getNumber_exp() %> năm</span>

                <span><i class="fas fa-eye icon"></i> Trạng thái: <%= job.isVisible() ? "Hiển thị" : "Ẩn" %></span>
            </div>
            <div class="job-actions">

                <form method="post" action="manageCreatedJob" style="margin: 0;">
                    <input type="hidden" name="action" value="edit" />
                    <input type="hidden" name="jobId" value="<%= job.getJobPost_ID() %>" />
                    <button type="submit" class="btn edit">Chỉnh sửa</button>
                </form>
                <form method="post" action="manageCreatedJob" style="margin: 0;" onsubmit="return confirm('Bạn có chắc chắn muốn xóa tin này?');">
                    <input type="hidden" name="action" value="delete" />
                    <input type="hidden" name="jobId" value="<%= job.getJobPost_ID() %>" />
                    <button type="submit" class="btn delete">Xóa</button>
                </form>
            </div>
        </div>
        <%
                }

            Integer currentPage = (Integer) request.getAttribute("currentPage");
            Integer totalPages = (Integer) request.getAttribute("totalPages");
            if (totalPages != null && totalPages > 1) {
        %>
        <div style="text-align: center; margin-top: 30px;">
            <nav>
                <ul style="list-style: none; padding: 0; display: inline-flex; gap: 6px;">
                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <li>
                        <a href="manageCreatedJob?page=<%= i %>" style="padding: 8px 14px; border-radius: 6px;
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
        <%
            } else {
        %>
        <p class="no-job">Không có tin tuyển dụng nào được tìm thấy.</p>
        <% } %>
    </body>
</html>
