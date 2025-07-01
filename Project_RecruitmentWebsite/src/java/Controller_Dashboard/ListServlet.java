package Controller_Dashboard;

import DAO.CandidateDAO;
import DAO.EmployerDAO;
import DAO.ServiceDAO;
import Models.Candidate;
import Models.Employer;
import Models.Service;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ListServlet", urlPatterns = {"/list"})
public class ListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EmployerDAO employerDAO = new EmployerDAO();
        CandidateDAO candidateDAO = new CandidateDAO();
        ServiceDAO serviceDAO = new ServiceDAO(); // ✅ Thêm DAO cho dịch vụ

        int totalCan = candidateDAO.countCandidates();
        int totalEmp = employerDAO.countEmployers();
        int totalUser = totalCan + totalEmp;
        int page = 1;
        int recordsPerPage = 10;

        String type = request.getParameter("type"); // employer | candidate
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int offset = (page - 1) * recordsPerPage;
        List<Employer> employers = new ArrayList<>();
        List<Candidate> candidates = new ArrayList<>();
        int totalRecords = 0;

        if ("employer".equals(type)) {
            employers = employerDAO.getEmployersByPage(offset, recordsPerPage);
            totalRecords = totalEmp;
            request.setAttribute("employers", employers);
        } else if ("candidate".equals(type)) {
            candidates = candidateDAO.getCandidatesByPage(offset, recordsPerPage);
            totalRecords = totalCan;
            request.setAttribute("candidates", candidates);
        }

        // ✅ Lấy danh sách tất cả dịch vụ
        List<Service> serviceList = serviceDAO.getAllService();
        request.setAttribute("serviceList", serviceList); // ✅ Gán vào request

        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        request.setAttribute("totalCan", totalCan);
        request.setAttribute("totalEmp", totalEmp);
        request.setAttribute("totalUsers", totalUser);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("type", type);

        request.getRequestDispatcher("viewuser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("toggleVisibility".equals(action)) {
            try {
                int serviceId = Integer.parseInt(request.getParameter("serviceId"));
                boolean visible = Boolean.parseBoolean(request.getParameter("visible"));

                ServiceDAO dao = new ServiceDAO();
                boolean updated = dao.updateServiceVisibility(serviceId, visible);

                if (updated) {
                    request.setAttribute("message", "Cập nhật trạng thái hiển thị thành công.");
                } else {
                    request.setAttribute("message", "Không thể cập nhật trạng thái.");
                }
            } catch (Exception e) {
                request.setAttribute("message", "Lỗi cập nhật trạng thái: " + e.getMessage());
            }
        }

        // Sau khi xử lý xong vẫn forward về lại danh sách như doGet()
        doGet(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><head><title>ListServlet</title></head><body>");
            out.println("<h1>This is ListServlet</h1>");
            out.println("</body></html>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet hiển thị danh sách người dùng và dịch vụ trong admin dashboard";
    }
}
