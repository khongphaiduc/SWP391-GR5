package DAO;
// pham trung duc

import Models.*;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class getListSaveJobPost extends DBContext {

    // lấy list job thằng user đẫ lưu (đã test)
    public List<JobPost> getListJobPostSaved(String IdUser) {
        List<JobPost> list = new ArrayList<>();
        try {

            String query = "SELECT s2.Title,s3.Company_Name,s2.Location,s2.Description,s1.date_cr,s2.JobPost_ID,s3.imgLogo,s1.JobPost_ID,s1.SavedJob_ID\n"
                    + "FROM [dbo].[SavedJob] s1\n"
                    + "join [dbo].[JobPost] s2 on s1.JobPost_ID=s2.JobPost_ID\n"
                    + "join [dbo].[Employer] s3 on s2.Employer_ID=s3.Employer_ID\n"
                    + "Where s1.Candidate_ID=?\n";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, IdUser);

            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                list.add(new JobPost(rs.getString("Title"),
                        rs.getString("Company_Name"),
                        rs.getString("Location"),
                        rs.getString("Description"),
                        rs.getDate("date_cr"),
                        rs.getInt("JobPost_ID"),
                        rs.getString("imgLogo"),
                        rs.getInt("SavedJob_ID")
                ));
            }
            return list;
        } catch (SQLException s) {
            System.out.println("Bug  SQL 1:" + s.getMessage());
        }
        return new ArrayList<>();
    }

    public static void main(String[] args) {
        getListSaveJobPost o = new getListSaveJobPost();
        o.getListJobPostSaved("3").forEach(a -> System.out.println(a));
    }
}
