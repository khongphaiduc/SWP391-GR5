package Controller_Job;

import DAO.CVDAO;
import DAO.EmployerDAO;
import Models.CV;
import Models.Employer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
//nâng cao: Tự động ẩn pagination nếu chỉ có 1 trang
//Thêm nút “Trang đầu” / “Trang cuối”
@WebServlet(name = "SearchCVsServlet", urlPatterns = {"/SearchCVsServlet"})
public class SearchCVsServlet extends HttpServlet {

    private static final int PAGE_SIZE = 2;

    private String normalize(String input) {
        if (input == null) return null;
        input = input.trim();
        return input.replaceAll("\\s+", " ");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"Employer".equals(role)) {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);
            return;
        }

        try {
            EmployerDAO edao = new EmployerDAO();
            Employer employer = edao.getEmployerByName(username);
            if (employer == null) {
                request.setAttribute("error", "Không tìm thấy thông tin nhà tuyển dụng.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            int employerId = employer.getEmployerId();
            session.setAttribute("employerId", employerId);

            String keyword = normalize(request.getParameter("keyword"));
            String address = normalize(request.getParameter("address"));
            String numberExpStr = request.getParameter("numberExp");
            String position = normalize(request.getParameter("position"));
            String field = normalize(request.getParameter("field"));

            Integer numberExp = null;
            if (numberExpStr != null && !numberExpStr.trim().isEmpty()) {
                try {
                    numberExp = Integer.parseInt(numberExpStr.trim());
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Số năm kinh nghiệm không hợp lệ.");
                    request.getRequestDispatcher("/error.jsp").forward(request, response);
                    return;
                }
            }

            // Phân trang
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage <= 0) currentPage = 1;
                } catch (NumberFormatException ignored) {}
            }
            int offset = (currentPage - 1) * PAGE_SIZE;

            // Gọi DAO
            CVDAO cvDao = new CVDAO();
            List<CV> appliedCVs = cvDao.searchCVsForEmployer(
                    employerId, address, numberExp, position, keyword, field, PAGE_SIZE, offset);

            int totalResults = cvDao.countSearchCVsForEmployer(
                    employerId, address, numberExp, position, keyword, field);
            int totalPages = (int) Math.ceil((double) totalResults / PAGE_SIZE);

            // Log
            System.out.println("🔍 Tìm kiếm CV - Trang " + currentPage + "/" + totalPages);
            System.out.println("  Tổng CV: " + totalResults + ", PageSize: " + PAGE_SIZE + ", Offset: " + offset);

            request.setAttribute("appliedCVs", appliedCVs);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            // Preserve filter
            request.setAttribute("keyword", keyword);
            request.setAttribute("address", address);
            request.setAttribute("numberExp", numberExp);
            request.setAttribute("position", position);
            request.setAttribute("field", field);

            if (appliedCVs.isEmpty()) {
                request.setAttribute("message", "Không tìm thấy CV phù hợp với tiêu chí tìm kiếm.");
            }

            request.getRequestDispatcher("/applied-cv-list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi tìm kiếm CV.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

