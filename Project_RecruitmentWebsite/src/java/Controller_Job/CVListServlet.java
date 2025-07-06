package Controller_Job;

import DAO.CVDAO;
import DAO.EmployerDAO;
import Models.CV;
import Models.Employer;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CVListServlet", urlPatterns = {"/cv-list"})
public class CVListServlet extends HttpServlet {
    private CVDAO cvDAO;
    private EmployerDAO employerDAO;

    private static final int PAGE_SIZE = 10; // Gợi ý tăng size hợp lý hơn

    @Override
    public void init() throws ServletException {
        cvDAO = new CVDAO();
        employerDAO = new EmployerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        // 1. Kiểm tra đăng nhập
        if (username == null || !"Employer".equals(role)) {
            response.sendRedirect("log/login.jsp");
            return;
        }

        // 2. Lấy employer từ username
        Employer employer = employerDAO.getEmployerByName(username);
        if (employer == null) {
            response.sendRedirect("log/login.jsp");
            return;
        }

        int employerId = employer.getEmployerId();
        session.setAttribute("employerId", employerId);

        // 3. Lấy jobPostId từ request
        String jobPostIdStr = request.getParameter("jobPostId");
        if (jobPostIdStr == null) {
            request.setAttribute("error", "Thiếu tham số jobPostId.");
            forwardToCVListWithMessage(request, response, null, 0, 0, 0, "Không tìm thấy công việc yêu cầu.");
            return;
        }

        int jobPostId;
        try {
            jobPostId = Integer.parseInt(jobPostIdStr);
        } catch (NumberFormatException e) {
            forwardToCVListWithMessage(request, response, null, 0, 0, 0, "ID công việc không hợp lệ.");
            return;
        }

        // 4. Phân trang
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage <= 0) currentPage = 1;
            } catch (NumberFormatException ignored) {
            }
        }
        int offset = (currentPage - 1) * PAGE_SIZE;

        // 5. Kiểm tra quyền truy cập jobPost
        if (!cvDAO.isJobPostOwnedByEmployer(jobPostId, employerId)) {
            forwardToCVListWithMessage(request, response, null, 0, 0, 0, "Bạn không có quyền truy cập vào công việc này.");
            return;
        }

        // 6. Lấy danh sách CV
        List<CV> cvList = cvDAO.getCVsByJobPostId(jobPostId, PAGE_SIZE, offset);

        // 7. Đếm tổng số CV và tính phân trang
        int totalCVs = cvDAO.countCVsByJobPostId(jobPostId);
        int totalPages = (int) Math.ceil((double) totalCVs / PAGE_SIZE);

        // 8. Nếu không có CV nào, hiển thị thông báo nhẹ nhàng
        if (cvList.isEmpty()) {
            forwardToCVListWithMessage(request, response, cvList, jobPostId, currentPage, totalPages, "Chưa có ứng viên nào ứng tuyển cho công việc này.");
            return;
        }

        // 9. Nếu có CV, hiển thị bình thường
        request.setAttribute("cvList", cvList);
        request.setAttribute("jobPostId", jobPostId);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCVs", totalCVs);
        request.getRequestDispatcher("cv_list.jsp").forward(request, response);
    }

    private void forwardToCVListWithMessage(HttpServletRequest request, HttpServletResponse response,
                                            List<CV> cvList, int jobPostId, int currentPage, int totalPages,
                                            String message) throws ServletException, IOException {
        request.setAttribute("cvList", cvList);
        request.setAttribute("jobPostId", jobPostId);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("message", message); // gán thông báo
        request.getRequestDispatcher("cv_list.jsp").forward(request, response);
    }
}
