package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

 
public class UpdateStepDAO extends DBContext{

    /**
     * Cập nhật Step cho Apply nếu Employer có quyền sở hữu JobPost tương ứng.
     * @param applyId ID của lượt Apply
     * @param newStep Bước mới (VD: "Đã phỏng vấn")
     * @param employerId ID của employer đang đăng nhập
     * @return true nếu cập nhật thành công
     * @throws SQLException nếu lỗi xảy ra trong DB
     */
    public boolean updateStep(int applyId, String newStep, int employerId) throws SQLException {
        String checkSQL = "SELECT 1 FROM Apply A " +
                          "JOIN JobPost J ON A.JobPost_ID = J.JobPost_ID " +
                          "WHERE A.Apply_ID = ? AND J.Employer_ID = ?";

        String updateSQL = "UPDATE Apply SET Step = ? WHERE Apply_ID = ?";

        try (PreparedStatement checkStmt = connection.prepareStatement(checkSQL)){          
            checkStmt.setInt(1, applyId);
            checkStmt.setInt(2, employerId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Employer có quyền → tiến hành cập nhật Step
                try (PreparedStatement updateStmt = connection.prepareStatement(updateSQL)) {
                    updateStmt.setString(1, newStep);
                    updateStmt.setInt(2, applyId);
                    int rowsAffected = updateStmt.executeUpdate();
                    return rowsAffected > 0;
                }
            }
        }
        return false; // Không có quyền hoặc lỗi
    }
    public static void main(String[] args) {
    UpdateStepDAO dao = new UpdateStepDAO();

    int applyId = 5;          // ID hồ sơ Apply bạn muốn test
    String newStep = "Đã phỏng vấn"; // Bước mới bạn muốn cập nhật
    int employerId = 4;         // ID của Employer (phải là chủ JobPost)

    try {
        boolean result = dao.updateStep(applyId, newStep, employerId);
        if (result) {
            System.out.println("✔ Cập nhật step thành công.");
        } else {
            System.out.println("✖ Không thể cập nhật step (có thể sai employer hoặc applyId).");
        }
    } catch (SQLException e) {
        System.out.println("❌ Lỗi SQL: " + e.getMessage());
    }
}

}
