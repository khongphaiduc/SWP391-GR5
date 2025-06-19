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
            int cvId = Integer.parseInt(request.getParameter("cvId"));
            Integer employerId = (Integer) request.getSession().getAttribute("employerId");

            if (employerId == null) {
                request.setAttribute("error", "Bạn cần đăng nhập để thực hiện hành động này.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            PotentialDAO dao = new PotentialDAO();
            if (dao.removePotentialCV(cvId, employerId)) {
                request.setAttribute("message", "Đã xóa CV khỏi danh sách tiềm năng thành công!");
            } else {
                request.setAttribute("error", "Không thể xóa CV khỏi danh sách tiềm năng.");
            }

            response.sendRedirect("potential-cvs");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID CV không hợp lệ.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}