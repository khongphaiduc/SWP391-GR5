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
                    + "  FROM [dbo].[JobPost]";

            PreparedStatement push = connection.prepareStatement(query);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                list.add(new JobPost(rs.getString("JobPost_ID"), rs.getString("Title"), rs.getString("Description"), rs.getString("Category"), rs.getString("Location"), rs.getDouble("Offer_Min"), rs.getDouble("Offer_Max"), rs.getString("Number_exp"), rs.getString("Visible"), rs.getString("TypeJob"), rs.getString("DayCreate")));
            }

            return list;

        } catch (Exception s) {
            System.out.println(s);
        }

        return null;
    }

    public static void main(String[] args) {
        SearchAnDisplayJob o = new SearchAnDisplayJob();
        
        if (o.getListJobPost() != null) {
            o.getListJobPost().forEach(s -> System.out.println(s));
        }

    }
}
