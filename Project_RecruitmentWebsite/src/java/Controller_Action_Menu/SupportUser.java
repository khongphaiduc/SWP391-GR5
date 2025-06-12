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

@WebServlet(name = "SupportUser", urlPatterns = {"/SupportUser"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)

public class SupportUser extends HttpServlet {

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
        request.getRequestDispatcher("ViewActionMenu/SupportUser.jsp").forward(request, response);
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
            String titel = request.getParameter("title");
            String idAdminSupport = "1";
            Part imageFIle = request.getPart("fileReport");
            String checktype =imageFIle.getContentType();
            
            if(checktype.startsWith("/image")){
                
            }
            
            if(imageFIle==null){
                 request.setAttribute("statusReport", "Ối Rồi Ôi Có Bug");
                 request.getRequestDispatcher("ViewActionMenu/SupportUser.jsp").forward(request, response);
                 return ;
            }
            
            InputStream image = imageFIle.getInputStream();   // chuyển từ ảnh về chuối nhị phân
            long sizeImage = imageFIle.getSize();

            SupportUserDAO reportDAO = new SupportUserDAO();

            result = reportDAO.sendReport(idUser, idRole, titel, content, image, sizeImage, idAdminSupport);

            System.out.println(result == true ? "Gửi thành công " : "Fail cmnr");
            statusReport = result == true ? "Xin lỗi vì trải nghiệm không tốt chúng tôi sẽ liên hệ lại với bạn sớm nhất ^*^" : "Gửi Thất Bại";
            request.setAttribute("statusReport", statusReport);

            request.getRequestDispatcher("ViewActionMenu/SupportUser.jsp").forward(request, response);
        } catch (Exception e) {       
            String statusReport =e.getMessage();
            request.setAttribute("statusReport", statusReport);
            request.getRequestDispatcher("ViewActionMenu/SupportUser.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
