<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Models.*" %>
<html>
    <head>
        <jsp:include page="/navbar.jsp" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách tin tuyển dụng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 80px 20px 20px;
            }

            .header {
                text-align: center;
                margin-bottom: 30px;
            }

            .header h1 {
                font-size: 2rem;
                color: #00c853;
                margin-bottom: 10px;
                font-weight: 600;
            }

            .header p {
                color: #6c757d;
                font-size: 1rem;
            }

            .job-list {
                display: flex;
                flex-direction: column;
                gap: 20px;
                margin-bottom: 30px;
            }

            .job-card {
                background: white;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 24px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                transition: box-shadow 0.3s ease;
            }

            .job-card:hover {
                box-shadow: 0 4px 16px rgba(0,0,0,0.15);
            }

            .job-header {
                border-bottom: 2px solid #00c853;
                padding-bottom: 16px;
                margin-bottom: 20px;
            }

            .job-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 8px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .job-position {
                font-size: 1.1rem;
                color: #00c853;
                font-weight: 500;
            }

            .job-info {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 16px;
                margin-bottom: 20px;
            }

            .info-item {
                display: flex;
                align-items: flex-start;
                gap: 12px;
                padding: 12px;
                background: #f8f9fa;
                border-radius: 6px;
                border-left: 3px solid #00c853;
            }

            .info-icon {
                color: #00c853;
                font-size: 16px;
                margin-top: 2px;
                min-width: 16px;
            }

            .info-content {
                flex: 1;
            }

            .info-label {
                font-size: 0.85rem;
                color: #7f8c8d;
                font-weight: 500;
                margin-bottom: 4px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .info-value {
                font-size: 0.95rem;
                color: #2c3e50;
                font-weight: 500;
                word-wrap: break-word;
            }

            .info-value a {
                color: #00c853;
                text-decoration: none;
            }

            .info-value a:hover {
                text-decoration: underline;
            }

            .job-actions {
                display: flex;
                gap: 12px;
                padding-top: 16px;
                border-top: 1px solid #e0e0e0;
            }

            .job-actions form {
                flex: 1;
            }

            .btn {
                width: 100%;
                padding: 12px 20px;
                border: none;
                border-radius: 6px;
                font-size: 0.95rem;
                font-weight: 500;
                cursor: pointer;
                text-decoration: none;
                text-align: center;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                transition: all 0.3s ease;
            }

            .btn-edit {
                background-color: #00c853;
                color: white;
            }

            .btn-edit:hover {
                background-color: #00a63f;
                transform: translateY(-1px);
            }

            .btn-delete {
                background-color: #e74c3c;
                color: white;
            }

            .btn-delete:hover {
                background-color: #c0392b;
                transform: translateY(-1px);
            }

            .no-jobs {
                text-align: center;
                padding: 60px 20px;
                background: white;
                border-radius: 8px;
                border: 1px solid #e0e0e0;
            }

            .no-jobs i {
                font-size: 4rem;
                color: #bdc3c7;
                margin-bottom: 20px;
            }

            .no-jobs h3 {
                font-size: 1.5rem;
                color: #2c3e50;
                margin-bottom: 10px;
            }

            .no-jobs p {
                color: #7f8c8d;
                font-size: 1rem;
            }

            .pagination-wrapper {
                background: white;
                padding: 20px;
                border-radius: 8px;
                border: 1px solid #e0e0e0;
                margin-top: 20px;
            }

            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                flex-wrap: wrap;
            }

            .pagination a, .pagination span {
                padding: 8px 12px;
                border-radius: 4px;
                text-decoration: none;
                font-weight: 500;
                min-width: 40px;
                text-align: center;
                transition: all 0.3s ease;
            }

            .pagination a {
                background: #f8f9fa;
                color: #2c3e50;
                border: 1px solid #e0e0e0;
            }

            .pagination a:hover {
                background: #00c853;
                color: white;
            }

            .pagination .current-page {
                background: #00c853;
                color: white;
            }

            .page-size-control {
                display: flex;
                align-items: center;
                gap: 8px;
                margin-left: 20px;
                padding-left: 20px;
                border-left: 1px solid #e0e0e0;
            }

            .page-size-control input {
                width: 60px;
                padding: 6px 8px;
                border: 1px solid #e0e0e0;
                border-radius: 4px;
                text-align: center;
            }

            .page-size-control button {
                padding: 6px 12px;
                background: #00c853;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
            }

            .page-size-control button:hover {
                background: #00a63f;
            }

            .status-badge {
                display: inline-block;
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 0.8rem;
                font-weight: 500;
                text-transform: uppercase;
            }

            .status-visible {
                background: #e8f5e8;
                color: #2e7d32;
            }

            .status-hidden {
                background: #f8d7da;
                color: #721c24;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .container {
                    padding: 80px 15px 15px;
                }

                .job-info {
                    grid-template-columns: 1fr;
                }

                .job-actions {
                    flex-direction: column;
                }

                .pagination {
                    flex-direction: column;
                    gap: 15px;
                }

                .page-size-control {
                    margin-left: 0;
                    padding-left: 0;
                    border-left: none;
                    border-top: 1px solid #e0e0e0;
                    padding-top: 15px;
                }
            }

            @media (max-width: 480px) {
                .job-title {
                    font-size: 1.3rem;
                }

                .job-card {
                    padding: 16px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1><i class="fas fa-briefcase"></i> Danh sách tin tuyển dụng</h1>
                <p>Quản lý tất cả tin tuyển dụng của bạn</p>
            </div>

            <%
                List<JobPost> jobList = (List<JobPost>) request.getAttribute("jobList");
                if (jobList != null && !jobList.isEmpty()) {
            %>
            <div class="job-list">
                <%
                    for (JobPost job : jobList) {
                %>
                <div class="job-card">
                    <div class="job-header">
                        <div class="job-title">
                            <i class="fas fa-briefcase"></i>
                            <a href="${pageContext.request.contextPath}/cv-list?jobPostId=<%= job.getJobPost_ID() %>" style="color: white; text-decoration: underline;">
                                <%= job.getTitle() %>
                            </a>
                        </div>


                        <div class="job-item-position">

                            <div class="job-position">
                                >>>>>>> b7aaaaddf37a469d9faf74f33f90c10c8c2134b2
                                <%= job.getPosition() %>
                            </div>
                        </div>

                        <div class="job-info">
                            <div class="info-item">
                                <i class="fas fa-building info-icon"></i>
                                <div class="info-content">
                                    <div class="info-label">Công ty</div>
                                    <div class="info-value"><%= job.getEmployer().getCompanyName() %></div>
                                </div>
                            </div>

                            <div class="info-item">
                                <i class="fas fa-sitemap info-icon"></i>
                                <div class="info-content">
                                    <div class="info-label">Ngành nghề</div>
                                    <div class="info-value"><%= job.getCategory() %></div>
                                </div>
                            </div>

                            <div class="info-item">
                                <i class="fas fa-map-marker-alt info-icon"></i>
                                <div class="info-content">
                                    <div class="info-label">Địa điểm</div>
                                    <div class="info-value"><%= job.getLocation() %></div>
                                </div>
                            </div>

                            <div class="info-item">
                                <i class="fas fa-money-bill-wave info-icon"></i>
                                <div class="info-content">
                                    <div class="info-label">Mức lương</div>
                                    <div class="info-value"><%= job.getOffer_Min() %> - <%= job.getOffer_Max() %></div>
                                </div>
                            </div>

                            <div class="info-item">
                                <i class="fas fa-hourglass info-icon"></i>
                                <div class="info-content">
                                    <div class="info-label">Kinh nghiệm</div>
                                    <div class="info-value"><%= job.getNumber_exp() %> năm</div>
                                </div>
                            </div>

                            <div class="info-item">
                                <i class="fas fa-calendar-alt info-icon"></i>
                                <div class="info-content">
                                    <div class="info-label">Ngày đăng</div>
                                    <div class="info-value"><%= job.getDayCre() %></div>
                                </div>
                            </div>

                            <div class="info-item">
                                <i class="fas fa-globe info-icon"></i>
                                <div class="info-content">
                                    <div class="info-label">Website công ty</div>
                                    <div class="info-value">
                                        <a href="<%= job.getEmployer().getUrlWebsite() %>" target="_blank">
                                            <%= job.getEmployer().getUrlWebsite() %>
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="info-item">
                                <i class="fas fa-users info-icon"></i>
                                <div class="info-content">
                                    <div class="info-label">Quy mô công ty</div>
                                    <div class="info-value"><%= job.getEmployer().getCompanySize() %></div>
                                </div>
                            </div>

                            <div class="info-item">
                                <i class="fas fa-envelope info-icon"></i>
                                <div class="info-content">
                                    <div class="info-label">Email công ty</div>
                                    <div class="info-value">
                                        <a href="mailto:<%= job.getEmployer().getEmail() %>"><%= job.getEmployer().getEmail() %></a>
                                    </div>
                                </div>
                            </div>

                            <div class="info-item">
                                <i class="fas fa-eye info-icon"></i>
                                <div class="info-content">
                                    <div class="info-label">Trạng thái</div>
                                    <div class="info-value">
                                        <span class="status-badge <%= job.isVisible() ? "status-visible" : "status-hidden" %>">
                                            <%= job.isVisible() ? "Hiển thị" : "Ẩn" %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="job-actions">
                            <form method="post" action="manageCreatedJob">
                                <input type="hidden" name="action" value="edit" />
                                <input type="hidden" name="jobId" value="<%= job.getJobPost_ID() %>" />
                                <button type="submit" class="btn btn-edit">
                                    <i class="fas fa-edit"></i> Chỉnh sửa
                                </button>
                            </form>
                            <form method="post" action="manageCreatedJob" onsubmit="return confirm('Bạn có chắc chắn muốn xóa tin này?');">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="jobId" value="<%= job.getJobPost_ID() %>" />
                                <button type="submit" class="btn btn-delete">
                                    <i class="fas fa-trash"></i> Xóa
                                </button>
                            </form>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>

                <% 
                    Integer currentPage = (Integer) request.getAttribute("currentPage");
                    Integer totalPages = (Integer) request.getAttribute("totalPages");
                    Integer pageSize = (Integer) session.getAttribute("pageSize");
                    if (totalPages != null) {
                %>
                <div class="pagination-wrapper">
                    <div class="pagination">
                        <% for (int i = 1; i <= totalPages; i++) { %>
                        <% if (i == currentPage) { %>

                        <span class="job-current-page"><%= i %></span>

                        <span class="current-page"><%= i %></span>

                        <% } else { %>
                        <a href="manageCreatedJob?page=<%= i %>"><%= i %></a>
                        <% } %>
                        <% } %>


                        <div class="job-page-size-control">

                            <div class="page-size-control">

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
                    <div class="no-jobs">
                        <i class="fas fa-briefcase"></i>
                        <h3>Chưa có tin tuyển dụng</h3>
                        <p>Không có tin tuyển dụng nào được tìm thấy. Hãy tạo tin tuyển dụng đầu tiên của bạn!</p>
                    </div>
                    <% } %>
                </div>
                </body>
                </html>