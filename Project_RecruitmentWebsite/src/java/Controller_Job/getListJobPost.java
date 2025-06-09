package Controller_Job;

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
            
            HttpSession session = request.getSession();
            String status = " ";
            String fields = request.getParameter("career");
            String location = request.getParameter("location");
            String nameCompany = request.getParameter("search");
            SearchAnDisplayJob o = new SearchAnDisplayJob();
            
           // -------------------------------------------------------
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

            var listJobPost = o.BuildTest("0", location, fields, null, null, nameCompany);

            listJobPost.sort((a, b) -> {
                var s = b.getDayCre().compareTo(a.getDayCre());
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

            // nếu list = 0S
            if (listJobPost.size() == 0) {
                request.setAttribute("status", status);
                request.getRequestDispatcher("ViewJobPost/DisplayListPostJob.jsp").forward(request, response);
                return;
            }

            request.setAttribute("ListJobPost", jobsOnPage);
            request.setAttribute("currentPage", currentpage);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("ViewJobPost/DisplayListPostJob.jsp").forward(request, response);

        } catch (Exception e) {
            request.getRequestDispatcher("ViewJobPost/DisplayListPostJob.jsp").forward(request, response);
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
