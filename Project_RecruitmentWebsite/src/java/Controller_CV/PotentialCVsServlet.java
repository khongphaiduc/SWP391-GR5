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

    private static final int PAGE_SIZE = 10;

    private String normalize(String input) {
        return (input == null) ? null : input.trim().replaceAll("\\s+", " ");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"Employer".equals(role)) {
            response.sendRedirect("log/login.jsp");
            return;
        }

        try {
            EmployerDAO employerDAO = new EmployerDAO();
            Employer employer = employerDAO.getEmployerByName(username);
            if (employer == null) {
                request.setAttribute("error", "Không tìm thấy thông tin nhà tuyển dụng.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            int employerId = employer.getEmployerId();
            session.setAttribute("employerId", employerId);

            // Lấy JobPostID từ query string
//            String jobPostIdParam = request.getParameter("jobPostId");
//            int jobPostId = 0;
//            if (jobPostIdParam != null && jobPostIdParam.matches("\\d+")) {
//                jobPostId = Integer.parseInt(jobPostIdParam);
//            } else {
//                request.setAttribute("error", "Thiếu hoặc sai JobPost ID.");
//                request.getRequestDispatcher("/error.jsp").forward(request, response);
//                return;
//            }

            // Phân trang
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && pageParam.matches("\\d+")) {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
            }
            int offset = (currentPage - 1) * PAGE_SIZE;

            // Lọc
            String keyword = normalize(request.getParameter("keyword"));
            String address = normalize(request.getParameter("address"));
            String position = normalize(request.getParameter("position"));
            String field = normalize(request.getParameter("field"));
            String expStr = request.getParameter("numberExp");
            Integer numberExp = null;
            if (expStr != null && !expStr.trim().isEmpty()) {
                try {
                    numberExp = Integer.parseInt(expStr.trim());
                } catch (NumberFormatException ignored) {
                }
            }

            PotentialDAO dao = new PotentialDAO();
            List<CV> potentialCVs;
            int totalCVs;

            boolean hasFilter =
                    (keyword != null && !keyword.trim().isEmpty())
                            || (address != null && !address.trim().isEmpty())
                            || (position != null && !position.trim().isEmpty())
                            || (field != null && !field.trim().isEmpty())
                            || (numberExp != null);

            if (hasFilter) {
                // Tìm kiếm có điều kiện
                potentialCVs = dao.searchPotentialCVsForEmployer(
                        employerId, address, numberExp, position, keyword, field, PAGE_SIZE, offset
                );
                totalCVs = dao.countSearchPotentialCVsForEmployer(
                        employerId, address, numberExp, position, keyword, field
                );
            } else {
                // Không có điều kiện lọc
                potentialCVs = dao.getPotentialCVsByEmployerId(employerId, currentPage, PAGE_SIZE);
                totalCVs = dao.getTotalPotentialCVs(employerId);
            }

            int totalPages = (int) Math.ceil((double) totalCVs / PAGE_SIZE);

            // Gửi dữ liệu cho JSP
            request.setAttribute("potentialCVs", potentialCVs);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            //request.setAttribute("jobPostId", jobPostId);

            // Preserve filter
            request.setAttribute("keyword", keyword);
            request.setAttribute("address", address);
            request.setAttribute("position", position);
            request.setAttribute("field", field);
            request.setAttribute("numberExp", numberExp);

            request.getRequestDispatcher("/potential-cvs.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xảy ra khi xử lý dữ liệu CV.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}

