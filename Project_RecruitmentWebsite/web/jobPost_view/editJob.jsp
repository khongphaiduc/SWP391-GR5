<%-- 
    Document   : editJob
    Created on : May 29, 2025, 10:55:58 AM
    Author     : PC
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.JobPost" %>
<%
    JobPost job = (JobPost) request.getAttribute("job");
%>
<html>
<head><title>Chỉnh sửa JobPost</title></head>
<body>
    <form action="updateJobPost" method="post">
        <input type="hidden" name="jobPost_ID" value="<%= job.getJobPost_ID() %>">
        Tiêu đề: <input type="text" name="title" value="<%= job.getTitle() %>"><br>
        Mô tả: <textarea name="description"><%= job.getDescription() %></textarea><br>
        Lương từ: <input type="number" name="offer_Min" value="<%= job.getOffer_Min() %>"><br>
        Lương đến: <input type="number" name="offer_Max" value="<%= job.getOffer_Max() %>"><br>
        <button type="submit">Cập nhật</button>
    </form>
</body>
</html>
