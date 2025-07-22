package DAO;

import dal.DBContext;
import Models.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FinancialDAO extends DBContext {

    // lấy list của thằng cần lấy 
    public List<FinancialMode> GetFinancial(String dateStart, String dateEnd, String codeTax) {
        List<FinancialMode> list = new ArrayList<>();
        try {
            String query = "SELECT s2.Company_Name, SUM(s1.Amount) AS Total, s2.Employer_ID\n"
                    + "FROM [dbo].[Orders] s1\n"
                    + "JOIN [dbo].[Employer] s2 ON s1.Employer_ID = s2.Employer_ID\n"
                    + "WHERE (? IS NULL OR s1.Date >= ?)\n"
                    + "AND (? IS NULL OR s1.Date <= DATEADD(day, 1, ?))\n"
                    + "AND (? IS NULL OR s2.TaxCode LIKE ?)\n"
                    + "GROUP BY s2.Employer_ID, s2.Company_Name";
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, dateStart);
            push.setString(2, dateStart);
            push.setString(3, dateEnd);
            push.setString(4, dateEnd);
            push.setString(5, codeTax);
            push.setString(6, codeTax != null ? "%" + codeTax + "%" : "%");
            ResultSet rs = push.executeQuery();
            int i = 0;
            while (rs.next()) {
                list.add(new FinancialMode(++i, rs.getString("Company_Name"), rs.getDouble("Total"), rs.getInt("Employer_ID")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // lấy lịch sử mua hàng 
    public List<FinancialMode> GetFinancialHistoty(String dateStart, String dateEnd, int idemployer) {
        List<FinancialMode> list = new ArrayList<>();
        try {
            String query = "SELECT s2.Service_Name, s1.Amount, s1.PayMethod, s1.Date, s3.Company_Name\n"
                    + "FROM [dbo].[Orders] s1\n"
                    + "JOIN [dbo].[Service] s2 ON s1.Service_ID = s2.Service_ID\n"
                    + "JOIN [dbo].[Employer] s3 ON s1.Employer_ID = s3.Employer_ID\n"
                    + "WHERE \n"
                    + " (? IS NULL OR s1.Date >= ?)\n"
                    + "AND (? IS NULL OR s1.Date <= DATEADD(day, 1, ?))\n"
                    + "AND s1.Employer_ID = ?";
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, dateStart);
            push.setString(2, dateStart);
            push.setString(3, dateEnd);
            push.setString(4, dateEnd);
            push.setInt(5, idemployer);
            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                list.add(new FinancialMode(rs.getString("Service_Name"),
                        rs.getDouble("Amount"),
                        rs.getString("PayMethod"),
                        rs.getString("Date"),
                        rs.getString("Company_Name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        FinancialDAO s = new FinancialDAO();

//        s.GetFinancial("2025/01/01", "2025/11/07", "TAX00002").forEach(k -> System.out.println(k.toString()));
        s.GetFinancialHistoty("2025/01/01", "2025/10/19", 1).forEach(k -> System.out.println(k.toString()));
    }

}
