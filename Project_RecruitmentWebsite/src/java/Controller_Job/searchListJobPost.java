package Controller_Job;

import DAO.*;
import Models.JobPost;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

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

            String status = null;
            String salary = request.getParameter("salary");
            if(salary==null){
                salary="0";
            }
            String location = request.getParameter("location");
            String career = request.getParameter("career");
            String experience = request.getParameter("exp");
            String typeJob = request.getParameter("typeJob");
            String searchKey = request.getParameter("searchKey");
            String searchKeyTrim = null;
            if (searchKey != null) {
                searchKeyTrim = searchKey.trim().replaceAll("\\s+", " ");
            }

            SearchAnDisplayJob o = new SearchAnDisplayJob();

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

            var listJobPost = o.BuildTest(salary, location, career, experience, typeJob, searchKeyTrim);

            int totalJobs = listJobPost.size();    // lấy số lượng jobpost có hiện tại
            String pageStr = request.getParameter("page");
            int currentpage = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
            int numberJobOfPage = 5; // dẳte số job mỗi trang

            int totalPages = (int) Math.ceil((double) totalJobs / numberJobOfPage); // tính  tổng số trang cần có 



            int start = (currentpage - 1) * numberJobOfPage;
            int end = Math.min(start + numberJobOfPage, totalJobs);

            List<JobPost> jobsOnPage;
            if (start >= totalJobs) {
                jobsOnPage = new ArrayList<>(); // Trang trống
            } else {
                jobsOnPage = listJobPost.subList(start, end);
            }

            System.out.println("currentPage = " + currentpage);
            System.out.println("totalPages = " + totalPages);
            System.out.println("start = " + start + ", end = " + end);
            System.out.println("totalJobs = " + totalJobs);

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
            request.setAttribute("keySearch", searchKey);

            if (listJobPost.size() == 0 || listJobPost.isEmpty()) {
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
