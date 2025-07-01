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
    <h2>Thanh Toán Dịch Vụ</h2>

    <!-- Bảng hiển thị dịch vụ cứng -->
    <table>
        <thead>
            <tr>
                <th>Mã dịch vụ</th>
                <th>Tên dịch vụ</th>
                <th>Giá</th>
                <th>Mô tả</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>Gói Đăng Tin VIP</td>
                <td>500,000 VND</td>
                <td>Đăng tin tuyển dụng ngay!</td>
            </tr>
        </tbody>
    </table>

    <!-- Form thanh toán -->
    <form action="ajaxServlet" method="post">
        <input type="hidden" name="totalBill" value="500000">
        <button type="submit">Đặt Mua</button>
    </form>
</body>
</html>
