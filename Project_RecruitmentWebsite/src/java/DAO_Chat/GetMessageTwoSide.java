package DAO_Chat;

import Models.Message;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class GetMessageTwoSide extends dal.DBContext {
   
    
     // lấy message
    public List<Message> getMessagesBetween(String user1, String user2) {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM ChatHistory WHERE (SenderUsername = ? AND ReceiverUsername = ?) OR (SenderUsername = ? AND ReceiverUsername = ?) ORDER BY ID ASC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user1);
            ps.setString(2, user2);
            ps.setString(3, user2);
            ps.setString(4, user1);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Message msg = new Message(rs.getString("SenderUsername"), rs.getString("ReceiverUsername"), rs.getString("Message"), ""); // hoặc thêm ảnh nếu có
                messages.add(msg);
            }
        } catch (SQLException e) {
            System.out.println("Bug tại GetMessageTwoSide với nội dung : " + e.getMessage());
        }
        return messages;
    }

    public static void main(String[] args) {
        GetMessageTwoSide o = new GetMessageTwoSide();

        o.getMessagesBetween("ducadmin", "ptrungduc1011@gmail.com").forEach(s -> System.out.println(s.toString()));
    }
}
