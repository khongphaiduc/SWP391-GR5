package DAO;

import dal.DBContext;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.*;
// InputStream  1 lớp giúp chuyển hóa từ các file thành đoạn mã nhị phân 
public class SupportUserDAO extends DBContext {

    // gửi báo cáo 
    public boolean sendReport(String senderID, String senderRole, String title, String content, InputStream image, long imageSize, String adminID) {
        try {
            String sql = "INSERT INTO [dbo].[FeedbackReport] "
                    + "([sender_id], [sender_role], [type], [title], [content], [status], [image_Report], [Admin_ID]) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement push = connection.prepareStatement(sql);
            push.setString(1, senderID);
            push.setString(2, senderRole);
            push.setString(3, "Report");
            push.setString(4, title);
            push.setString(5, content);
            push.setString(6, "pending");
            push.setBinaryStream(7, image, imageSize); // tối ưu hơn
            push.setString(8, adminID);

            int result = push.executeUpdate();

            System.out.println(result != 0 ? "Gửi feedback thành công" : "Gửi feedback thất bại");
            return result != 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        try {
            SupportUserDAO dao = new SupportUserDAO(); 

            String senderID = "123";
            String senderRole = "candidate";
            String title = "Test báo cáo";
            String content = "Nội dung báo cáo test";
            String adminID = "1";

          
            File file = new File("D:\\logo.png");
            InputStream image = new FileInputStream(file);
            long imageSize = file.length();

            boolean result = dao.sendReport(senderID, senderRole, title, content, image, imageSize, adminID);
            System.out.println("Kết quả: " + (result ? "Thành công" : "Thất bại"));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
