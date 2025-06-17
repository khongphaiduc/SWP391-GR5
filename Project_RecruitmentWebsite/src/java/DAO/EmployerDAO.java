package DAO;

import Models.Employer;
import dal.DBContext;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployerDAO extends DBContext {
     public Employer getEmployerById(int id) {
        String sql = "SELECT * FROM Employer WHERE Employer_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Employer emp = new Employer();
                emp.setEmployerId(rs.getInt("Employer_ID"));
                emp.setNameEmployer(rs.getString("EmployerName"));
                emp.setEmail(rs.getString("Email"));
                emp.setPasswordHash(rs.getString("Password_hash"));
                emp.setCompanyName(rs.getString("Company_Name"));
                emp.setDescription(rs.getString("Description"));
                emp.setLocation(rs.getString("Location"));
                emp.setUrlWebsite(rs.getString("URL_Website"));
                emp.setCompanySize(rs.getString("CompanySize"));
     
                return emp;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

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
    public int getTotalEmployersByName(String name) {
    String sql = "SELECT COUNT(*) FROM Employer WHERE EmployerName LIKE ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, "%" + name + "%");
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        rs.close();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}
      public List<Employer> getAllEmployers() {
    List<Employer> list = new ArrayList<>();
    String sql = "SELECT * FROM Employer";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Employer emp = new Employer();
            emp.setEmployerId(rs.getInt("Employer_ID"));
            emp.setNameEmployer(rs.getString("EmployerName"));
            emp.setEmail(rs.getString("Email"));
            emp.setPasswordHash(rs.getString("Password_hash"));
            emp.setCompanyName(rs.getString("Company_Name"));
            emp.setDescription(rs.getString("Description"));
            emp.setLocation(rs.getString("Location"));
            emp.setUrlWebsite(rs.getString("URL_Website"));
            emp.setCompanySize(rs.getString("CompanySize"));

            list.add(emp);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    
     public List<Employer> getEmployersByPage(int offset, int recordsPerPage) {
    List<Employer> list = new ArrayList<>();
    String sql = "SELECT * FROM Employer ORDER BY Employer_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, offset);
        ps.setInt(2, recordsPerPage);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Employer e = new Employer();
            e.setEmployerId(rs.getInt("Employer_ID"));
            e.setNameEmployer(rs.getString("EmployerName"));
            e.setEmail(rs.getString("Email"));
            e.setPasswordHash(rs.getString("Password_hash"));
            e.setCompanyName(rs.getString("Company_Name"));
            e.setDescription(rs.getString("Description"));
            e.setLocation(rs.getString("Location"));
            e.setUrlWebsite(rs.getString("URL_Website"));
            e.setCompanySize(rs.getString("CompanySize"));
      
            list.add(e);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}  
     public void deleteEmployer(int id) {
        String sql = "DELETE FROM Employer WHERE Employer_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
     


public int countEmployers() {
    int count = 0;
    String sql = "SELECT COUNT(*) FROM Employer";
    try (PreparedStatement stmt = connection.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {
        if (rs.next()) {
            count = rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}
 public List<Employer> searchEmployersByName(String name, int offset, int limit) {
    List<Employer> employers = new ArrayList<>();
    String sql = "SELECT Employer_ID, EmployerName, Email FROM Employer WHERE EmployerName LIKE ? " +
                 "ORDER BY Employer_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, "%" + name + "%");
        ps.setInt(2, offset);
        ps.setInt(3, limit);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Employer emp = new Employer();
            emp.setEmployerId(rs.getInt("Employer_ID"));
            emp.setNameEmployer(rs.getString("EmployerName"));
            emp.setEmail(rs.getString("Email"));
            employers.add(emp);
        }
        rs.close();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return employers;
}
 public static void main(String[] args) {
        // Khởi tạo EmployerDAO
        EmployerDAO employerDAO = new EmployerDAO();

        // Tham số test
        String searchKeyword = "A"; // Từ khóa tìm kiếm
        int page = 1;                 // Trang hiện tại
        int recordsPerPage = 10;      // Số bản ghi trên mỗi trang
        int offset = (page - 1) * recordsPerPage;

        // Test 1: Lấy tất cả Employers
        System.out.println("--- Test lấy tất cả Employers ---");
        List<Employer> allEmployers = employerDAO.getAllEmployers();
        for (Employer emp : allEmployers) {
            System.out.println("ID: " + emp.getEmployerId() + ", Name: " + emp.getNameEmployer() + ", Email: " + emp.getEmail());
        }
        System.out.println("Tổng số Employers: " + allEmployers.size());

        // Test 2: Lấy Employers theo trang
        System.out.println("\n--- Test lấy Employers theo trang ---");
        List<Employer> employersByPage = employerDAO.getEmployersByPage(offset, recordsPerPage);
        System.out.println("Kết quả trang " + page + " (mỗi trang " + recordsPerPage + " bản ghi):");
        for (Employer emp : employersByPage) {
            System.out.println("ID: " + emp.getEmployerId() + ", Name: " + emp.getNameEmployer() + ", Email: " + emp.getEmail());
        }

        // Test 3: Tìm kiếm Employers theo tên
        System.out.println("\n--- Test tìm kiếm Employers với từ khóa '" + searchKeyword + "' ---");
        List<Employer> searchResults = employerDAO.searchEmployersByName(searchKeyword, offset, recordsPerPage);
        int totalSearchResults = employerDAO.getTotalEmployersByName(searchKeyword);
        for (Employer emp : searchResults) {
            System.out.println("ID: " + emp.getEmployerId() + ", Name: " + emp.getNameEmployer()+ ", Email: " + emp.getEmail());
        }
        System.out.println("Tổng số Employers khớp với từ khóa: " + totalSearchResults);
    }
}