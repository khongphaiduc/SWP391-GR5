package DAO;

import Models.JobPost;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dal.DBContext;

public class JobPostDAO extends DBContext {

    // Lấy danh sách bài đăng theo Employer_ID
    public List<JobPost> getJobPostsByEmployerId(int employerId) {
        List<JobPost> jobPosts = new ArrayList<>();
        String sql = "SELECT * FROM JobPost WHERE Employer_ID = ? ORDER BY DayCreate DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, employerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                JobPost job = new JobPost();
                job.setJobPost_ID(rs.getInt("JobPost_ID"));
                job.setEmployer_ID(rs.getInt("Employer_ID"));
                job.setTitle(rs.getString("Title"));
                job.setDescription(rs.getString("Description"));
                job.setCategory(rs.getString("Category"));
                job.setPosition(rs.getString("Position"));
                job.setLocation(rs.getString("Location"));
                job.setOffer_Min(rs.getDouble("Offer_Min"));
                job.setOffer_Max(rs.getDouble("Offer_Max"));
                job.setNumber_exp(rs.getInt("Number_exp"));
                job.setVisible(rs.getBoolean("Visible"));
                job.setTypeJob(rs.getString("TypeJob"));

                jobPosts.add(job);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jobPosts;
    }

    public boolean addJobPost(JobPost job) {
        String sql = "INSERT INTO JobPost (Employer_ID, Title, Description, Category, Position, Location, "
                + "Offer_Min, Offer_Max, Number_exp, Visible, TypeJob) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, job.getEmployer_ID());
            stmt.setString(2, job.getTitle());
            stmt.setString(3, job.getDescription());
            stmt.setString(4, job.getCategory());
            stmt.setString(5, job.getPosition());
            stmt.setString(6, job.getLocation());
            stmt.setDouble(7, job.getOffer_Min());
            stmt.setDouble(8, job.getOffer_Max());
            stmt.setInt(9, job.getNumber_exp());
            stmt.setBoolean(10, job.isVisible());
            stmt.setString(11, job.getTypeJob());

            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateJobPost(String title, String description, String category, String position, String location,
            double offerMin, double offerMax, int numberExp, boolean visible, String typeJob,
            int jobPostID) {
        String sql = "UPDATE JobPost SET Title = ?, Description = ?, Category = ?, Position = ?, Location = ?, "
                + "Offer_Min = ?, Offer_Max = ?, Number_exp = ?, Visible = ?, TypeJob = ? "
                + "WHERE JobPost_ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setString(3, category);
            stmt.setString(4, position);
            stmt.setString(5, location);
            stmt.setDouble(6, offerMin);
            stmt.setDouble(7, offerMax);
            stmt.setInt(8, numberExp);
            stmt.setBoolean(9, visible);
            stmt.setString(10, typeJob);
            stmt.setInt(11, jobPostID);

            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void deleteJobPost(int id) {
        String sql = "DELETE FROM JobPost WHERE jobPost_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public JobPost getJobPostById(int id) {
        String sql = "SELECT * FROM JobPost WHERE jobPost_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                JobPost job = new JobPost();
                job.setJobPost_ID(rs.getInt("JobPost_ID"));
                job.setTitle(rs.getString("Title"));
                job.setDescription(rs.getString("Description"));
                job.setPosition(rs.getString("Position"));
                job.setLocation(rs.getString("Location"));
                job.setOffer_Min(rs.getDouble("Offer_Min"));
                job.setOffer_Max(rs.getDouble("Offer_Max"));
                job.setNumber_exp(rs.getInt("Number_exp"));
                job.setVisible(rs.getBoolean("Visible"));
                job.setTypeJob(rs.getString("TypeJob"));
                job.setDayCre(rs.getDate("DayCreate"));
                job.setEmployer_ID(rs.getInt("Employer_ID"));
                job.setCategory(rs.getString("Category"));
                return job;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
