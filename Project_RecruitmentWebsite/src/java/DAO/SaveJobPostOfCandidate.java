package DAO;

import dal.DBContext;
import java.sql.*;

public class SaveJobPostOfCandidate extends DBContext {

    // chèn vào jobPost (đẫ test)
    public String getCandidateIDByName(String accountName) {
        try {

            String query = "SELECT [Candidate_ID]\n"
                    + "      ,[CandidateName]\n"
                    + "  FROM [dbo].[Candidate]\n"
                    + "  Where CandidateName like ?";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, accountName);

            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                return rs.getString("Candidate_ID");
            }

        } catch (SQLException s) {
            System.out.println("Bug  SQL 1:" + s.getMessage());
        }
        return "";
    }

    // chèn vào jobPost  (đã test)
    public boolean saveJobPost(String candidateID, String jobPostID) {
        try {

            String query = "INSERT INTO [dbo].[SavedJob]\n"
                    + "           ([Candidate_ID]\n"
                    + "           ,[JobPost_ID]\n"
                    + "           )\n"
                    + "     VALUES (?,?)";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, candidateID);
            push.setString(2, jobPostID);

            int result = push.executeUpdate();

            if (result != 0) {
                System.out.println("Lưu Thành Công");
            } else {
                System.out.println("Lưu Thất Bại");
            }

            return result != 0;

        } catch (SQLException s) {
            System.out.println("Bug  SQL 2:" + s.getMessage());
        }

        return false;
    }

      // lấy số lượng jobpost của 1 thằng  (đã test)
    public int getNumberJobPostSavedByCandidate(String idCandidate) {
        try {

            String query = "SELECT count(s1.Candidate_ID) as Result \n"
                    + "FROM [dbo].[SavedJob] s1\n"
                    + "Where s1.Candidate_ID=?\n"
                    + "group by s1.Candidate_ID";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, idCandidate);
          

            ResultSet  rs  = push.executeQuery();
            while (rs.next()) {              
              return rs.getInt("Result");
            }

        } catch (SQLException s) {
            System.out.println("Bug  SQL 3:" + s.getMessage());
        }

        return 0;
    }

    public static void main(String[] args) {
        SaveJobPostOfCandidate o = new SaveJobPostOfCandidate();
//        System.out.println(o.getCandidateIDByName("Nguyễn Văn A"));

        // System.out.println(o.saveJobPost("12","14"));
        System.out.println(o.getNumberJobPostSavedByCandidate("16"));
    }
}
