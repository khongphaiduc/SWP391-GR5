/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO_Chat;

import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Models.*;

/**
 *
 * @author Admin
 */
public class GetMessage extends DBContext {

    public List<LiveChat> getNewMessages(String senderID, String receiverID, int lastMessageId) {
        List<LiveChat> listMessage = new ArrayList<>();
        String query = "SELECT Message_ID, Sender_ID, Sender_Role, Receiver_ID, Receiver_Role, Content, SentAt, IsRead "
                + "FROM ChatMessage "
                + "WHERE ((Sender_ID = ? AND Receiver_ID = ?) OR (Sender_ID = ? AND Receiver_ID = ?)) "
                + "AND Message_ID > ? "
                + "ORDER BY SentAt ASC";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, senderID);
            ps.setString(2, receiverID);
            ps.setString(3, receiverID); // đảo ngược để lấy cả 2 chiều
            ps.setString(4, senderID);
            ps.setInt(5, lastMessageId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listMessage.add(new LiveChat(
                        rs.getInt("Message_ID"),
                        rs.getString("Sender_ID"),
                        rs.getString("Sender_Role"),
                        rs.getString("Receiver_ID"),
                        rs.getString("Receiver_Role"),
                        rs.getDate("SentAt"),
                        rs.getString("Content"),
                        rs.getInt("IsRead")
                ));
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy tin nhắn mới: " + e.getMessage());
        }
        return listMessage;
    }

    public static void main(String[] args) {
        GetMessage o = new GetMessage();

       o.getNewMessages("21", "1",0).forEach(s-> System.out.println(s.content));
       

    }

}
