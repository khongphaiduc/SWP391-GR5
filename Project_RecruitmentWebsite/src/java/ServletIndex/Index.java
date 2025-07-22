package ServletIndex;

import DAO.SaveJobPostOfCandidate;
import DAO.SearchAnDisplayJob;
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
            SearchAnDisplayJob o = new SearchAnDisplayJob();

            var list = o.getListJobPost();
             
             list.sort((a, b) -> a.getDayCre().compareTo(b.getDayCre()));
           var sublist =   list.subList(0, 5);
            request.setAttribute("ListHome", sublist);
             
            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println(e.getMessage() );
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
