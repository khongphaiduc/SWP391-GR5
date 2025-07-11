<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head><title>Kết quả</title></head>
<body>
    <h2>Kết quả:</h2>
    <p>Số câu đúng: <%= request.getAttribute("score") %> / <%= request.getAttribute("total") %></p>
</body>
</html>
