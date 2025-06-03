<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Models.*" %>

<html>
<head>
    <jsp:include page="/navbar.jsp" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý CV - TopCV Style</title>
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
            background-color: #f4f4f4; /* Changed to match CV creation page */
            min-height: 100vh;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .header-section {
            text-align: center;
            margin: 40px 0;
            color: #2e4f4f; /* Changed to dark green for consistency */
        }

        .header-section h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-transform: uppercase; /* Uppercase for consistency */
        }

        .header-section p {
            font-size: 1.1rem;
            opacity: 0.9;
            font-weight: 300;
        }

        .cv-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .cv-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(46, 79, 79, 0.08); /* Adjusted shadow color */
            overflow: hidden;
            transition: all 0.3s ease;
            border: 1px solid rgba(46, 79, 79, 0.1); /* Changed border color */
        }

        .cv-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 32px rgba(46, 79, 79, 0.15);
            border-color: rgba(46, 79, 79, 0.2);
        }

        .cv-header {
            background: linear-gradient(135deg, #2e4f4f 0%, #1a3c3c 100%); /* Dark green gradient */
            padding: 20px;
            color: white;
            position: relative;
        }

        .cv-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #2e4f4f, #1a3c3c); /* Consistent gradient */
        }

        .cv-preview {
            width: 80px;
            height: 100px;
            border-radius: 8px;
            overflow: hidden;
            border: 3px solid rgba(255,255,255,0.3);
            float: right;
            margin-left: 20px;
        }

        .cv-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .cv-title {
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
            text-transform: uppercase; /* Uppercase for consistency */
        }

        .cv-position {
            font-size: 1rem;
            opacity: 0.9;
            font-weight: 400;
        }

        .cv-body {
            padding: 24px;
        }

        .cv-info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 24px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #2e4f4f; /* Changed to dark green */
        }

        .info-icon {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, #2e4f4f, #1a3c3c); /* Dark green gradient */
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 14px;
            flex-shrink: 0;
        }

        .info-content {
            flex: 1;
        }

        .info-label {
            font-size: 0.75rem;
            color: #666;
            text-transform: uppercase;
            font-weight: 500;
            letter-spacing: 0.5px;
            margin-bottom: 2px;
        }

        .info-value {
            font-size: 0.9rem;
            color: #333;
            font-weight: 500;
        }

        .cv-actions {
            display: flex;
            gap: 12px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .cv-actions form {
            flex: 1;
            margin: 0;
        }

        .btn {
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

        .btn-view {
            background: linear-gradient(135deg, #2e4f4f, #1a3c3c); /* Dark green gradient */
            color: white;
        }

        .btn-view:hover {
            background: linear-gradient(135deg, #1a3c3c, #143333);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(46, 79, 79, 0.3);
        }

        .btn-edit {
            background: linear-gradient(135deg, #2e4f4f, #1a3c3c); /* Consistent with view */
            color: white;
        }

        .btn-edit:hover {
            background: linear-gradient(135deg, #1a3c3c, #143333);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(46, 79, 79, 0.3);
        }

        .btn-delete {
            background: linear-gradient(135deg, #ff6b6b, #e53e3e); /* Kept red for delete */
            color: white;
        }

        .btn-delete:hover {
            background: linear-gradient(135deg, #ff5252, #d32f2f);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 107, 107, 0.3);
        }

        .no-cv {
            text-align: center;
            background: white;
            padding: 60px 40px;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(46, 79, 79, 0.08);
            border: 1px solid rgba(46, 79, 79, 0.1);
        }

        .no-cv i {
            font-size: 4rem;
            color: #2e4f4f; /* Changed to dark green */
            margin-bottom: 20px;
            display: block;
        }

        .no-cv h3 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 10px;
            font-weight: 600;
            text-transform: uppercase; /* Uppercase for consistency */
        }

        .no-cv p {
            color: #666;
            font-size: 1rem;
        }

        .pagination-wrapper {
            background: white;
            padding: 24px;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(46, 79, 79, 0.08);
            margin-top: 30px;
            border: 1px solid rgba(46, 79, 79, 0.1);
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .pagination a, .pagination span {
            padding: 10px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            min-width: 44px;
            text-align: center;
        }

        .pagination a {
            background: #f8f9fa;
            color: #333;
            border: 1px solid #e9ecef;
        }

        .pagination a:hover {
            background: #2e4f4f; /* Dark green */
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(46, 79, 79, 0.2);
        }

        .pagination .current {
            background: linear-gradient(135deg, #2e4f4f, #1a3c3c);
            color: white;
            box-shadow: 0 4px 12px rgba(46, 79, 79, 0.3);
        }

        .page-size-control {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-left: 20px;
            padding-left: 20px;
            border-left: 2px solid #e9ecef;
        }

        .page-size-control input {
            width: 60px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            text-align: center;
            font-weight: 500;
        }

        .page-size-control button {
            padding: 8px 16px;
            background: linear-gradient(135deg, #2e4f4f, #1a3c3c); /* Dark green gradient */
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .page-size-control button:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(46, 79, 79, 0.3);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 0 15px;
            }

            .header-section h1 {
                font-size: 2rem;
            }

            .cv-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .cv-info-grid {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .cv-actions {
                flex-direction: column;
            }

            .btn {
                padding: 14px 16px;
            }

            .pagination {
                flex-direction: column;
                gap: 16px;
            }

            .page-size-control {
                margin-left: 0;
                padding-left: 0;
                border-left: none;
                border-top: 2px solid #e9ecef;
                padding-top: 16px;
            }
        }

        @media (max-width: 480px) {
            .cv-header {
                padding: 16px;
            }

            .cv-preview {
                width: 60px;
                height: 75px;
                float: none;
                margin: 0 auto 12px;
            }

            .cv-title {
                font-size: 1.2rem;
                text-align: center;
            }

            .cv-position {
                text-align: center;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header-section">
        <h1><i class="fas fa-file-alt"></i> QUẢN LÝ CV</h1>
        <p>Danh sách tất cả CV của bạn</p>
    </div>

    <%
        List<CV> cvList = (List<CV>) request.getAttribute("cvList");
        if (cvList != null && !cvList.isEmpty()) {
    %>
    <div class="cv-grid">
        <%
            for (CV cv : cvList) {
        %>
        <div class="cv-card">
            <div class="cv-header">
                <div class="cv-preview">
                    <img src="viewCV?cvId=<%= cv.getCvId() %>" alt="CV Preview" onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAiIGhlaWdodD0iMTAwIiB2aWV3Qm94PSIwIDAgODAgMTAwIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8cmVjdCB3aWR0aD0iODAiIGhlaWdodD0iMTAwIiBmaWxsPSIjZjhmOWZhIi8+CjxwYXRoIGQ9Ik00MCA1MEwyNSA2MEw1NSA2MFoiIGZpbGw9IiNkZGQiLz4KPHN2Zz4K'">
                </div>
                <div class="cv-title">
                    <i class="fas fa-user"></i>
                    <%= cv.getFullName() %>
                </div>
                <div class="cv-position">
                    <%= cv.getPosition() %>
                </div>
            </div>
            <div class="cv-body">
                <div class="cv-info-grid">
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-briefcase"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Kinh nghiệm</div>
                            <div class="info-value"><%= cv.getNumberExp() %> năm</div>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Lương hiện tại</div>
                            <div class="info-value"><%= cv.getCurrentSalary() %></div>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-birthday-cake"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Ngày sinh</div>
                            <div class="info-value"><%= cv.getBirthday() %></div>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-venus-mars"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Giới tính</div>
                            <div class="info-value"><%= cv.getGender() %></div>
                        </div>
                    </div>
                </div>
                <div class="cv-actions">
                    <a href="viewCV?cvId=<%= cv.getCvId() %>" class="btn btn-view" target="_blank" style="flex: 1;">
                        <i class="fas fa-eye"></i> Xem CV
                    </a>
                    <form method="post" action="manageCreatedCV" style="flex: 1; margin: 0;">
                        <input type="hidden" name="action" value="edit" />
                        <input type="hidden" name="cvId" value="<%= cv.getCvId() %>" />
                        <button type="submit" class="btn btn-edit">
                            <i class="fas fa-edit"></i> Chỉnh sửa
                        </button>
                    </form>
                    <form method="post" action="manageCreatedCV" style="flex: 1; margin: 0;" onsubmit="return confirm('Bạn có chắc chắn muốn xóa CV này không?');">
                        <input type="hidden" name="action" value="delete" />
                        <input type="hidden" name="cvId" value="<%= cv.getCvId() %>" />
                        <button type="submit" class="btn btn-delete">
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
        Integer pageSize = (Integer) request.getAttribute("pageSize");
        if (totalPages != null && totalPages > 1) {
    %>
    <div class="pagination-wrapper">
        <div class="pagination">
            <% for (int i = 1; i <= totalPages; i++) { %>
                <% if (i == currentPage) { %>
                    <span class="current"><%= i %></span>
                <% } else { %>
                    <a href="manageCreatedCV?page=<%= i %>"><%= i %></a>
                <% } %>
            <% } %>
            
            <div class="page-size-control">
                <span>Hiển thị:</span>
                <form action="manageCreatedCV" style="display: flex; align-items: center; gap: 8px;">
                    <input type="number" name="pageSize" value="<%=pageSize%>" min="1" max="20">
                    <button type="submit">OK</button>
                </form>
            </div>
        </div>
    </div>
    <% } %>

    <% } else { %>
    <div class="no-cv">
        <i class="fas fa-file-alt"></i>
        <h3>CHƯA CÓ CV NÀO</h3>
        <p>Bạn chưa tạo CV nào. Hãy tạo CV đầu tiên của mình ngay bây giờ!</p>
    </div>
    <% } %>
</div>
</body>
</html>