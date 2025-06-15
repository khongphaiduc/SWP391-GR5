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
                font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #f8fcf9 0%, #f0f7f2 100%);
                min-height: 100vh;
                color: #2d3748;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .header {
                text-align: center;
                margin-bottom: 40px;
                padding: 40px 20px;
                background: white;
                border-radius: 20px;
                box-shadow: 0 4px 25px rgba(34, 139, 34, 0.08);
                border: 1px solid rgba(34, 139, 34, 0.1);
            }

            .header h2 {
                font-size: 2.5em;
                font-weight: 700;
                background: linear-gradient(135deg, #228b22 0%, #32cd32 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 12px;
            }

            .header p {
                font-size: 1.1em;
                color: #718096;
                font-weight: 400;
            }

            .cards-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
                gap: 25px;
                margin-bottom: 30px;
            }

            .apply-card {
                background: white;
                border-radius: 16px;
                padding: 28px;
                box-shadow: 0 6px 30px rgba(34, 139, 34, 0.08);
                border: 1px solid rgba(34, 139, 34, 0.12);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                position: relative;
                overflow: hidden;
            }

            .apply-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, #228b22, #32cd32);
                transform: scaleX(0);
                transition: transform 0.3s ease;
            }

            .apply-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 12px 40px rgba(34, 139, 34, 0.15);
                border-color: rgba(34, 139, 34, 0.2);
            }

            .apply-card:hover::before {
                transform: scaleX(1);
            }

            .card-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 20px;
            }

            .apply-id {
                background: linear-gradient(135deg, #f0fff0 0%, #c8e6c8 100%);
                color: #2d5a2d;
                padding: 8px 16px;
                border-radius: 25px;
                font-size: 0.85em;
                font-weight: 600;
                letter-spacing: 0.5px;
            }

            .job-title {
                font-size: 1.4em;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 8px;
                line-height: 1.3;
            }

            .job-position {
                color: #4a5568;
                font-size: 1em;
                font-weight: 500;
                margin-bottom: 20px;
                padding: 6px 12px;
                background: #f7fafc;
                border-radius: 8px;
                display: inline-block;
            }

            .card-info {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-bottom: 24px;
            }

            .info-item {
                display: flex;
                flex-direction: column;
            }

            .info-label {
                font-size: 0.85em;
                color: #718096;
                font-weight: 500;
                margin-bottom: 6px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .info-value {
                font-size: 1em;
                font-weight: 600;
                color: #2d3748;
            }

            .salary {
                color: #228b22;
                font-size: 1.1em;
                font-weight: 700;
            }

            .status {
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 0.85em;
                font-weight: 600;
                text-transform: capitalize;
                text-align: center;
                border: 2px solid;
            }

            .status.pending {
                background: #fef5e7;
                color: #dd6b20;
                border-color: #fbd38d;
            }

            .status.approved {
                background: #f0fff4;
                color: #38a169;
                border-color: #9ae6b4;
            }

            .status.rejected {
                background: #fed7d7;
                color: #e53e3e;
                border-color: #feb2b2;
            }

            .step-badge {
                background: linear-gradient(135deg, #32cd32 0%, #228b22 100%);
                color: white;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 0.85em;
                font-weight: 600;
                text-align: center;
                box-shadow: 0 4px 12px rgba(34, 139, 34, 0.3);
            }

            .card-actions {
                display: flex;
                justify-content: flex-end;
                margin-top: 24px;
                padding-top: 20px;
                border-top: 1px solid #e2e8f0;
            }

            .cancel-btn {
                background: linear-gradient(135deg, #fed7d7 0%, #feb2b2 100%);
                color: #c53030;
                border: 2px solid #fed7d7;
                padding: 12px 24px;
                border-radius: 25px;
                cursor: pointer;
                font-size: 0.9em;
                font-weight: 600;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .cancel-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
                transition: left 0.5s;
            }

            .cancel-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(197, 48, 48, 0.2);
                background: linear-gradient(135deg, #feb2b2 0%, #fc8181 100%);
                border-color: #feb2b2;
            }

            .cancel-btn:hover::before {
                left: 100%;
            }

            .cancel-btn:active {
                transform: translateY(0);
            }

            .no-data {
                grid-column: 1 / -1;
                text-align: center;
                padding: 60px 40px;
                background: white;
                border-radius: 20px;
                border: 2px dashed #cbd5e0;
                color: #718096;
            }

            .no-data-icon {
                font-size: 4em;
                margin-bottom: 20px;
                opacity: 0.6;
            }

            .no-data-text {
                font-size: 1.2em;
                font-weight: 500;
                margin-bottom: 8px;
            }

            .no-data-subtext {
                font-size: 1em;
                opacity: 0.8;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 0 10px;
                }

                .cards-grid {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }

                .apply-card {
                    padding: 24px;
                }

                .header {
                    padding: 30px 20px;
                    margin-bottom: 30px;
                }

                .header h2 {
                    font-size: 2em;
                }

                .card-info {
                    grid-template-columns: 1fr;
                    gap: 16px;
                }

                .job-title {
                    font-size: 1.2em;
                }
            }

            @media (max-width: 480px) {
                body {
                    padding: 15px;
                }

                .apply-card {
                    padding: 20px;
                }

                .header h2 {
                    font-size: 1.8em;
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
                        <div class="apply-id">#<%= a.getApply_ID() %></div>
                    </div>
                    <div class="job-title">
                        <a href="${pageContext.request.contextPath}/detailJob?postId=<%= a.getJobPost_ID() %>"><%= a.getJobTitle() %></a>
                    </div>
                    <div class="job-position"><%= a.getJobPosition() %></div>

                    <div class="card-info">
                        <div class="info-item">
                            <div class="info-label">Mức lương</div>
                            <div class="info-value salary"><%= a.getOfferMin() %> - <%= a.getOfferMax() %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Trạng thái</div>
                            <div class="status <%= a.getStatus().toLowerCase() %>">
                                <%= a.getStatus() %>
                            </div>
                        </div>
                    </div>

                    <div class="card-info">
                        <div class="info-item">
                            <div class="info-label">Bước hiện tại</div>
                            <div class="step-badge">
                                <%= a.getStep() %>
                            </div>
                        </div>
                        <div class="info-item">
                            <!-- Placeholder for balance -->
                        </div>
                    </div>

                    <div class="card-actions">
                        <form action="<%= request.getContextPath() %>/CandidateApplyList" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn hủy Apply này không?');" style="margin: 0;">
                            <input type="hidden" name="applyID" value="<%= a.getApply_ID() %>"/>
                            <button type="submit" class="cancel-btn">Hủy Apply</button>
                        </form>
                    </div>
                </div>
                <% 
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer pageSize = (Integer) session.getAttribute("pageSize");
    if (totalPages != null ) {
                %>
                <div class="cv-pagination-wrapper">
                    <div class="cv-pagination">
                        <% for (int i = 1; i <= totalPages; i++) { %>
                        <% if (i == currentPage) { %>
                        <span class="cv-current-page"><%= i %></span>
                        <% } else { %>
                        <a href="CandidateApplyList?page=<%= i %>"><%= i %></a>
                        <% } %>
                        <% } %>

                        <div class="cv-page-size-control">
                            <span>Hiển thị:</span>
                            <form action="CandidateApplyList" style="display: flex; align-items: center; gap: 8px;">
                                <input type="number" name="pageSize" value="<%=pageSize%>" min="1" max="20">
                                <button type="submit">OK</button>
                            </form>
                        </div>
                    </div>
                </div>
                <% }} } else { %>
                <div class="no-data">
                    <div class="no-data-icon">🔍</div>
                    <div class="no-data-text">Chưa có Apply nào</div>
                    <div class="no-data-subtext">Hãy tìm kiếm và ứng tuyển các công việc phù hợp với bạn!</div>
                </div>
                <% } %>
            </div>
        </div>
    </body>
</html>