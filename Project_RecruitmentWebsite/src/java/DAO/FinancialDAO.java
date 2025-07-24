package DAO;

import dal.DBContext;
import Models.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

public class FinancialDAO extends DBContext {

    // lấy list của thằng cần lấy 
    public List<FinancialMode> GetFinancial(String dateStart, String dateEnd, String codeTax) {
        List<FinancialMode> list = new ArrayList<>();
        try {

            String query = "SELECT s2.Company_Name, SUM(s1.Amount) AS Total , s2.Employer_ID, count(s1.Service_ID) as Number\n"
                    + "FROM [dbo].[Orders] s1\n"
                    + "JOIN [dbo].[Employer] s2 ON s1.Employer_ID = s2.Employer_ID\n"
                    + "WHERE  (? IS NULL OR s1.Date >= ?)\n"
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
                list.add(new FinancialMode(++i, rs.getString("Company_Name"), rs.getDouble("Total"), rs.getInt("Employer_ID"), rs.getInt("Number")));
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
            String query = "SELECT s2.Service_Name, s1.Amount, s1.PayMethod, s1.Date, s3.Company_Name, s1.Duration\n"
                    + "FROM [dbo].[Orders] s1\n"
                    + "JOIN [dbo].[Service] s2 ON s1.Service_ID = s2.Service_ID\n"
                    + "JOIN [dbo].[Employer] s3 ON s1.Employer_ID = s3.Employer_ID\n"
                    + "WHERE (? IS NULL OR s1.Date >= ?)\n"
                    + "AND (? IS NULL OR s1.Date <= DATEADD(day, 1, ?))\n"
                    + "AND s1.Employer_ID = ?";
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, dateStart);
            push.setString(2, dateStart);
            push.setString(3, dateEnd);
            push.setString(4, dateEnd);
            push.setInt(5, idemployer);
            ResultSet rs = push.executeQuery();
            DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
            DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            while (rs.next()) {
                String fullDateTime = rs.getString("Date"); // ví dụ: "2025-07-22 12:59:05.300"
                System.out.println("Raw Date: " + fullDateTime); // Log để kiểm tra
                try {
                    LocalDateTime ldt = LocalDateTime.parse(fullDateTime, inputFormatter);
                    String formattedDate = ldt.format(outputFormatter);
                    LocalDate startDate = ldt.toLocalDate();
                    int duration = rs.getInt("Duration");
                    LocalDate endDate = startDate.plusDays(duration);
                    list.add(new FinancialMode(
                            rs.getString("Service_Name"),
                            rs.getDouble("Amount"),
                            rs.getString("PayMethod"),
                            formattedDate,
                            rs.getString("Company_Name"),
                            endDate.format(outputFormatter)
                    ));
                } catch (DateTimeParseException e) {
                    System.err.println("Lỗi định dạng ngày: " + fullDateTime + ", lỗi: " + e.getMessage());
                    continue; // Bỏ qua bản ghi có ngày không hợp lệ
                }
            }
            System.out.println("Số lượng bản ghi: " + list.size());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        FinancialDAO s = new FinancialDAO();

        //s.GetFinancial("2025/01/01", "2025/11/07", "TAX00001").forEach(k -> System.out.println(k.toString()));
        s.GetFinancialHistoty("2025/01/01", "2025/10/19", 1).forEach(k -> System.out.println(k.toString()));
    }

}
