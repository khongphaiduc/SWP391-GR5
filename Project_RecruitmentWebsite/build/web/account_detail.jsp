<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Models.Employer, Models.Candidate" %>
<%
    String type = (String) request.getAttribute("type");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Account Details</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: #1f2937;
        }

        .admin-header {
            background: linear-gradient(135deg, #16a34a 0%, #22c55e 100%);
            color: white;
            padding: 3rem 0;
            position: relative;
        }

        .admin-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
        }

        .card-detail {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            border: 1px solid #e5e7eb;
            max-width: 700px;
            margin: 0 auto;
        }

        .avatar-img {
            max-width: 160px;
            max-height: 160px;
            border-radius: 12px;
            border: 1px solid #ccc;
        }

        .info-label {
            font-weight: 600;
            color: #6b7280;
        }

        .info-value {
            font-size: 1rem;
            color: #1f2937;
        }
    </style>
</head>
<body>

<!-- Header -->
<div class="admin-header text-center">
    <div class="container">
        <h1>Account Details</h1>
        <p class="lead">Detailed information of ${type} account</p>
    </div>
</div>

<!-- Content -->
<div class="container py-5">
    <div class="card-detail">
        <c:if test="${type == 'employer'}">
            <h3 class="mb-4"><i class="fas fa-user-tie me-2"></i>Employer Information</h3>
            <div class="row mb-3"><div class="col-sm-4 info-label">ID:</div><div class="col-sm-8 info-value">${user.employerId}</div></div>
            <div class="row mb-3"><div class="col-sm-4 info-label">Name:</div><div class="col-sm-8 info-value">${user.employerName}</div></div>
            <div class="row mb-3"><div class="col-sm-4 info-label">Email:</div><div class="col-sm-8 info-value">${user.email}</div></div>
            <div class="row mb-3"><div class="col-sm-4 info-label">Company:</div><div class="col-sm-8 info-value">${user.companyName}</div></div>
            <div class="row mb-3"><div class="col-sm-4 info-label">Description:</div><div class="col-sm-8 info-value">${user.description}</div></div>
            <div class="row mb-3"><div class="col-sm-4 info-label">Location:</div><div class="col-sm-8 info-value">${user.location}</div></div>
            <div class="row mb-3"><div class="col-sm-4 info-label">Website:</div><div class="col-sm-8 info-value">${user.urlWebsite}</div></div>
            <div class="row mb-3"><div class="col-sm-4 info-label">Company Size:</div><div class="col-sm-8 info-value">${user.companySize}</div></div>
            <c:if test="${user.imgLogo != null}">
                <div class="text-center mt-4">
                    <img src="data:image/png;base64,${org.apache.commons.codec.binary.Base64.encodeBase64String(user.imgLogo)}" class="avatar-img" alt="Logo"/>
                    <p class="text-muted mt-2">Company Logo</p>
                </div>
            </c:if>
        </c:if>

        <c:if test="${type == 'candidate'}">
            <h3 class="mb-4"><i class="fas fa-user me-2"></i>Candidate Information</h3>
            <div class="row mb-3"><div class="col-sm-4 info-label">ID:</div><div class="col-sm-8 info-value">${user.candidateId}</div></div>
            <div class="row mb-3"><div class="col-sm-4 info-label">Name:</div><div class="col-sm-8 info-value">${user.candidateName}</div></div>
            <div class="row mb-3"><div class="col-sm-4 info-label">Email:</div><div class="col-sm-8 info-value">${user.email}</div></div>
            <div class="row mb-3"><div class="col-sm-4 info-label">Address:</div><div class="col-sm-8 info-value">${user.address}</div></div>
            <div class="row mb-3"><div class="col-sm-4 info-label">Birthday:</div><div class="col-sm-8 info-value">${user.birthday}</div></div>
            <div class="row mb-3"><div class="col-sm-4 info-label">Nationality:</div><div class="col-sm-8 info-value">${user.nationality}</div></div>
            <c:if test="${user.avatar != null}">
                <div class="text-center mt-4">
                    <img src="data:image/png;base64,${org.apache.commons.codec.binary.Base64.encodeBase64String(user.avatar)}" class="avatar-img" alt="Avatar"/>
                    <p class="text-muted mt-2">User Avatar</p>
                </div>
            </c:if>
        </c:if>

        <div class="text-center mt-4">
            <a href="list?type=${type}" class="btn btn-secondary px-4">← Back to User List</a>
        </div>
    </div>
</div>

</body>
</html>
