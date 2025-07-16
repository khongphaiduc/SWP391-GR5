package DAO;

import dal.DBContext;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.*;
// InputStream  1 lớp giúp chuyển hóa từ các file thành đoạn mã nhị phân 

public class SupportUserDAO extends DBContext {

    // gửi báo cáo 
    public boolean sendReportAndFeebBack(String senderID, String senderRole, String phone, String title, String content, String urlImage, String adminID) {
        try {
            String sql = "INSERT INTO [dbo].[FeedbackReport]\n"
                    + "           ([sender_id]\n"
                    + "           ,[sender_role]\n"
                    + "           ,[phone_sender]\n"
                    + "           ,[title]\n"
                    + "           ,[content]\n"
                    + "           ,[image_Report]\n"
                    + "           ,[Admin_ID])\n"
                    + "     VALUES\n"
                    + "           (?,?,?,?,?,?,?)";

            PreparedStatement push = connection.prepareStatement(sql);
            push.setString(1, senderID);
            push.setString(2, senderRole);
            push.setString(3, phone);
            push.setString(4, title);
            push.setString(5, content);
            push.setString(6, urlImage);
            push.setString(7, adminID);

            int result = push.executeUpdate();

            System.out.println(result != 0 ? "Gửi feedback thành công" : "Gửi feedback thất bại");
            return result != 0;

        } catch (Exception e) {
            System.out.println("Bug ở SupportUserDAO :"+e.getMessage());
        }
        return false;
    }

    public static void main(String[] args) {
        try {
            SupportUserDAO dao = new SupportUserDAO();

            String senderID = "1";
            String senderRole = "candidate";
            String title = "Test báo cáo";
            String content = "Nội dung báo cáo test";
            String adminID = "1";

            File file = new File("D:\\logo.png");
            InputStream image = new FileInputStream(file);
            long imageSize = file.length();

            boolean result = dao.sendReportAndFeebBack(senderID, senderRole, title, title, content, title, adminID);
            System.out.println("Kết quả: " + (result ? "Thành công" : "Thất bại"));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
