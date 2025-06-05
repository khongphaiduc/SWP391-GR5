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
// pham trung duc   : dung để lấy jobpost đã lưu và hiển thị

@WebServlet(name = "DisplayListJobPostSaveOfCandidate", urlPatterns = {"/DisplayListJobPostSaveOfCandidate"})
public class DisplayListJobPostSaveOfCandidate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet getListJobPostSaveOfCandidate</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet getListJobPostSaveOfCandidate at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            HttpSession session = request.getSession();
            SaveJobPostOfCandidate saveJobPostDAO = new SaveJobPostOfCandidate();
            String user = (String) session.getAttribute("username");
            String idUser = "";
            
            // check user đã đăng nhập chưa 
            if (user != null) {
                idUser = saveJobPostDAO.getCandidateIDByName(user);    // lấy id của thằng user
                
            } else if (user == null) {
                request.setAttribute("statuss", "usernull");
                request.getRequestDispatcher("ViewActionMenu/DisplayListJobPostSaveByCandidate.jsp").forward(request, response);
                return ;
            }

            getListSaveJobPost getListJobPostDAO = new getListSaveJobPost();

            var listJobPost = getListJobPostDAO.getListJobPostSaved(idUser);    // list Jobpost của thằng user

            if (listJobPost.size() == 0) {
                request.setAttribute("statuss", "usernull");
                request.getRequestDispatcher("ViewActionMenu/DisplayListJobPostSaveByCandidate.jsp").forward(request, response);
                return;
            }
            
           
            request.setAttribute("listJobPost", listJobPost);
            request.getRequestDispatcher("ViewActionMenu/DisplayListJobPostSaveByCandidate.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Loi nay cu em :" + e.getMessage());
            request.getRequestDispatcher("ViewActionMenu/DisplayListJobPostSaveByCandidate.jsp").forward(request, response);
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
