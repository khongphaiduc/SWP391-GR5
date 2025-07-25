package Controller_Job;

import DAO.CVDAO;
import DAO.EmployerDAO;
import Models.CV;
import Models.Employer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/view-applied-cvs")
public class ViewAppliedCVsServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10; // Số CV mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        // Kiểm tra quyền
        if (username == null || !"Employer".equals(role)) {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);
            return;
        }

        // Lấy employerId từ DB
        EmployerDAO edao = new EmployerDAO();
        Employer employer = edao.getEmployerByName(username);
        int employerId = employer.getEmployerId();
        //int employerId = 1;
        session.setAttribute("employerId", employerId);

        // Xử lý phân trang
        int page;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            if (page <= 0) {
                page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        int offset = (page - 1) * PAGE_SIZE;

        int jobPostId = 0;
        if (session.getAttribute("jpId") == null) {
            if (request.getParameter("jobPostId") != null) {
                jobPostId = Integer.parseInt(request.getParameter("jobPostId"));
                session.setAttribute("jpId", jobPostId);
            }
        }else{
            jobPostId=(int)session.getAttribute("jpId");
        }

        // Lấy danh sách CV phân trang
        CVDAO cvdao = new CVDAO();
        List<CV> appliedCVs = cvdao.getCVsByJobPostId(jobPostId, PAGE_SIZE, offset);

        // (Tuỳ chọn) Tổng số bản ghi để tính số trang
        int totalCVs = cvdao.countAppliedCVsByEmployer(employerId);
        int totalPages = (int) Math.ceil((double) totalCVs / PAGE_SIZE);

        // Gửi dữ liệu đến JSP
        request.setAttribute("appliedCVs", appliedCVs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("applied-cv-list.jsp").forward(request, response);
    }
}
