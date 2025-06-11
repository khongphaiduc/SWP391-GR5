package ServletIndex;

import DAO.SaveJobPostOfCandidate;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "Index", urlPatterns = {"/Index"})
public class Index extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Index</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Index at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // -------------------------------------------------------
            HttpSession session = request.getSession();
            SaveJobPostOfCandidate saveJob = new SaveJobPostOfCandidate();
            int numberJobPost = 0;
            String user = (String) session.getAttribute("username");

            // kiểm tra xem đăng nhập chưa và lấy số lượng post đã lưu 
            if (user != null) {
                String IdUser = saveJob.getCandidateIDByName(user);
                numberJobPost = saveJob.getNumberJobPostSavedByCandidate(IdUser);
            }

            session.setAttribute("numberJobPost", numberJobPost);    // số lượng jobpost của thằng user
            // -------------------------------------------------------
            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
          
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
           
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
