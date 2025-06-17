package DAO;

import Models.Employer;
import dal.DBContext;
import java.io.InputStream;
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

                Blob logoBlob = rs.getBlob("imgLogo");
                if (logoBlob != null) {
                    employer.setImgLogo(logoBlob.getBinaryStream());
                }

                employer.setPhoneNumber(rs.getString("PhoneNumber"));
            }
        } catch (Exception e) {
            System.err.println("Error in getEmployerByName: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt);
        }

        return employer;
    }

    /**
     * Update employer với image
     */
    public boolean updateEmployer(String nameEmployer, String email, String description,
            String location, String urlWebsite, String companyName,
            InputStream imgLogoStream, String phoneNumber) {

        PreparedStatement stmt = null;
        boolean isUpdated = false;

        try {
            String sql = "UPDATE Employer SET Email = ?, Description = ?, Location = ?, "
                    + "URL_Website = ?, Company_Name = ?, PhoneNumber = ?, imgLogo = ? "
                    + "WHERE EmployerName = ?";

            stmt = connection.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, description);
            stmt.setString(3, location);
            stmt.setString(4, urlWebsite);
            stmt.setString(5, companyName);
            stmt.setString(6, phoneNumber);
            stmt.setBlob(7, imgLogoStream);
            stmt.setString(8, nameEmployer);

            int rows = stmt.executeUpdate();
            isUpdated = rows > 0;

            System.out.println("Update with image - Rows affected: " + rows);

        } catch (SQLException e) {
            System.err.println("SQL Error in updateEmployer (with image): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeStatement(stmt);
        }

        return isUpdated;
    }

    /**
     * Update employer không có image (chỉ update text fields)
     */
    public boolean updateEmployerWithoutImage(String nameEmployer, String email,
            String description, String location, String urlWebsite,
            String companyName, String phoneNumber) {

        PreparedStatement stmt = null;
        boolean isUpdated = false;

        try {
            String sql = "UPDATE Employer SET Email = ?, Description = ?, Location = ?, "
                    + "URL_Website = ?, Company_Name = ?, PhoneNumber = ? "
                    + "WHERE EmployerName = ?";

            stmt = connection.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, description);
            stmt.setString(3, location);
            stmt.setString(4, urlWebsite);
            stmt.setString(5, companyName);
            stmt.setString(6, phoneNumber);
            stmt.setString(7, nameEmployer);

            int rows = stmt.executeUpdate();
            isUpdated = rows > 0;

            System.out.println("Update without image - Rows affected: " + rows);

        } catch (SQLException e) {
            System.err.println("SQL Error in updateEmployerWithoutImage: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeStatement(stmt);
        }

        return isUpdated;
    }

    /**
     * Kiểm tra email đã tồn tại chưa (để validate khi update)
     */
    public boolean isEmailExists(String email, String currentEmployerName) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean exists = false;

        try {
            String sql = "SELECT COUNT(*) FROM Employer WHERE Email = ? AND EmployerName != ?";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, currentEmployerName);
            rs = stmt.executeQuery();

            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt);
        }

        return exists;
    }

    /**
     * Kiểm tra phone number đã tồn tại chưa
     */
    public boolean isPhoneExists(String phoneNumber, String currentEmployerName) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean exists = false;

        try {
            String sql = "SELECT COUNT(*) FROM Employer WHERE PhoneNumber = ? AND EmployerName != ?";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, phoneNumber);
            stmt.setString(2, currentEmployerName);
            rs = stmt.executeQuery();

            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking phone existence: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, stmt);
        }

        return exists;
    }

    /**
     * Helper method để đóng resources
     */
    private void closeResources(ResultSet rs, PreparedStatement stmt) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        } catch (SQLException ex) {
            System.err.println("Error closing resources: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    /**
     * Helper method để đóng statement
     */
    private void closeStatement(PreparedStatement stmt) {
        try {
            if (stmt != null) {
                stmt.close();
            }
        } catch (SQLException ex) {
            System.err.println("Error closing statement: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}
