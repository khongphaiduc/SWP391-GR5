package Controller_Admin_Response_FeedBackAndShupport;

import DAO.ReportDAO;
import MyService.ImageUtil;
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

            var viewDetail = reportDAO.viewDetail(idReport);

            String pathImage = ImageUtil.getImageUrl(viewDetail.urlImage, "D:/");

            request.setAttribute("pathImage", pathImage);
            request.setAttribute("ElementViewDetail", viewDetail);

            request.getRequestDispatcher("UI_Admin_Report/ResponseEmailToUser.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            request.getRequestDispatcher("UI_Admin_Report/ResponseEmailToUser.jsp").forward(request, response);
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
