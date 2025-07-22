/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Notification;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class NotificationDAO extends DBContext {

    // Lấy danh sách thông báo theo role ('Candidate', 'Employer', 'Admin') hoặc 'All'
    public List<Notification> getNotificationsForRole(String role) throws SQLException {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM Notification WHERE roleTarget = ? OR roleTarget = 'All' ORDER BY createdAt DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, role);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    notifications.add(mapResultSetToNotification(rs));
                }
            }
        }
        return notifications;
    }

    public Notification getNotificationById(int id) throws SQLException {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM Notification WHERE id=? ORDER BY createdAt DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    notifications.add(mapResultSetToNotification(rs));
                }
            }
        }
        return notifications.get(0);
    }

    // Lấy tất cả thông báo
    public List<Notification> getAllNotifications(Date fromDate, Date toDate) throws SQLException {
        List<Notification> notifications = new ArrayList<>();

        String sql = "SELECT * FROM Notification WHERE 1=1";
        if (fromDate != null) {
            sql += " AND createdAt >= ?";
        }
        if (toDate != null) {
            sql += " AND createdAt <= ?";
        }
        sql += " ORDER BY createdAt DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;

            if (fromDate != null) {
                ps.setDate(index++, new java.sql.Date(fromDate.getTime()));
            }
            if (toDate != null) {
                ps.setDate(index++, new java.sql.Date(toDate.getTime()));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    notifications.add(mapResultSetToNotification(rs));
                }
            }
        }

        return notifications;
    }

    // Thêm thông báo mới
    public boolean addNotification(Notification noti) throws SQLException {
        String sql = "INSERT INTO Notification (title, content, createdAt, roleTarget) VALUES (?, ?, GETDATE(), ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, noti.getTitle());
            stmt.setString(2, noti.getContent());
            stmt.setString(3, noti.getRoleTarget());
            return stmt.executeUpdate() > 0;
        }
    }

    // Xóa thông báo theo id
    public boolean deleteNotification(int id) throws SQLException {
        String sql = "DELETE FROM Notification WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
    // Cập nhật nội dung thông báo theo ID

    public boolean updateNotification(Notification noti) throws SQLException {
        String sql = "UPDATE Notification SET title = ?, content = ?, roleTarget = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, noti.getTitle());
            stmt.setString(2, noti.getContent());
            stmt.setString(3, noti.getRoleTarget());
            stmt.setInt(4, noti.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    // Helper để map từ ResultSet sang đối tượng Notification
    private Notification mapResultSetToNotification(ResultSet rs) throws SQLException {
        return new Notification(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("content"),
                rs.getTimestamp("createdAt"),
                rs.getString("roleTarget")
        );
    }

}
