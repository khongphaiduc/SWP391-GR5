package Controller_ServicePackage;

import DAO.ServiceDAO;
import Models.Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Arrays;

@WebServlet(name = "UpdateServiceServlet", urlPatterns = {"/update-service"})
public class UpdateServiceServlet extends HttpServlet {

    // XỬ LÝ GET → hiển thị form cập nhật
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra quyền Admin
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (role == null || !"Admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/log/login.jsp");
            return;
        }

        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/list?type=service");
                return;
            }

            int serviceId = Integer.parseInt(idParam);
            ServiceDAO dao = new ServiceDAO();
            Service service = dao.getServiceById(serviceId);  // Bạn cần có method này trong DAO

            if (service == null) {
                request.setAttribute("message", "Không tìm thấy dịch vụ.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("/404.jsp").forward(request, response);
            } else {
                request.setAttribute("service", service);
                request.getRequestDispatcher("/page_service/updateService.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("message", "ID không hợp lệ.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("/404.jsp").forward(request, response);
        }
    }

    // XỬ LÝ POST → cập nhật service
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (role == null || !"Admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/log/login.jsp");
            return;
        }

        try {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            String serviceName = request.getParameter("serviceName");
            double price = Double.parseDouble(request.getParameter("price"));
            String descriptionRaw = request.getParameter("description"); // textarea chỉ trả về 1 string
            int duration = Integer.parseInt(request.getParameter("duration"));

            String promoIdStr = request.getParameter("promotionId");
            Integer promotionId = (promoIdStr == null || promoIdStr.trim().isEmpty()) ? null : Integer.parseInt(promoIdStr);

            Service service = new Service();
            service.setServiceId(serviceId);
            service.setServiceName(serviceName);
            service.setPrice(price);
            service.setDescription(descriptionRaw); // sẽ được split trong DAO nếu cần
            service.setDuration(duration);
            service.setPromotionId(promotionId);

            ServiceDAO dao = new ServiceDAO();
            boolean success = dao.updateService(service);

            Service updatedService = dao.getServiceById(serviceId); // load lại để hiển thị

            request.setAttribute("service", updatedService);
            request.setAttribute("message", success ? "Cập nhật thành công!" : "Cập nhật thất bại!");
            request.setAttribute("messageType", success ? "success" : "error");

            request.getRequestDispatcher("/page_service/updateService.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi khi cập nhật: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị và xử lý cập nhật dịch vụ (Admin only)";
    }
}
