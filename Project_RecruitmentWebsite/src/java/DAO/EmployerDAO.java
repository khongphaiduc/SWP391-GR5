
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package DAO;

import Models.Employer;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author PC
 */
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
                employer.setEmployerName(rs.getString("EmployerName"));
                employer.setEmail(rs.getString("Email"));
                employer.setPasswordHash(rs.getString("Password_hash"));
                employer.setCompanyName(rs.getString("Company_Name"));
                employer.setDescription(rs.getString("Description"));
                employer.setLocation(rs.getString("Location"));
                employer.setUrlWebsite(rs.getString("URL_Website"));
                employer.setCompanySize(rs.getString("CompanySize"));
                employer.setImgLogo(rs.getBytes("imgLogo"));
            }

        } catch (SQLException e) {
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
            emp.setEmployerName(rs.getString("EmployerName"));
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
            e.setEmployerName(rs.getString("EmployerName"));
            e.setEmail(rs.getString("Email"));
            e.setPasswordHash(rs.getString("Password_hash"));
            e.setCompanyName(rs.getString("Company_Name"));
            e.setDescription(rs.getString("Description"));
            e.setLocation(rs.getString("Location"));
            e.setUrlWebsite(rs.getString("URL_Website"));
            e.setCompanySize(rs.getString("CompanySize"));
            e.setImgLogo(rs.getBytes("ImgLogo"));
            list.add(e);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
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
            System.out.println("ID: " + emp.getEmployerId() + ", Name: " + emp.getEmployerName() + ", Email: " + emp.getEmail());
        }
        System.out.println("Tổng số Employers: " + allEmployers.size());

        // Test 2: Lấy Employers theo trang
        System.out.println("\n--- Test lấy Employers theo trang ---");
        List<Employer> employersByPage = employerDAO.getEmployersByPage(offset, recordsPerPage);
        System.out.println("Kết quả trang " + page + " (mỗi trang " + recordsPerPage + " bản ghi):");
        for (Employer emp : employersByPage) {
            System.out.println("ID: " + emp.getEmployerId() + ", Name: " + emp.getEmployerName() + ", Email: " + emp.getEmail());
        }

        // Test 3: Tìm kiếm Employers theo tên
        System.out.println("\n--- Test tìm kiếm Employers với từ khóa '" + searchKeyword + "' ---");
        List<Employer> searchResults = employerDAO.searchEmployersByName(searchKeyword, offset, recordsPerPage);
        int totalSearchResults = employerDAO.getTotalEmployersByName(searchKeyword);
        for (Employer emp : searchResults) {
            System.out.println("ID: " + emp.getEmployerId() + ", Name: " + emp.getEmployerName() + ", Email: " + emp.getEmail());
        }
        System.out.println("Tổng số Employers khớp với từ khóa: " + totalSearchResults);
    }
   public Employer getEmployerById(int id) {
        String sql = "SELECT * FROM Employer WHERE Employer_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Employer emp = new Employer();
                emp.setEmployerId(rs.getInt("Employer_ID"));
                emp.setEmployerName(rs.getString("EmployerName"));
                emp.setEmail(rs.getString("Email"));
                emp.setPasswordHash(rs.getString("Password_hash"));
                emp.setCompanyName(rs.getString("Company_Name"));
                emp.setDescription(rs.getString("Description"));
                emp.setLocation(rs.getString("Location"));
                emp.setUrlWebsite(rs.getString("URL_Website"));
                emp.setCompanySize(rs.getString("CompanySize"));
                emp.setImgLogo(rs.getBytes("imgLogo"));
                return emp;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateEmployer(Employer emp) {
        String sql = "UPDATE Employer SET EmployerName=?, Email=?, Password_hash=?, Company_Name=?, Description=?, Location=?, URL_Website=?, CompanySize=?, imgLogo=? WHERE Employer_ID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, emp.getEmployerName());
            ps.setString(2, emp.getEmail());
            ps.setString(3, emp.getPasswordHash());
            ps.setString(4, emp.getCompanyName());
            ps.setString(5, emp.getDescription());
            ps.setString(6, emp.getLocation());
            ps.setString(7, emp.getUrlWebsite());
            ps.setString(8, emp.getCompanySize());
            ps.setBytes(9, emp.getImgLogo());
            ps.setInt(10, emp.getEmployerId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
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
    public List<Employer> getAllEmployers() {
    List<Employer> list = new ArrayList<>();
    String sql = "SELECT * FROM Employer";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Employer emp = new Employer();
            emp.setEmployerId(rs.getInt("Employer_ID"));
            emp.setEmployerName(rs.getString("EmployerName"));
            emp.setEmail(rs.getString("Email"));
            emp.setPasswordHash(rs.getString("Password_hash"));
            emp.setCompanyName(rs.getString("Company_Name"));
            emp.setDescription(rs.getString("Description"));
            emp.setLocation(rs.getString("Location"));
            emp.setUrlWebsite(rs.getString("URL_Website"));
            emp.setCompanySize(rs.getString("CompanySize"));
            emp.setImgLogo(rs.getBytes("imgLogo"));
            list.add(emp);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    



}
