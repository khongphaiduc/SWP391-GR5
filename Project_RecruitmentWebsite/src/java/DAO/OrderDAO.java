package DAO;

import Models.Order;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO extends DBContext {

    public int insertOrder(Order o) throws SQLException {
        String sql = "INSERT INTO Orders (Employer_ID, Service_ID, Amount, PayMethod, Status, Date) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, o.getEmployerId());
            ps.setInt(2, o.getServiceId());
            ps.setDouble(3, o.getAmount());
            ps.setString(4, o.getPayMethod());
            ps.setString(5, o.getStatus()); 
            ps.setTimestamp(6, new Timestamp(o.getDate().getTime()));

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);  // Trả về Order_ID vừa được tạo
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<Order> getOrdersByEmployerId(int employerId) throws SQLException {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE Employer_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order(
                            rs.getInt("Order_ID"),
                            rs.getInt("Employer_ID"),
                            rs.getInt("Service_ID"),
                            rs.getDouble("Amount"),
                            rs.getString("PayMethod"),
                            rs.getString("Status"),                     
                            rs.getTimestamp("Date")
                    );
                    list.add(o);
                }
            }
        }
        return list;
    }

    public boolean updateOrderStatus(int orderId, String newStatus) throws SQLException {
        String sql = "UPDATE Orders SET Status = ? WHERE Order_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
