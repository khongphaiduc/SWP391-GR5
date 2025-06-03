package DAO;

import Models.Employer;
import dal.DBContext;
import java.sql.*;

public class EmployerDAO extends DBContext {

    public Employer getEmployerByName(String nameEmployer) {
        Employer employer = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT * FROM Employer WHERE EmployerName = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, nameEmployer);
            rs = stmt.executeQuery();

            if (rs.next()) {
                employer = new Employer();
                employer.setEmployerId(rs.getInt("Employer_ID"));
                employer.setNameEmployer(rs.getString("EmployerName"));
                employer.setEmail(rs.getString("Email"));
                employer.setPasswordHash(rs.getString("Password_hash"));
                employer.setCompanyName(rs.getString("Company_Name"));
                employer.setDescription(rs.getString("Description"));
                employer.setLocation(rs.getString("Location"));
                employer.setUrlWebsite(rs.getString("URL_Website"));
                employer.setCompanySize(rs.getString("CompanySize"));
                employer.setImgLogo(rs.getBytes("imgLogo"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return employer;
    }
}
