/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Apply;

import DAO.CVDAO;
import Models.CV;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 *
 * @author PC
 */
public class DownloadCVZipServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DownloadCVZipServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DownloadCVZipServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] ids = request.getParameterValues("cvId");
        List<Integer> cvIds = new ArrayList<>();
        if (ids != null) {
            for (String id : ids) {
                try {
                    cvIds.add(Integer.parseInt(id));
                } catch (NumberFormatException ignored) {
                }
            }
        }

        if (cvIds.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Không có ID hợp lệ.");
            return;
        }

        response.setContentType("application/zip");
        response.setHeader("Content-Disposition", "attachment; filename=\"cv_bundle.zip\"");

        try (ZipOutputStream zos = new ZipOutputStream(response.getOutputStream())) {
            for (int cvId : cvIds) {
                CV cv = new CVDAO().getCVById(cvId);
                if (cv == null) {
                    continue;
                }

                // Tạo PDF dưới dạng byte[]
                ByteArrayOutputStream pdfOutput = generatePdf(cv, getServletContext());

                if (pdfOutput != null) {
                    ZipEntry entry = new ZipEntry("CV_" + cvId + ".pdf");
                    zos.putNextEntry(entry);
                    zos.write(pdfOutput.toByteArray());
                    zos.closeEntry();
                }
            }
        }
    }

    private ByteArrayOutputStream generatePdf(CV cv, ServletContext context) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        Document doc = new Document(PageSize.A4, 0, 0, 5, 5);

        try {

            PdfWriter.getInstance(doc, out);
            doc.open();

            String fontPath = context.getRealPath("/fonts/arial.ttf");
            BaseFont bf = BaseFont.createFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            Font whiteFont = new Font(bf, 11, Font.NORMAL, BaseColor.WHITE);
            Font whiteBold = new Font(bf, 12, Font.BOLD, BaseColor.WHITE);
            Font blackFont = new Font(bf, 11);
            Font blackBold = new Font(bf, 14, Font.BOLD);

            PdfPTable mainTable = new PdfPTable(new float[]{3f, 7f});
            mainTable.setWidthPercentage(100);

            // Cột trái
            PdfPCell leftCell = new PdfPCell();
            leftCell.setBackgroundColor(new BaseColor(52, 73, 85));
            leftCell.setPadding(20);
            leftCell.setBorder(Rectangle.NO_BORDER);
            leftCell.setMinimumHeight(doc.getPageSize().getHeight() - 40);

            if (cv.getFileData() != null && !cv.getFileData().trim().isEmpty()) {
                try {
                    String avatarPath = context.getRealPath("/img/" + cv.getFileData());
                    Image avatar = Image.getInstance(avatarPath);
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

            addInfo(leftCell, "THÔNG TIN CÁ NHÂN", whiteBold);
            addInfo(leftCell, "Ngày sinh", whiteBold, cv.getBirthday().toString(), whiteFont);
            addInfo(leftCell, "Giới tính", whiteBold, cv.getGender(), whiteFont);
            addInfo(leftCell, "Quốc tịch", whiteBold, cv.getNationality(), whiteFont);
            addInfo(leftCell, "Email", whiteBold, cv.getEmail(), whiteFont);
            addInfo(leftCell, "Địa chỉ", whiteBold, cv.getAddress(), whiteFont);

            // Cột phải
            PdfPCell rightCell = new PdfPCell();
            rightCell.setBackgroundColor(BaseColor.WHITE);
            rightCell.setPadding(30);
            rightCell.setBorder(Rectangle.NO_BORDER);

            Paragraph name = new Paragraph(cv.getFullName().toUpperCase(), new Font(bf, 24, Font.BOLD));
            name.setSpacingAfter(30);
            rightCell.addElement(name);

            addSection(rightCell, "MỤC TIÊU NGHỀ NGHIỆP", blackBold, cv.getPosition(), blackFont);
            addSection(rightCell, "KINH NGHIỆM LÀM VIỆC", blackBold, cv.getNumberExp() + " năm kinh nghiệm", blackFont);
            addSection(rightCell, "HỌC VẤN", blackBold, cv.getEducation(), blackFont);
            addSection(rightCell, "KỸ NĂNG", blackBold, cv.getField(), blackFont);
            addSection(rightCell, "MỨC LƯƠNG HIỆN TẠI", blackBold,
                    String.format("%,.0f VND", cv.getCurrentSalary()), blackFont);

            mainTable.addCell(leftCell);
            mainTable.addCell(rightCell);
            doc.add(mainTable);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            doc.close();
        }

        return out;
    }

    private void addInfo(PdfPCell cell, String label, Font labelFont) {
        Paragraph p = new Paragraph(label, labelFont);
        p.setSpacingAfter(10);
        cell.addElement(p);
    }

    private void addInfo(PdfPCell cell, String label, Font labelFont, String value, Font valueFont) {
        Paragraph l = new Paragraph(label, labelFont);
        l.setSpacingAfter(2);
        cell.addElement(l);

        Paragraph v = new Paragraph(value, valueFont);
        v.setSpacingAfter(8);
        cell.addElement(v);
    }

    private void addSection(PdfPCell cell, String title, Font titleFont, String content, Font contentFont) {
        cell.addElement(new Paragraph(title, titleFont));
        cell.addElement(new Paragraph(new Chunk(new com.itextpdf.text.pdf.draw.LineSeparator())));
        cell.addElement(new Paragraph(content, contentFont));
        cell.addElement(Chunk.NEWLINE);
    }




    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
