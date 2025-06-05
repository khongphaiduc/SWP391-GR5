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

@WebServlet(name = "searchListJobPost", urlPatterns = {"/searchListJobPost"})
public class searchListJobPost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet searchListJobPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet searchListJobPost at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");

            HttpSession session = request.getSession();
            String status = null;
            String salary = request.getParameter("salary");
            String location = request.getParameter("location");
            String career = request.getParameter("career");
            String experience = request.getParameter("exp");
            String typeJob = request.getParameter("typeJob");
            String searchKey = request.getParameter("searchKey");
            SearchAnDisplayJob o = new SearchAnDisplayJob();
             
       
            var listJobPost = o.BuildTest(salary, location, career, experience, typeJob,searchKey);
            // thằng mới đăng tin hiển  thị lên đầu
            listJobPost.sort((a, b) -> {
              var s =  b.getDayCre().compareTo(a.getDayCre());
                     return s; 
              });
              
            int totalJobs = listJobPost.size();    // lấy số lượng jobpost có hiện tại
            String pageStr = request.getParameter("page");
            int currentpage = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
            int numberJobOfPage = 8; // dẳte số job mỗi trang

            int totalPages = (int) Math.ceil((double) totalJobs / numberJobOfPage); // tính  tổng số trang cần có 

            int start = (currentpage - 1) * numberJobOfPage;
            int end = Math.min(start + numberJobOfPage, totalJobs);

            var jobsOnPage = listJobPost.subList(start, end);

            request.setAttribute("ListJobPost", jobsOnPage);
            request.setAttribute("currentPage", currentpage);
            request.setAttribute("totalPages", totalPages);

            // tìm kiếm bên trong 
            session.setAttribute("selectedSalary", salary);
            session.setAttribute("location", location);
            session.setAttribute("career", career);
            session.setAttribute("exp", experience);
            session.setAttribute("typeJob", typeJob);
            session.setAttribute("searchKey", searchKey);
            request.setAttribute("ListJobPost", listJobPost);

            if (listJobPost.size() == 0) {
                status = "ối rồi ôi";
                request.setAttribute("status", status);
                request.getRequestDispatcher("ViewJobPost/DisplayListPostJob.jsp").forward(request, response);
                return;
            }

            request.getRequestDispatcher("ViewJobPost/DisplayListPostJob.jsp").forward(request, response);
        } catch (Exception e) {
            request.getRequestDispatcher("ViewJobPost/DisplayListPostJob.jsp").forward(request, response);
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
