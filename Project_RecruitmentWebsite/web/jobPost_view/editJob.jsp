<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.*" %>
<%@ page import="java.util.ArrayList" %>

<%
    JobPost job = (JobPost) request.getAttribute("job");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa tin tuyển dụng</title>
    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Select2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <!-- Font: Roboto -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .navbar {
            background-color: #28a745;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .navbar .brand {
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
        }
        .navbar .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: 500;
        }
        .navbar .nav-links a:hover {
            text-decoration: underline;
        }
        .container {
            max-width: 1000px;
            margin: 40px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .form-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #28a745;
            text-align: center;
            text-transform: uppercase;
        }
        .message-box {
            background-color: #e7f3e7;
            border: 1px solid #28a745;
            border-radius: 4px;
            padding: 10px;
            margin-bottom: 20px;
            color: #28a745;
            font-size: 14px;
            text-align: center;
        }
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }
        .form-column {
            display: flex;
            flex-direction: column;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 500;
            color: #28a745;
            font-size: 14px;
        }
        input, select, textarea {
            width: 100%;
            padding: 12px 14px;
            margin-bottom: 18px;
            border: 1px solid #cbd5e0;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border 0.3s ease, box-shadow 0.3s ease;
        }
        input:focus, select:focus, textarea:focus {
            border-color: #28a745;
            box-shadow: 0 0 5px rgba(40, 167, 69, 0.2);
            outline: none;
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        .select2-container--default .select2-selection--single {
            border: 1px solid #cbd5e0;
            border-radius: 6px;
            height: 44px;
            padding: 6px;
            font-size: 14px;
        }
        .select2-container--default .select2-selection--single .select2-selection__rendered {
            line-height: 32px;
            color: #333;
        }
        .select2-container--default .select2-selection--single .select2-selection__arrow {
            height: 42px;
        }
        .select2-container--default .select2-selection--single:focus {
            border-color: #28a745;
            box-shadow: 0 0 5px rgba(40, 167, 69, 0.2);
        }
        .select2-container {
            margin-bottom: 18px;
            width: 100% !important;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            font-weight: 500;
            border: none;
            border-radius: 6px;
            padding: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.1s ease;
            font-size: 16px;
            width: 200px;
            align-self: center;
        }
        input[type="submit"]:hover {
            background-color: #218838;
            transform: translateY(-1px);
        }
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            .container {
                max-width: 600px;
            }
            .navbar {
                flex-direction: column;
                padding: 10px;
            }
            .navbar .nav-links {
                margin-top: 10px;
            }
            .navbar .nav-links a {
                margin: 0 10px;
            }
            input[type="submit"] {
                width: 100%;
            }
        }
    </style>

    <script>
        $(document).ready(function () {
            $('#jobCategory').select2({
                placeholder: "Chọn danh mục nghề",
                allowClear: true
            });
            $('#location').select2({
                placeholder: "Chọn địa điểm",
                allowClear: true
            });
        });
    </script>
</head>
<body>
    <jsp:include page="/navbar.jsp" />
    <div class="container">
        <div class="form-title">Chỉnh sửa tin tuyển dụng</div>
        <% String message = (String) request.getAttribute("message");
        if (message != null) { %>
            <div class="message-box"><%= message %></div>
        <% } %>
        <form action="updateJobPost" method="post">
            <input type="hidden" name="jobPost_ID" value="<%= job.getJobPost_ID() %>">
            <div class="form-grid">
                <!-- Left Column -->
                <div class="form-column">
                    <label>Tiêu đề công việc</label>
                    <input type="text" name="title" placeholder="Nhập tiêu đề" value="<%= job.getTitle() %>" required>

                    <label>Mô tả công việc</label>
                    <textarea name="description" rows="3" placeholder="Nhập mô tả" required><%= job.getDescription() %></textarea>

                    <label>Danh mục</label>
                    <select id="jobCategory" name="category">
                        <option value="">-- Chọn ngành nghề --</option>
                        <%
                            ArrayList<String> jobCategories = (ArrayList<String>) request.getAttribute("jobCategories");
                            if (jobCategories != null) {
                                for (String category : jobCategories) {
                        %>
                        <option value="<%= category %>" <%= category.equals(job.getCategory()) ? "selected" : "" %>><%= category %></option>
                        <%
                                }
                            }
                        %>
                    </select>

                    <label>Vị trí</label>
                    <input type="text" name="position" placeholder="Nhập vị trí" value="<%= job.getPosition() %>">

                    <label>Địa điểm</label>
                    <select id="location" name="location">
                        <option value="">-- Chọn địa điểm --</option>
                        <%
                            ArrayList<String> locations = (ArrayList<String>) request.getAttribute("locations");
                            if (locations != null) {
                                for (String location : locations) {
                        %>
                        <option value="<%= location %>" <%= location.equals(job.getLocation()) ? "selected" : "" %>><%= location %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <!-- Right Column -->
                <div class="form-column">
                    <label>Lương tối thiểu (VNĐ)</label>
                    <input type="number" name="offerMin" step="1000" placeholder="Nhập lương tối thiểu" value="<%= job.getOffer_Min() %>">

                    <label>Lương tối đa (VNĐ)</label>
                    <input type="number" name="offerMax" step="1000" placeholder="Nhập lương tối đa" value="<%= job.getOffer_Max() %>">

                    <label>Số năm kinh nghiệm yêu cầu</label>
                    <input type="number" name="numberExp" min="0" placeholder="Nhập số năm kinh nghiệm" value="<%= job.getNumber_exp() %>">

                    <label>Loại hình công việc</label>
                    <select name="typeJob" required>
                        <option value="Full time" <%= "Full time".equals(job.getTypeJob()) ? "selected" : "" %>>Full time</option>
                        <option value="Part time" <%= "Part time".equals(job.getTypeJob()) ? "selected" : "" %>>Part time</option>
                        <option value="Internship" <%= "Internship".equals(job.getTypeJob()) ? "selected" : "" %>>Internship</option>
                        <option value="Freelance" <%= "Freelance".equals(job.getTypeJob()) ? "selected" : "" %>>Freelance</option>
                        <option value="Remote" <%= "Remote".equals(job.getTypeJob()) ? "selected" : "" %>>Remote</option>
                    </select>

                    <label>Hiển thị tin tuyển dụng?</label>
                    <select name="visible">
                        <option value="1" <%= "1".equals(String.valueOf(job.getVisible())) ? "selected" : "" %>>Có</option>
                        <option value="0" <%= "0".equals(String.valueOf(job.getVisible())) ? "selected" : "" %>>Không</option>
                    </select>

                    <input type="submit" value="Cập nhật">
                </div>
            </div>
        </form>
    </div>
</body>
</html>