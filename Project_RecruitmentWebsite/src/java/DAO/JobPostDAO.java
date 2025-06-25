package DAO;

import Models.Employer;
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

    public List<JobPost> getAllJobPost() {
        List<JobPost> list = new ArrayList<>();
        String sql = "SELECT * FROM JobPost ";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

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
                list.add(job);
                return list;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<JobPost> getJobPostByPage(int offset, int recordsPerPage) {
        List<JobPost> list = new ArrayList<>();
        String sql = "SELECT * FROM JobPost ORDER BY JobPost_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, recordsPerPage);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
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
                list.add(job);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countJobPost() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM JobPost";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    /*       public static void main(String[] args) {
        // Khởi tạo EmployerDAO
        JobPostDAO dao = new JobPostDAO();

        // Tham số test
        String searchKeyword = "A"; // Từ khóa tìm kiếm
        int page = 1;                 // Trang hiện tại
        int recordsPerPage = 10;      // Số bản ghi trên mỗi trang
        int offset = (page - 1) * recordsPerPage;

        // Test 1: Lấy tất cả Employers
        System.out.println("--- Test lấy tất cả Employers ---");
        List<JobPost> all = dao.getJobPostByPage(offset, recordsPerPage) ;
        for (JobPost emp : all) {
            System.out.println("ID: " + emp.getJobPost_ID()+ ", Name: " + emp.getCategory()+ ", Email: ");
        }
        System.out.println("Tổng số Employers: " + all.size());

  
    }
     */
    public List<JobPost> getAllJobPostsWithEmployer() {
        List<JobPost> jobPosts = new ArrayList<>();

        String sql = "SELECT jp.*, e.Employer_ID, e.EmployerName, e.Email, e.Password_hash, e.Company_Name, "
                + "e.Description AS EmployerDesc, e.Location AS EmployerLocation, e.URL_Website, "
                + "e.CompanySize, e.PhoneNumber, e.imgLogo "
                + "FROM JobPost jp "
                + "JOIN Employer e ON jp.Employer_ID = e.Employer_ID "
                + "ORDER BY jp.DayCreate DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
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
                job.setDayCre(rs.getDate("DayCreate"));

                Employer emp = new Employer();
                emp.setEmployerId(rs.getInt("Employer_ID"));
                emp.setNameEmployer(rs.getString("EmployerName"));
                emp.setEmail(rs.getString("Email"));
                emp.setPasswordHash(rs.getString("Password_hash"));
                emp.setCompanyName(rs.getString("Company_Name"));
                emp.setDescription(rs.getString("EmployerDesc"));
                emp.setLocation(rs.getString("EmployerLocation"));
                emp.setUrlWebsite(rs.getString("URL_Website"));
                emp.setCompanySize(rs.getString("CompanySize"));
                emp.setPhoneNumber(rs.getString("PhoneNumber"));

                emp.setImgLogo(rs.getString("imgLogo"));

                job.setEmployer(emp);
                jobPosts.add(job);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return jobPosts;
    }

    public JobPost getJobPostWithEmployerById(int jobPostId) {
        String sql = "SELECT jp.*, e.Employer_ID, e.EmployerName, e.Email, e.Password_hash, e.Company_Name, "
                + "e.Description AS EmployerDesc, e.Location AS EmployerLocation, e.URL_Website, "
                + "e.CompanySize, e.PhoneNumber, e.imgLogo "
                + "FROM JobPost jp "
                + "JOIN Employer e ON jp.Employer_ID = e.Employer_ID "
                + "WHERE jp.JobPost_ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, jobPostId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
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
                job.setDayCre(rs.getDate("DayCreate"));

                Employer emp = new Employer();
                emp.setEmployerId(rs.getInt("Employer_ID"));
                emp.setNameEmployer(rs.getString("EmployerName"));
                emp.setEmail(rs.getString("Email"));
                emp.setPasswordHash(rs.getString("Password_hash"));
                emp.setCompanyName(rs.getString("Company_Name"));
                emp.setDescription(rs.getString("EmployerDesc"));
                emp.setLocation(rs.getString("EmployerLocation"));
                emp.setUrlWebsite(rs.getString("URL_Website"));
                emp.setCompanySize(rs.getString("CompanySize"));
                emp.setPhoneNumber(rs.getString("PhoneNumber"));

                 emp.setImgLogo(rs.getString("imgLogo"));

                job.setEmployer(emp);
                return job;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<JobPost> getJobPostWithEmployerByEmployerId(int employerId) {
        List<JobPost> jobList = new ArrayList<>();

        String sql = "SELECT jp.*, e.Company_Name, e.email, e.URL_Website, e.companySize, e.imgLogo \n"
                + "                FROM JobPost jp \n"
                + "                JOIN Employer e ON jp.employer_id = e.employer_id \n"
                + "                WHERE jp.employer_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, employerId);

            try (ResultSet rs = ps.executeQuery()) {
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
                    job.setDayCre(rs.getDate("DayCreate"));

                    Employer employer = new Employer();
                    employer.setEmployerId(employerId);
                    employer.setCompanyName(rs.getString("Company_Name"));
                    employer.setEmail(rs.getString("email"));
                    employer.setUrlWebsite(rs.getString("URL_Website"));
                    employer.setCompanySize(rs.getString("companySize"));
                     employer.setImgLogo(rs.getString("imgLogo"));

                    job.setEmployer(employer);
                    jobList.add(job);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Log cho dev
        }

        return jobList;
    }

}
