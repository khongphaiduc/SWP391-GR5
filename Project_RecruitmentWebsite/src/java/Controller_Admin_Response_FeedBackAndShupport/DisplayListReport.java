package Controller_Admin_Response_FeedBackAndShupport;

import DAO.ReportDAO;
import Models.Report;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "DisplayListReport", urlPatterns = {"/DisplayListReport"})
public class DisplayListReport extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DisplayListReport</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DisplayListReport at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            ReportDAO reportDAO = new ReportDAO();

            String date = request.getParameter("date");
            String phone = request.getParameter("phone");
            String status = request.getParameter("status");

            if (status != null && status.equals("all")) {
                status = null;
            }

            System.out.println(date);
            System.out.println(phone);
            System.out.println(status);

            var list = reportDAO.search(date, phone, status);

            int totalJobs = list.size();
            String pageStr = request.getParameter("page");
            int currentpage = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
            int numberJobOfPage = 7;

            int totalPages = (int) Math.ceil((double) totalJobs / numberJobOfPage);

            int start = (currentpage - 1) * numberJobOfPage;
            int end = Math.min(start + numberJobOfPage, totalJobs);

            List<Report> ListReport;
            if (start >= totalJobs) {
                ListReport = new ArrayList<>();
            } else {
                ListReport = list.subList(start, end);
            }

            // Sửa ở đây: truyền đúng biến cho JSP
            request.setAttribute("listReport", ListReport);
            request.setAttribute("currentPage", currentpage);
            request.setAttribute("totalPages", totalPages);
            session.setAttribute("date", date);
            session.setAttribute("phone", phone);
            session.setAttribute("status", status);

            System.out.println("List" + list.size());
            request.getRequestDispatcher("UI_Admin_Report/ViewListTicket.jsp").forward(request, response);

        } catch (Exception e) {
            request.getRequestDispatcher("UI_Admin_Report/ViewListTicket.jsp").forward(request, response);
            System.out.println("Bug tại servlet DisplayListReport :" + e.getMessage());
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
    }
}