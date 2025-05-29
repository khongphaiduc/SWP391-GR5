//phamtrunduc
package DAO;

import java.sql.*;
import Models.JobPost;
import dal.DBContext;
import java.util.ArrayList;
import java.util.Dictionary;
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
                list.add(new JobPost(
                        rs.getInt("JobPost_ID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getString("Category"),
                        rs.getString("Position"),
                        rs.getString("Location"),
                        rs.getDouble("Offer_Min"),
                        rs.getDouble("Offer_Max"),
                        rs.getInt("Number_exp"),
                        rs.getBoolean("Visible"),
                        rs.getString("TypeJob"),
                        rs.getString("DayCreate"),
                        rs.getString("Company_Name")));
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
                list.add(new JobPost(
                        rs.getInt("JobPost_ID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getString("Category"),
                        rs.getString("Position"),
                        rs.getString("Location"),
                        rs.getDouble("Offer_Min"),
                        rs.getDouble("Offer_Max"),
                        rs.getInt("Number_exp"),
                        rs.getBoolean("Visible"),
                        rs.getString("TypeJob"),
                        rs.getString("DayCreate"),
                        rs.getString("Company_Name")));
            }

            return list;

        } catch (Exception s) {
            System.out.println(s);
        }

        return null;
    }

    // tìm theo vị trí  với các option kèm theo   (đã test)
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
                    + "WHERE " + t + " AND s1.Location like ?";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, location);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                list.add(new JobPost(
                        rs.getInt("JobPost_ID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getString("Category"),
                        rs.getString("Position"),
                        rs.getString("Location"),
                        rs.getDouble("Offer_Min"),
                        rs.getDouble("Offer_Max"),
                        rs.getInt("Number_exp"),
                        rs.getBoolean("Visible"),
                        rs.getString("TypeJob"),
                        rs.getString("DayCreate"),
                        rs.getString("Company_Name")));
            }
            return list;

        } catch (Exception s) {
            System.out.println(s);
        }

        return new ArrayList<>();  // Trả list rỗng 
    }

    // chỉ tìm theo vị trí   (đã test 30/5)
    public List<JobPost> getListJobPostByOnlyLocation(String location) {

        String option = "WHERE s1.Location LIKE N'%Hồ Chí Minh%'   or s1.Location like 'HCM%'";

        if (location.equals("1")) {
            option = " WHERE s1.Location LIKE N'%Hồ Chí Minh%'   or s1.Location like 'HCM%'";   // Hồ Chí Minh   1
        } else if (location.equals("2")) {
            option = "  WHERE s1.Location LIKE N'%Hà Nội%'   or s1.Location like 'HN%' ";      // Hà  Nội  2
        } else if (location.equals("3")) {
            option = " WHERE s1.Location LIKE N'%Đà Nẵng%'   or s1.Location like 'DN%'";        // Đà Nẵng 3
        } else {
            option = " WHERE s1.Location LIKE N'%" + location + "%' ";
        }

        List<JobPost> list = new ArrayList<>();

        try {
            String query = "SELECT s1.[JobPost_ID]\n"
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
                    + "  join [dbo].[Employers] s2 on s1.Employer_ID=s2.Employer_ID"
                    + option;

            PreparedStatement push = connection.prepareStatement(query);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                list.add(new JobPost(
                        rs.getInt("JobPost_ID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getString("Category"),
                        rs.getString("Position"),
                        rs.getString("Location"),
                        rs.getDouble("Offer_Min"),
                        rs.getDouble("Offer_Max"),
                        rs.getInt("Number_exp"),
                        rs.getBoolean("Visible"),
                        rs.getString("TypeJob"),
                        rs.getString("DayCreate"),
                        rs.getString("Company_Name")));
            }
            return list;

        } catch (Exception s) {
            System.out.println(s);
        }

        return new ArrayList<>();  // Trả list rỗng 
    }

    // tìm theo lĩnh vực 
    public List<JobPost> getListJobPostByField(String option, String location, String field) {
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
            String query = "SELECT [JobPost_ID]\n"
                    + "      ,[Employer_ID]\n"
                    + "      ,[Title]\n"
                    + "      ,[Description]\n"
                    + "      ,[Category]\n"
                    + "      ,[Position]\n"
                    + "      ,[Location]\n"
                    + "      ,[Offer_Min]\n"
                    + "      ,[Offer_Max]\n"
                    + "      ,[Number_exp]\n"
                    + "      ,[Visible]\n"
                    + "      ,[TypeJob]\n"
                    + "      ,[DayCreate]\n"
                    + "  FROM [dbo].[JobPost] s1\n"
                    + "  Where s1.Category = ? and " + t + " and (s1.Location=?)";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, field);
            push.setString(2, location);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                list.add(new JobPost(
                        rs.getInt("JobPost_ID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getString("Category"),
                        rs.getString("Position"),
                        rs.getString("Location"),
                        rs.getDouble("Offer_Min"),
                        rs.getDouble("Offer_Max"),
                        rs.getInt("Number_exp"),
                        rs.getBoolean("Visible"),
                        rs.getString("TypeJob"),
                        rs.getString("DayCreate"),
                        rs.getString("Company_Name")));
            }
            return list;

        } catch (Exception s) {
            System.out.println(s);
        }

        return new ArrayList<>();  // Trả list rỗng 
    }

    // chỉ tìm theo lĩnh vực  (đã test 30/5)
    public List<JobPost> getListJobPostByOnlyField(String field) {

        String option = "";

        if (field.equals("1")) {
            option = "  WHERE s1.Category like N'Công nghệ thông tin' or s1.Category like 'IT'";   // 1 it
        } else if (field.equals("2")) {
            option = " WHERE s1.Category like N'%Nhân sự%' or s1.Category like 'HR'";              //2 nhân sự (HR)
        } else if (field.equals("3")) {
            option = " WHERE s1.Category like N'%Marketing%'";
        } else if (field.equals("4")) {
            option = " WHERE s1.Category like N'%Kinh doanh%' or s1.Category like '%Tài chính%'";
        } else if (field.equals("5")) {
            option = "   WHERE s1.Category like N'%Mỹ thuật%'";
        } else if (field.equals("6")) {
            option = "   WHERE s1.Category like N'%Kiểm toán%'";
        } else if (field.equals("7")) {
            option = "   WHERE s1.Category like N'%Sales%'";
        } else if (field.equals("8")) {
            option = "   WHERE s1.Category like N'%Design%'";
        } else if (field.equals("9")) {
            option = "    WHERE s1.Category like N'%Finance%'";
        }
        List<JobPost> list = new ArrayList<>();

        try {
            String query = "SELECT s1.[JobPost_ID]\n"
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
                    + option;

            PreparedStatement push = connection.prepareStatement(query);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                list.add(new JobPost(
                        rs.getInt("JobPost_ID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getString("Category"),
                        rs.getString("Position"),
                        rs.getString("Location"),
                        rs.getDouble("Offer_Min"),
                        rs.getDouble("Offer_Max"),
                        rs.getInt("Number_exp"),
                        rs.getBoolean("Visible"),
                        rs.getString("TypeJob"),
                        rs.getString("DayCreate"),
                        rs.getString("Company_Name")));
            }
            return list;

        } catch (Exception s) {
            System.out.println(s);
        }

        return new ArrayList<>();  // Trả list rỗng 
    }

    // tìm kiếm theo tên công ty  (đã test 30/5)
    public List<JobPost> getListJobPostByOnlyNameCompany(String nameCompany) {

        List<JobPost> list = new ArrayList<>();

        try {
            String query = "SELECT s1.[JobPost_ID]\n"
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
                    + "  WHERE s2.Company_Name like ? ";
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, "%" + nameCompany + "%");   // hihih
            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                list.add(new JobPost(
                        rs.getInt("JobPost_ID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getString("Category"),
                        rs.getString("Position"),
                        rs.getString("Location"),
                        rs.getDouble("Offer_Min"),
                        rs.getDouble("Offer_Max"),
                        rs.getInt("Number_exp"),
                        rs.getBoolean("Visible"),
                        rs.getString("TypeJob"),
                        rs.getString("DayCreate"),
                        rs.getString("Company_Name")));
            }
            return list;

        } catch (Exception s) {
            System.out.println(s);
        }

        return new ArrayList<>();  // Trả list rỗng 
    }

    public static void main(String[] args) {
        SearchAnDisplayJob o = new SearchAnDisplayJob();
        o.getListJobPostByOnlyNameCompany("ABC Co.").forEach(a->System.out.println(a));
        
    }

}
