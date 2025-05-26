/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.*;
import Models.CV;
import dal.DBContext;
import java.sql.*;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class AccountDAO extends DBContext {

    public Account getAccountByUserName(String username) {
        List<Account> accountList = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            DBContext dBContext = new DBContext();
            String sql = "SELECT * FROM Account WHERE Account_Name = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Account account = new Account();
                account.setAccountId(rs.getInt("Account_ID"));
                account.setAccountName(rs.getString("Account_Name"));
                account.setEmail(rs.getString("Email"));
                account.setPasswordHash(rs.getString("Password_hash"));
                account.setRole(rs.getString("Role"));
                Timestamp timestamp = rs.getTimestamp("date_cr");
                if (timestamp != null) {
                    account.setDateCreated(timestamp.toLocalDateTime());
                }
                accountList.add(account);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return accountList.isEmpty() ? null : accountList.get(0);
    }

}
