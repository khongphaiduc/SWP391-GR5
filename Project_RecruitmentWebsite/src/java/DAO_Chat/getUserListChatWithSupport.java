/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO_Chat;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class getUserListChatWithSupport extends dal.DBContext {

    
     // truy vấn database  lấy danh sách nhưng thằng đã từng chát với support
    public List<String> getUserListChatWithSupports(String suppport) {
        List<String> listNameUser = new ArrayList<>();
        String sql = "select distinct s1.SenderUsername\n"
                + "from [dbo].[ChatHistory] s1\n"
                + "Where [ReceiverUsername]=?";
        try {
            PreparedStatement push = connection.prepareStatement(sql);
            push.setString(1, suppport);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                listNameUser.add(rs.getString("SenderUsername"));
            }
            return listNameUser;
        } catch (SQLException e) {
            System.out.println("Bug tại Class  getUserListChatWithSupport với nội dung :" + e.getMessage());
        }
        return new ArrayList<>();
    }
    
    
    public static void main(String[] args) {
        getUserListChatWithSupport  o  =  new getUserListChatWithSupport();
        
        o.getUserListChatWithSupports("ducadmin").forEach( s->  System.out.println(s));
       
    }
}
