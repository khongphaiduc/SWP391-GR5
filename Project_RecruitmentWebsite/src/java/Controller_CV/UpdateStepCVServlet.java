package Controller_CV;

import DAO.EmployerDAO;
import DAO.UpdateStepDAO;
import DAO.CVDAO;
import Models.CV;
import MyService.MyEmail;
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
        String newStep = request.getParameter("step");
        String cvIdRaw = request.getParameter("cvId");
        String jobPostIdRaw = request.getParameter("jobPostId");

        HttpSession session = request.getSession();
        EmployerDAO employerDAO = new EmployerDAO();
        String username = (String) session.getAttribute("username");
        
        int employerId = employerDAO.getEmployerByName(username).getEmployerId();

        if (username == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Bạn chưa đăng nhập.");
            return;
        }

        if (applyIdRaw == null || newStep == null || newStep.trim().isEmpty() || cvIdRaw == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu dữ liệu cần thiết.");
            return;
        }

        try {
            int applyId = Integer.parseInt(applyIdRaw);
            int cvId = Integer.parseInt(cvIdRaw);
            int jobPostId = Integer.parseInt(jobPostIdRaw);

            UpdateStepDAO dao = new UpdateStepDAO();
            boolean updated = dao.updateStep(applyId, newStep, employerId);

            if (updated) {
                session.setAttribute("message", "✔ Cập nhật trạng thái CV thành công.");

                // ✅ Gửi email nếu là mời phỏng vấn
                if ("Mời phỏng vấn".equalsIgnoreCase(newStep)) {
                    CVDAO cvDao = new CVDAO(); // DAO để lấy CV
                    CV cv = cvDao.getCVById(cvId); // Lấy CV theo id

                    if (cv != null && cv.getEmail() != null) {
                        String toEmail = cv.getEmail();
                        String subject = "Thư mời phỏng vấn từ công ty";
                        String body = "Chào bạn " + cv.getFullName() + ",\n\n"
                                + "CV của bạn đã được chọn để mời phỏng vấn.\n"
                                + "Vui lòng truy cập hệ thống hoặc liên hệ lại để xác nhận thời gian.\n\n"
                                + "Trân trọng,\n";
                                
                        MyEmail.sendEmail(toEmail, subject, body);
                    }
                }

            } else {
                session.setAttribute("message", "✖ Không thể cập nhật trạng thái. Có thể bạn không có quyền.");
            }

            response.sendRedirect("view-cv-detail?cvId=" + cvId + "&jobPostId=" + jobPostId);


        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống khi cập nhật.");
        }
    }
}
