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

    public List<Apply> filterAppliesByCandidate(int candidateID, String salary, String location,
            String category, String numberExp,
            String typeJob, String companyName) {
        if (salary == null) {
            salary = "0";
        }

        String min, max;
        switch (salary) {
            case "1":
                min = "0";
                max = "10";
                break;
            case "2":
                min = "10";
                max = "20";
                break;
            case "3":
                min = "20";
                max = "30";
                break;
            case "4":
                min = "30";
                max = "40";
                break;
            case "5":
                min = "40";
                max = "100000";
                break;
            default:
                min = "0";
                max = "100000000";
                break;
        }

        List<Apply> list = new ArrayList<>();

        String sql = "SELECT a.*, j.Title, j.Position, j.Offer_Min, j.Offer_Max, j.Location, "
                + "       j.Category, j.Number_exp, j.TypeJob, e.Company_Name "
                + "FROM Apply a "
                + "JOIN JobPost j ON a.JobPost_ID = j.JobPost_ID "
                + "JOIN Employer e ON j.Employer_ID = e.Employer_ID "
                + "WHERE a.Candidate_ID = ? "
                + "AND (j.Offer_Min >= ?) AND (j.Offer_Max <= ?) "
                + "AND (? IS NULL OR j.Location LIKE ?) "
                + "AND (? IS NULL OR j.Category LIKE ?) "
                + "AND (? IS NULL OR j.Number_exp LIKE ?) "
                + "AND (? IS NULL OR j.TypeJob LIKE ?) "
                + "AND (? IS NULL OR j.Title LIKE ?) "
                + "ORDER BY a.Apply_ID DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, candidateID);
            ps.setDouble(2, Double.parseDouble(min));
            ps.setDouble(3, Double.parseDouble(max));

            ps.setString(4, location != null ? "%" + location + "%" : null);
            ps.setString(5, location != null ? "%" + location + "%" : null);

            ps.setString(6, category != null ? "%" + category + "%" : null);
            ps.setString(7, category != null ? "%" + category + "%" : null);

            ps.setString(8, numberExp != null ? "%" + numberExp + "%" : null);
            ps.setString(9, numberExp != null ? "%" + numberExp + "%" : null);

            ps.setString(10, typeJob != null ? "%" + typeJob + "%" : null);
            ps.setString(11, typeJob != null ? "%" + typeJob + "%" : null);

            ps.setString(12, companyName != null ? "%" + companyName + "%" : null);
            ps.setString(13, companyName != null ? "%" + companyName + "%" : null);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Apply apply = new Apply();
                apply.setApply_ID(rs.getInt("Apply_ID"));
                apply.setJobPost_ID(rs.getInt("JobPost_ID"));
                apply.setCandidate_ID(rs.getInt("Candidate_ID"));
                apply.setCV_ID(rs.getInt("CV_ID"));
                apply.setStatus(rs.getString("Status"));
                apply.setStep(rs.getString("Step"));

                // Gán thêm thông tin job
                apply.setJobTitle(rs.getString("Title"));
                apply.setJobPosition(rs.getString("Position"));
                apply.setOfferMin(rs.getDouble("Offer_Min"));
                apply.setOfferMax(rs.getDouble("Offer_Max"));
                apply.setLocation(rs.getString("Location"));
                apply.setCategory(rs.getString("Category"));
                apply.setNumberExp(rs.getInt("Number_exp"));
                apply.setTypeJob(rs.getString("TypeJob"));
                apply.setCompanyName(rs.getString("Company_Name"));

                list.add(apply);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
