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
                candidate.setAvatar(rs.getBytes("avata"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return candidate;
    }
}
