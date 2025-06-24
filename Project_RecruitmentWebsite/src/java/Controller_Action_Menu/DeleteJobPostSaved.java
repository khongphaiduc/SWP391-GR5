package Controller_Action_Menu;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.*;

// pham trung duc : xóa jobpost đã lưu 

@WebServlet(name = "DeleteJobPostSaved", urlPatterns = {"/DeleteJobPostSaved"})
public class DeleteJobPostSaved extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteJobPostSaved</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteJobPostSaved at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            DeleteJobPostDAO deleteJobPostSaveDAO = new DeleteJobPostDAO();
            String idJobPost = request.getParameter("idJobPost");

            if (idJobPost != null) {

                boolean result = deleteJobPostSaveDAO.deleteJobPost(idJobPost);

                if (result) {

                    response.setStatus(200);
                    return;
                } else {

                    response.setStatus(500);
                    return;
                }

            }

        } catch (Exception e) {
            System.out.println("Bug ở deleteJobPostSaved và Content là :" + e.getMessage());
            response.sendRedirect("DisplayListJobPostSaveOfCandidate");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
