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

@WebServlet(name = "SearchCVsServlet", urlPatterns = {"/SearchCVsServlet"})
public class SearchCVsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        // Kiểm tra login và vai trò
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
            session.setAttribute("employerId", employerId); // lưu vào session để dùng cho các servlet khác

            // Lấy tham số tìm kiếm từ request
            String keyword = request.getParameter("keyword");
            String address = request.getParameter("address");
            String numberExpStr = request.getParameter("numberExp");
            String position = request.getParameter("position");
            String field = request.getParameter("field");

            // Chuyển đổi kinh nghiệm sang kiểu số (nullable)
            Integer numberExp = null;
            if (numberExpStr != null && !numberExpStr.trim().isEmpty()) {
                try {
                    numberExp = Integer.parseInt(numberExpStr);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Số năm kinh nghiệm không hợp lệ.");
                    request.getRequestDispatcher("/error.jsp").forward(request, response);
                    return;
                }
            }

            // Gọi DAO để tìm kiếm CV
            CVDAO cvDao = new CVDAO();
            List<CV> appliedCVs = cvDao.searchCVsForEmployer(employerId, address, numberExp, position, keyword, field);

            // Log
            System.out.println("Số CV tìm thấy: " + appliedCVs.size());

            // Truyền dữ liệu sang JSP
            request.setAttribute("appliedCVs", appliedCVs);
            request.setAttribute("keyword", keyword);
            request.setAttribute("address", address);
            request.setAttribute("numberExp", numberExp);
            request.setAttribute("position", position);
            request.setAttribute("field", field);

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
