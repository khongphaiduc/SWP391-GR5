<%-- 
    Document   : editJob
    Created on : May 29, 2025, 10:55:58 AM
    Author     : PC
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.*" %>
<%
    JobPost job = (JobPost) request.getAttribute("job");
%>
<html>
    <head>
        <jsp:include page="/navbar.jsp" />

        <title>Chỉnh sửa JobPost</title>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f0fff4;
                margin: 0;
                padding: 0;
            }
            .form-title {
                font-size: 24px;
                font-weight: 700;
                margin-bottom: 30px;
                color: #198754;
            }
            .container {
                width: 500px;
                margin: 40px auto;
                background: #ffffff;
                padding: 30px 35px;
                border-radius: 10px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
            }
            h2 {
                text-align: center;
                color: #2f855a;
                margin-bottom: 24px;
            }
            label {
                display: block;
                margin-bottom: 6px;
                font-weight: 500;
                color: #2d3748;
            }
            input, select, textarea {
                width: 100%;
                padding: 10px 12px;
                margin-bottom: 18px;
                
                border: 1px solid #cbd5e0;
                border-radius: 6px;
                font-size: 14px;
                box-sizing: border-box;
                transition: border 0.3s;
            }
            input:focus, select:focus, textarea:focus {
                border-color: #68d391;
                outline: none;
            }
            input[type="submit"] {
                background-color: #38a169;
                color: white;
                font-weight: bold;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            input[type="submit"]:hover {
                background-color: #2f855a;
            }
            button {
                margin-top: 20px;
                padding: 10px;
                width: 100%;
                background-color: #00b386;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
            }

            button:hover {
                background-color: #009e75;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="text-center">
                <div class="form-title">Chỉnh sửa tin tuyển dụng</div>
                <% String message = (String) request.getAttribute("message");
                if (message != null) { %>
                <p><%= message %></p>
                <% } %>
            </div>
            <form action="updateJobPost" method="post">
                <input type="hidden" name="jobPost_ID" value="<%= job.getJobPost_ID() %>">

                <label>Tiêu đề công việc</label>
                <input type="text" name="title" placeholder="Nhập tiêu đề" value="<%= job.getTitle()%>">

                <label>Mô tả công việc</label>
                <textarea name="description" rows="3" placeholder="Nhập mô tả" value="<%= job.getDescription()%>"></textarea>

                <label>Danh mục</label>
                <input type="text" name="category" placeholder="Nhập danh mục" value="<%= job.getCategory()%>">

                <label>Vị trí</label>
                <input type="text" name="position" placeholder="Nhập vị trí" value="<%= job.getPosition()%>">

                <label>Địa điểm</label>
                <input type="text" name="location" placeholder="Nhập địa điểm" value="<%= job.getLocation()%>">

                <label>Lương tối thiểu (VNĐ)</label>
                <input type="number" name="offerMin" step="1000" placeholder="Nhập lương tối thiểu" value="<%= job.getOffer_Min() %>">

                <label>Lương tối đa (VNĐ)</label>
                <input type="number" name="offerMax" step="1000" placeholder="Nhập lương tối đa" value="<%= job.getOffer_Max() %>"> 

                <label>Số năm kinh nghiệm yêu cầu</label>
                <input type="number" name="numberExp" min="0" placeholder="Nhập số năm kinh nghiệm" value="<%= job.getNumber_exp() %>">
                <label>Loại hình công việc</label>
                <select name="typeJob" required>
                    <option value="Full time">Full time</option>
                    <option value="Part time">Part time</option>
                    <option value="Internship">Internship</option>
                    <option value="Freelance">Freelance</option>
                    <option value="Remote">Remote</option>
                </select>

                <label>Hiển thị tin tuyển dụng?</label>
                <select name="visible">
                    <option value="1">Có</option>
                    <option value="0">Không</option>
                </select>
                <button type="submit">Cập nhật</button>
            </form>
        </div>
    </body>
</html>
