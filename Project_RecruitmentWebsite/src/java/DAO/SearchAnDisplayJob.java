//phamtrunduc
package DAO;

import java.sql.*;
import Models.JobPost;
import dal.DBContext;
import java.util.ArrayList;
import java.util.List;

public class SearchAnDisplayJob extends DBContext {

    // lấy list Job để hiển thị  (đức đã test)
    public List<JobPost> getListJobPost() {
        List<JobPost> list = new ArrayList<>();

        try {
            String query = "SELECT [JobPost_ID]\n"
                    + "      ,s1.[Employer_ID]\n"
                    + "      ,[Title]\n"
                    + "      ,s1.[Description]\n"
                    + "      ,[Category]\n"
                    + "      ,[Position]\n"
                    + "      ,s1.[Location]\n"
                    + "      ,[Offer_Min]\n"
                    + "      ,[Offer_Max]\n"
                    + "      ,[Number_exp]\n"
                    + "      ,[Visible]\n"
                    + "      ,[TypeJob]\n"
                    + "      ,[DayCreate]\n"
                    + "	  ,s2.Company_Name\n"
                    + "  FROM [dbo].[JobPost] s1\n"
                    + "  join [dbo].[Employers] s2 on s1.Employer_ID=s2.Employer_ID";

            PreparedStatement push = connection.prepareStatement(query);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                list.add(new JobPost(rs.getInt("JobPost_ID"), rs.getString("Title"), rs.getString("Description"), rs.getString("Category"), rs.getString("Location"), rs.getDouble("Offer_Min"), rs.getDouble("Offer_Max"), rs.getInt("Number_exp"), rs.getBoolean("Visible"), rs.getString("TypeJob"), rs.getString("DayCreate"), rs.getString("Company_Name")));
            }

            return list;

        } catch (Exception s) {
            System.out.println(s);
        }

        return null;
    }

    // tìm theo lương   (đã test)
    public List<JobPost> getListJobPostBySalary(String option) {
        String t = "";

        if (option.equals("1")) {
            t = "s1.Offer_Min>0 and s1.Offer_Max<=1000";
        } else if (option.equals("2")) {
            t = "s1.Offer_Min>=1000 and s1.Offer_Max<=1500";
        } else if (option.equals("3")) {
            t = "s1.Offer_Min>=1500 and s1.Offer_Max<=2000";
        } else if (option.equals("4")) {
            t = "s1.Offer_Min>=2000 and s1.Offer_Max<=3000";
        } else if (option.equals("0")) {
            t = "s1.Offer_Min>0";
        } else {
            t = "s1.Offer_Min>=3000";
        }

        List<JobPost> list = new ArrayList<>();

        try {
            String query = "SELECT [JobPost_ID]\n"
                    + "      ,s1.[Employer_ID]\n"
                    + "      ,[Title]\n"
                    + "      ,s1.[Description]\n"
                    + "      ,[Category]\n"
                    + "      ,[Position]\n"
                    + "      ,s1.[Location]\n"
                    + "      ,[Offer_Min]\n"
                    + "      ,[Offer_Max]\n"
                    + "      ,[Number_exp]\n"
                    + "      ,[Visible]\n"
                    + "      ,[TypeJob]\n"
                    + "      ,[DayCreate]\n"
                    + "	  ,s2.Company_Name\n"
                    + "  FROM [dbo].[JobPost] s1\n"
                    + "  join [dbo].[Employers] s2 on s1.Employer_ID=s2.Employer_ID\n"
                    + "  where " + t;

            PreparedStatement push = connection.prepareStatement(query);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                list.add(new JobPost(rs.getInt("JobPost_ID"), rs.getString("Title"), rs.getString("Description"), rs.getString("Category"), rs.getString("Location"), rs.getDouble("Offer_Min"), rs.getDouble("Offer_Max"), rs.getInt("Number_exp"), rs.getBoolean("Visible"), rs.getString("TypeJob"), rs.getString("DayCreate"), rs.getString("Company_Name")));
            }
            return list;

        } catch (Exception s) {
            System.out.println(s);
        }

        return null;
    }

    // tìm theo vị trí     (đã test)
    public List<JobPost> getListJobPostByLocation(String option, String location) {
        String t = "s1.Offer_Min > 0";

        if (option.equals("1")) {
            t = "s1.Offer_Min>0 and s1.Offer_Max<=1000";
        } else if (option.equals("2")) {
            t = "s1.Offer_Min>=1000 and s1.Offer_Max<=1500";
        } else if (option.equals("3")) {
            t = "s1.Offer_Min>=1500 and s1.Offer_Max<=2000";
        } else if (option.equals("4")) {
            t = "s1.Offer_Min>=2000 and s1.Offer_Max<=3000";
        } else if (option.equals("0")) {
            t = "s1.Offer_Min>0";
        } else {
            t = "s1.Offer_Min>=3000";
        }

        List<JobPost> list = new ArrayList<>();

        try {
            String query = "SELECT [JobPost_ID], s1.[Employer_ID], [Title], s1.[Description], [Category], "
                    + "[Position], s1.[Location], [Offer_Min], [Offer_Max], [Number_exp], [Visible], [TypeJob], "
                    + "[DayCreate], s2.Company_Name "
                    + "FROM [dbo].[JobPost] s1 "
                    + "JOIN [dbo].[Employers] s2 ON s1.Employer_ID = s2.Employer_ID "
                    + "WHERE " + t + " AND s1.Location = ?";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, location);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                list.add(new JobPost(
                        rs.getInt("JobPost_ID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getString("Category"),
                        rs.getString("Location"),
                        rs.getDouble("Offer_Min"),
                        rs.getDouble("Offer_Max"),
                        rs.getInt("Number_exp"),
                        rs.getBoolean("Visible"),
                        rs.getString("TypeJob"),
                        rs.getString("DayCreate"),
                        rs.getString("Company_Name")
                ));
            }
            return list;

        } catch (Exception s) {
            System.out.println(s);
        }

        return new ArrayList<>();  // Trả list rỗng 
    }

    public static void main(String[] args) {
        SearchAnDisplayJob o = new SearchAnDisplayJob();

        if (o.getListJobPost() != null) {
            o.getListJobPostByLocation("0", "HCM").forEach(s -> System.out.println(s));
        }

    }
}
