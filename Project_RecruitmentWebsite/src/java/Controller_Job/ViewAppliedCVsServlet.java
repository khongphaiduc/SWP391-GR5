package Controller_Job;

import DAO.CVDAO;
import DAO.EmployerDAO;
import Models.CV;
import Models.Employer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/view-applied-cvs")
public class ViewAppliedCVsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");       
        if (username == null || !"Employer".equals(role)) {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);
            return;
        } else {
            EmployerDAO edao = new EmployerDAO();
            Employer employer = edao.getEmployerByName(username);
            int employerId = employer.getEmployerId();
            //int employerId = 1;
            session.setAttribute("employerId", employerId);
            CVDAO cvdao = new CVDAO();
            List<CV> appliedCVs = cvdao.getAppliedCVsByEmployer(employerId);

            request.setAttribute("appliedCVs", appliedCVs);
            request.getRequestDispatcher("applied-cv-list.jsp").forward(request, response);
        }
    }
}
