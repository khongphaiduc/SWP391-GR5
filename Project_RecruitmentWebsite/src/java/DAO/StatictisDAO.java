package DAO;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class StatictisDAO extends DBContext {

    // lấy số lượng candidte của 1 tháng 1 năm
    public int GetNumberOfNewRegisterCadidate(int Month, int Year) {
        try {
            String query = " select Count(s1.Candidate_ID) as Number\n"
                    + "  from [dbo].[Candidate]s1\n"
                    + "  where Month(s1.dateCre) =? and Year(s1.dateCre)=?";
            PreparedStatement push = connection.prepareStatement(query);
            push.setInt(1, Month);
            push.setInt(2, Year);
            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                return rs.getInt("Number");
            }
        } catch (Exception e) {
            System.out.println("Bug Statictis :" + e.getMessage());
        }
        return 0;
    }

    // lấy số lượng employer của 1 tháng 1 năm
    public int GetNumberOfNewRegisterEmployer(int Month, int Year) {
        try {
            String query = " select Count(s1.dateCre) as Number\n"
                    + " from [dbo].[Employer] s1\n"
                    + " where Month(s1.dateCre) = ? and  Year(s1.dateCre)=? ";
            PreparedStatement push = connection.prepareStatement(query);
            push.setInt(1, Month);
            push.setInt(2, Year);
            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                return rs.getInt("Number");
            }
        } catch (Exception e) {
            System.out.println("Bug Statictis :" + e.getMessage());
        }
        return 0;
    }

    // thống kê Employer theo năm
    public List<Integer> GetStatictisNumberEmployer(int Year) {
        List<Integer> list = new ArrayList<>();
        for (int i = 1; i <= 12; i++) {
            list.add(GetNumberOfNewRegisterEmployer(i, Year));
        }
        return list;
    }

    // thống kê Candidate theo năm
    public List<Integer> GetStatictisNumberCandidate(int Year) {
        List<Integer> list = new ArrayList<>();
        for (int i = 1; i <= 12; i++) {
            list.add(GetNumberOfNewRegisterCadidate(i, Year));
        }
        return list;
    }

    //thống kê doanh thu theo tháng của năm
    public double GetProfixOFMonth(int Month, int Year) {

        try {
            String query = " select Sum(s1.Amount) as Total\n"
                    + " from  [dbo].[Orders]s1\n"
                    + " where s1.Status = 'done'and Month(s1.Date) = ? and Year(s1.Date)=?";
            PreparedStatement push = connection.prepareStatement(query);
            push.setInt(1, Month);
            push.setInt(2, Year);
            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    // lấy tất cả doanh thu của các tháng trong năm
    public List<Double> StatisticProfixOfYear(int Year) {
        List<Double> list = new ArrayList<>();
        for (int i = 1; i <= 12; i++) {
            list.add(GetProfixOFMonth(i, Year));
        }
        return list;
    }

    // tính tổng doanh thu
    public double TotalProfix(List<Double> profix) {
        double total = 0;
        for (int i = 0; i < profix.size(); i++) {
            total += profix.get(i);
        }
        return total;
    }

    //số lượng tin tuyển dụng của 1 tháng  trong năm 
    public int GetNumberJobPost(int Month, int Year) {
        try {
            String query = "  select count(s1.JobPost_ID) as Total \n"
                    + "  from [dbo].[JobPost] s1\n"
                    + "  where  Month (s1.DayCreate) = ? and Year(s1.DayCreate)=?";
            PreparedStatement push = connection.prepareStatement(query);
            push.setInt(1, Month);
            push.setInt(2, Year);
            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    // thống kê số lương tin tuyển dụng của cả năm
    public List<Integer> StatictisNumberJobPostOfYear(int Year) {
        List<Integer> list = new ArrayList<>();
        for (int i = 1; i <= 12; i++) {
            list.add(GetNumberJobPost(i, Year));
        }
        return list;
    }

    // số lượng báo cáo của tháng 
    public int GetNumberReport(int Month, int Year) {
        try {
            String query = "  select count(s1.FeedbackReport_ID) as Number\n"
                    + "  from [dbo].[FeedbackReport] s1\n"
                    + "  where Month(s1.created_at)=? and Year(s1.created_at)=?";
            PreparedStatement push = connection.prepareStatement(query);
            push.setInt(1, Month);
            push.setInt(2, Year);
            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                return rs.getInt("Number");
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
// thống kê số lượng báo caos của cả năm
    public List<Integer> StatictisNumberReportfYear(int Year) {
        List<Integer> list = new ArrayList<>();
        for (int i = 1; i <= 12; i++) {
            list.add(GetNumberReport(i, Year));
        }
        return list;
    }

    public static void main(String[] args) {
        StatictisDAO s = new StatictisDAO();
        //   System.out.println(s.GetNumberOfNewRegisterEmployer(3, 2025));
        // s.GetStatictisNumberCandidate(2025).forEach(k -> System.out.println(k));
        // s.StatictisNumberCandidate(2025).forEach((var k) -> System.out.println(k));
        //System.out.println(s.GetNumberCandidateNewRigister(4, 2025));
    }
}
