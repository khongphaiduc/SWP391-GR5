package Controller_Admin_Response_FeedBackAndShupport;

import DAO.ReportDAO;
import Models.Report;
import MyService.ImageUtil;
import MyService.MyEmail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ViewDetail", urlPatterns = {"/ViewDetail"})
public class ViewDetail extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewDetail at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            ReportDAO reportDAO = new ReportDAO();

            String idReport = request.getParameter("idReport");

            System.out.println("ID reprot là : " + idReport);
            Report viewDetail = reportDAO.viewDetail(idReport);
            String pathImage = reportDAO.viewDetail(idReport).urlImage;
            String email = reportDAO.getEmailUerReport(viewDetail.id, viewDetail.role);
            if (viewDetail != null) {
                request.setAttribute("ViewDetailReprot", viewDetail);
                request.setAttribute("pathImage", pathImage);
                request.setAttribute("Email", email);
                request.setAttribute("idReport", idReport);
                request.setAttribute("StatusReport", viewDetail.status);
            }
           
            request.getRequestDispatcher("UI_Admin_Report/ResponseEmailToUser.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            request.getRequestDispatcher("UI_Admin_Report/ResponseEmailToUser.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            ReportDAO reportDAO = new ReportDAO();

            String idReport = request.getParameter("idReport");

            System.out.println("ID reprot là : " + idReport);
            Report viewDetail = reportDAO.viewDetail(idReport);
            String pathImage = reportDAO.viewDetail(idReport).urlImage;
            String email = reportDAO.getEmailUerReport(viewDetail.id, viewDetail.role);
            if (viewDetail != null) {
                request.setAttribute("ViewDetailReprot", viewDetail);
                request.setAttribute("pathImage", pathImage);
                request.setAttribute("Email", email);
                request.setAttribute("idReport", idReport);
            }

            String content = request.getParameter("content");
            String emails = request.getParameter("emailuser");
            MyEmail.sendEmail(emails, "Phản Hồi Báo Cao", content);
             request.setAttribute("successSend", true);
            request.getRequestDispatcher("UI_Admin_Report/ResponseEmailToUser.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
