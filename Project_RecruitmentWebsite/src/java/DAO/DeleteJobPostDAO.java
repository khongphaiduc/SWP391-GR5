
package DAO;
import dal.DBContext;
import java.sql.*;

/**
 *
 * @author pham trung duc , phương thức xóa job đã lưu
 */
public class DeleteJobPostDAO extends DBContext {

    // xóa jobpost đẫ lưu (đã test)
    public boolean deleteJobPost(String iDJobPostSaved) {
        try {

            String query = "DELETE FROM [dbo].[SavedJob]\n"
                    + "      WHERE [SavedJob_ID] = ?";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, iDJobPostSaved);

            int row = push.executeUpdate();

            return row != 0 ? true : false;
        } catch (SQLException s) {
            System.out.println("Bug  SQL 1:" + s.getMessage());
        }
        return false;
    }
    
    public static void main(String[] args) {
        DeleteJobPostDAO   o = new DeleteJobPostDAO();
        System.out.println(o.deleteJobPost("279"));
    }
}
