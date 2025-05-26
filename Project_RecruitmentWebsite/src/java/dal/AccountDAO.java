/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.Account;

/**
 *
 * @author Admin
 */
public class AccountDAO extends DBContext {

    public void addAccount(String accountName, String passwordHash, String email, String role) {
        String sql = "INSERT INTO Account (Account_Name, Password_hash, Email, Role) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, accountName);        // Account_Name
            stmt.setString(2, passwordHash);       // Password_hash
            stmt.setString(3, email);              // Email
            stmt.setString(4, role);               // Role
            stmt.executeUpdate();                  // date_cr tự động, Account_ID tự động
        } catch (Exception e) {
            e.printStackTrace(); // Hoặc throw lên cho Controller xử lý
        }
    }
// READ by ID

    public Account getAccountById(int id) {
        String sql = "SELECT * FROM Account WHERE Account_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToAccount(rs);
            }
        } catch (Exception e) {
            System.out.println("❌ Failed to get account: " + e.getMessage());
        }
        return null;
    }

    // READ all
    public List<Account> getAllAccounts() {
        List<Account> accounts = new ArrayList<>();
        String sql = "SELECT * FROM Account";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                accounts.add(mapResultSetToAccount(rs));
            }
        } catch (Exception e) {
            System.out.println("❌ Failed to get all accounts: " + e.getMessage());
        }
        return accounts;
    }

    // UPDATE
    public boolean updateAccount(Account acc) {
        String sql = "UPDATE Account SET Account_Name=?, Password_hash=?, Email=?, Role=? WHERE Account_ID=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, acc.getAccountName());
            stmt.setString(2, acc.getPasswordHash());
            stmt.setString(3, acc.getEmail());
            stmt.setString(4, acc.getRole());
            stmt.setInt(5, acc.getAccountId());

            // Sử dụng executeUpdate để kiểm tra số dòng bị ảnh hưởng
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("✅ Account updated.");
                return true; // Nếu có ít nhất 1 dòng bị cập nhật
            } else {
                System.out.println("❌ No account found to update.");
                return false; // Không có dòng nào bị ảnh hưởng
            }
        } catch (Exception e) {
            System.out.println("❌ Failed to update: " + e.getMessage());
            return false; // Trả về false khi có lỗi xảy ra
        }
    }

    // DELETE
    public void deleteAccount(int id) {
        String sql = "DELETE FROM Account WHERE Account_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            System.out.println("✅ Account deleted.");
        } catch (Exception e) {
            System.out.println("❌ Failed to delete: " + e.getMessage());
        }
    }

    // Helper: convert ResultSet to Account object
    private Account mapResultSetToAccount(ResultSet rs) throws SQLException {
        Account acc = new Account();
        acc.setAccountId(rs.getInt("Account_ID"));
        acc.setAccountName(rs.getString("Account_Name"));
        acc.setPasswordHash(rs.getString("Password_hash"));
        acc.setEmail(rs.getString("Email"));
        acc.setDateCreated(rs.getTimestamp("date_cr").toLocalDateTime().toLocalDate());
        acc.setRole(rs.getString("Role"));
        return acc;
    }

    public Account check(String username, String password) {
        String sql = "SELECT * FROM Account WHERE Account_Name = ? AND Password_hash = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return mapResultSetToAccount(rs);
            }
        } catch (Exception e) {
            System.out.println("❌ Error in check(): " + e.getMessage());
        }
        return null;
    }
    public List<Account> getAccountsByPage(int start, int count) {
    List<Account> list = new ArrayList<>();
    String sql = "SELECT * FROM Account ORDER BY Account_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, start);
        ps.setInt(2, count);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Account acc = new Account();
            acc.setAccountId(rs.getInt("Account_ID"));
            acc.setAccountName(rs.getString("Account_Name"));
            acc.setPasswordHash(rs.getString("Password_hash"));
            acc.setEmail(rs.getString("Email"));
            acc.setRole(rs.getString("Role"));
            list.add(acc);
        }
    } catch (SQLException e) {
        System.out.println("❌ getAccountsByPage error: " + e.getMessage());
    }
    return list;
}

public int countAccounts() {
    String sql = "SELECT COUNT(*) FROM Account";
    try (Statement stmt = connection.createStatement()) {
        ResultSet rs = stmt.executeQuery(sql);
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException e) {
        System.out.println("❌ countAccounts error: " + e.getMessage());
    }
    return 0;
}
public int countAccountsByRole(String role) {
    String sql = "SELECT COUNT(*) FROM Account WHERE Role = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, role);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException e) {
        System.out.println("❌ countAccountsByRole error: " + e.getMessage());
    }
    return 0;
}


    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();

        System.out.print("Nhập tên tài khoản: ");
        String name = "khiem02111111";

        System.out.print("Nhập email: ");
        String email = "vxtjkm02111111@gmial.com";

        System.out.print("Nhập mật khẩu (hash): ");
        String pass = "0211";

        System.out.print("Nhập vai trò (role): ");
        String role = "Admin";

        dao.addAccount(name, pass, email, role);
    }

}
