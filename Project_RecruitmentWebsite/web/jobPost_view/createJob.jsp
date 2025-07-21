<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Models.JobPost" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html lang="vi">
    <%
        boolean isEdit = request.getAttribute("isEdit") != null && (boolean) request.getAttribute("isEdit");
        JobPost job = isEdit ? (JobPost) request.getAttribute("job") : null;

        String title = isEdit && job != null ? job.getTitle() : "";
        String description = isEdit && job != null ? job.getDescription() : "";
        String category = isEdit && job != null ? job.getCategory() : "";
        String position = isEdit && job != null ? job.getPosition() : "";
        String location = isEdit && job != null ? job.getLocation() : "";
        double offerMin = isEdit && job != null ? job.getOffer_Min() : 0;
        double offerMax = isEdit && job != null ? job.getOffer_Max() : 0;
        int numberExp = isEdit && job != null ? job.getNumber_exp() : 0;
        String typeJob = isEdit && job != null ? job.getTypeJob() : "";
        boolean visible = isEdit && job != null && job.isVisible();
        int jobId = isEdit && job != null ? job.getJobPost_ID() : -1;

        List<String> jobCategories = (List<String>) request.getAttribute("jobCategories");
        List<String> locations = (List<String>) request.getAttribute("locations");
    %>
    <head>
        <meta charset="UTF-8">
        <title><%= isEdit ? "Chỉnh sửa tin tuyển dụng" : "Đăng tin tuyển dụng" %></title>

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
                margin-top: 10px;
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

            function formatCurrencyInput(input) {
                let value = input.value.replace(/\D/g, '');
                if (value === '') {
                    input.value = '';
                    return;
                }
                input.value = new Intl.NumberFormat('vi-VN').format(value);
            }
            document.addEventListener("DOMContentLoaded", function () {
                function cleanCurrency(value) {
                    return parseInt(value.replace(/,/g, '')) || 0;
                }

                document.querySelector("form").addEventListener("submit", function (e) {
                    const minInput = document.querySelector("input[name='offerMin']");
                    const maxInput = document.querySelector("input[name='offerMax']");

                    const minSalary = cleanCurrency(minInput.value);
                    const maxSalary = cleanCurrency(maxInput.value);

                    if (minSalary > maxSalary) {
                        alert("Lương tối đa phải lớn hơn hoặc bằng lương tối thiểu.");
                        maxInput.focus();
                        e.preventDefault();
                    }
                });
            });
        </script>
    </head>


    <body>
        <jsp:include page="/navbar.jsp" />
        <br/>
        <h2 style="text-align: center;"><%= isEdit ? "Chỉnh sửa tin tuyển dụng" : "Đăng tin tuyển dụng mới" %></h2>

        <% String message = (String) request.getAttribute("message");
        if (message != null) { %>
        <div class="message-box"><%= message %></div>
        <% } %>
        <div class="container">

            <form action="<%= isEdit ? "updateJobPost" : "createJob" %>" method="post">
                <% if (isEdit) { %>
                <input type="hidden" name="jobId" value="<%= jobId %>">
                <% } %>
                <div class="form-grid">
                    <!-- Left Column -->
                    <div class="form-column">
                        <label for="title">Tiêu đề:</label>
                        <input type="text" name="title" id="title" placeholder="Nhập tiêu đề" required value="<%= title %>">

                        <label for="description">Mô tả:</label>
                        <textarea name="description" id="description" rows="3" required><%= description %></textarea>

                        <label for="jobCategory">Danh mục nghề:</label>
                        <select id="jobCategory" name="category" required>
                            <option value="">-- Chọn ngành nghề --</option>
                            <% if (jobCategories != null) {
                                for (String cat : jobCategories) {
                                    boolean selected = cat.equals(category); %>
                            <option value="<%= cat %>" <%= selected ? "selected" : "" %>><%= cat %></option>
                            <%  }
            } %>
                        </select>

                        <label for="position">Vị trí:</label>
                        <input type="text" name="position" id="position" placeholder="VD: Thực tập sinh Backend" required value="<%= position %>">

                        <label for="location">Địa điểm:</label>
                        <select id="location" name="location" required>
                            <option value="">-- Chọn địa điểm --</option>
                            <% if (locations != null) {
                                for (String loc : locations) {
                                    boolean selected = loc.equals(location); %>
                            <option value="<%= loc %>" <%= selected ? "selected" : "" %>><%= loc %></option>
                            <%  }
            } %>
                        </select>
                    </div>

                    <div class="form-column">
                        <label for="offerMin">Lương tối thiểu (triệu VND):</label>
                        <input type="text" name="offerMin" id="offerMin" required oninput="formatCurrencyInput(this)" value="<%= offerMin > 0 ? String.format("%,d", offerMin) : "" %>">

                        <label for="offerMax">Lương tối đa (triệu VND):</label>
                        <input type="text" name="offerMax" id="offerMax" required oninput="formatCurrencyInput(this)" value="<%= offerMax > 0 ? String.format("%,d", offerMax) : "" %>">

                        <label for="numberExp">Số năm kinh nghiệm:</label>
                        <input type="text" name="numberExp" id="numberExp" placeholder="VD: 2" required value="<%= numberExp > 0 ? numberExp : "" %>">

                        <label for="typeJob">Loại công việc:</label>
                        <select id="typeJob" name="typeJob" required>
                            <%
                                String[] types = {"Full time", "Part time", "Internship", "Freelance", "Remote"};
                                for (String t : types) {
                            %>
                            <option value="<%= t %>" <%= t.equals(typeJob) ? "selected" : "" %>><%= t %></option>
                            <% } %>
                        </select>

                        <label for="visible">Hiển thị tin:</label>
                        <select id="visible" name="visible">
                            <option value="1" <%= visible ? "selected" : "" %>>Có</option>
                            <option value="0" <%= !visible ? "selected" : "" %>>Không</option>
                        </select>

                        <input type="submit" value="<%= isEdit ? "Cập nhật tin" : "Đăng tuyển" %>">
                    </div>
                </div>

            </form>
        </div>
    </body>

</html>