<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Models.*" %>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách tin tuyển dụng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: #f5f5f5;
                color: #333;
                line-height: 1.6;
            }

            .job-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 80px 20px;
            }

            .job-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .job-header h1 {
                font-size: 1.8rem;
                color: #00c853;
                margin-bottom: 8px;
                font-weight: 600;
            }

            .job-header p {
                color: #6c757d;
                font-size: 1rem;
            }

            .job-table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }

            .job-table th, .job-table td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #e0e0e0;
            }

            .job-table th {
                background: #f8f9fa;
                font-weight: 500;
                color: #2c3e50;
                font-size: 0.9rem;
                text-transform: uppercase;
            }

            .job-table td {
                font-size: 0.95rem;
                color: #2c3e50;
            }

            .job-table tr:hover {
                background: #f5f5f5;
            }

            .job-title a {
                color: #2c3e50;
                text-decoration: none;
            }

            .job-title a:hover {
                color: #00c853;
                text-decoration: underline;
            }

            .job-status-badge {
                display: inline-block;
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 0.8rem;
                font-weight: 500;
            }

            .job-status-visible {
                background: #e8f5e8;
                color: #2e7d32;
            }

            .job-status-hidden {
                background: #f8d7da;
                color: #721c24;
            }

            .job-actions {
                display: flex;
                gap: 8px;
            }

            .job-btn {
                padding: 8px 12px;
                border: none;
                border-radius: 4px;
                font-size: 0.9rem;
                font-weight: 500;
                cursor: pointer;
                text-align: center;
                color: white;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            .job-btn-edit {
                background-color: #00c853;
            }

            .job-btn-edit:hover {
                background-color: #00a63f;
            }

            .job-btn-delete {
                background-color: #e74c3c;
            }

            .job-btn-delete:hover {
                background-color: #c0392b;
            }

            .job-no-jobs {
                text-align: center;
                padding: 40px 20px;
                background: white;
                border-radius: 8px;
                border: 1px solid #e0e0e0;
                margin: 20px 0;
            }

            .job-no-jobs i {
                font-size: 3rem;
                color: #bdc3c7;
                margin-bottom: 15px;
            }

            .job-no-jobs h3 {
                font-size: 1.3rem;
                color: #2c3e50;
                margin-bottom: 8px;
            }

            .job-no-jobs p {
                color: #7f8c8d;
                font-size: 0.95rem;
            }

            .job-pagination-wrapper {
                background: white;
                padding: 15px;
                border-radius: 8px;
                border: 1px solid #e0e0e0;
                margin-top: 20px;
            }

            .job-pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                flex-wrap: wrap;
            }

            .job-pagination a, .job-pagination span {
                padding: 6px 12px;
                border-radius: 4px;
                text-decoration: none;
                font-weight: 500;
                min-width: 36px;
                text-align: center;
            }

            .job-pagination a {
                background: #f8f9fa;
                color: #2c3e50;
                border: 1px solid #e0e0e0;
            }

            .job-pagination a:hover {
                background: #00c853;
                color: white;
            }

            .job-current-page {
                background: #00c853;
                color: white;
            }

            .job-page-size-control {
                display: flex;
                align-items: center;
                gap: 8px;
                margin-left: 20px;
                padding-left: 20px;
                border-left: 1px solid #e0e0e0;
            }

            .job-page-size-control input {
                width: 50px;
                padding: 5px;
                border: 1px solid #e0e0e0;
                border-radius: 4px;
                text-align: center;
            }

            .job-page-size-control button {
                padding: 5px 10px;
                background: #00c853;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
            }

            .job-page-size-control button:hover {
                background: #00a63f;
            }

            @media (max-width: 768px) {
                .job-container {
                    padding: 80px 15px;
                }

                .job-table {
                    display: block;
                    overflow-x: auto;
                }

                .job-page-size-control {
                    margin-left: 0;
                    padding-left: 0;
                    border-left: none;
                    border-top: 1px solid #e0e0e0;
                    padding-top: 10px;
                    justify-content: center;
                }
            }

            @media (max-width: 480px) {
                .job-table th, .job-table td {
                    padding: 10px;
                    font-size: 0.85rem;
                }

                .job-actions {
                    flex-direction: column;
                    gap: 6px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/navbar.jsp" />
        <div class="job-container">
            <div class="job-header">
                <h1><i class="fas fa-briefcase"></i> Danh sách tin tuyển dụng</h1>
                <p>Quản lý tất cả tin tuyển dụng của bạn</p>
            </div>

            <%
                List<JobPost> jobList = (List<JobPost>) request.getAttribute("jobList");
                if (jobList != null && !jobList.isEmpty()) {
            %>
            <table class="job-table">
                <thead>
                    <tr>
                        <th>Tiêu đề</th>
                        <th>Vị trí</th>
                        <th>Công ty</th>
                        <th>Địa điểm</th>
                        <th>Mức lương</th>
                        <th>Trạng thái</th>
                        <th>Tổng CV</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (JobPost job : jobList) {
                    %>
                    <tr>
                        <td class="job-title">
                            <a href="<%=request.getContextPath()%>/detailJob?postId=<%= job.getJobPost_ID() %>">
                                <%= job.getTitle() %>
                            </a>
                            
                        </td>
                        <td><%= job.getPosition() %></td>
                        <td><%= job.getEmployer().getCompanyName() %></td>
                        <td><%= job.getLocation() %></td>
                        <td><%= job.getOffer_Min() %> - <%= job.getOffer_Max() %></td>
                        <td>
                            <span class="job-status-badge <%= job.isVisible() ? "job-status-visible" : "job-status-hidden" %>">
                                <%= job.isVisible() ? "Hiển thị" : "Ẩn" %>
                            </span>
                        </td>
                        <td><%= job.getCvCount() %></td>
                        <td>
                            <div class="job-actions">
                                <form method="post" action="manageCreatedJob">
                                    <input type="hidden" name="action" value="edit" />
                                    <input type="hidden" name="jobId" value="<%= job.getJobPost_ID() %>" />
                                    <button type="submit" class="job-btn job-btn-edit">
                                        <i class="fas fa-edit"></i> Sửa
                                    </button>
                                </form>
                                <form method="post" action="manageCreatedJob" onsubmit="return confirm('Bạn có chắc chắn muốn xóa tin này?');">
                                    <input type="hidden" name="action" value="delete" />
                                    <input type="hidden" name="jobId" value="<%= job.getJobPost_ID() %>" />
                                    <button type="submit" class="job-btn job-btn-delete">
                                        <i class="fas fa-trash"></i> Xóa
                                    </button>
                                </form>
                                <form method="get" action="view-applied-cvs">
                                    <input type="hidden" name="jobPostId" value="<%= job.getJobPost_ID() %>" />
                                    <button type="submit" class="job-btn job-btn-edit">
                                          Chi tiết các CV 
                                    </button>
                                </form>
                                
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                        
                    %>
                </tbody>
            </table>
            <% 
                Integer currentPage = (Integer) request.getAttribute("currentPage");
                Integer totalPages = (Integer) request.getAttribute("totalPages");
                Integer pageSize = (Integer) session.getAttribute("pageSize");
                if (totalPages != null && totalPages > 1) {
            %>
            <div class="job-pagination-wrapper">
                <div class="job-pagination">
                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <% if (i == currentPage) { %>
                    <span class="job-current-page"><%= i %></span>
                    <% } else { %>
                    <a href="manageCreatedJob?page=<%= i %>"><%= i %></a>
                    <% } %>
                    <% } %>

                    <div class="job-page-size-control">
                        <span>Hiển thị:</span>
                        <form action="manageCreatedJob" style="display: flex; align-items: center; gap: 8px;">
                            <input type="number" name="pageSize" value="<%=pageSize%>" min="1" max="20">
                            <button type="submit">OK</button>
                        </form>
                    </div>
                </div>
            </div>
            <% } %>

            <% } else { %>
            <div class="job-no-jobs">
                <i class="fas fa-briefcase"></i>
                <h3>Chưa có tin tuyển dụng</h3>
                <p>Không có tin tuyển dụng nào được tìm thấy. Hãy tạo tin tuyển dụng đầu tiên của bạn!</p>
            </div>
            <% } %>
        </div>
    </body>
</html>