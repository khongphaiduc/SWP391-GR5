<%@ page import="Models.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Form form = (Form) request.getAttribute("form");
%>
<html>
<head>
    <title>Xem trước form</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            padding: 30px;
        }

        h2 {
            text-align: center;
            color: #00b86b;
            font-weight: 600;
        }

        .question {
            margin-bottom: 25px;
        }

        .question p {
            font-weight: 600;
            margin-bottom: 10px;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
        }

        .option {
            display: block;
            margin: 5px 0;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
        }

        .back-btn:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <jsp:include page="/navbar.jsp" />
<div class="container">
    <h2><%= form.getTitle() %></h2>
    <form>
        <%
            for (Question q : form.getQuestions()) {
        %>
        <div class="question">
            <p><%= q.getQuestionText() %></p>
            <% if ("text".equals(q.getType())) { %>
                <input type="text" placeholder="Nhập câu trả lời..." />
            <% } else { %>
                <label class="option"><input type="radio" name="<%= q.getQuestionText() %>"/> A</label>
                <label class="option"><input type="radio" name="<%= q.getQuestionText() %>"/> B</label>
                <label class="option"><input type="radio" name="<%= q.getQuestionText() %>"/> C</label>
                <label class="option"><input type="radio" name="<%= q.getQuestionText() %>"/> D</label>
            <% } %>
        </div>
        <% } %>
        <a href="${pageContext.request.contextPath}/manageForm" class="back-btn">Quay lại</a>
    </form>
</div>
</body>
</html>
