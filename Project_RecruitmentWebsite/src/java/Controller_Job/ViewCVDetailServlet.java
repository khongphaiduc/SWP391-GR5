package Controller_Job;

import DAO.CVDAO;
import DAO.ApplyDAO;
import DAO.PotentialDAO;
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
        String jobPostIdParam = request.getParameter("jobPostId");

        if (cvIdParam == null || jobPostIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số cvId hoặc jobPostId");
            return;
        }

        try {
            int cvId = Integer.parseInt(cvIdParam);
            int jobPostId = Integer.parseInt(jobPostIdParam);

            HttpSession session = request.getSession();
            Integer employerId = (Integer) session.getAttribute("employerId");

            CVDAO cvDAO = new CVDAO();
            CV cv = cvDAO.getCVById(cvId);

            ApplyDAO applyDAO = new ApplyDAO();
            Apply apply = applyDAO.getApplyByCvIdAndJobPostId(cvId, jobPostId); // method mới

            if (cv != null) {
                request.setAttribute("cv", cv);
                request.setAttribute("jobPostId", jobPostId);

                if (apply != null) {
                    request.setAttribute("apply", apply);
                    request.setAttribute("applyId", apply.getApply_ID());
                }

                boolean isPotential = false;
                if (employerId != null) {
                    PotentialDAO potentialDAO = new PotentialDAO();
                    isPotential = potentialDAO.isPotentialCVExists(cvId, employerId, jobPostId);
                }
                request.setAttribute("isPotential", isPotential);

                request.getRequestDispatcher("view-cv-detail.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Không tìm thấy CV");
                request.getRequestDispatcher("view-cv-detail.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tham số không hợp lệ");
        }
    }
}
