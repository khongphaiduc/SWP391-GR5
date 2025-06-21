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
            int cvId = Integer.parseInt(request.getParameter("cvId"));
            HttpSession session = request.getSession();
            Integer employerId = (Integer) session.getAttribute("employerId");

            if (employerId == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            PotentialDAO dao = new PotentialDAO();
            boolean added = dao.addPotentialCV(cvId, employerId);

            if (added) {
                request.getSession().setAttribute("toastMessage", "✅ CV đã được lưu vào danh sách tiềm năng!");
                String referer = request.getHeader("Referer");
                response.sendRedirect(referer != null ? referer : "applied-cv-list.jsp");
            } else {
                request.getSession().setAttribute("toastMessage", "⚠️ CV đã tồn tại hoặc có lỗi!");
                String referer = request.getHeader("Referer");
                response.sendRedirect(referer != null ? referer : "applied-cv-list.jsp");
            }

            // ➤ Redirect về lại trang hiển thị CV đã ứng tuyển
//            String referer = request.getHeader("Referer");
//            response.sendRedirect(referer != null ? referer : "applied-cv-list.jsp");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
