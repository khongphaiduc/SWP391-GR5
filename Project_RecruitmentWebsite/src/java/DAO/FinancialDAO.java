package DAO;

import dal.DBContext;
import Models.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
                    + "WHERE s1.Status = 'done' AND (? IS NULL OR s1.Date > ?)\n"
                    + "AND (? IS NULL OR s1.Date < ?) \n"
                    + "AND (? IS NULL OR s2.TaxCode LIKE ?)\n"
                    + "GROUP BY s2.Employer_ID  ,s2.Company_Name ";

            PreparedStatement push = connection.prepareStatement(query);

            // Gán giá trị cho các tham số
            push.setString(1, dateStart);
            push.setString(2, dateStart);

            push.setString(3, dateEnd);
            push.setString(4, dateEnd);

            push.setString(5, codeTax);
            push.setString(6, codeTax != null ? "%" + codeTax + "%" : null);

            ResultSet rs = push.executeQuery();
            int i = 0;
            while (rs.next()) {
                list.add(new FinancialMode(++i, rs.getString("Company_Name"), rs.getDouble("Total"), rs.getInt("Employer_ID"), rs.getInt("Number")));
            }

        } catch (Exception e) {
            System.out.println("Bug Financial: " + e.getMessage());
        }
        return list;
    }

    // lấy lịch sử mua hàng 
    public List<FinancialMode> GetFinancialHistoty(String dateStart, String dateEnd, int idemployer) {
        List<FinancialMode> list = new ArrayList<>();

        try {
            String query = "select s2.Service_Name , s1.Amount,s1.PayMethod,s1.Date,s3.Company_Name,s1.Duration\n"
                    + "  from [dbo].[Orders] s1 \n"
                    + "  join [dbo].[Service] s2 on s1.Service_ID=s2.Service_ID\n"
                    + "  join [dbo].[Employer] s3 on s1.Employer_ID=s3.Employer_ID\n"
                    + "  where s1.Status = 'done' \n"
                    + "  and s1.Date>=? \n"
                    + "  and s1.Date<=?\n"
                    + "  and s1.Employer_ID =?";

            PreparedStatement push = connection.prepareStatement(query);

            push.setString(1, dateStart);
            push.setString(2, dateEnd);
            push.setInt(3, idemployer);
            ResultSet rs = push.executeQuery();
            DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SS");
            DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            while (rs.next()) {
                String fullDateTime = rs.getString("Date"); // ví dụ: "2025-07-14 16:50:37.03"

                // Chuyển sang LocalDateTime
                LocalDateTime ldt = LocalDateTime.parse(fullDateTime, inputFormatter);

                // Format lại ngày thành dd/MM/yyyy
                String formattedDate = ldt.format(outputFormatter);

                // Lấy ngày bắt đầu (LocalDate) để cộng thêm duration
                LocalDate startDate = ldt.toLocalDate();
                int duration = rs.getInt("Duration");
                LocalDate endDate = startDate.plusDays(duration);

                list.add(new FinancialMode(
                        rs.getString("Service_Name"),
                        rs.getDouble("Amount"),
                        rs.getString("PayMethod"),
                        formattedDate, // 👈 ngày đã format (String "dd/MM/yyyy")
                        rs.getString("Company_Name"),
                        endDate.format(outputFormatter) // 👈 format ngày kết thúc
                ));
            }

        } catch (Exception e) {
            System.out.println("Bug Financial: " + e.getMessage());
        }
        return list;
    }

    public static void main(String[] args) {
        FinancialDAO s = new FinancialDAO();

        //s.GetFinancial("2025/01/01", "2025/11/07", "TAX00001").forEach(k -> System.out.println(k.toString()));
        s.GetFinancialHistoty("2025/01/01", "2025/10/19", 1).forEach(k -> System.out.println(k.toString()));
    }

}
