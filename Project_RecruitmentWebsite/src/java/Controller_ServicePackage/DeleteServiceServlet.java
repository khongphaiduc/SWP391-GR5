package Controller_ServicePackage;

import DAO.ServiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet xử lý yêu cầu xóa gói dịch vụ theo ID
 */
@WebServlet(name = "DeleteServiceServlet", urlPatterns = {"/delete-servicepackage"})
public class DeleteServiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra session và quyền Admin
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : null;
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (username == null || role == null || !"Admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/log/login.jsp");
            return;
        }

        // Lấy ID từ query string
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            request.setAttribute("message", "Thiếu mã dịch vụ để xóa.");
            request.getRequestDispatcher("/404.jsp").forward(request, response);
            return;
        }

        int serviceId = 0;
        try {
            serviceId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            request.setAttribute("message", "ID không hợp lệ.");
            request.getRequestDispatcher("/404.jsp").forward(request, response);
            return;
        }

        // Gọi DAO để xóa
        ServiceDAO dao = new ServiceDAO();
        boolean deleted = dao.deleteService(serviceId);

        if (deleted) {
            // Xóa thành công → quay lại trang danh sách service
            request.setAttribute("message", "Xóa dịch vụ thành công.");
            request.setAttribute("messageType", "success");
        } else {
            // Xóa thất bại
            request.setAttribute("message", "Không thể xóa dịch vụ. Có thể đang được sử dụng.");
            request.setAttribute("messageType", "error");
        }
        request.getRequestDispatcher("/list").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Xóa gói dịch vụ theo ID";
    }
}
