package DAO;

import Models.CV;
import Models.JobPost;
import dal.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PotentialDAO extends DBContext {

    // Kiểm tra CV đã tồn tại trong Potential với Employer và JobPost cụ thể
    public boolean isPotentialCVExists(int cvId, int employerId, int jobPostId) {
        String sql = "SELECT 1 FROM Potential WHERE CV_ID = ? AND Employer_ID = ? AND JobPost_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, employerId);
            ps.setInt(3, jobPostId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Thêm CV vào danh sách tiềm năng
    public boolean addPotentialCV(int cvId, int employerId, int jobPostId) {
        String sql = "INSERT INTO Potential (CV_ID, Employer_ID, JobPost_ID) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, employerId);
            ps.setInt(3, jobPostId);
            return ps.executeUpdate() > 0;
        } catch (SQLIntegrityConstraintViolationException e) {
            System.out.println("⚠️ CV đã tồn tại trong danh sách tiềm năng.");
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xoá CV khỏi danh sách tiềm năng
    public boolean removePotentialCV(int cvId, int employerId, int jobPostId) {
        String sql = "DELETE FROM Potential WHERE CV_ID = ? AND Employer_ID = ? AND JobPost_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, employerId);
            ps.setInt(3, jobPostId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy danh sách CV tiềm năng theo Employer
    public List<CV> getPotentialCVsByEmployerId(int employerId, int page, int pageSize) {
        List<CV> result = new ArrayList<>();
        String sql = "SELECT DISTINCT "
                + "CV.CV_ID, CV.Candidate_ID, CV.Full_Name, CV.Address, CV.Email, "
                + "CV.Position, CV.Number_exp, CV.Education, CV.Field, CV.Current_Salary, "
                + "CV.Birthday, CV.Nationality, CV.Gender, CV.FileData, CV.MimeType, "
                + "JP.JobPost_ID, JP.Title, JP.Position AS JP_Position, JP.Location, A.Step "
                + "FROM Potential P "
                + "JOIN CV ON P.CV_ID = CV.CV_ID "
                + "JOIN Apply A ON CV.CV_ID = A.CV_ID AND P.JobPost_ID = A.JobPost_ID "
                + "JOIN JobPost JP ON A.JobPost_ID = JP.JobPost_ID "
                + "WHERE P.Employer_ID = ? "
                + "ORDER BY CV.CV_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employerId);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                result.add(mapCV(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Đếm số CV tiềm năng
    public int countPotentialCVsByEmployerId(int employerId) {
        String sql = "SELECT COUNT(DISTINCT CV_ID) FROM Potential WHERE Employer_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    // Đếm tất cả CV tiềm năng không phân biệt jobpost

    public int getTotalPotentialCVs(int employerId) {
        String sql = "SELECT COUNT(*) FROM Potential WHERE Employer_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // --------------------- Tìm kiếm ---------------------
    private void buildSearchConditions(StringBuilder sql, List<Object> params,
            String address, Integer numberExp, String position,
            String keyword, String field) {

        if (address != null && !address.isEmpty()) {
            sql.append(" AND LOWER(CV.Address) LIKE ?");
            params.add("%" + address.toLowerCase() + "%");
        }

        if (numberExp != null) {
            sql.append(" AND CV.Number_exp = ?");
            params.add(numberExp);
        }

        if (position != null && !position.isEmpty()) {
            sql.append(" AND LOWER(CV.Position) LIKE ?");
            params.add("%" + position.toLowerCase() + "%");
        }

        if (field != null && !field.isEmpty()) {
            sql.append(" AND LOWER(CV.Field) LIKE ?");
            params.add("%" + field.toLowerCase() + "%");
        }

        if (keyword != null && !keyword.isEmpty()) {
            String[] words = keyword.toLowerCase().split("\\s+");
            for (String word : words) {
                sql.append(" AND (")
                        .append("LOWER(CV.Full_Name) LIKE ? OR ")
                        .append("LOWER(CV.Address) LIKE ? OR ")
                        .append("LOWER(CV.Position) LIKE ? OR ")
                        .append("LOWER(CV.Education) LIKE ? OR ")
                        .append("LOWER(CV.Gender) LIKE ? OR ")
                        .append("LOWER(CV.Field) LIKE ? OR ")
                        .append("LOWER(CV.Email) LIKE ? OR ")
                        .append("LOWER(CV.Nationality) LIKE ?")
                        .append(")");
                for (int i = 0; i < 8; i++) {
                    params.add("%" + word + "%");
                }
            }
        }
    }

    private String normalize(String input) {
        if (input == null) {
            return null;
        }
        return input.trim().replaceAll("\\s+", " ");
    }

    public List<CV> searchPotentialCVsForEmployer(int employerId, String address, Integer numberExp,
            String position, String keyword, String field,
            int limit, int offset) {
        List<CV> result = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        address = normalize(address);
        position = normalize(position);
        field = normalize(field);
        keyword = normalize(keyword);

        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT CV.CV_ID, CV.Candidate_ID, CV.Full_Name, CV.Address, CV.Email, "
                + "CV.Position, CV.Number_exp, CV.Education, CV.Field, CV.Current_Salary, "
                + "CV.Birthday, CV.Nationality, CV.Gender, CV.FileData, CV.MimeType, "
                + "JP.JobPost_ID, JP.Title, JP.Position AS JP_Position, JP.Location, A.Step "
                + "FROM Potential P "
                + "JOIN CV ON P.CV_ID = CV.CV_ID "
                + "JOIN Apply A ON CV.CV_ID = A.CV_ID AND P.JobPost_ID = A.JobPost_ID "
                + "JOIN JobPost JP ON A.JobPost_ID = JP.JobPost_ID "
                + "WHERE P.Employer_ID = ?"
        );

        params.add(employerId);
        buildSearchConditions(sql, params, address, numberExp, position, keyword, field);
        sql.append(" ORDER BY CV.CV_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(mapCV(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public int countSearchPotentialCVsForEmployer(int employerId, String address, Integer numberExp,
            String position, String keyword, String field) {
        List<Object> params = new ArrayList<>();

        address = normalize(address);
        position = normalize(position);
        field = normalize(field);
        keyword = normalize(keyword);

        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(DISTINCT CV.CV_ID) FROM Potential P "
                + "JOIN CV ON P.CV_ID = CV.CV_ID "
                + "JOIN Apply A ON CV.CV_ID = A.CV_ID AND P.JobPost_ID = A.JobPost_ID "
                + "JOIN JobPost JP ON A.JobPost_ID = JP.JobPost_ID "
                + "WHERE P.Employer_ID = ?"
        );

        params.add(employerId);
        buildSearchConditions(sql, params, address, numberExp, position, keyword, field);

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // -----------------------------------------
    // Helper để mapping dữ liệu CV từ ResultSet
    private CV mapCV(ResultSet rs) throws SQLException {
        CV cv = new CV();
        cv.setCvId(rs.getInt("CV_ID"));
        cv.setCandidateId(rs.getInt("Candidate_ID"));
        cv.setFullName(rs.getString("Full_Name"));
        cv.setAddress(rs.getString("Address"));
        cv.setEmail(rs.getString("Email"));
        cv.setPosition(rs.getString("Position"));
        cv.setNumberExp(rs.getInt("Number_exp"));
        cv.setEducation(rs.getString("Education"));
        cv.setField(rs.getString("Field"));
        cv.setCurrentSalary(rs.getDouble("Current_Salary"));
        cv.setBirthday(rs.getDate("Birthday"));
        cv.setNationality(rs.getString("Nationality"));
        cv.setGender(rs.getString("Gender"));
        cv.setFileData(rs.getString("FileData"));
        cv.setMimeType(rs.getString("MimeType"));

        JobPost jobPost = new JobPost();
        jobPost.setJobPost_ID(rs.getInt("JobPost_ID"));
        jobPost.setTitle(rs.getString("Title"));
        jobPost.setPosition(rs.getString("JP_Position"));
        jobPost.setLocation(rs.getString("Location"));
        cv.setJobPost(jobPost);

        cv.setStep(rs.getString("Step"));
        return cv;
    }

    // ------------------ Test nhanh ------------------
    public static void main(String[] args) {
        PotentialDAO dao = new PotentialDAO();
        int cvId = 3;
        int empId = 1;
        int jobId = 5;

        if (!dao.isPotentialCVExists(cvId, empId, jobId)) {
            boolean success = dao.addPotentialCV(cvId, empId, jobId);
            System.out.println(success ? "✅ Thêm thành công." : "❌ Thêm thất bại.");
        } else {
            System.out.println("⚠️ CV đã tồn tại.");
        }

        List<CV> list = dao.getPotentialCVsByEmployerId(empId, 1, 10);
        for (CV cv : list) {
            System.out.println("🔹 " + cv.getFullName() + " - " + cv.getJobPost().getTitle());
        }
    }
}
