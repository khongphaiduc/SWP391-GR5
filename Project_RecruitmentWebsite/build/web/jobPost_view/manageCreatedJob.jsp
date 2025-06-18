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
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                background-color: #f4f4f4;
                min-height: 100vh;
                padding: 0;
            }

            .job-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
                padding-top: 70px; /* Adjust for sticky navbar height */
            }

            .job-header-section {
                text-align: center;
                margin: 40px 0;
                color: #2e4f4f;
            }

            .job-header-section h1 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 10px;
                text-shadow: 0 2px 4px rgba(0,0,0,0.1);
                text-transform: uppercase;
            }

            .job-header-section p {
                font-size: 1.1rem;
                opacity: 0.9;
                font-weight: 300;
            }

            .job-list-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                gap: 24px;
                margin-bottom: 40px;
            }

            .job-item-card {
                background: white;
                border-radius: 16px;
                box-shadow: 0 4px 16px rgba(46, 79, 79, 0.08);
                overflow: hidden;
                transition: all 0.3s ease;
                border: 1px solid rgba(46, 79, 79, 0.1);
            }

            .job-item-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 8px 32px rgba(46, 79, 79, 0.15);
                border-color: rgba(46, 79, 79, 0.2);
            }

            .job-item-header {
                background: linear-gradient(135deg, #2e4f4f 0%, #1a3c3c 100%);
                padding: 20px;
                color: white;
                position: relative;
            }

            .job-item-header::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, #2e4f4f, #1a3c3c);
            }

            .job-item-title {
                font-size: 1.4rem;
                font-weight: 600;
                margin-bottom: 8px;
                display: flex;
                align-items: center;
                gap: 8px;
                text-transform: uppercase;
            }

            .job-item-position {
                font-size: 1rem;
                opacity: 0.9;
                font-weight: 400;
            }

            .job-item-body {
                padding: 24px;
            }

            .job-info-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 16px;
                margin-bottom: 24px;
            }

            .job-info-item {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 12px;
                background: #f8f9fa;
                border-radius: 8px;
                border-left: 4px solid #2e4f4f;
            }

            .job-info-icon {
                width: 36px;
                height: 36px;
                background: linear-gradient(135deg, #2e4f4f, #1a3c3c);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 14px;
                flex-shrink: 0;
            }

            .job-info-content {
                flex: 1;
            }

            .job-info-label {
                font-size: 0.75rem;
                color: #666;
                text-transform: uppercase;
                font-weight: 500;
                letter-spacing: 0.5px;
                margin-bottom: 2px;
            }

            .job-info-value {
                font-size: 0.9rem;
                color: #333;
                font-weight: 500;
            }

            .job-item-actions {
                display: flex;
                gap: 12px;
                padding-top: 20px;
                border-top: 1px solid #eee;
            }

            .job-item-actions form {
                flex: 1;
                margin: 0;
            }

            .job-btn {
                width: 100%;
                padding: 12px 16px;
                border-radius: 8px;
                font-weight: 600;
                text-decoration: none;
                text-align: center;
                transition: all 0.3s ease;
                font-size: 0.9rem;
                border: none;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 6px;
                box-sizing: border-box;
            }

            .job-btn-edit {
                background: linear-gradient(135deg, #2e4f4f, #1a3c3c);
                color: white;
            }

            .job-btn-edit:hover {
                background: linear-gradient(135deg, #1a3c3c, #143333);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(46, 79, 79, 0.3);
            }

            .job-btn-delete {
                background: linear-gradient(135deg, #ff6b6b, #e53e3e);
                color: white;
            }

            .job-btn-delete:hover {
                background: linear-gradient(135deg, #ff5252, #d32f2f);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(255, 107, 107, 0.3);
            }

            .job-no-results {
                text-align: center;
                background: white;
                padding: 60px 40px;
                border-radius: 16px;
                box-shadow: 0 4px 16px rgba(46, 79, 79, 0.08);
                border: 1px solid rgba(46, 79, 79, 0.1);
                margin: 0 auto;
                max-width: 600px;
            }

            .job-no-results i {
                font-size: 4rem;
                color: #2e4f4f;
                margin-bottom: 20px;
                display: block;
            }

            .job-no-results h3 {
                font-size: 1.5rem;
                color: #333;
                margin-bottom: 10px;
                font-weight: 600;
                text-transform: uppercase;
            }

            .job-no-results p {
                color: #666;
                font-size: 1rem;
            }

            .job-pagination-wrapper {
                background: white;
                padding: 24px;
                border-radius: 16px;
                box-shadow: 0 4px 16px rgba(46, 79, 79, 0.08);
                margin-top: 30px;
                border: 1px solid rgba(46, 79, 79, 0.1);
            }

            .job-pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 12px;
                flex-wrap: wrap;
            }

            .job-pagination a, .job-pagination span {
                padding: 10px 16px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
                min-width: 44px;
                text-align: center;
            }

            .job-pagination a {
                background: #f8f9fa;
                color: #333;
                border: 1px solid #e9ecef;
            }

            .job-pagination a:hover {
                background: #2e4f4f;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(46, 79, 79, 0.2);
            }

            .job-pagination .job-current-page {
                background: linear-gradient(135deg, #2e4f4f, #1a3c3c);
                color: white;
                box-shadow: 0 4px 12px rgba(46, 79, 79, 0.3);
            }

            .job-page-size-control {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-left: 20px;
                padding-left: 20px;
                border-left: 2px solid #e9ecef;
            }

            .job-page-size-control input {
                width: 60px;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 6px;
                text-align: center;
                font-weight: 500;
            }

            .job-page-size-control button {
                padding: 8px 16px;
                background: linear-gradient(135deg, #2e4f4f, #1a3c3c);
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .job-page-size-control button:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(46, 79, 79, 0.3);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .job-container {
                    padding: 0 15px;
                }

                .job-header-section h1 {
                    font-size: 2rem;
                }

                .job-list-grid {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }

                .job-info-grid {
                    grid-template-columns: 1fr;
                    gap: 12px;
                }

                .job-item-actions {
                    flex-direction: column;
                }

                .job-btn {
                    padding: 14px 16px;
                }

                .job-pagination {
                    flex-direction: column;
                    gap: 16px;
                }

                .job-page-size-control {
                    margin-left: 0;
                    padding-left: 0;
                    border-left: none;
                    border-top: 2px solid #e9ecef;
                    padding-top: 16px;
                }
            }

            @media (max-width: 480px) {
                .job-item-header {
                    padding: 16px;
                }

                .job-item-title {
                    font-size: 1.2rem;
                    text-align: center;
                }

                .job-item-position {
                    text-align: center;
                }
            }
        </style>
    </head>
    <body>
        <div class="job-container">
            <div class="job-header-section">
                <h1><i class="fas fa-briefcase"></i> DANH SÁCH TIN TUYỂN DỤNG</h1>
                <p>Danh sách tất cả tin tuyển dụng của bạn</p>
            </div>

            <%
                List<JobPost> jobList = (List<JobPost>) request.getAttribute("jobList");
                if (jobList != null && !jobList.isEmpty()) {
            %>
            <div class="job-list-grid">
                <%
                    for (JobPost job : jobList) {
                %>
                <div class="job-item-card">
                    <div class="job-item-header">
                        <div class="job-item-title">
                            <i class="fas fa-briefcase"></i>
                            <a href="${pageContext.request.contextPath}/cv-list?jobPostId=<%= job.getJobPost_ID() %>" style="color: white; text-decoration: underline;">
                                <%= job.getTitle() %>
                            </a>
                        </div>

                        <div class="job-item-position">
                            <%= job.getPosition() %>
                        </div>
                    </div>
                    <div class="job-item-body">
                        <div class="job-info-grid">
                            <div class="job-info-item">
                                <div class="job-info-icon">
                                    <i class="fas fa-building"></i>
                                </div>
                                <div class="job-info-content">
                                    <div class="job-info-label">Công ty</div>
                                    <div class="job-info-value"><%= job.getCompapy() %></div>
                                </div>
                            </div>
                            <div class="job-info-item">
                                <div class="job-info-icon">
                                    <i class="fas fa-sitemap"></i>
                                </div>
                                <div class="job-info-content">
                                    <div class="job-info-label">Ngành nghề</div>
                                    <div class="job-info-value"><%= job.getCategory() %></div>
                                </div>
                            </div>
                            <div class="job-info-item">
                                <div class="job-info-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div class="job-info-content">
                                    <div class="job-info-label">Địa điểm</div>
                                    <div class="job-info-value"><%= job.getLocation() %></div>
                                </div>
                            </div>
                            <div class="job-info-item">
                                <div class="job-info-icon">
                                    <i class="fas fa-money-bill-wave"></i>
                                </div>
                                <div class="job-info-content">
                                    <div class="job-info-label">Mức lương</div>
                                    <div class="job-info-value"><%= job.getOffer_Min() %> - <%= job.getOffer_Max() %></div>
                                </div>
                            </div>
                            <div class="job-info-item">
                                <div class="job-info-icon">
                                    <i class="fas fa-hourglass"></i>
                                </div>
                                <div class="job-info-content">
                                    <div class="job-info-label">Kinh nghiệm</div>
                                    <div class="job-info-value"><%= job.getNumber_exp() %> năm</div>
                                </div>
                            </div>
                            <div class="job-info-item">
                                <div class="job-info-icon">
                                    <i class="fas fa-eye"></i>
                                </div>
                                <div class="job-info-content">
                                    <div class="job-info-label">Trạng thái</div>
                                    <div class="job-info-value"><%= job.isVisible() ? "Hiển thị" : "Ẩn" %></div>
                                </div>
                            </div>
                        </div>
                        <div class="job-item-actions">
                            <form method="post" action="manageCreatedJob" style="flex: 1; margin: 0;">
                                <input type="hidden" name="action" value="edit" />
                                <input type="hidden" name="jobId" value="<%= job.getJobPost_ID() %>" />
                                <button type="submit" class="job-btn job-btn-edit">
                                    <i class="fas fa-edit"></i> Chỉnh sửa
                                </button>
                            </form>
                            <form method="post" action="manageCreatedJob" style="flex: 1; margin: 0;" onsubmit="return confirm('Bạn có chắc chắn muốn xóa tin này?');">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="jobId" value="<%= job.getJobPost_ID() %>" />
                                <button type="submit" class="job-btn job-btn-delete">
                                    <i class="fas fa-trash"></i> Xóa
                                </button>
                            </form>
                        </div>
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
            <div class="job-no-results">
                <i class="fas fa-briefcase"></i>
                <h3>CHƯA CÓ TIN TUYỂN DỤNG</h3>
                <p>Không có tin tuyển dụng nào được tìm thấy. Hãy tạo tin tuyển dụng đầu tiên của bạn!</p>
            </div>
            <% } %>
        </div>
    </body>
</html>