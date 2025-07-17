package DAO;

import Models.Promotion;
import dal.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PromotionDAO extends DBContext {

    // Thêm khuyến mãi mới
    public boolean addPromotion(Promotion promo) {
        String sql = "INSERT INTO Promotion (Code, Discount, Date_St, Date_En) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, promo.getCode());
            ps.setDouble(2, promo.getDiscount());
            ps.setTimestamp(3, new Timestamp(promo.getDateStart().getTime()));
            ps.setTimestamp(4, new Timestamp(promo.getDateEnd().getTime()));
            return ps.executeUpdate() > 0;
        } catch (SQLIntegrityConstraintViolationException e) {
            System.out.println("⚠️ Mã khuyến mãi đã tồn tại: " + promo.getCode());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy tất cả khuyến mãi
    public List<Promotion> getAllPromotions() {
        List<Promotion> list = new ArrayList<>();
        String sql = "SELECT * FROM Promotion ORDER BY date_cr DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapPromotion(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy khuyến mãi theo ID
    public Promotion getPromotionById(int id) {
        String sql = "SELECT * FROM Promotion WHERE Promotion_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapPromotion(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy khuyến mãi theo mã CODE
    public Promotion getPromotionByCode(String code) {
        String sql = "SELECT * FROM Promotion WHERE Code = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapPromotion(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật khuyến mãi
    public boolean updatePromotion(Promotion promo) {
        String sql = "UPDATE Promotion SET Code = ?, Discount = ?, Date_St = ?, Date_En = ? WHERE Promotion_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, promo.getCode());
            ps.setDouble(2, promo.getDiscount());
            ps.setTimestamp(3, new Timestamp(promo.getDateStart().getTime()));
            ps.setTimestamp(4, new Timestamp(promo.getDateEnd().getTime()));
            ps.setInt(5, promo.getPromotionId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xoá khuyến mãi
    public boolean deletePromotion(int promoId) {
        String sql = "DELETE FROM Promotion WHERE Promotion_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, promoId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy các khuyến mãi đang hoạt động (tại thời điểm hiện tại)
    public List<Promotion> getActivePromotions() {
        List<Promotion> list = new ArrayList<>();
        String sql = "SELECT * FROM Promotion WHERE GETDATE() BETWEEN Date_St AND Date_En";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapPromotion(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper mapping từ ResultSet → Promotion
    private Promotion mapPromotion(ResultSet rs) throws SQLException {
        Promotion p = new Promotion();
        p.setPromotionId(rs.getInt("Promotion_ID"));
        p.setCode(rs.getString("Code"));
        p.setDiscount(rs.getDouble("Discount"));
        p.setDateStart(rs.getTimestamp("Date_St"));
        p.setDateEnd(rs.getTimestamp("Date_En"));
        p.setDateCreated(rs.getTimestamp("date_cr"));
        return p;
    }

    // ------------------------- Test -------------------------
    public static void main(String[] args) {
        PromotionDAO dao = new PromotionDAO();
        List<Promotion> active = dao.getActivePromotions();
        for (Promotion p : active) {
            System.out.println("🔸 " + p.getCode() + " (" + p.getDiscount() + "%)");
        }
    }
}
