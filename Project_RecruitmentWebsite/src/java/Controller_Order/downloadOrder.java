package Controller_Order;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import DAO.OrderDAO;
import Models.Order;
import Models.Employer;
import Models.Service;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

public class downloadOrder extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        OrderDAO dao = new OrderDAO();
        Order order = dao.getOrderById(orderId);

        if (order == null) {
            response.getWriter().write("Không tìm thấy đơn hàng");
            return;
        }

        Employer emp = order.getEmployer();
        Service service = order.getService();

        // Tính ngày hết hạn nếu chưa có
        if (order.getExpiredDate() == null && order.getDuration() > 0) {
            long millis = order.getDate().getTime() + order.getDuration() * 24L * 60 * 60 * 1000;
            order.setExpiredDate(new java.sql.Timestamp(millis));
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=Invoice_" + orderId + ".pdf");

        Document doc = new Document(PageSize.A4, 36, 36, 36, 36);
        OutputStream out = response.getOutputStream();

        try {
            PdfWriter.getInstance(doc, out);
            doc.open();

            String fontPath = getServletContext().getRealPath("/fonts/arial.ttf");
            BaseFont bf = BaseFont.createFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            Font titleFont = new Font(bf, 16, Font.BOLD);
            Font labelFont = new Font(bf, 12, Font.BOLD);
            Font textFont = new Font(bf, 12);

            // Thông tin cửa hàng
            doc.add(new Paragraph("Genz Tìm Việc", labelFont));
            doc.add(new Paragraph("Địa chỉ: Đại học FPT, Hòa Lạc", labelFont));
            doc.add(new Paragraph("SĐT: 0909 999 999", labelFont));
            doc.add(Chunk.NEWLINE);
            // Tiêu đề
            Paragraph title = new Paragraph("HÓA ĐƠN BÁN DỊCH VỤ", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(15);
            doc.add(title);


            // Thông tin khách hàng
            doc.add(new Paragraph("Tên khách hàng: " + emp.getNameEmployer(), textFont));
            doc.add(new Paragraph("Công ty: " + emp.getCompanyName(), textFont));
            doc.add(new Paragraph("Email: " + emp.getEmail(), textFont));
            doc.add(new Paragraph("SĐT: " + emp.getPhoneNumber(), textFont));
            doc.add(new Paragraph("Địa chỉ: " + emp.getLocation(), textFont));
            doc.add(Chunk.NEWLINE);

            // Bảng dịch vụ
            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            table.setWidths(new float[]{1f, 4f, 2f, 3f, 3f});

            String[] headers = {"STT", "TÊN DỊCH VỤ", "THỜI HẠN", "ĐƠN GIÁ", "THÀNH TIỀN"};
            for (String h : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(h, labelFont));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);
            }

            // Dòng dữ liệu
            table.addCell("1");
            table.addCell(new Phrase(service.getServiceName(), textFont));
            table.addCell(service.getDuration() + " ngày");
            table.addCell(String.format("%,.0f VND", service.getPrice()));
            table.addCell(String.format("%,.0f VND", service.getPrice()));
            doc.add(table);

            // Tổng tiền
            doc.add(Chunk.NEWLINE);

            Paragraph total = new Paragraph("Tổng cộng: " + String.format("%,.0f VND", order.getAmount()), labelFont);
            total.setAlignment(Element.ALIGN_RIGHT);
            doc.add(total);

            Paragraph method = new Paragraph("Phương thức thanh toán: " + order.getPayMethod(), textFont);
            method.setAlignment(Element.ALIGN_RIGHT);
            doc.add(method);

            Paragraph status = new Paragraph("Trạng thái: " + order.getStatus(), textFont);
            status.setAlignment(Element.ALIGN_RIGHT);
            doc.add(status);

            Paragraph regDate = new Paragraph("Ngày đăng ký: " + new SimpleDateFormat("dd/MM/yyyy").format(order.getDate()), textFont);
            regDate.setAlignment(Element.ALIGN_RIGHT);
            doc.add(regDate);

            Paragraph expDate = new Paragraph("Hết hạn: " + new SimpleDateFormat("dd/MM/yyyy").format(order.getExpiredDate()), textFont);
            expDate.setAlignment(Element.ALIGN_RIGHT);
            doc.add(expDate);

            doc.add(Chunk.NEWLINE);

            // Ký tên
            PdfPTable sign = new PdfPTable(2);
            sign.setWidthPercentage(100);
            sign.setSpacingBefore(20);
            sign.addCell(new Phrase("KHÁCH HÀNG", labelFont));
            sign.addCell(new Phrase("NGƯỜI BÁN HÀNG", labelFont));
            doc.add(sign);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            doc.close();
            out.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
