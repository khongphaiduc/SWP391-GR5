/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Job;

import DAO.*;
import Models.*;
import MyService.JobCategoryProvider;
import MyService.LocationProvider;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class manageCreatedJobServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet manageCreatedJobServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet manageCreatedJobServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        if (username == null || !"Employer".equals(role)) {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);
            return;
        } else {

            EmployerDAO employerDAO = new EmployerDAO();
            Employer employer = employerDAO.getEmployerByName(username);
            int employerId = employer.getEmployerId();

            JobPostDAO jobPostDAO = new JobPostDAO();
            List<JobPost> jobList = jobPostDAO.getJobPostsByEmployerId(employerId);

            String pageParam = request.getParameter("page");
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
            int pageSize = 5;
            if (session.getAttribute("pageSize") != null) {
                pageSize = (int) (session.getAttribute("pageSize"));
            }
            if (request.getParameter("pageSize") != null) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }
            session.setAttribute("pageSize", pageSize);
            int totalJob = jobList.size();
            int totalPages = (int) Math.ceil((double) totalJob / pageSize);
            int fromIndex = (page - 1) * pageSize;
            int toIndex = Math.min(fromIndex + pageSize, totalJob);

            if (fromIndex >= totalJob) {
                fromIndex = 0;
                toIndex = Math.min(pageSize, totalJob);
                page = 1;
            }

            List<JobPost> paginatedList = jobList.subList(fromIndex, toIndex);

            request.setAttribute("jobList", paginatedList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("jobPost_view/manageCreatedJob.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int jobId = Integer.parseInt(request.getParameter("jobId"));
        PrintWriter out = response.getWriter();

        JobPostDAO jobPostDAO = new JobPostDAO();
        JobPost jobPost = jobPostDAO.getJobPostById(jobId);

        switch (action) {
            case "edit":
                request.setAttribute("job", jobPost);
                ArrayList<String> jobCategories = JobCategoryProvider.getJobCategories();
                request.setAttribute("jobCategories", jobCategories);

                ArrayList<String> locations = LocationProvider.getLocations();
                request.setAttribute("locations", locations);

                request.getRequestDispatcher("jobPost_view/editJob.jsp").forward(request, response);

                break;

            case "delete":

                jobPostDAO.deleteJobPost(jobId);
                response.sendRedirect("manageCreatedJob");
                break;
            default:
                response.sendRedirect("manageCreatedJob");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
