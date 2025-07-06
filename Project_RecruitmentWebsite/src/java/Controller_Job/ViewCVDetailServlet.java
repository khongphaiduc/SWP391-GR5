package Controller_Job;

import DAO.CVDAO;
import DAO.ApplyDAO;
import Models.CV;
import Models.Apply;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "ViewCVDetailServlet", urlPatterns = {"/view-cv-detail"})
public class ViewCVDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cvIdParam = request.getParameter("cvId");

        if (cvIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID CV");
            return;
        }

        try {
            int cvId = Integer.parseInt(cvIdParam);

            CVDAO cvDAO = new CVDAO();
            CV cv = cvDAO.getCVById(cvId);

            ApplyDAO applyDAO = new ApplyDAO();
            Apply apply = applyDAO.getApplyByCvId(cvId); // 🔁 Lấy apply theo CV

            if (cv != null) {
                request.setAttribute("cv", cv);

                if (apply != null) {
                    request.setAttribute("applyId", apply.getApply_ID()); // Gửi applyId để JSP dùng
                    request.setAttribute("apply", apply); // để dùng ${apply.step}

                }

                request.getRequestDispatcher("view-cv-detail.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Không tìm thấy CV");
                request.getRequestDispatcher("view-cv-detail.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        }
    }
}
