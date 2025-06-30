package Controller_CV;

import DAO.UpdateStepDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/update-step")
public class UpdateStepCVServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ request
        String applyIdRaw = request.getParameter("applyId");
        String newStep = request.getParameter("step"); // Đúng name trong form
        String cvIdRaw = request.getParameter("cvId"); // Thêm dòng này

        HttpSession session = request.getSession();
        Integer employerId = (Integer) session.getAttribute("employerId");

        if (employerId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn chưa đăng nhập.");
            return;
        }

        // Kiểm tra dữ liệu đầu vào
        if (applyIdRaw == null || newStep == null || newStep.trim().isEmpty() || cvIdRaw == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu dữ liệu cần thiết.");
            return;
        }

        try {
            int applyId = Integer.parseInt(applyIdRaw);
            int cvId = Integer.parseInt(cvIdRaw); // Parse cvId

            UpdateStepDAO dao = new UpdateStepDAO();
            boolean updated = dao.updateStep(applyId, newStep, employerId);

            if (updated) {
                session.setAttribute("message", "✔ Cập nhật trạng thái CV thành công.");
            } else {
                session.setAttribute("message", "✖ Không thể cập nhật trạng thái. Có thể bạn không có quyền.");
            }

            // Redirect trở lại trang xem chi tiết CV
            response.sendRedirect("view-cv-detail?cvId=" + cvId);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống khi cập nhật.");
        }
    }
}
