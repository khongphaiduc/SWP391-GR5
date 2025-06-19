<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.Apply" %>
<%@ page import="java.util.List" %>
<html>
    <head>
        <jsp:include page="/navbar.jsp" />

        <title>Danh sách Apply</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f0f8f0;
                color: #333;
                line-height: 1.6;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .header {
                text-align: center;
                margin-bottom: 30px;
                padding: 30px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .header h2 {
                font-size: 2.2em;
                color: #2d5a2d;
                margin-bottom: 10px;
            }

            .header p {
                font-size: 1.1em;
                color: #666;
            }

            .cards-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .apply-card {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                border-left: 4px solid #4CAF50;
                transition: transform 0.2s ease;
            }

            .apply-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            }

            .card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }

            .apply-id {
                background: #e8f5e8;
                color: #2d5a2d;
                padding: 8px 15px;
                border-radius: 20px;
                font-size: 0.9em;
                font-weight: bold;
            }

            .job-title {
                font-size: 1.3em;
                font-weight: bold;
                color: #2d5a2d;
                margin-bottom: 8px;
            }

            .job-title a {
                color: #2d5a2d;
                text-decoration: none;
            }

            .job-title a:hover {
                color: #4CAF50;
            }

            .job-position {
                color: #666;
                font-size: 1em;
                margin-bottom: 20px;
                padding: 5px 10px;
                background: #f9f9f9;
                border-radius: 5px;
                display: inline-block;
            }

            .card-info {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
                margin-bottom: 20px;
            }

            .info-item {
                display: flex;
                flex-direction: column;
            }

            .info-label {
                font-size: 0.9em;
                color: #888;
                font-weight: bold;
                margin-bottom: 5px;
            }

            .info-value {
                font-size: 1em;
                font-weight: bold;
                color: #333;
            }

            .salary {
                color: #4CAF50;
                font-size: 1.1em;
            }

            .status {
                padding: 6px 12px;
                border-radius: 15px;
                font-size: 0.9em;
                font-weight: bold;
                text-align: center;
            }

            .status.pending {
                background: #fff3cd;
                color: #856404;
            }

            .status.approved {
                background: #d4edda;
                color: #155724;
            }

            .status.rejected {
                background: #f8d7da;
                color: #721c24;
            }

            .step-badge {
                background: #4CAF50;
                color: white;
                padding: 8px 15px;
                border-radius: 15px;
                font-size: 0.9em;
                font-weight: bold;
                text-align: center;
            }

            .card-actions {
                display: flex;
                justify-content: flex-end;
                margin-top: 20px;
                padding-top: 15px;
                border-top: 1px solid #eee;
            }

            .cancel-btn {
                background: #dc3545;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 0.9em;
                font-weight: bold;
                transition: background 0.2s ease;
            }

            .cancel-btn:hover {
                background: #c82333;
            }

            .no-data {
                grid-column: 1 / -1;
                text-align: center;
                padding: 50px;
                background: white;
                border-radius: 10px;
                border: 2px dashed #ddd;
                color: #666;
            }

            .no-data-icon {
                font-size: 3em;
                margin-bottom: 15px;
            }

            .no-data-text {
                font-size: 1.2em;
                font-weight: bold;
                margin-bottom: 8px;
            }

            .no-data-subtext {
                font-size: 1em;
            }

            .cv-pagination-wrapper {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-top: 30px;
            }

            .cv-pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .cv-pagination a, .cv-pagination span {
                padding: 8px 12px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
                min-width: 40px;
                text-align: center;
            }

            .cv-pagination a {
                background: #f8f9fa;
                color: #333;
                border: 1px solid #ddd;
            }

            .cv-pagination a:hover {
                background: #4CAF50;
                color: white;
            }

            .cv-pagination .cv-current-page {
                background: #4CAF50;
                color: white;
            }

            .cv-page-size-control {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-left: 20px;
                padding-left: 20px;
                border-left: 2px solid #ddd;
            }

            .cv-page-size-control input {
                width: 60px;
                padding: 5px 8px;
                border: 1px solid #ddd;
                border-radius: 3px;
                text-align: center;
            }

            .cv-page-size-control button {
                padding: 5px 15px;
                background: #4CAF50;
                color: white;
                border: none;
                border-radius: 3px;
                font-weight: bold;
                cursor: pointer;
            }

            .cv-page-size-control button:hover {
                background: #45a049;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .container {
                    padding: 10px;
                }

                .cards-grid {
                    grid-template-columns: 1fr;
                    gap: 15px;
                }

                .apply-card {
                    padding: 20px;
                }

                .header {
                    padding: 20px;
                    margin-bottom: 20px;
                }

                .header h2 {
                    font-size: 1.8em;
                }

                .card-info {
                    grid-template-columns: 1fr;
                    gap: 10px;
                }

                .cv-page-size-control {
                    margin-left: 0;
                    padding-left: 0;
                    border-left: none;
                    border-top: 2px solid #ddd;
                    padding-top: 15px;
                    margin-top: 15px;
                }
            }

            @media (max-width: 480px) {
                .apply-card {
                    padding: 15px;
                }

                .header h2 {
                    font-size: 1.6em;
                }

                .card-header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h2>Danh sách Apply của bạn</h2>
                <p>Theo dõi trạng thái các ứng tuyển một cách dễ dàng</p>
            </div>

            <div class="cards-grid">
                <%
                    List<Apply> applies = (List<Apply>) request.getAttribute("applies");
                    if (applies != null && !applies.isEmpty()) {
                        for (Apply a : applies) {
                %>
                <div class="apply-card">
                    <div class="card-header">
                        <div class="apply-id">Mã Apply: #<%= a.getApply_ID() %></div>
                    </div>

                    <!-- Tên công việc và vị trí -->
                    <div class="job-title">
                        <a href="<%=request.getContextPath()%>/detailJob?postId=<%= a.getJobPost_ID() %>">
                            <%= a.getJobTitle() %>
                        </a>
                    </div>
                    <div class="job-position"><%= a.getJobPosition() %></div>



                    <!-- Mức lương + Trạng thái -->
                    <div class="card-info">
                        <div class="info-item">
                            <div class="info-label">Mức lương</div>
                            <div class="info-value salary"><%= a.getOfferMin() %> - <%= a.getOfferMax() %> triệu</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Trạng thái</div>
                            <div class="status <%= a.getStatus().toLowerCase() %>">
                                <%= a.getStatus() %>
                            </div>
                        </div>
                    </div>

                    <!-- Bước xử lý -->
                    <div class="card-info">
                        <div class="info-item">
                            <div class="info-label">Bước hiện tại</div>
                            <div class="step-badge"><%= a.getStep() %></div>
                        </div>
                    </div>

                    <!-- Hành động -->
                    <div class="card-actions">
                        <form action="<%= request.getContextPath() %>/CandidateApplyList" method="post" 
                              onsubmit="return confirm('Bạn có chắc chắn muốn hủy Apply này không?');">
                            <input type="hidden" name="applyID" value="<%= a.getApply_ID() %>"/>
                            <button type="submit" class="cancel-btn">Hủy Apply</button>
                        </form>
                    </div>
                </div>
                <%
                        } // end for
                %>

               
                <%
                    } else { // Nếu không có apply nào
                %>
                <div class="no-data">
                    <div class="no-data-icon">🔍</div>
                    <div class="no-data-text">Chưa có Apply nào</div>
                    <div class="no-data-subtext">Hãy tìm kiếm và ứng tuyển các công việc phù hợp với bạn!</div>
                </div>
                <% } %>
            </div>
             <!-- Phân trang -->
                <div class="cv-pagination-wrapper">
                    <div class="cv-pagination">
                        <% 
                            Integer currentPage = (Integer) request.getAttribute("currentPage");
                            Integer totalPages = (Integer) request.getAttribute("totalPages");
                            Integer pageSize = (Integer) session.getAttribute("pageSize");

                            if (totalPages != null) {
                                for (int i = 1; i <= totalPages; i++) {
                                    if (i == currentPage) {
                        %>
                        <span class="cv-current-page"><%= i %></span>
                        <%      } else { %>
                        <a href="CandidateApplyList?page=<%= i %>"><%= i %></a>
                        <%      }
                                } // end for
                        %>

                        <!-- Chọn số dòng/trang -->
                        <div class="cv-page-size-control">
                            <span>Hiển thị:</span>
                            <form action="CandidateApplyList" method="get" style="display: flex; align-items: center; gap: 8px;">
                                <input type="number" name="pageSize" value="<%= (pageSize != null ? pageSize : 5) %>" min="1" max="20">
                                <button type="submit">OK</button>
                            </form>
                        </div>
                        <% } %>
                    </div>
                </div>
        </div>
    </body>

</html>