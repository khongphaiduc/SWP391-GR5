
package Controller_Admin_Response_FeedBackAndShupport;

import DAO.ReportDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "setStatus", urlPatterns = {"/setStatus"})
public class setStatus extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet setStatus</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet setStatus at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idReport = request.getParameter("idReport");
            String newStatus = request.getParameter("newStatus");

            ReportDAO resportDAO = new ReportDAO();

            boolean result = resportDAO.setNewStatusReport(newStatus, idReport);

            if (result) {
                response.setStatus(200);
            } else {
                response.setStatus(500);
            }

        } catch (Exception e) {
            System.out.println("Bug tại servlet setStatus :"+e.getMessage());
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
