/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.*;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class ApplyDAO extends DBContext {

    public void insertApply(Apply apply) {
        String sql = "INSERT INTO Apply (JobPost_ID, Candidate_ID, CV_ID, Status, Step) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, apply.getJobPost_ID());
            ps.setInt(2, apply.getCandidate_ID());
            ps.setInt(3, apply.getCV_ID());
            ps.setString(4, apply.getStatus());
            ps.setString(5, apply.getStep());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Apply getApplyByID(int applyID) {
        String sql = "SELECT * FROM Apply WHERE Apply_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, applyID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractApply(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Apply> getAllApplies() {
        List<Apply> list = new ArrayList<>();
        String sql = "SELECT * FROM Apply";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractApply(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateApply(Apply apply) {
        String sql = "UPDATE Apply SET JobPost_ID=?, Candidate_ID=?, CV_ID=?, Status=?, Step=? WHERE Apply_ID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, apply.getJobPost_ID());
            ps.setInt(2, apply.getCandidate_ID());
            ps.setInt(3, apply.getCV_ID());
            ps.setString(4, apply.getStatus());
            ps.setString(5, apply.getStep());
            ps.setInt(6, apply.getApply_ID());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // DELETE
    public void deleteApply(int applyID) {
        String sql = "DELETE FROM Apply WHERE Apply_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, applyID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // EXTRA: check if candidate already applied
    public boolean hasApplied(int candidateID, int jobPostID) {
        String sql = "SELECT * FROM Apply WHERE Candidate_ID = ? AND JobPost_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, candidateID);
            ps.setInt(2, jobPostID);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Create Apply object
    private Apply extractApply(ResultSet rs) throws SQLException {
        Apply apply = new Apply();
        apply.setApply_ID(rs.getInt("Apply_ID"));
        apply.setJobPost_ID(rs.getInt("JobPost_ID"));
        apply.setCandidate_ID(rs.getInt("Candidate_ID"));
        apply.setCV_ID(rs.getInt("CV_ID"));
        apply.setStatus(rs.getString("Status"));
        apply.setStep(rs.getString("Step"));
        return apply;
    }

    public List<Apply> getAppliesByCandidateID(int candidateID) {
        List<Apply> list = new ArrayList<>();
        String sql = "SELECT * FROM Apply WHERE Candidate_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, candidateID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractApply(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Apply> getAppliesWithJobPostByCandidateID(int candidateID) {
        List<Apply> list = new ArrayList<>();
        String sql = "SELECT a.*, j.Title, j.Position, j.Offer_Min, j.Offer_Max "
                + "FROM Apply a JOIN JobPost j ON a.JobPost_ID = j.JobPost_ID "
                + "WHERE a.Candidate_ID = ? ORDER BY a.Apply_ID DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, candidateID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Apply apply = extractApply(rs);
                // Gán thêm thông tin từ JobPost
                apply.setJobTitle(rs.getString("Title"));
                apply.setJobPosition(rs.getString("Position"));
                apply.setOfferMin(rs.getDouble("Offer_Min"));
                apply.setOfferMax(rs.getDouble("Offer_Max"));
                list.add(apply);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
