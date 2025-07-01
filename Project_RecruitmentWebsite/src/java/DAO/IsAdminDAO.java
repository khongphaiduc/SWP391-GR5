/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.EncodePassword;
import java.sql.*;
import dal.DBContext;

/**
 *
 * @author pham trung duc
 */
public class IsAdminDAO extends DBContext {

    public boolean isAdmin(String accountName) {

        try {

            String query = "SELECT [Admin_ID]\n"
                    + "      ,[Username]\n"
                    + "      ,[Password_hash]\n"
                    + "  FROM [dbo].[Admin]\n"
                    + "  Where Username like ?";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, accountName);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                return rs.getString("Username").equals(accountName);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;

    }

    // đăng nhập  Admin  (đẫ test)
    public boolean LogInAccountAdmin(String accountAdmin, String passwordAdmin) {
        try {
            String query = "SELECT [Admin_ID]\n"
                    + "      ,[Username]\n"
                    + "      ,[Password_hash]\n"
                    + "  FROM [dbo].[Admin]\n"
                    + "  Where Username like ?";

           String passwordHash = EncodePassword.encodePasswordbyHash(passwordAdmin);  // encode 

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, accountAdmin);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                String getpasswordEncodeInBase = rs.getString("Password_hash");
                if (passwordHash.equals(getpasswordEncodeInBase)) { // thay bien thanh passwordHash thanh passwordAdmin de chay 
                    return true;
                }
            }

        } catch (SQLException s) {
            System.out.println("Lỗi SQL: " + s.getMessage());
        }
        return false;
    }

    public static void main(String[] args) {
        IsAdminDAO o = new IsAdminDAO();
        //System.out.println(EncodePassword.encodePasswordbyHash("123456"));
        System.out.println(o.isAdmin("admin99"));
        System.out.println(o.LogInAccountAdmin("admin99", "123456"));
    }
}
