/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Action_Menu;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import DAO.*;
import jakarta.servlet.annotation.MultipartConfig;

@WebServlet(name = "FeebBackAndSupport", urlPatterns = {"/FeebBackAndSupport"})
@MultipartConfig( //@MultipartConfig trong Java Servlet được sử dụng để cấu hình việc xử lý dữ liệu gửi lên từ form có enctype là multipart/form-data
        fileSizeThreshold = 1024 * 1024 * 1, // Nếu file upload lớn hơn ngưỡng này, nó sẽ được ghi tạm vào file trong ổ đĩa, còn nhỏ hơn thì giữ trong bộ nhớ (RAM).
        maxFileSize = 1024 * 1024 * 90, // Kích thước tối đa cho mỗi file được upload (tính bằng byte).
        maxRequestSize = 1024 * 1024 * 90 // Kích thước tối đa của toàn bộ request bao gồm nhiều file và các trường form khác.
)

public class FeebBackAndSupport extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SupportUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SupportUser at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("ViewActionMenu/FeedbackAndReport.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            boolean result = false;
            String statusReport = " ";
            HttpSession session = request.getSession();
            String idUser = (String) session.getAttribute("idUser");
            String idRole = (String) session.getAttribute("role");

            String content = request.getParameter("content");
            String titel = request.getParameter("titel");
            String idAdminSupport = "1";                 // gửi  tới 
            Part imageFIle = request.getPart("fileReport");
            String checktype = imageFIle.getContentType();

            if (checktype.startsWith("video/")) {
                request.setAttribute("statusReport", "Vui lòng chỉ gửi hình ảnh");
                 request.setAttribute("content", content);
                request.getRequestDispatcher("ViewActionMenu/FeedbackAndReport.jsp").forward(request, response);
                return;
            }

            if (imageFIle == null) {
                request.setAttribute("statusReport", "Ối Rồi Ôi Có Bug");
                request.getRequestDispatcher("ViewActionMenu/FeedbackAndReport.jsp").forward(request, response);
                return;
            }

            InputStream image = imageFIle.getInputStream();   // chuyển từ ảnh về chuối nhị phân
            long sizeImage = imageFIle.getSize();

            SupportUserDAO reportDAO = new SupportUserDAO();

            result = reportDAO.sendReportAndFeebBack(idUser, idRole, titel, content, image, sizeImage, idAdminSupport);

            System.out.println(result == true ? "Gửi thành công " : "Fail cmnr");
            statusReport = result == true ? "Người hỗ trợ của chúng tỗi sẽ liên hệ lại với bạn thông qua số điện thoại,xin quý khách để ý điện thoại  " : "Gửi Thất Bại";
            request.setAttribute("statusReport", statusReport);
            request.getRequestDispatcher("ViewActionMenu/FeedbackAndReport.jsp").forward(request, response);
        } catch (Exception e) {
            String statusReport = e.getMessage();
            request.setAttribute("statusReport", statusReport);
            System.out.println("Bug " + statusReport);
            request.getRequestDispatcher("ViewActionMenu/FeedbackAndReport.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
