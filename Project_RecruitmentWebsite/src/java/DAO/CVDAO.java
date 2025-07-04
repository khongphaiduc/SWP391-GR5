/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Models.*;
import dal.DBContext;
import java.util.Collections;

/**
 *
 * @author PC
 */
public class CVDAO extends DBContext {

    public boolean addCV(String fullName, String address, String email,
            String position, int numberExp, String education, String field,
            Double currentSalary, Date birthday, int candidateId,
            String nationality, String gender, String inputStream, String mimeType) {
        try {
            String sql = "INSERT INTO CV (full_Name, address, email, position, number_Exp, education, field, current_Salary, birthday, nationality, gender, candidate_Id, FileData, MimeType) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setString(1, fullName);
            stmt.setString(2, address);
            stmt.setString(3, email);
            stmt.setString(4, position);
            stmt.setInt(5, numberExp);
            stmt.setString(6, education);
            stmt.setString(7, field);
            stmt.setDouble(8, currentSalary);
            stmt.setDate(9, new java.sql.Date(birthday.getTime()));
            stmt.setString(10, nationality);
            stmt.setString(11, gender);
            stmt.setInt(12, candidateId);
            stmt.setString(13, inputStream);
            stmt.setString(14, mimeType);
            int row = stmt.executeUpdate();
            return row > 0;

        } catch (Exception e) {
            return false;
        }
    }

    public List<CV> getCVByCandidate(int candidateId) {
        List<CV> cvList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT * FROM CV WHERE Candidate_ID = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, candidateId);
            rs = stmt.executeQuery();

            while (rs.next()) {
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
                
                cvList.add(cv);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cvList;
    }

    public CV getCVById(int CVId) {
        List<CV> cvList = new ArrayList<>();

        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            DBContext dBContext = new DBContext();

            String sql = "SELECT * FROM CV WHERE CV_ID = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, CVId);
            rs = stmt.executeQuery();

            while (rs.next()) {
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
                cvList.add(cv);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cvList.get(0);
    }

    public boolean deleteCVById(int cvId) {
        try {
            String sql = "DELETE FROM CV WHERE CV_ID = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, cvId);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean editCVById(int cvId, String fullName, String address, String email,
            String position, int numberExp, String education, String field,
            Double currentSalary, Date birthday, String nationality, String gender,
            String inputStream, String mimeType) {
        try {
            StringBuilder sql = new StringBuilder("UPDATE CV SET full_Name=?, address=?, email=?,"
                    + " position=?, number_Exp=?, education=?, field=?,"
                    + " current_Salary=?, birthday=?, nationality=?, gender=?");

            if (inputStream != null) {
                sql.append(", FileData = ?, MimeType = ?");
            }

            sql.append(" WHERE CV_ID=?");

            PreparedStatement stmt = connection.prepareStatement(sql.toString());

            stmt.setString(1, fullName);
            stmt.setString(2, address);
            stmt.setString(3, email);
            stmt.setString(4, position);
            stmt.setInt(5, numberExp);
            stmt.setString(6, education);
            stmt.setString(7, field);
            stmt.setDouble(8, currentSalary);
            stmt.setDate(9, new java.sql.Date(birthday.getTime()));
            stmt.setString(10, nationality);
            stmt.setString(11, gender);

            int index = 12;
            if (inputStream != null) {
                stmt.setString(index++, inputStream);
                stmt.setString(index++, mimeType);
            }

            stmt.setInt(index, cvId);

            int updatedRows = stmt.executeUpdate();
            return updatedRows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean editCVWithoutFile(int cvId, String fullName, String address, String email,
            String position, int numberExp, String education, String field,
            double currentSalary, Date birthday, String nationality, String gender) {
        try {
            String sql = "UPDATE CV SET full_Name=?, address=?, email=?, position=?, number_Exp=?, education=?, field=?, "
                    + "current_Salary=?, birthday=?, nationality=?, gender=? WHERE CV_ID=?";
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setString(1, fullName);
            stmt.setString(2, address);
            stmt.setString(3, email);
            stmt.setString(4, position);
            stmt.setInt(5, numberExp);
            stmt.setString(6, education);
            stmt.setString(7, field);
            stmt.setDouble(8, currentSalary);
            stmt.setDate(9, new java.sql.Date(birthday.getTime()));
            stmt.setString(10, nationality);
            stmt.setString(11, gender);
            stmt.setInt(12, cvId);

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

// Code by mkhanh
// hàm lấy CV được apply vào 1 công ty
    public List<CV> getAppliedCVsByEmployer(int employerId, int limit, int offset) {
        List<CV> cvList = new ArrayList<>();
        String sql = "SELECT CV.CV_ID, CV.Candidate_ID, CV.Full_Name, CV.Address, CV.Email, "
                + "CV.Position, CV.Number_exp, CV.Education, CV.Field, CV.Current_Salary, "
                + "CV.Birthday, CV.Nationality, CV.Gender, CV.FileData, CV.MimeType, "
                + "JP.JobPost_ID, JP.Title, JP.Position AS JP_Position, JP.Location, A.Apply_ID "
                + "FROM CV "
                + "INNER JOIN Apply A ON CV.CV_ID = A.CV_ID "
                + "INNER JOIN JobPost JP ON A.JobPost_ID = JP.JobPost_ID "
                + "WHERE JP.Employer_ID = ? "
                + "ORDER BY CV.CV_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, employerId);
            stmt.setInt(2, offset);  // OFFSET
            stmt.setInt(3, limit);   // FETCH NEXT

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
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
                cv.setApply_ID(rs.getInt("Apply_ID"));
                JobPost jobPost = new JobPost();
                jobPost.setJobPost_ID(rs.getInt("JobPost_ID"));
                jobPost.setTitle(rs.getString("Title"));
                jobPost.setPosition(rs.getString("JP_Position"));
                jobPost.setLocation(rs.getString("Location"));
                cv.setJobPost(jobPost);

                cvList.add(cv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return cvList;
    }

    //count CV applied 
    public int countAppliedCVsByEmployer(int employerId) {
        String sql = "SELECT COUNT(*) FROM CV "
                + "INNER JOIN Apply A ON CV.CV_ID = A.CV_ID "
                + "INNER JOIN JobPost JP ON A.JobPost_ID = JP.JobPost_ID "
                + "WHERE JP.Employer_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, employerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

//hàm search Cv for employer
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
        input = input.trim();              // Loại bỏ khoảng trắng đầu và cuối
        input = input.replaceAll("\\s+", " "); // Thay nhiều khoảng trắng thành 1
        return input;
    }

    public List<CV> searchCVsForEmployer(int employerId, String address, Integer numberExp,
            String position, String keyword, String field,
            int limit, int offset) {
        List<CV> result = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        // Chuẩn hóa đầu vào
        address = normalize(address);
        position = normalize(position);
        field = normalize(field);
        keyword = normalize(keyword);

        // Bắt đầu xây dựng câu SQL
        StringBuilder sql = new StringBuilder(
                "SELECT CV.CV_ID, CV.Candidate_ID, CV.Full_Name, CV.Address, CV.Email, "
                + "CV.Position, CV.Number_exp, CV.Education, CV.Field, CV.Current_Salary, "
                + "CV.Birthday, CV.Nationality, CV.Gender, CV.FileData, CV.MimeType, "
                + "JobPost.JobPost_ID, JobPost.Title, JobPost.Position AS JP_Position, JobPost.Location "
                + "FROM CV "
                + "INNER JOIN Apply ON CV.CV_ID = Apply.CV_ID "
                + "INNER JOIN JobPost ON Apply.JobPost_ID = JobPost.JobPost_ID "
                + "WHERE JobPost.Employer_ID = ?"
        );

        // Thêm employerId vào param đầu tiên
        params.add(employerId);

        // Gắn các điều kiện tìm kiếm nếu có
        buildSearchConditions(sql, params, address, numberExp, position, keyword, field);

        // Thêm phân trang theo cú pháp SQL Server
        sql.append(" ORDER BY CV.CV_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset); // OFFSET
        params.add(limit);  // FETCH NEXT

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
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

                result.add(cv);
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in searchCVsForEmployer: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected error in searchCVsForEmployer: " + e.getMessage());
            e.printStackTrace();
        }

        return result;
    }

    //count CV khi search
    public int countSearchCVsForEmployer(int employerId, String address, Integer numberExp,
            String position, String keyword, String field) {
        List<Object> params = new ArrayList<>();

        address = normalize(address);
        position = normalize(position);
        field = normalize(field);
        keyword = normalize(keyword);

        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM CV "
                + "INNER JOIN Apply ON CV.CV_ID = Apply.CV_ID "
                + "INNER JOIN JobPost ON Apply.JobPost_ID = JobPost.JobPost_ID "
                + "WHERE JobPost.Employer_ID = ?"
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

    
    
    //method hiện thị CV thuộc JobPost
    // 1. Kiểm tra xem JobPost có thuộc về Employer hay không
    public boolean isJobPostOwnedByEmployer(int jobPostId, int employerId) {
        String sql = "SELECT 1 FROM JobPost WHERE JobPost_ID = ? AND Employer_ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, jobPostId);
            stmt.setInt(2, employerId);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Nếu có kết quả thì đúng employer sở hữu
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    //đếm 
    public int countCVsByJobPostId(int jobPostId) {
    String sql = "SELECT COUNT(*) FROM Apply WHERE JobPost_ID = ?";
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, jobPostId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}
    // 2. Lấy danh sách CV apply vào JobPost_ID
    public List<CV> getCVsByJobPostId(int jobPostId, int limit, int offset) {
        List<CV> cvList = new ArrayList<>();

        String sql = "SELECT CV.CV_ID, CV.Candidate_ID, CV.Full_Name, CV.Address, CV.Email, "
                + "CV.Position, CV.Number_exp, CV.Education, CV.Field, CV.Current_Salary, "
                + "CV.Birthday, CV.Nationality, CV.Gender, CV.FileData, CV.MimeType, "
                + "JP.Title "
                + "FROM Apply A "
                + "INNER JOIN CV ON A.CV_ID = CV.CV_ID "
                + "INNER JOIN JobPost JP ON A.JobPost_ID = JP.JobPost_ID "
                + "WHERE A.JobPost_ID = ? "
                + "ORDER BY CV.CV_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, jobPostId); // WHERE A.JobPost_ID = ?
            stmt.setInt(2, offset);     // OFFSET ?
            stmt.setInt(3, limit);      // FETCH NEXT ?

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
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
                jobPost.setTitle(rs.getString("Title"));
                cv.setJobPost(jobPost);

                cvList.add(cv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cvList;
    }

    // 3. Kết hợp: chỉ lấy CV nếu jobPost thuộc employer
    public List<CV> getSecureCVsByJobPost(int jobPostId, int employerId, int limit, int offset) {
        if (isJobPostOwnedByEmployer(jobPostId, employerId)) {
            return getCVsByJobPostId(jobPostId, limit, offset);
        } else {
            System.out.println("⚠ JobPost_ID " + jobPostId + " is not owned by Employer_ID " + employerId);
            return Collections.emptyList();
        }
    }

    
    
    public static void main(String[] args) {
        CVDAO dao = new CVDAO();

        int employerId = 1; // ID employer muốn test
        int pageSize = 5;   // Số CV mỗi trang
        int page = 1;       // Trang muốn test (bạn có thể thay đổi)

        int offset = (page - 1) * pageSize;

        // Lấy danh sách CV theo trang
        List<CV> cvList = dao.getAppliedCVsByEmployer(employerId, pageSize, offset);

        // Tổng số CV để kiểm tra tổng số trang
        int total = dao.countAppliedCVsByEmployer(employerId);
        int totalPages = (int) Math.ceil((double) total / pageSize);

        // In ra kết quả
        System.out.println("==> Đang ở trang " + page + "/" + totalPages);
        System.out.println("==> Có tổng cộng " + total + " CV ứng tuyển");

        if (cvList.isEmpty()) {
            System.out.println("⚠ Không có CV nào trong trang này.");
        } else {
            for (CV cv : cvList) {
                System.out.println("--------------------------------------------------");
                System.out.println("Họ tên: " + cv.getFullName());
                System.out.println("Email: " + cv.getEmail());
                System.out.println("Vị trí ứng tuyển: " + cv.getPosition());
                System.out.println("Kinh nghiệm: " + cv.getNumberExp() + " năm");
                System.out.println("Ứng tuyển vào: " + (cv.getJobPost() != null ? cv.getJobPost().getTitle() : "N/A"));
            }
        }
    }

    // Test case 1: Search by address only
//        System.out.println("🔍 Tìm kiếm theo địa chỉ 'HN':");
//        List<CV> result1 = dao.searchCVsForEmployer(1, null, null, null, null);
//        for (CV cv : result1) {
//            System.out.println("CV ID: " + cv.getCvId() + ", Họ tên: " + cv.getFullName()
//                    + ", Địa chỉ: " + cv.getAddress() + ", Vị trí: " + cv.getPosition()
//                    + ", Kinh nghiệm: " + cv.getNumberExp());
//        }
//        System.out.println("------------");
//
//        // Test case 2: Search by address and numberExp
//        System.out.println("🔍 Tìm kiếm theo địa chỉ 'HN' và số năm kinh nghiệm = 2:");
//        List<CV> result2 = dao.searchCVsForEmployer(employerId, "HN", 2, null, null);
//        for (CV cv : result2) {
//            System.out.println("CV ID: " + cv.getCvId() + ", Họ tên: " + cv.getFullName()
//                    + ", Địa chỉ: " + cv.getAddress() + ", Vị trí: " + cv.getPosition()
//                    + ", Kinh nghiệm: " + cv.getNumberExp());
//        }
//        System.out.println("------------");
//
//        // ✅ Test case 3: Search by keyword (ví dụ: tìm 'developer' trong Full_Name, Position, Field, Education)
//        System.out.println("🔍 Tìm kiếm theo từ khóa 'developer':");
//        List<CV> result3 = dao.searchCVsForEmployer(employerId, null, null, null, "developer");
//        for (CV cv : result3) {
//            System.out.println("CV ID: " + cv.getCvId() + ", Họ tên: " + cv.getFullName()
//                    + ", Vị trí: " + cv.getPosition() + ", Ngành: " + cv.getField()
//                    + ", Học vấn: " + cv.getEducation());
//        }
//        System.out.println("------------");
//
//        // Test case 4: Kết hợp address + numberExp + position + keyword
//        System.out.println("🔍 Kết hợp HN + 2 năm + 'Dev' + từ khóa 'Java':");
//        List<CV> result4 = dao.searchCVsForEmployer(employerId, null, null, null, "Web");
//        for (CV cv : result4) {
//            System.out.println("CV ID: " + cv.getCvId() + ", Họ tên: " + cv.getFullName()
//                    + ", Vị trí: " + cv.getPosition() + ", Học vấn: " + cv.getEducation()
//                    + ", Ngành: " + cv.getField());
//        }
//        System.out.println("------------");
}
