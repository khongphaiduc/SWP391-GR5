/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Employer;
import dal.DBContext;
import java.sql.*;

/**
 *
 * @author PC
 */
public class EmployerDAO extends DBContext {

    public Employer getEmployerByAccountName(String username) {
        Employer employer = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT e.*, a.Account_Name, a.Email AS AccountEmail "
                    + "FROM Employers e "
                    + "JOIN Account a ON e.Account_ID = a.Account_ID "
                    + "WHERE a.Account_Name = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();

            if (rs.next()) {

                employer = new Employer();
                employer.setEmployerId(rs.getInt("Employer_ID"));
                employer.setNameEmployer(rs.getString("Name_Employer"));
                employer.setAccountId(rs.getInt("Account_ID"));
                employer.setCompanyName(rs.getString("Company_Name"));
                employer.setDescription(rs.getString("Description"));
                employer.setLocation(rs.getString("Location"));
                employer.setUrlWebsite(rs.getString("URL_Website"));
                employer.setCompanySize(rs.getString("CompanySize"));
                employer.setImgLogo(rs.getBytes("imgLogo"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return employer;
    }

}
