///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package DAO;
//
//import Models.CV;
//import dal.DBContext;
//import java.sql.Blob;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.util.ArrayList;
//import java.util.List;
//
///**
// *
// * @author admin
// */
//public class paginationDAO extends DBContext {
//
//    public int getPagination(int employerId) {  //hàm để làm phân trang hiện thị CV cho employer
//        String sql = "SELECT COUNT(DISTINCT A.CV_ID) AS SoLuongCV_Applied\n"
//                + "FROM Apply A\n"
//                + "JOIN JobPost JP ON A.JobPost_ID = JP.JobPost_ID\n"
//                + "WHERE JP.Employer_ID = 1;";
//        try {
//            PreparedStatement stmt = connection.prepareStatement(sql);
//            stmt.setInt(1, employerId);
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                return rs.getInt(1);
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return 0;
//    }
//
//    public List<CV> pagingCV(int index,int employerId) {
//        List<CV> list = new ArrayList<>();
//        String sql = "SELECT DISTINCT CV.*\n"
//                + "FROM Apply A\n"
//                + "JOIN JobPost JP ON A.JobPost_ID = JP.JobPost_ID\n"
//                + "JOIN CV ON A.CV_ID = CV.CV_ID\n"
//                + "WHERE JP.Employer_ID = 1\n"
//                + "ORDER BY CV.CV_ID\n"
//                + "OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY;\n";
//        try {
//            PreparedStatement stmt = connection.prepareStatement(sql);
//            stmt.setInt(1, employerId);
//            stmt.setInt(1, (index - 1) * 5);
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                CV cv = new CV();
//                cv.setCvId(rs.getInt("CV_ID"));
//                cv.setCandidateId(rs.getInt("Candidate_ID"));
//                cv.setFullName(rs.getString("Full_Name"));
//                cv.setAddress(rs.getString("Address"));
//                cv.setEmail(rs.getString("Email"));
//                cv.setPosition(rs.getString("Position"));
//                cv.setNumberExp(rs.getInt("Number_exp"));
//                cv.setEducation(rs.getString("Education"));
//                cv.setField(rs.getString("Field"));
//                cv.setCurrentSalary(rs.getDouble("Current_Salary"));
//                cv.setBirthday(rs.getDate("Birthday"));
//                cv.setNationality(rs.getString("Nationality"));
//                cv.setGender(rs.getString("Gender"));
//
//                Blob blob = rs.getBlob("FileData");
//                if (blob != null) {
//                    cv.setFileData(blob.getBinaryStream());
//                }
//                cv.setMimeType(rs.getString("MimeType"));
//
//                list.add(cv);
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return list;
//    }
//
//    public static void main(String[] args) {
//        paginationDAO dao = new paginationDAO();
////        int totalCV = dao.getPagination();
////        System.out.println(totalCV);
//
//        List<CV> list = dao.pagingCV(1,1);
//        for (CV c : list) {
//            System.out.println(c);
//        }
//
//    }
//}

package DAO;

import Models.CV;
import dal.DBContext;


import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class paginationDAO extends DBContext {
    
    private static final int PAGE_SIZE = 5;

    public int getPagination(int employerId) {
        String sql = "SELECT COUNT(DISTINCT A.CV_ID) AS SoLuongCV_Applied\n"
                + "FROM Apply A\n"
                + "JOIN JobPost JP ON A.JobPost_ID = JP.JobPost_ID\n"
                + "WHERE JP.Employer_ID = ?;";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, employerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<CV> pagingCV(int index, int employerId) {
        List<CV> list = new ArrayList<>();
        String sql = "SELECT DISTINCT CV.*\n"
                + "FROM Apply A\n"
                + "JOIN JobPost JP ON A.JobPost_ID = JP.JobPost_ID\n"
                + "JOIN CV ON A.CV_ID = CV.CV_ID\n"
                + "WHERE JP.Employer_ID = ?\n"
                + "ORDER BY CV.CV_ID\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, employerId);
            stmt.setInt(2, (index - 1) * PAGE_SIZE);
            stmt.setInt(3, PAGE_SIZE);
            try (ResultSet rs = stmt.executeQuery()) {
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
                    list.add(cv);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public static void main(String[] args) {
        paginationDAO dao = new paginationDAO();
//        int totalCV = dao.getPagination();
//        System.out.println(totalCV);

        List<CV> list = dao.pagingCV(4,1);
        for (CV c : list) {
            System.out.println(c);
        }
    }
}