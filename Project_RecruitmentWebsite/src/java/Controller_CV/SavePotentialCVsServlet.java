package Controller_CV;

import DAO.PotentialDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "SavePotentialCVsServlet", urlPatterns = {"/save-potential-cvs"})
public class SavePotentialCVsServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy dữ liệu từ request
            int cvId = Integer.parseInt(request.getParameter("cvId"));
            int jobPostId = Integer.parseInt(request.getParameter("jobPostId")); // Bổ sung

            HttpSession session = request.getSession();
            Integer employerId = (Integer) session.getAttribute("employerId");

            if (employerId == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Gọi DAO
            PotentialDAO dao = new PotentialDAO();
            boolean added = dao.addPotentialCV(cvId, employerId, jobPostId); // Gọi đúng hàm

            // Gửi thông báo và redirect
            if (added) {
                session.setAttribute("toastMessage", "✅ CV đã được lưu vào danh sách tiềm năng!");
            } else {
                session.setAttribute("toastMessage", "⚠️ CV đã tồn tại hoặc có lỗi!");
            }

            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : "applied-cv-list.jsp");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu không hợp lệ (cvId hoặc jobPostId).");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi lưu CV tiềm năng.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
