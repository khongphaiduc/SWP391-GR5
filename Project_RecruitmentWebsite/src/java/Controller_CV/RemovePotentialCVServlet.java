package Controller_CV;

import DAO.PotentialDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RemovePotentialCVServlet", urlPatterns = {"/remove-potential-cv"})
public class RemovePotentialCVServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy ID từ form hoặc URL
            int cvId = Integer.parseInt(request.getParameter("cvId"));
            int jobPostId = Integer.parseInt(request.getParameter("jobPostId")); // ✅ thêm jobPostId

            // Lấy employer từ session
            Integer employerId = (Integer) request.getSession().getAttribute("employerId");

            if (employerId == null) {
                request.setAttribute("error", "Bạn cần đăng nhập để thực hiện hành động này.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // Gọi DAO xử lý
            PotentialDAO dao = new PotentialDAO();
            boolean removed = dao.removePotentialCV(cvId, employerId, jobPostId); // ✅ truyền đủ 3 tham số

            String message = removed
                    ? "✅ Đã xóa CV khỏi danh sách tiềm năng thành công!"
                    : "⚠ Không thể xóa CV khỏi danh sách tiềm năng.";

            request.getSession().setAttribute("message", message);

            // Quay về trang trước
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : "potential-cvs.jsp");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ (CV_ID hoặc JobPost_ID sai định dạng).");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống khi xóa CV khỏi danh sách tiềm năng.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
