package Controller_Action_Menu;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.*;
import jakarta.servlet.http.HttpSession;
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
            HttpSession session = request.getSession();
            boolean remove = true;
            boolean checkRound1 = false;
            DeleteJobPostDAO deleteJobPostSaveDAO = new DeleteJobPostDAO();
            String idJobPost = request.getParameter("idJobPost");

            if (idJobPost != null) {
                remove = true;
                session.setAttribute("remove",remove);
                boolean result = deleteJobPostSaveDAO.deleteJobPost(idJobPost);
                if (result) {
                    checkRound1 = true;
                    session.setAttribute("check", checkRound1);
                    response.sendRedirect("DisplayListJobPostSaveOfCandidate");
                    return;
                } else {
                    checkRound1 = false;
                    session.setAttribute("check", checkRound1);
                    response.sendRedirect("DisplayListJobPostSaveOfCandidate");
                    return;
                }
            }

        } catch (Exception e) {
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
