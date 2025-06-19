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
            String nationality, String gender, InputStream inputStream, String mimeType) {
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
            stmt.setBlob(13, inputStream);
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
                Blob fileBlob = rs.getBlob("FileData");
                if (fileBlob != null) {
                    cv.setFileData(fileBlob.getBinaryStream());
                }
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
                Blob fileBlob = rs.getBlob("FileData");
                if (fileBlob != null) {
                    cv.setFileData(fileBlob.getBinaryStream());
                }
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
            InputStream inputStream, String mimeType) {
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
                stmt.setBlob(index++, inputStream);
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
    public List<CV> getAppliedCVsByEmployer(int employerId) {
        List<CV> cvList = new ArrayList<>();
        String sql = "SELECT CV.CV_ID, CV.Candidate_ID, CV.Full_Name, CV.Address, CV.Email, "
                + "CV.Position, CV.Number_exp, CV.Education, CV.Field, CV.Current_Salary, "
                + "CV.Birthday, CV.Nationality, CV.Gender, CV.FileData, CV.MimeType, "
                + "JP.JobPost_ID, JP.Title, JP.Position AS JP_Position, JP.Location "
                + "FROM CV "
                + "INNER JOIN Apply A ON CV.CV_ID = A.CV_ID "
                + "INNER JOIN JobPost JP ON A.JobPost_ID = JP.JobPost_ID "
                + "WHERE JP.Employer_ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, employerId);
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

                Blob blob = rs.getBlob("FileData");
                if (blob != null) {
                    cv.setFileData(blob.getBinaryStream());
                }
                cv.setMimeType(rs.getString("MimeType"));

                // Tạo và gắn JobPost
                JobPost jobPost = new JobPost();
                jobPost.setJobPost_ID(rs.getInt("JobPost_ID"));
                jobPost.setTitle(rs.getString("Title"));
                jobPost.setPosition(rs.getString("JP_Position"));
                jobPost.setLocation(rs.getString("Location"));

                cv.setJobPost(jobPost);

                cvList.add(cv);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Có thể thay bằng logger nếu có hệ thống log
        }

        return cvList;
    }

//hàm search Cv for employer
    public List<CV> searchCVsForEmployer(int employerId, String address, Integer numberExp, String position, String keyword, String field) {
    List<CV> result = new ArrayList<>();
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

    if (address != null && !address.trim().isEmpty()) {
        sql.append(" AND CV.Address LIKE ?");
    }
    if (numberExp != null) {
        sql.append(" AND CV.Number_exp = ?");
    }
    if (position != null && !position.trim().isEmpty()) {
        sql.append(" AND CV.Position LIKE ?");
    }
    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND (CV.Address LIKE ? OR CV.Position LIKE ? OR CV.Education LIKE ? OR CV.Gender LIKE ? OR CV.Field LIKE ?)");
    }

    try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
        int paramIndex = 1;
        ps.setInt(paramIndex++, employerId);

        if (address != null && !address.trim().isEmpty()) {
            ps.setString(paramIndex++, "%" + address + "%");
        }
        if (numberExp != null) {
            ps.setInt(paramIndex++, numberExp);
        }
        if (position != null && !position.trim().isEmpty()) {
            ps.setString(paramIndex++, "%" + position + "%");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            String likeKeyword = "%" + keyword + "%";
            ps.setString(paramIndex++, likeKeyword); // Address 
            ps.setString(paramIndex++, likeKeyword); // Position
            ps.setString(paramIndex++, likeKeyword); // Education
            ps.setString(paramIndex++, likeKeyword); // Gender
            ps.setString(paramIndex++, likeKeyword);
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
            Blob blob = rs.getBlob("FileData");
            if (blob != null) {
                cv.setFileData(blob.getBinaryStream());
            }
            cv.setMimeType(rs.getString("MimeType"));

            // Gắn JobPost vào CV
            JobPost jobPost = new JobPost();
            jobPost.setJobPost_ID(rs.getInt("JobPost_ID"));
            jobPost.setTitle(rs.getString("Title"));
            jobPost.setPosition(rs.getString("JP_Position"));
            jobPost.setLocation(rs.getString("Location"));
            cv.setJobPost(jobPost);

            result.add(cv);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return result;
}
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

    // 2. Lấy danh sách CV apply vào JobPost_ID
    public List<CV> getCVsByJobPostId(int jobPostId) {
    List<CV> cvList = new ArrayList<>();

    String sql = "SELECT CV.CV_ID, CV.Candidate_ID, CV.Full_Name, CV.Address, CV.Email, "
               + "CV.Position, CV.Number_exp, CV.Education, CV.Field, CV.Current_Salary, "
               + "CV.Birthday, CV.Nationality, CV.Gender, CV.FileData, CV.MimeType, "
               + "JP.Title "
               + "FROM Apply A "
               + "INNER JOIN CV ON A.CV_ID = CV.CV_ID "
               + "INNER JOIN JobPost JP ON A.JobPost_ID = JP.JobPost_ID "
               + "WHERE A.JobPost_ID = ?";

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, jobPostId);
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

            Blob blob = rs.getBlob("FileData");
            if (blob != null) {
                cv.setFileData(blob.getBinaryStream());
            }
            cv.setMimeType(rs.getString("MimeType"));

            // Gắn JobPost Title nếu cần sử dụng trong hiển thị
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
    public List<CV> getSecureCVsByJobPost(int jobPostId, int employerId) {
        if (isJobPostOwnedByEmployer(jobPostId, employerId)) {
            return getCVsByJobPostId(jobPostId);
        } else {
            System.out.println("⚠ JobPost_ID " + jobPostId + " is not owned by Employer_ID " + employerId);
            return Collections.emptyList();
        }
    }


    public static void main(String[] args) {
        CVDAO dao = new CVDAO();
        int employerId = 1;  // ví dụ employer đang đăng nhập có ID = 1
            int jobPostId = 1;   // muốn lấy CV apply vào jobPost có ID = 1

            List<CV> cvList = dao.getSecureCVsByJobPost(jobPostId, employerId);

            if (cvList.isEmpty()) {
                System.out.println("⚠ Không có CV nào hoặc JobPost không thuộc employer.");
            } else {
                System.out.println("📄 Danh sách CV apply vào JobPost_ID = " + jobPostId + ":");
                for (CV cv : cvList) {
                    System.out.println("-----------------------------------");
                    System.out.println("Họ tên: " + cv.getFullName());
                    System.out.println("Email: " + cv.getEmail());
                    System.out.println("Vị trí ứng tuyển: " + cv.getPosition());
                    System.out.println("Kinh nghiệm: " + cv.getNumberExp() + " năm");
                    System.out.println("Trình độ học vấn: " + cv.getEducation());
                    System.out.println("Quốc tịch: " + cv.getNationality());
                    JobPost jp = cv.getJobPost();
                    if(jp != null){
                        System.out.println("Tiêu đề: " + jp.getTitle());
                }
                    
                    
                    
            }
                
            }

//        int employerId = 1;
//        List<CV> appliedCVs = dao.getAppliedCVsByEmployer(employerId);
//
//            // In ra danh sách CVs và thông tin jobpost tương ứng
//            for (CV cv : appliedCVs) {
//                System.out.println("----- CV -----");
//                System.out.println("Tên ứng viên: " + cv.getFullName());
//                System.out.println("Email: " + cv.getEmail());
//                System.out.println("Vị trí ứng tuyển: " + cv.getPosition());
//                System.out.println("Kinh nghiệm: " + cv.getNumberExp() + " năm");
//
//                JobPost jp = cv.getJobPost();
//                if (jp != null) {
//                    System.out.println("--- JobPost ---");
//                    System.out.println("Tiêu đề: " + jp.getTitle());
//                    System.out.println("Vị trí: " + jp.getPosition());
//                    System.out.println("Địa điểm: " + jp.getLocation());
//                }
//                System.out.println();
//            }

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

}
