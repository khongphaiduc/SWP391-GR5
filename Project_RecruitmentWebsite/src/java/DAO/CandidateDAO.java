package DAO;


import Models.*;
import java.sql.*;
import dal.DBContext;

import java.util.ArrayList;
import java.util.List;

public class CandidateDAO extends DBContext {

    public Candidate getCandidateByName(String candidateName) {
        Candidate candidate = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {

            String sql = "SELECT * FROM Candidate WHERE CandidateName = ?";

            stmt = connection.prepareStatement(sql);
            stmt.setString(1, candidateName);
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
     

   


                candidate.setPasswordHash(rs.getString("Password_hash"));
                Blob avatarBlob = rs.getBlob("Avatar");
                if (avatarBlob != null) {
                    candidate.setAvatar(avatarBlob.getBinaryStream());
                }

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

        return candidate;
    }
    public List<Candidate> searchCandidatesByName(String name, int offset, int limit) {
    List<Candidate> candidates = new ArrayList<>();
    String sql = "SELECT Candidate_ID, CandidateName, Email FROM Candidate WHERE CandidateName LIKE ? " +
                 "ORDER BY Candidate_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, "%" + name + "%");
        ps.setInt(2, offset);
        ps.setInt(3, limit);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Candidate can = new Candidate();
            can.setCandidateId(rs.getInt("Candidate_ID"));
            can.setCandidateName(rs.getString("CandidateName"));
            can.setEmail(rs.getString("Email"));
            candidates.add(can);
        }
        rs.close();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return candidates;
}

public int getTotalCandidatesByName(String name) {
    String sql = "SELECT COUNT(*) FROM Candidate WHERE CandidateName LIKE ?";
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


    public boolean updateCandidate(Candidate candidate) {
        PreparedStatement stmt = null;
        boolean updated = false;
        try {
            String sql = "UPDATE Candidate SET CandidateName = ?, Address = ?, Email = ?, Birthday = ?, Nationality = ?, Password_hash = ?, avatar = ? WHERE Candidate_ID = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, candidate.getCandidateName());
            stmt.setString(2, candidate.getAddress());
            stmt.setString(3, candidate.getEmail());
            stmt.setDate(4, candidate.getBirthday());
            stmt.setString(5, candidate.getNationality());
            stmt.setString(6, candidate.getPasswordHash());
            stmt.setBlob(7, candidate.getAvatar());
            stmt.setInt(8, candidate.getCandidateId());

            int rowsAffected = stmt.executeUpdate();
            updated = (rowsAffected > 0);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return updated;
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
                  list.add(can);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}



}

