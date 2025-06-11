package DAO;

import dal.DBContext;
import java.sql.*;

public class FeedBackDAO extends DBContext {

    // gửi feedback từ thằng user (đã test)
    public boolean sendFeedBack(String senderID, String serderRole, String titel, String content, String adminID) {

        try {
            String sql = "INSERT INTO [dbo].[FeedbackReport]\n"
                    + "           ([sender_id]\n"
                    + "           ,[sender_role]\n"
                    + "           ,[type]\n"
                    + "           ,[title]\n"
                    + "           ,[content]\n"
                    + "           ,[status]          \n"
                    + "           ,[Admin_ID])\n"
                    + "     VALUES\n"
                    + "           (?,?,?,?,?,?,?)";
            PreparedStatement push = connection.prepareStatement(sql);
            push.setString(1, senderID);
            push.setString(2, serderRole);
            push.setString(3, "Feedback");
            push.setString(4, titel);
            push.setString(5, content);
            push.setString(6, "pending");
            push.setString(7, adminID);

            int result = push.executeUpdate();

            if (result != 0) {
                System.out.println("Gửi feedback thành công ");
            } else {
                System.out.println("Gửi feedback thành công ");
            }
            return result != 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();

        }
        return false;
    }
    
    // lấy Id của thằng user 
    
    
    public static void main(String[] args) {
        FeedBackDAO o = new FeedBackDAO();
        System.out.println(o.sendFeedBack("12", "Employer", "Test times 2", "hahaha", "1"));
    }
}
