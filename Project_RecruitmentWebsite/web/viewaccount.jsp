<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Account" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Account acc = (Account) request.getAttribute("account");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Account Details</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4 text-primary"><i class="fas fa-user"></i> Account Details</h2>
        <div class="card shadow p-4">
            <table class="table table-borderless">
                <tr>
                    <th>ID</th>
                    <td>${account.accountId}</td>
                </tr>
                <tr>
                    <th>Username</th>
                    <td>${account.accountName}</td>
                </tr>
                <tr>
                    <th>Password Hash</th>
                    <td>${account.passwordHash}</td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td>${account.email}</td>
                </tr>
                <tr>
                    <th>Role</th>
                    <td>${account.role}</td>
                </tr>
                <!-- Bạn có thể thêm các trường khác nếu Account có -->
            </table>
            <a href="list" class="btn btn-secondary mt-3">
                <i class="fas fa-arrow-left"></i> Back to List
            </a>
            <a href="editAccount?id=${account.accountId}" class="btn btn-warning mt-3 ms-2">
                <i class="fas fa-edit"></i> Edit Account
            </a>
        </div>
    </div>

    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>
