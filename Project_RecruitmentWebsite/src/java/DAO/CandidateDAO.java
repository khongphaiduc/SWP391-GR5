package DAO;
import Models.Candidate;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CandidateDAO extends DBContext {

    public Candidate getCandidateByAccountName(String username) {
        Candidate candidate = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
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
                candidate.setPasswordHash(rs.getString("Password_hash")); // nếu có
                candidate.setAvatar(rs.getBytes("Avatar")); // nếu có
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }

        return candidate;
    }

   public List<Candidate> getCandidatesByPage(int offset, int recordsPerPage) {
    List<Candidate> list = new ArrayList<>();
    String sql = "SELECT * FROM Candidate ORDER BY Candidate_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, offset);
        ps.setInt(2, recordsPerPage);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Candidate c = new Candidate();
            c.setCandidateId(rs.getInt("Candidate_ID"));
            c.setCandidateName(rs.getString("CandidateName"));
                  c.setAddress(rs.getString("Address"));
            c.setEmail(rs.getString("Email"));  
      
            c.setBirthday(rs.getDate("Birthday"));
            c.setNationality(rs.getString("Nationality"));
            c.setPasswordHash(rs.getString("Password_hash"));
            c.setAvatar(rs.getBytes("Avatar")); // nếu có
            list.add(c);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}


public int countCandidates() {
    int count = 0;
    String sql = "SELECT COUNT(*) FROM Candidate";
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
  public Candidate getCandidateById(int id) {
        String sql = "SELECT * FROM Candidate WHERE Candidate_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Candidate can = new Candidate();
                can.setCandidateId(rs.getInt("Candidate_ID"));
                can.setCandidateName(rs.getString("CandidateName"));
                can.setAddress(rs.getString("Address"));
                can.setEmail(rs.getString("Email"));
                can.setBirthday(rs.getDate("Birthday"));
                can.setNationality(rs.getString("Nationality"));
                can.setPasswordHash(rs.getString("Password_hash"));
                can.setAvatar(rs.getBytes("Avatar"));
                return can;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

 

    public void deleteCandidate(int id) {
        String sql = "DELETE FROM Candidate WHERE Candidate_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }public List<Candidate> getAllCandidates() {
    List<Candidate> list = new ArrayList<>();
    String sql = "SELECT * FROM Candidate";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Candidate can = new Candidate();
            can.setCandidateId(rs.getInt("Candidate_ID"));
            can.setCandidateName(rs.getString("CandidateName"));
            can.setAddress(rs.getString("Address"));
            can.setEmail(rs.getString("Email"));
            can.setBirthday(rs.getDate("Birthday"));
            can.setNationality(rs.getString("Nationality"));
            can.setPasswordHash(rs.getString("Password_hash"));
            can.setAvatar(rs.getBytes("Avatar"));
            list.add(can);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

      public static void main(String[] args) {
        CandidateDAO dao = new CandidateDAO();
        int testId = 1; // thay bằng ID cần kiểm thử

        Candidate candidate = dao.getCandidateById(testId);

        if (candidate != null) {
            System.out.println("Candidate Found:");
            System.out.println("ID: " + candidate.getCandidateId());
            System.out.println("Name: " + candidate.getCandidateName());
            System.out.println("Email: " + candidate.getEmail());
            System.out.println("Address: " + candidate.getAddress());
            System.out.println("Birthday: " + candidate.getBirthday());
            System.out.println("Nationality: " + candidate.getNationality());
        } else {
            System.out.println("No candidate found with ID: " + testId);
        }
    }
}
