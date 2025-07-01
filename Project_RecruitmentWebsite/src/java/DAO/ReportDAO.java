/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import dal.DBContext;
import Models.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO extends DBContext {

    // lấy danh sách các báo cáo 
    public List<Report> getListReport() {
        List<Report> list = new ArrayList<>();
        try {
            String query = "SELECT [FeedbackReport_ID]\n"
                    + "      ,[sender_id]\n"
                    + "      ,[sender_role]\n"
                    + "      ,[phone_sender]\n"
                    + "      ,[title]\n"
                    + "      ,[content]\n"
                    + "      ,[created_at]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[FeedbackReport]";

            PreparedStatement push = connection.prepareStatement(query);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                list.add(new Report(rs.getString("FeedbackReport_ID"), rs.getString("sender_id"),
                        rs.getString("sender_role"),
                        rs.getString("phone_sender"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getDate("created_at"),
                        rs.getString("status")));
            }
            return list;
        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());
        }
        return new ArrayList<>();
    }

    // set new Status cho report 
    public boolean setNewStatusReport(String status, String idReport) {
        try {
            String query = "Update  [dbo].[FeedbackReport]\n"
                    + "      Set [status]=?\n"
                    + "      WHERE  [FeedbackReport_ID]=?";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, status);
            push.setString(2, idReport);
            int row = push.executeUpdate();
            return row > 0 ? true : false;
        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());
        }
        return false;
    }

    //get View Detail của 1 thằng 
    public Report viewDetail(String idFeedBackReportID) {
        try {
            String query = "SELECT [FeedbackReport_ID]\n"
                    + "      ,[sender_id]\n"
                    + "      ,[sender_role]\n"
                    + "      ,[phone_sender]\n"
                    + "      ,[title]\n"
                    + "      ,[content]\n"
                    + "      ,[created_at]\n"
                    + "      ,[status]\n"
                    + "      ,[image_Report]\n"
                    + "      ,[Admin_ID]\n"
                    + "  FROM [dbo].[FeedbackReport] s1\n"
                    + "  WHERE s1.FeedbackReport_ID = ?";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1,idFeedBackReportID);
            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                return new Report(rs.getString("FeedbackReport_ID"), rs.getString("sender_id"),
                        rs.getString("sender_role"),
                        rs.getString("phone_sender"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getDate("created_at"),
                        rs.getString("status"),
                        rs.getString("image_Report"));
            }

        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());
        }
        return null;
    }
    
    

    // search
    public List<Report> search(String date, String phone, String status) {
        List<Report> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM FeedbackReport WHERE "
                    + "(? IS NULL OR CONVERT(DATE, created_at) LIKE ?) "
                    + "AND (? IS NULL OR phone_sender LIKE ?) "
                    + "AND (? IS NULL OR status LIKE ?)";

            PreparedStatement push = connection.prepareStatement(sql);

            // Date
            if (date == null || date.isEmpty()) {
                push.setNull(1, java.sql.Types.VARCHAR);
                push.setNull(2, java.sql.Types.VARCHAR);
            } else {
                push.setString(1, "%" + date + "%");
                push.setString(2, "%" + date + "%");
            }

            // Phone
            if (phone == null || phone.isEmpty()) {
                push.setNull(3, java.sql.Types.VARCHAR);
                push.setNull(4, java.sql.Types.VARCHAR);
            } else {
                push.setString(3, "%" + phone + "%");
                push.setString(4, "%" + phone + "%");
            }

            // Status
            if (status == null || status.isEmpty()) {
                push.setNull(5, java.sql.Types.VARCHAR);
                push.setNull(6, java.sql.Types.VARCHAR);
            } else {
                push.setString(5, "%" + status + "%");
                push.setString(6, "%" + status + "%");
            }

            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                list.add(new Report(
                        rs.getString("FeedbackReport_ID"),
                        rs.getString("sender_id"),
                        rs.getString("sender_role"),
                        rs.getString("phone_sender"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getDate("created_at"),
                        rs.getString("status")
                ));
            }

        } catch (Exception e) {
            System.out.println("Lỗi trong search(): " + e.getMessage());
        }

        return list;
    }

    public static void main(String[] args) {
        ReportDAO s = new ReportDAO();
//        s.search(null, null, "resolved").forEach(t -> System.out.println(t));
        //  System.out.println(s.setNewStatusReport("resolved", "1"));
        System.out.println(s.viewDetail("6"));
    }
}
