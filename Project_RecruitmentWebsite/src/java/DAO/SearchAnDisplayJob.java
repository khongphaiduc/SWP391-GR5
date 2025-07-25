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
                    + "  join [dbo].[Employer] s2 on s1.Employer_ID=s2.Employer_ID";

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
                        rs.getDate("DayCreate"),
                        rs.getString("Company_Name")));
            }

            return list;

        } catch (Exception s) {
            System.out.println(s);
        }

        return null;
    }
 public List<JobPost> BuildTest(String salary, String location, String category, String number, String typeJob, String companyName) {
    
        if (salary == null) {
            salary = "0";
        }

        String min = null;
        String max = null;

        if (salary.equals("1")) {
            min = "0";
            max = "10";
        } else if (salary.equals("2")) {
            min = "10";
            max = "20";
        } else if (salary.equals("3")) {
            min = "20";
            max = "30";
        } else if (salary.equals("4")) {
            min = "30";
            max = "40";
        } else if (salary.equals("5")) {
            min = "40";
            max = "100000";
        } else if (salary.equals("0")) {
            min = "0";
            max = "100000000";
        }

        List<JobPost> list = new ArrayList<>();

        try {
            String query = "SELECT [JobPost_ID], s1.[Employer_ID], [Title], s1.[Description],\n"
                    + "       [Category], [Position], s1.[Location], [Offer_Min], [Offer_Max],\n"
                    + "       [Number_exp], [Visible], [TypeJob], [DayCreate], s2.Company_Name, s2.imgLogo\n"
                    + "FROM [dbo].[JobPost] s1\n"
                    + "JOIN [dbo].[Employer] s2 ON s1.Employer_ID = s2.Employer_ID\n"
                    + "WHERE (s1.Offer_Min >= ?) AND (s1.Offer_Max <= ?)\n"
                    + "  AND (? IS NULL OR s1.Location LIKE ?)\n"
                    + "  AND (? IS NULL OR s1.Category like ?)\n"
                    + "  AND (? IS NULL OR s1.Number_exp like ?)\n"
                    + "  AND (? IS NULL OR s1.TypeJob like ?) \n"
                    + "  AND (? IS NULL OR Title like ?)"
                    + "  AND(Visible = 1)"
                    + "Order by DayCreate desc";
            
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, min);
            push.setString(2, max);

            push.setString(3, location != null ? "%" + location + "%" : null);
            push.setString(4, location != null ? "%" + location + "%" : null);

            push.setString(5, category != null ? "%" + category + "%" : null);
            push.setString(6, category != null ? "%" + category + "%" : null);

            push.setString(7, number != null ? "%" + number + "%" : null);
            push.setString(8, number != null ? "%" + number + "%" : null);

            push.setString(9, typeJob != null ? "%" + typeJob + "%" : null);
            push.setString(10, typeJob != null ? "%" + typeJob + "%" : null);

            push.setString(11, companyName != null ? "%" + companyName + "%" : null);
            push.setString(12, companyName != null ? "%" + companyName + "%" : null);
            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                JobPost jb = new JobPost(
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
                        rs.getDate("DayCreate"),
                        rs.getString("Company_Name"));
                jb.setImgLogo(rs.getString("imgLogo"));
                list.add(jb);
            }
            return list;

        } catch (Exception s) {
            System.out.println(s);
        }

        return new ArrayList<>();  // Trả list rỗng 
    }
    
    

    public static void main(String[] args) {
        SearchAnDisplayJob o = new SearchAnDisplayJob();
        o.BuildTest("0", null, null, null, null,null).forEach(a -> System.out.println(a));
        //    o.getListJobPost() .forEach(a -> System.out.println(a));

    }
}
