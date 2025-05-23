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

/**
 *
 * @author PC
 */
public class CVDAO extends DBContext{
    

    public  boolean addCV(String fullName, String address, String email,
            String position, int numberExp, String education, String field,
            Double currentSalary, Date birthday,
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
            stmt.setInt(12, 1); // candidateId = 1 (test)
            stmt.setBlob(13, inputStream);
            stmt.setString(14, mimeType);
            int row = stmt.executeUpdate();
            return row > 0;

        } catch (Exception e) {
            return false;
        }
    }

    public  List<CV> getCVByCandidate(int candidateId) {
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
             DBContext dBContext=new DBContext();
            
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

}
