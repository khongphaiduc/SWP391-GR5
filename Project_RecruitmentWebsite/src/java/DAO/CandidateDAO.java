/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.*;
import java.sql.*;

import dal.DBContext;

/**
 *
 * @author PC
 */
public class CandidateDAO extends DBContext {

    public Candidate getCandidateByAccountName(String username) {
        Candidate candidate = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            DBContext dBContext = new DBContext();

            String sql = "SELECT c.*, a.Account_Name, a.Email AS AccountEmail "
                    + "FROM Candidate c "
                    + "JOIN Account a ON c.Account_ID = a.Account_ID "
                    + "WHERE a.Account_Name = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();

            if (rs.next()) {
                candidate = new Candidate();
                candidate.setCandidateId(rs.getInt("Candidate_ID"));
                candidate.setCandidateName(rs.getString("CandidateName"));
                candidate.setAddress(rs.getString("Address"));
                candidate.setEmail(rs.getString("Email")); 
                candidate.setBirthday(rs.getDate("Birthday"));
                candidate.setNationality(rs.getString("Nationality"));
                candidate.setAccountId(rs.getInt("Account_ID"));
                
            }

        } catch (Exception e) {
            e.printStackTrace();
        
        }

        return candidate;
    }

}
