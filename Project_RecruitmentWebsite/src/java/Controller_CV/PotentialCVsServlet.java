package Controller_CV;

import DAO.PotentialDAO;
import DAO.EmployerDAO;
import Models.CV;
import Models.Employer;
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

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        // Kiểm tra đăng nhập và quyền truy cập
        if (username == null || !"Employer".equals(role)) {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);
            return;
        }

        try {
            // Lấy Employer từ DB
            EmployerDAO edao = new EmployerDAO();
            Employer employer = edao.getEmployerByName(username);
            if (employer == null) {
                request.setAttribute("error", "Không tìm thấy thông tin nhà tuyển dụng.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            int employerId = employer.getEmployerId();
            session.setAttribute("employerId", employerId);

            // Phân trang
            int page = 1;
            int pageSize = 10;

            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            // Lấy danh sách CV tiềm năng
            PotentialDAO dao = new PotentialDAO();
            List<CV> potentialCVs = dao.getPotentialCVsByEmployerId(employerId, page, pageSize);
            int totalCVs = dao.getTotalPotentialCVs(employerId);
            int totalPages = (int) Math.ceil((double) totalCVs / pageSize);

            // Gửi dữ liệu sang JSP
            request.setAttribute("potentialCVs", potentialCVs);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/potential-cvs.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi tải danh sách CV tiềm năng.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
