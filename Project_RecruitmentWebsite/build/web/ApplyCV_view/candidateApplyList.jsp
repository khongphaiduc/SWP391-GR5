<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.Apply" %>
<%@ page import="java.util.*" %>
<%@ page import="MyService.*" %>
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
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8fdf8;
                color: #333;
                line-height: 1.5;
            }

            .container {
                max-width: 1100px;
                margin: 0 auto;
                padding: 15px;
            }

            .header {
                text-align: center;
                margin-bottom: 25px;
                padding: 20px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 1px 4px rgba(0,0,0,0.1);
            }

            .header h2 {
                font-size: 1.8em;
                color: #2d5a2d;
                margin-bottom: 5px;
                font-weight: 600;
            }

            .header p {
                color: #666;
                font-size: 0.95em;
            }

            /* New Filter Bar Styles */
            .filter-bar {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                margin-bottom: 25px;
                border: 1px solid #e8f5e8;
            }

            .filter-container {
                display: flex;
                align-items: flex-end;
                gap: 15px;
                flex-wrap: wrap;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
                min-width: 150px;
                flex: 1;
            }

            .filter-group.search-group {
                flex: 2;
                min-width: 250px;
            }

            .filter-label {
                display: flex;
                align-items: center;
                gap: 6px;
                margin-bottom: 8px;
                font-weight: 600;
                color: #2d5a2d;
                font-size: 0.9em;
            }

            .filter-label i {
                font-size: 1em;
                color: #4CAF50;
            }

            .filter-select,
            .filter-input {
                padding: 10px 12px;
                border: 2px solid #e8f5e8;
                border-radius: 8px;
                font-size: 0.95em;
                background: white;
                transition: all 0.3s ease;
                appearance: none;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
                background-position: right 10px center;
                background-repeat: no-repeat;
                background-size: 16px;
                padding-right: 40px;
            }

            .filter-input {
                background-image: none;
                padding-right: 12px;
            }

            .filter-select:focus,
            .filter-input:focus {
                outline: none;
                border-color: #4CAF50;
                box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
            }

            .filter-select:hover,
            .filter-input:hover {
                border-color: #4CAF50;
            }

            .search-button {
                background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                color: white;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 0.95em;
                box-shadow: 0 2px 4px rgba(76, 175, 80, 0.2);
            }

            .search-button:hover {
                background: linear-gradient(135deg, #45a049 0%, #4CAF50 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(76, 175, 80, 0.3);
            }

            .cards-grid {
                display: flex;
                flex-direction: column;
                gap: 10px;
                margin-bottom: 25px;
            }

            .apply-card {
                background: white;
                border-radius: 8px;
                padding: 15px;
                box-shadow: 0 1px 4px rgba(0,0,0,0.1);
                border-left: 3px solid #4CAF50;
                transition: box-shadow 0.2s ease;
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .apply-card:hover {
                box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            }

            .apply-id {
                background: #e8f5e8;
                color: #2d5a2d;
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 0.75em;
                font-weight: 500;
                white-space: nowrap;
                min-width: 80px;
                text-align: center;
            }

            .job-info {
                flex: 1;
                min-width: 0;
            }

            .job-title {
                font-size: 1em;
                font-weight: 600;
                color: #2d5a2d;
                margin-bottom: 2px;
            }

            .job-title a {
                color: inherit;
                text-decoration: none;
            }

            .job-title a:hover {
                color: #4CAF50;
            }

            .job-position {
                color: #666;
                font-size: 0.85em;
                background: #f9f9f9;
                padding: 2px 6px;
                border-radius: 4px;
                display: inline-block;
            }

            .salary-info {
                color: #4CAF50;
                font-weight: 600;
                font-size: 0.9em;
                white-space: nowrap;
                min-width: 120px;
                text-align: center;
            }

            .status {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 0.75em;
                font-weight: 500;
                text-align: center;
                white-space: nowrap;
                min-width: 70px;
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

            .step-process {
                display: flex;
                align-items: center;
                gap: 6px;
                min-width: 200px;
            }

            .step-item {
                display: flex;
                align-items: center;
                gap: 3px;
                font-size: 0.7em;
                font-weight: 500;
                white-space: nowrap;
            }

            .step-dot {
                width: 8px;
                height: 8px;
                border-radius: 50%;
                background: #ddd;
                flex-shrink: 0;
            }

            .step-dot.active {
                background: #4CAF50;
            }

            .step-dot.completed {
                background: #28a745;
            }

            .step-line {
                width: 12px;
                height: 1px;
                background: #ddd;
            }

            .step-line.completed {
                background: #28a745;
            }

            .step-text {
                color: #888;
            }

            .step-text.active {
                color: #4CAF50;
                font-weight: 600;
            }

            .step-text.completed {
                color: #28a745;
            }

            .card-actions {
                min-width: 80px;
            }

            .cancel-btn {
                background: #dc3545;
                color: white;
                border: none;
                padding: 6px 12px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 0.8em;
                font-weight: 500;
                transition: background 0.2s ease;
            }

            .cancel-btn:hover {
                background: #c82333;
            }

            .no-data {
                grid-column: 1 / -1;
                text-align: center;
                padding: 40px 20px;
                background: white;
                border-radius: 8px;
                border: 2px dashed #ddd;
                color: #666;
            }

            .no-data-icon {
                font-size: 2.5em;
                margin-bottom: 10px;
            }

            .no-data-text {
                font-size: 1.1em;
                font-weight: 500;
                margin-bottom: 5px;
            }

            .pagination-wrapper {
                background: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 1px 4px rgba(0,0,0,0.1);
            }

            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                flex-wrap: wrap;
            }

            .pagination a, .pagination span {
                padding: 6px 10px;
                border-radius: 4px;
                text-decoration: none;
                font-size: 0.9em;
                min-width: 32px;
                text-align: center;
            }

            .pagination a {
                background: #f8f9fa;
                color: #333;
                border: 1px solid #ddd;
                transition: all 0.2s ease;
            }

            .pagination a:hover {
                background: #4CAF50;
                color: white;
                border-color: #4CAF50;
            }

            .pagination .current-page {
                background: #4CAF50;
                color: white;
                font-weight: 500;
            }

            .page-size-control {
                display: flex;
                align-items: center;
                gap: 8px;
                margin-left: 15px;
                padding-left: 15px;
                border-left: 1px solid #ddd;
            }

            .page-size-control input {
                width: 50px;
                padding: 4px 6px;
                border: 1px solid #ddd;
                border-radius: 3px;
                text-align: center;
                font-size: 0.9em;
            }

            .page-size-control button {
                padding: 4px 10px;
                background: #4CAF50;
                color: white;
                border: none;
                border-radius: 3px;
                font-size: 0.9em;
                cursor: pointer;
                transition: background 0.2s ease;
            }

            .page-size-control button:hover {
                background: #45a049;
            }

            /* Responsive */
            @media (max-width: 1200px) {
                .filter-container {
                    gap: 12px;
                }
                .filter-group {
                    min-width: 130px;
                }
                .filter-group.search-group {
                    min-width: 200px;
                }
            }

            @media (max-width: 992px) {
                .filter-container {
                    flex-wrap: wrap;
                    gap: 15px;
                }
                .filter-group {
                    flex: 1 1 calc(33.333% - 10px);
                    min-width: 150px;
                }
                .filter-group.search-group {
                    flex: 1 1 100%;
                    min-width: auto;
                }
            }

            @media (max-width: 768px) {
                .container {
                    padding: 10px;
                }
                .filter-bar {
                    padding: 15px;
                }
                .filter-container {
                    flex-direction: column;
                    align-items: stretch;
                    gap: 15px;
                }
                .filter-group {
                    min-width: auto;
                    flex: none;
                }
                .apply-card {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 8px;
                    padding: 12px;
                }
                .job-info {
                    min-width: auto;
                }
                .salary-info, .status, .step-badge {
                    min-width: auto;
                    text-align: left;
                }
                .card-actions {
                    min-width: auto;
                }
                .page-size-control {
                    margin-left: 0;
                    padding-left: 0;
                    border-left: none;
                    border-top: 1px solid #ddd;
                    padding-top: 10px;
                    margin-top: 10px;
                }

                @media (max-width: 480px) {
                    .header {
                        padding: 15px;
                    }
                    .header h2 {
                        font-size: 1.5em;
                    }
                    .apply-card {
                        padding: 10px;
                    }
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

            <!-- Filter Bar -->
            <div class="filter-bar">
                <form action="searchListApply" method="get" id="filterForm">
                    <div class="filter-container">
                        <!-- Lương -->
                        <div class="filter-group">
                            <label class="filter-label">
                                <i class="bi bi-cash-stack"></i> Lương
                            </label>
                            <select class="filter-select" name="salary" onchange="document.getElementById('filterForm').submit()">
                                <option value="0" <%= "0".equals(session.getAttribute("selectedSalary")) ? "selected" : "" %>>Tất cả</option>
                                <option value="1" <%= "1".equals(session.getAttribute("selectedSalary")) ? "selected" : "" %>>Dưới 10 triệu</option>
                                <option value="2" <%= "2".equals(session.getAttribute("selectedSalary")) ? "selected" : "" %>>10-20 triệu</option>
                                <option value="3" <%= "3".equals(session.getAttribute("selectedSalary")) ? "selected" : "" %>>20-30 triệu</option>
                                <option value="4" <%= "4".equals(session.getAttribute("selectedSalary")) ? "selected" : "" %>>30-40 triệu</option>
                                <option value="5" <%= "5".equals(session.getAttribute("selectedSalary")) ? "selected" : "" %>>Trên 40 triệu</option>
                            </select>
                        </div>

                        <!-- Vị trí -->
                        <div class="filter-group">
                            <label class="filter-label"><i class="bi bi-geo-alt"></i> Vị trí</label>
                            <select class="filter-select" name="location" onchange="document.getElementById('filterForm').submit()">
                                <option value="" <%= "".equals(session.getAttribute("location")) ? "selected" : "" %>>Tất cả</option>
                                <% ArrayList<String> locations = LocationProvider.getLocations(); 
                               for(String lct: locations){ %>
                                <option value="<%=lct%>" <%= lct.equals(session.getAttribute("location")) ? "selected" : "" %>><%=lct%></option>
                                <% } %>
                            </select>
                        </div>

                        <!-- Ngành nghề -->
                        <div class="filter-group">
                            <label class="filter-label"><i class="bi bi-briefcase"></i> Ngành nghề</label>
                            <select class="filter-select" name="career" onchange="document.getElementById('filterForm').submit()">
                                <option value="" <%= "".equals(session.getAttribute("career")) ? "selected" : "" %>>Tất cả</option>
                                <% ArrayList<String> categories = JobCategoryProvider.getJobCategories(); 
                               for(String ctgr: categories){ %>
                                <option value="<%=ctgr%>" <%= ctgr.equals(session.getAttribute("career")) ? "selected" : "" %>><%=ctgr%></option>
                                <% } %>
                            </select>
                        </div>

                        <!-- Kinh nghiệm -->
                        <div class="filter-group">
                            <label class="filter-label"><i class="bi bi-award"></i> Kinh nghiệm</label>
                            <select class="filter-select" name="exp" onchange="document.getElementById('filterForm').submit()">
                                <option value="" <%= "".equals(session.getAttribute("exp")) ? "selected" : "" %>>Tất cả</option>
                                <option value="1" <%= "1".equals(session.getAttribute("exp")) ? "selected" : "" %>>1 năm</option>
                                <option value="2" <%= "2".equals(session.getAttribute("exp")) ? "selected" : "" %>>2 năm</option>
                                <option value="3" <%= "3".equals(session.getAttribute("exp")) ? "selected" : "" %>>3 năm+</option>
                            </select>
                        </div>

                        <!-- Hình thức -->
                        <div class="filter-group">
                            <label class="filter-label"><i class="bi bi-clock-history"></i> Hình thức</label>
                            <select class="filter-select" name="typeJob" onchange="document.getElementById('filterForm').submit()">
                                <option value="" <%= "".equals(session.getAttribute("typeJob")) ? "selected" : "" %>>Tất cả</option>
                                <option value="Part time" <%= "Part time".equals(session.getAttribute("typeJob")) ? "selected" : "" %>>Bán thời gian</option>
                                <option value="Full time" <%= "Full time".equals(session.getAttribute("typeJob")) ? "selected" : "" %>>Full time</option>
                                <option value="Internship" <%= "Internship".equals(session.getAttribute("typeJob")) ? "selected" : "" %>>Thực tập</option>
                                <option value="Remote" <%= "Remote".equals(session.getAttribute("typeJob")) ? "selected" : "" %>>Remote</option>
                            </select>
                        </div>

                        <!-- Tìm kiếm -->
                        <div class="filter-group search-group">
                            <label class="filter-label"><i class="bi bi-search"></i> Tìm theo tên tin tuyển</label>
                            <div style="display: flex; gap: 8px;">
                                <input type="text" class="filter-input" name="searchKey" value="<%= request.getAttribute("keySearch") != null ? request.getAttribute("keySearch") : "" %>" 
                                       placeholder="Nhập từ khóa và Enter" style="flex: 1;">
                                <button type="submit" class="search-button">Tìm kiếm</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Kết quả Apply -->
            <div class="cards-grid">
                <%
                    List<Apply> applies = (List<Apply>) request.getAttribute("applies");
                    if (applies != null && !applies.isEmpty()) {
                        for (Apply a : applies) {
                %>
                <div class="apply-card">
                    <div class="apply-id">#<%= a.getApply_ID() %></div>

                    <div class="job-info">
                        <div class="job-title">
                            <a href="<%=request.getContextPath()%>/detailJob?postId=<%= a.getJobPost_ID() %>">
                                <%= a.getJobTitle() %>
                            </a>
                        </div>
                        <div class="job-position"><%= a.getJobPosition() %></div>
                    </div>

                    <div class="salary-info">
                        <%= a.getOfferMin() %> - <%= a.getOfferMax() %> triệu
                    </div>

                    <div class="status <%= a.getStatus().toLowerCase() %>">
                        <%= a.getStatus() %>
                    </div>

                    <div class="step-process">
                        <%
                            String currentStep = a.getStep();
                            String[] steps = {"Đã nhận hồ sơ", "Đang xét duyệt", "Mời phỏng vấn", "Đã phỏng vấn", "Đã nhận việc"};
                            int currentStepIndex = -1;
                            for (int i = 0; i < steps.length; i++) {
                                if (steps[i].equalsIgnoreCase(currentStep)) {
                                    currentStepIndex = i;
                                    break;
                                }
                            }
                            for (int i = 0; i < steps.length; i++) {
                                String stepClass = "";
                                String dotClass = "";
                                String lineClass = "";
                                if (i < currentStepIndex) {
                                    stepClass = "completed";
                                    dotClass = "completed";
                                    lineClass = "completed";
                                } else if (i == currentStepIndex) {
                                    stepClass = "active";
                                    dotClass = "active";
                                }
                        %>
                        <div class="step-item">
                            <div class="step-dot <%= dotClass %>"></div>
                            <span class="step-text <%= stepClass %>"><%= steps[i] %></span>
                        </div>
                        <% if (i < steps.length - 1) { %>
                        <div class="step-line <%= lineClass %>"></div>
                        <% } %>
                        <% } %>
                    </div>

                    <div class="card-actions">
                        <form action="<%= request.getContextPath() %>/CandidateApplyList" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn hủy Apply này không?');">
                            <input type="hidden" name="applyID" value="<%= a.getApply_ID() %>"/>
                            <button type="submit" class="cancel-btn">Hủy</button>
                        </form>
                    </div>
                </div>
                <% } } else { %>
                <div class="no-data">
                    <div class="no-data-icon">🔍</div>
                    <div class="no-data-text">Chưa có Apply nào</div>
                    <div class="no-data-subtext">Hãy tìm kiếm và ứng tuyển các công việc phù hợp với bạn!</div>
                </div>
                <% } %>
            </div>

            <!-- Phân trang -->
            <div class="pagination-wrapper">
                <div class="pagination">
                    <%
                        Integer currentPage = (Integer) request.getAttribute("currentPage");
                        Integer totalPages = (Integer) request.getAttribute("totalPages");
                        Integer pageSize = (Integer) session.getAttribute("pageSize");

                        String queryParams = "salary=" + session.getAttribute("selectedSalary") +
                                             "&location=" + session.getAttribute("location") +
                                             "&career=" + session.getAttribute("career") +
                                             "&exp=" + session.getAttribute("exp") +
                                             "&typeJob=" + session.getAttribute("typeJob") +
                                             "&searchKey=" + request.getAttribute("keySearch");

                        if (totalPages != null) {
                            for (int i = 1; i <= totalPages; i++) {
                                if (i == currentPage) {
                    %>
                    <span class="current-page"><%= i %></span>
                    <% } else { %>
                    <a href="CandidateApplyList?page=<%= i %>&<%= queryParams %>"><%= i %></a>
                    <% } } %>

                    <div class="page-size-control">
                        <span>Hiển thị:</span>
                        <form action="CandidateApplyList" method="get" style="display: flex; align-items: center; gap: 6px;">
                            <input type="number" name="pageSize" value="<%= (pageSize != null ? pageSize : 5) %>" min="1" max="20">
                            <input type="hidden" name="page" value="1">
                            <input type="hidden" name="salary" value="<%= session.getAttribute("selectedSalary") %>">
                            <input type="hidden" name="location" value="<%= session.getAttribute("location") %>">
                            <input type="hidden" name="career" value="<%= session.getAttribute("career") %>">
                            <input type="hidden" name="exp" value="<%= session.getAttribute("exp") %>">
                            <input type="hidden" name="typeJob" value="<%= session.getAttribute("typeJob") %>">
                            <input type="hidden" name="searchKey" value="<%= request.getAttribute("keySearch") %>">
                            <button type="submit">OK</button>
                        </form>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </body>

</html>