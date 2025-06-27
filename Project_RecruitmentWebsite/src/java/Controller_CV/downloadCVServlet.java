package Controller_CV;

import DAO.CVDAO;
import Models.CV;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.itextpdf.text.pdf.draw.LineSeparator;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.OutputStream;
import org.apache.tomcat.jakartaee.commons.compress.utils.IOUtils;

public class downloadCVServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int cvId = Integer.parseInt(request.getParameter("cvId"));
        CVDAO dao = new CVDAO();
        CV cv = dao.getCVById(cvId);

        if (cv == null) {
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=CV_" + cvId + ".pdf");

        Document doc = new Document(PageSize.A4, 0, 0, 20, 20);
        OutputStream out = response.getOutputStream();

        try {
            PdfWriter.getInstance(doc, out);
            doc.open();

            // Tạo font
            String fontPath = getServletContext().getRealPath("/fonts/arial.ttf");
            BaseFont bf = BaseFont.createFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            Font whiteFont = new Font(bf, 11, Font.NORMAL, BaseColor.WHITE);
            Font whiteBold = new Font(bf, 12, Font.BOLD, BaseColor.WHITE);
            Font blackFont = new Font(bf, 11);
            Font blackBold = new Font(bf, 14, Font.BOLD);

            // Bảng 2 cột (30% - 70%)
            PdfPTable mainTable = new PdfPTable(new float[]{3f, 7f});
            mainTable.setWidthPercentage(100);

            // === CỘT TRÁI - XANH ĐẬM ===
            PdfPCell leftCell = new PdfPCell();
            leftCell.setBackgroundColor(new BaseColor(52, 73, 85));
            leftCell.setPadding(20);
            leftCell.setBorder(Rectangle.NO_BORDER);
            leftCell.setMinimumHeight(doc.getPageSize().getHeight() - 40);

            // Ảnh đại diện
            String avatarPath = cv.getFileData();

            if (avatarPath != null && !avatarPath.trim().isEmpty()) {
                String realImagePath = getServletContext().getRealPath("/img/" + avatarPath);

                try {
                    Image avatar = Image.getInstance(realImagePath);
                    avatar.scaleToFit(120, 120);
                    avatar.setAlignment(Element.ALIGN_CENTER);

                    Paragraph imgPara = new Paragraph(new Chunk(avatar, 0, 0, true));
                    imgPara.setAlignment(Element.ALIGN_CENTER);
                    imgPara.setSpacingAfter(25);
                    leftCell.addElement(imgPara);
                } catch (Exception e) {
                    leftCell.addElement(new Paragraph("(Không thể hiển thị ảnh)", whiteFont));
                }
            }

            // Thông tin cá nhân
            leftCell.addElement(new Paragraph("THÔNG TIN CÁ NHÂN", whiteBold));
            leftCell.addElement(new Paragraph("Ngày sinh", whiteBold));
            leftCell.addElement(new Paragraph(cv.getBirthday().toString(), whiteFont));
            leftCell.addElement(new Paragraph("Giới tính", whiteBold));
            leftCell.addElement(new Paragraph(cv.getGender(), whiteFont));
            leftCell.addElement(new Paragraph("Quốc tịch", whiteBold));
            leftCell.addElement(new Paragraph(cv.getNationality(), whiteFont));
            leftCell.addElement(new Paragraph("Email", whiteBold));
            leftCell.addElement(new Paragraph(cv.getEmail(), whiteFont));
            leftCell.addElement(new Paragraph("Địa chỉ", whiteBold));
            leftCell.addElement(new Paragraph(cv.getAddress(), whiteFont));

            // === CỘT PHẢI - TRẮNG ===
            PdfPCell rightCell = new PdfPCell();
            rightCell.setBackgroundColor(BaseColor.WHITE);
            rightCell.setPadding(30);
            rightCell.setBorder(Rectangle.NO_BORDER);

            // Tên ứng viên
            Paragraph name = new Paragraph(cv.getFullName().toUpperCase(), new Font(bf, 24, Font.BOLD));
            name.setSpacingAfter(30);
            rightCell.addElement(name);

            // Mục tiêu nghề nghiệp
            rightCell.addElement(new Paragraph("MỤC TIÊU NGHỀ NGHIỆP", blackBold));
            LineSeparator line1 = new LineSeparator();
            rightCell.addElement(new Paragraph(new Chunk(line1)));
            rightCell.addElement(new Paragraph(cv.getPosition(), blackFont));
            rightCell.addElement(Chunk.NEWLINE);

            // Kinh nghiệm
            rightCell.addElement(new Paragraph("KINH NGHIỆM LÀM VIỆC", blackBold));
            LineSeparator line2 = new LineSeparator();
            rightCell.addElement(new Paragraph(new Chunk(line2)));
            rightCell.addElement(new Paragraph(cv.getNumberExp() + " năm kinh nghiệm", blackFont));
            rightCell.addElement(Chunk.NEWLINE);

            // Học vấn
            rightCell.addElement(new Paragraph("HỌC VẤN", blackBold));
            LineSeparator line3 = new LineSeparator();
            rightCell.addElement(new Paragraph(new Chunk(line3)));
            rightCell.addElement(new Paragraph(cv.getEducation(), blackFont));
            rightCell.addElement(Chunk.NEWLINE);

            // Kỹ năng
            rightCell.addElement(new Paragraph("KỸ NĂNG", blackBold));
            LineSeparator line4 = new LineSeparator();
            rightCell.addElement(new Paragraph(new Chunk(line4)));
            rightCell.addElement(new Paragraph(cv.getField(), blackFont));
            rightCell.addElement(Chunk.NEWLINE);

            // Mức lương
            rightCell.addElement(new Paragraph("MỨC LƯƠNG HIỆN TẠI", blackBold));
            LineSeparator line5 = new LineSeparator();
            rightCell.addElement(new Paragraph(new Chunk(line5)));
            rightCell.addElement(new Paragraph(String.format("%,.0f VND", cv.getCurrentSalary()), blackFont));

            mainTable.addCell(leftCell);
            mainTable.addCell(rightCell);
            doc.add(mainTable);

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
