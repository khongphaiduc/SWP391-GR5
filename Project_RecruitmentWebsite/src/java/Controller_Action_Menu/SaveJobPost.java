package Controller_Action_Menu;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import DAO.*;
// dung để lưu jobPost

@WebServlet(name = "SaveJobPost", urlPatterns = {"/SaveJobPost"})
public class SaveJobPost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SaveJobPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SaveJobPost at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession();

            String accountNameUser = (String) session.getAttribute("username");
            String iDJopPost = request.getParameter("idJobPost");

            SaveJobPostOfCandidate savejobpost = new SaveJobPostOfCandidate();

            String idCandidate = savejobpost.getCandidateIDByName(accountNameUser);  // lấy id của user này 

            System.out.println("accountNameUser:" + accountNameUser);
            System.out.println("iDJopPost: " + iDJopPost);

            boolean result = savejobpost.saveJobPost(idCandidate, iDJopPost);  // save jobpost


            if (result) {
                response.setStatus(200);  // chèn thành công 
            } else {
                response.setStatus(500);   // chèn thất bại 
            }

        } catch (Exception e) {
            response.setStatus(500);
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
    }// </editor-fold>

}
