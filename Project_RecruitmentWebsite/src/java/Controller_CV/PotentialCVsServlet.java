package Controller_CV;

import DAO.PotentialDAO;
import Models.CV;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/potential-cvs")
public class PotentialCVsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int employerId = 1; // Tạm thời cố định để test
        int page = 1;
        int pageSize = 10;

        // Xử lý phân trang nếu cần
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        PotentialDAO dao = new PotentialDAO();
        List<CV> potentialCVs = dao.getPotentialCVsByEmployerId(employerId, page, pageSize);
        int totalCVs = dao.getTotalPotentialCVs(employerId);
        int totalPages = (int) Math.ceil((double) totalCVs / pageSize);

        request.setAttribute("potentialCVs", potentialCVs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/potential-cvs.jsp").forward(request, response);
    }
}