package DAO;

import Models.Employer;
import Models.Order;
import Models.Service;
import dal.DBContext;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO extends DBContext {

    public int insertOrder(Order o) throws SQLException {
        String sql = "INSERT INTO Orders (Employer_ID, Service_ID, Amount,"
                + " PayMethod, Status, Duration) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, o.getEmployerId());
            ps.setInt(2, o.getServiceId());
            ps.setDouble(3, o.getAmount());
            ps.setString(4, o.getPayMethod());
            ps.setString(5, o.getStatus());
            ps.setInt(6, o.getDuration());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
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
        String sql = "SELECT o.Order_ID, o.Employer_ID, o.Service_ID, o.Amount, o.PayMethod, o.Status, o.Date, "
                + "s.Service_Name, o.Duration "
                + "FROM Orders o "
                + "JOIN Service s ON o.Service_ID = s.Service_ID "
                + "WHERE o.Employer_ID = ?";

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

                    o.setServiceName(rs.getString("Service_Name"));
                    o.setDuration(rs.getInt("Duration"));

                    // Tính ngày hết hạn: Date + Duration
                    LocalDateTime orderDate = rs.getTimestamp("Date").toLocalDateTime();
                    LocalDateTime expiredDate = orderDate.plusDays(o.getDuration());
                    o.setExpiredDate(Timestamp.valueOf(expiredDate));

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

    public List<Order> getAllOrdersWithEmployerAndService() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.Order_ID, o.Employer_ID, o.Service_ID, o.Amount, o.PayMethod, o.Status, o.Date, "
                + "e.EmployerName, e.Company_Name, e.Email, e.PhoneNumber, e.Location, e.URL_Website, e.imgLogo, "
                + "s.Service_Name, s.Price, s.Description, s.Duration "
                + "FROM Orders o "
                + "JOIN Employer e ON o.Employer_ID = e.Employer_ID "
                + "JOIN Service s ON o.Service_ID = s.Service_ID "
                + "ORDER BY o.Date DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("Order_ID"));
                order.setEmployerId(rs.getInt("Employer_ID"));
                order.setServiceId(rs.getInt("Service_ID"));
                order.setAmount(rs.getDouble("Amount"));
                order.setPayMethod(rs.getString("PayMethod"));
                order.setStatus(rs.getString("Status"));
                order.setDate(rs.getTimestamp("Date"));

                // Set Employer
                Employer emp = new Employer();
                emp.setEmployerId(rs.getInt("Employer_ID"));
                emp.setNameEmployer(rs.getString("EmployerName"));
                emp.setCompanyName(rs.getString("Company_Name"));
                emp.setEmail(rs.getString("Email"));
                emp.setPhoneNumber(rs.getString("PhoneNumber"));
                emp.setLocation(rs.getString("Location"));
                emp.setUrlWebsite(rs.getString("URL_Website"));
                emp.setImgLogo(rs.getString("imgLogo"));
                order.setEmployer(emp);

                // Set Service
                Service service = new Service();
                service.setServiceId(rs.getInt("Service_ID"));
                service.setServiceName(rs.getString("Service_Name"));
                service.setPrice(rs.getDouble("Price"));
                service.setDescription(rs.getString("Description"));
                service.setDuration(rs.getInt("Duration"));
                order.setService(service);

                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void updateExpiredOrdersBasedOnDuration() {
        String sql = "UPDATE Orders SET Status = 'expired' "
                + "WHERE Status = 'success' AND EXISTS ("
                + "  SELECT 1 FROM Service "
                + "  WHERE Service.Service_ID = Orders.Service_ID "
                + "  AND DATEADD(DAY, Orders.Duration, Orders.Date) <= GETDATE()"
                + ")";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int rows = ps.executeUpdate();
            System.out.println("Updated " + rows + " expired orders based on duration.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean hasSuccessfulOrderWithService(int employerId, int serviceId) {
        String sql = "SELECT 1 FROM Orders WHERE Employer_ID = ? "
                + "AND Service_ID = ? AND Status = 'success'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, employerId);
            ps.setInt(2, serviceId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteOrderById(int orderId) throws SQLException {
        String sql = "DELETE FROM Orders WHERE Order_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }

    public List<Order> getOrdersByMonthAndYear(Integer month, Integer year) {
    List<Order> list = new ArrayList<>();
    String sql = "SELECT o.Order_ID, o.Employer_ID, o.Service_ID, o.Amount, o.PayMethod, o.Status, o.Date, "
            + "e.EmployerName, e.Company_Name, e.Email, e.PhoneNumber, e.Location, e.URL_Website, e.imgLogo, "
            + "s.Service_Name, s.Price, s.Description, s.Duration "
            + "FROM Orders o "
            + "JOIN Employer e ON o.Employer_ID = e.Employer_ID "
            + "JOIN Service s ON o.Service_ID = s.Service_ID "
            + "WHERE 1=1";

    if (month != null) {
        sql += " AND MONTH(o.Date) = ?";
    }
    if (year != null) {
        sql += " AND YEAR(o.Date) = ?";
    }

    sql += " ORDER BY o.Date DESC";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        int index = 1;
        if (month != null) {
            ps.setInt(index++, month);
        }
        if (year != null) {
            ps.setInt(index++, year);
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Order order = new Order();
            order.setOrderId(rs.getInt("Order_ID"));
            order.setEmployerId(rs.getInt("Employer_ID"));
            order.setServiceId(rs.getInt("Service_ID"));
            order.setAmount(rs.getDouble("Amount"));
            order.setPayMethod(rs.getString("PayMethod"));
            order.setStatus(rs.getString("Status"));
            order.setDate(rs.getTimestamp("Date"));

            // Set Employer
            Employer emp = new Employer();
            emp.setEmployerId(rs.getInt("Employer_ID"));
            emp.setNameEmployer(rs.getString("EmployerName"));
            emp.setCompanyName(rs.getString("Company_Name"));
            emp.setEmail(rs.getString("Email"));
            emp.setPhoneNumber(rs.getString("PhoneNumber"));
            emp.setLocation(rs.getString("Location"));
            emp.setUrlWebsite(rs.getString("URL_Website"));
            emp.setImgLogo(rs.getString("imgLogo"));
            order.setEmployer(emp);

            // Set Service
            Service service = new Service();
            service.setServiceId(rs.getInt("Service_ID"));
            service.setServiceName(rs.getString("Service_Name"));
            service.setPrice(rs.getDouble("Price"));
            service.setDescription(rs.getString("Description"));
            service.setDuration(rs.getInt("Duration"));
            order.setService(service);

            list.add(order);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}


}
