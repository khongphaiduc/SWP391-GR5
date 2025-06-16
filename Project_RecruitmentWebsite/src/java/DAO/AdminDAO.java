/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.EncodePassword;
import MyService.MyEmail;
import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class AdminDAO extends DBContext{
     public boolean isNameUser(String account) {
        try {
            String query = "SELECT [Username]  \n"
                    + "  FROM [dbo].[Admin]\n"
                    + "  where Username = ?";
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, account);
            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                String result = rs.getString("Username");
                if (result.equals(account)) {
                    return true;
                }
            }

        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());
        }
        return false;
    }
     
        public boolean registerAdmin(String account, String password) {
        try {
            String query = "INSERT INTO [dbo].[Admin]\n"
                    + "           ([Username]          \n"
                    + "           ,[Password_hash] )\n"
                    + "     VALUES (?,?)";

            String passwordHash = EncodePassword.encodePasswordbyHash(password);  // encode trước khi lưu vào database 

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, account);

            push.setString(2, passwordHash);

            int row = push.executeUpdate();

            System.out.println(row + " dòng đã được thêm");
     
          
            return row != 0;
        } catch (SQLException s) {
            System.out.println("Lỗi SQL: " + s.getMessage());
        }
        return false;
    }
     
}
