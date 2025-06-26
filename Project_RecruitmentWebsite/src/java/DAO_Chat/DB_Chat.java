
package DAO_Chat;


import Models.Message;
import java.sql.*;
import dal.DBContext;


// lưu tin nhắn
public class DB_Chat extends DBContext {

     // chèn  message vào database 
    public void saveMessage(Message msg) {
        String sql = "INSERT INTO ChatHistory (SenderUsername, ReceiverUsername, Message) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, msg.from);
            ps.setString(2, msg.to);
            ps.setString(3, msg.message);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
    public static void main(String[] args) {
         DB_Chat  chat = new DB_Chat();
       chat.saveMessage(new Message("admin", "hihi", "test", "test"));
    }
}
