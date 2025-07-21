/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_TableFinancial;

import Models.FinancialMode;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.OutputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet(name = "ExportExcelHistory", urlPatterns = {"/ExportExcelHistory"})
public class ExportExcelHistory extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ExportExcelHistory</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExportExcelHistory at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<FinancialMode> list = (List<FinancialMode>) session.getAttribute("ListHistory");

        if (list == null || list.isEmpty()) {
            response.sendError(404, "Không có dữ liệu báo cáo để xuất Excel.");
            return;
        }

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Lịch sử giao dich");

            // Tạo style định dạng số
            CellStyle numberStyle = workbook.createCellStyle();
            DataFormat format = workbook.createDataFormat();
            numberStyle.setDataFormat(format.getFormat("#,##0.00")); // Hiển thị dạng 1,234,567.89

            // Header
            Row headerRow = sheet.createRow(0);
            String[] headers = {"Tên Dịch Vụ", "Giá Tiền", "Phương Thức Thanh Toán", "Ngày Mua"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
            }

            // Data
            int rowIdx = 1;
            for (FinancialMode fm : list) {
                Row row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(fm.nameService);
                row.createCell(1).setCellValue(fm.getAmount());
                row.createCell(2).setCellValue(fm.getPayMethod());
                row.createCell(3).setCellValue(fm.getDate());            
            }

            // Total
            double total = list.stream().mapToDouble(FinancialMode::getAmount).sum();
            Row totalRow = sheet.createRow(rowIdx);
            totalRow.createCell(1).setCellValue("Tổng cộng:");
            Cell totalCell = totalRow.createCell(2);
            totalCell.setCellValue(total);
            totalCell.setCellStyle(numberStyle);

            // Tự động co giãn cột
            sheet.autoSizeColumn(0);
            sheet.autoSizeColumn(1);
            sheet.autoSizeColumn(2);

            // Xuất file
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
            String formattedTime = now.format(formatter);
            String filename = "attachment; filename=ReportHistory_" + formattedTime + ".xlsx";

            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", filename);
            OutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
        } catch (Exception e) {
            response.sendError(500, "Lỗi xuất Excel: " + e.getMessage());
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
