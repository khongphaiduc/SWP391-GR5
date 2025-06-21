<%-- 
    Document   : payment.jsp
    Created on : 6 Mar 2025, 4:28:59 pm
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán Đơn Hàng</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background-color: #f4f4f4; }
        .total { font-weight: bold; }
        button { padding: 10px 15px; background-color: #28a745; color: white; border: none; cursor: pointer; margin-top: 20px; }
        button:hover { background-color: #218838; }
    </style>
</head>
<body>
    <h2>Danh Sách Sản Phẩm Thanh Toán</h2>
    

    <form action="ajaxServlet" method="post">
        <input type="number" name="totalBill" require>
        <button type="submit">Đặt Mua</button>
    </form>
</body>
</html>
