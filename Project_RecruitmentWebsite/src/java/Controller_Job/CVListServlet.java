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

        // 1. Kiểm tra session
        if (username == null || !"Employer".equals(role)) {
            response.sendRedirect("log/login.jsp");
            return;
        }

        // 2. Lấy Employer từ username
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
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        int jobPostId;
        try {
            jobPostId = Integer.parseInt(jobPostIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID công việc không hợp lệ.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // 4. Lấy danh sách CV nếu jobPost thuộc employer
        List<CV> cvList = cvDAO.getSecureCVsByJobPost(jobPostId, employerId);

        request.setAttribute("cvList", cvList);
        request.setAttribute("jobPostId", jobPostId);

        RequestDispatcher dispatcher = request.getRequestDispatcher("cv_list.jsp");
        dispatcher.forward(request, response);
    }
}
