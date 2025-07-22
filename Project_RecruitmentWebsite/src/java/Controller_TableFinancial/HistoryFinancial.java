package Controller_TableFinancial;

import DAO.FinancialDAO;
import Models.FinancialMode;
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

@WebServlet(name = "HistoryFinancial", urlPatterns = {"/HistoryFinancial"})
public class HistoryFinancial extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HistoryFinancial</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HistoryFinancial at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            String dateStart = request.getParameter("dateStart");
            String dateEnd = request.getParameter("dateEnd");
            String idempoyer = request.getParameter("idemployer");

            int id = 0;
            if (idempoyer != null) {
                id = Integer.parseInt(idempoyer);
            }

            List<FinancialMode> list = new ArrayList();
            FinancialDAO financialDAO = new FinancialDAO();
            list = financialDAO.GetFinancialHistoty(dateStart, dateEnd, id);
            String CompanyName = list.get(0).companyName;
            request.setAttribute("CompanyName", CompanyName);
            session.setAttribute("ListHistory", list);

            request.getRequestDispatcher("TableReportFinancial/DetailFinancial.jsp").forward(request, response);
        } catch (Exception e) {

            request.getRequestDispatcher("TableReportFinancial/DetailFinancial.jsp").forward(request, response);
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
