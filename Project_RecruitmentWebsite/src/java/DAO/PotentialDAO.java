package DAO;

import Models.CV;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PotentialDAO extends DBContext {

    // Check if CV exists in the Potential table
    public boolean isPotentialCVExists(int cvId, int employerId) {
        String sql = "SELECT 1 FROM Potential WHERE CV_ID = ? AND Employer_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, employerId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Add CV to Potential table
    public boolean addPotentialCV(int cvId, int employerId) {
        String sql = "INSERT INTO Potential (CV_ID, Employer_ID) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, employerId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLIntegrityConstraintViolationException e) {
            System.out.println("CV already marked as potential.");
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Remove CV from Potential table
    public boolean removePotentialCV(int cvId, int employerId) {
        String sql = "DELETE FROM Potential WHERE CV_ID = ? AND Employer_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, employerId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get potential CVs by employer ID with pagination
    public List<CV> getPotentialCVsByEmployerId(int employerId, int page, int pageSize) {
        List<CV> result = new ArrayList<>();
        String sql = "SELECT CV.* FROM CV "
                + "JOIN Potential ON CV.CV_ID = Potential.CV_ID "
                + "WHERE Potential.Employer_ID = ? "
                + "ORDER BY CV.CV_ID "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employerId);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
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

                try {
                    Blob blob = rs.getBlob("FileData");
                    if (blob != null && blob.length() > 0) {
                        cv.setFileData(blob.getBinaryStream());
                    } else {
                        cv.setFileData(null);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    cv.setFileData(null);
                }

                cv.setMimeType(rs.getString("MimeType"));
                result.add(cv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Get total count of potential CVs for pagination
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
 
    public static void main(String[] args) {
        PotentialDAO potentialDAO = new PotentialDAO();

        int testCvId = 3;           // Thay bằng ID CV có thật trong DB
        int testEmployerId = 1;     // Thay bằng Employer ID có thật

        System.out.println("=== KIỂM TRA VÀ THÊM CV TIỀM NĂNG ===");

        // Kiểm tra sự tồn tại
        boolean exists = potentialDAO.isPotentialCVExists(testCvId, testEmployerId);
        if (exists) {
            System.out.println("⚠️ CV (ID: " + testCvId + ") đã có trong danh sách tiềm năng của employer " + testEmployerId + ".");
        } else {
            // Thử thêm vào
            boolean added = potentialDAO.addPotentialCV(testCvId, testEmployerId);
            if (added) {
                System.out.println("✅ Đã thêm CV (ID: " + testCvId + ") vào danh sách tiềm năng.");
            } else {
                System.out.println("❌ Lỗi: Không thể thêm CV vào danh sách tiềm năng.");
            }
        }

        System.out.println("\n=== DANH SÁCH CV TIỀM NĂNG CỦA EMPLOYER " + testEmployerId + " ===");
        List<CV> potentialCVs = potentialDAO.getPotentialCVsByEmployerId(testEmployerId,1,10);

        if (potentialCVs.isEmpty()) {
            System.out.println("⚠️ Chưa có CV nào được đánh dấu là tiềm năng.");
        } else {
            for (CV cv : potentialCVs) {
                System.out.println("🔹 CV ID: " + cv.getCvId());
                System.out.println("   ➤ Họ tên     : " + cv.getFullName());
                System.out.println("   ➤ Email      : " + cv.getEmail());
                System.out.println("   ➤ Vị trí     : " + cv.getPosition());
                System.out.println("   ➤ Kinh nghiệm: " + cv.getNumberExp() + " năm");
                System.out.println("-----------------------------------------------");
            }
        }
    }
}

