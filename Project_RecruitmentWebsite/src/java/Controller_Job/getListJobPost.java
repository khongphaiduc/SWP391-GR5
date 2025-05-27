package Controller_Job;

import DAO.SearchAnDisplayJob;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "getListJobPost", urlPatterns = {"/getListJobPost"})
public class getListJobPost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet getListJobPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet getListJobPost at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            SearchAnDisplayJob o = new SearchAnDisplayJob();

            var listJobPost = o.getListJobPost();  // lấy list từ database lên nhe

            request.setAttribute("ListJobPost", listJobPost);
            request.getRequestDispatcher("ViewCV/DisplayListPostJob.jsp").forward(request, response);

        } catch (Exception e) {
            request.getRequestDispatcher("ViewCV/DisplayListPostJob.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();

            String status = null;

            String salary = request.getParameter("salary");
            String location = request.getParameter("location");
            String career = request.getParameter("career");
            String experience = request.getParameter("exp");
            String typeJob = request.getParameter("typeJob");
            String searchKey = request.getParameter("searchKey");
            SearchAnDisplayJob o = new SearchAnDisplayJob();
            var listJobPost = o.getListJobPost();
            if (salary != null && location != null) {
                listJobPost = o.getListJobPostByLocation(salary, location);
                request.setAttribute("ListJobPost", listJobPost);
            } else if (salary != null) {
                listJobPost = o.getListJobPostBySalary(salary);
                request.setAttribute("ListJobPost", listJobPost);
            }

            if (listJobPost.size() == 0) {
                status = "ối rồi ôi";
                request.setAttribute("status", status);
                request.getRequestDispatcher("ViewCV/DisplayListPostJob.jsp").forward(request, response);
                return;
            }

            // lưu các option của user vào session
            session.setAttribute("selectedSalary", salary);
            session.setAttribute("location", location);
            session.setAttribute("career", career);
            session.setAttribute("exp", experience);
            session.setAttribute("typeJob", typeJob);
            session.setAttribute("searchKey", searchKey);
            // list
            request.setAttribute("ListJobPost", listJobPost);
            request.getRequestDispatcher("ViewCV/DisplayListPostJob.jsp").forward(request, response);
        } catch (Exception e) {
            request.getRequestDispatcher("ViewCV/DisplayListPostJob.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
