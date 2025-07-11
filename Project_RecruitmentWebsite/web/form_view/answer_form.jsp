<%@ page import="Models.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Question> questions = (List<Question>) request.getAttribute("questions");
    int formId = (int) request.getAttribute("formId");
%>
<html>
    <head>
        <title>Trả lời Form</title>
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
                margin-bottom: 30px;
            }

            .question-block {
                margin-bottom: 25px;
                padding: 15px;
                border-radius: 8px;
                background-color: #fafafa;
                border: 1px solid #ddd;
            }

            .question-block p {
                margin-bottom: 10px;
                font-weight: 600;
            }

            input[type="text"] {
                width: 100%;
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #ccc;
                font-size: 15px;
            }

            .option {
                display: block;
                margin-bottom: 8px;
            }

            button[type="submit"] {
                background-color: #00b86b;
                color: white;
                padding: 12px 24px;
                border: none;
                border-radius: 8px;
                font-weight: bold;
                font-size: 16px;
                cursor: pointer;
                margin-top: 20px;
            }

            button[type="submit"]:hover {
                background-color: #009b5a;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Trả lời Biểu mẫu</h2>
            <form action="submitAnswer" method="post">
                <input type="hidden" name="formId" value="<%= formId %>" />
                <%
                    int index = 0;
                    for (Question q : questions) {
                %>
                <div class="question-block">
                    <p><%= q.getQuestionText() %></p>
                    <% if ("text".equals(q.getType())) { %>
                    <input type="text" name="answer<%= index %>" placeholder="Nhập câu trả lời..." />
                    <% } else { %>
                    <label class="option"><input type="radio" name="answer<%= index %>" value="A" /> A</label>
                    <label class="option"><input type="radio" name="answer<%= index %>" value="B" /> B</label>
                    <label class="option"><input type="radio" name="answer<%= index %>" value="C" /> C</label>
                        <% } %>
                </div>
                <%
                        index++;
                    }
                %>
                <input type="hidden" name="total" value="<%= index %>" />
                <button type="submit">Nộp bài</button>
            </form>
        </div>
    </body>
</html>
