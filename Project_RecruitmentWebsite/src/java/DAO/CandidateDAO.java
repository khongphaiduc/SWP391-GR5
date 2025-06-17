package DAO;

import Models.*;
import java.sql.*;
import dal.DBContext;

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
}
