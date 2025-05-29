/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Job;

import DAO.*;
import Models.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
public class createJobServlet extends HttpServlet {

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
            out.println("<title>Servlet createJobServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet createJobServlet at " + request.getContextPath() + "</h1>");
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
            request.getRequestDispatcher("jobPost_view/createJob.jsp").forward(request, response);
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
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String position = request.getParameter("position");
        String location = request.getParameter("location");

        double offerMin = parseDoubleSafe(request.getParameter("offerMin"));
        double offerMax = parseDoubleSafe(request.getParameter("offerMax"));
        int numberExp = parseIntSafe(request.getParameter("numberExp"));
        String typeJob = request.getParameter("typeJob");
        boolean visible = "1".equals(request.getParameter("visible"));

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        EmployerDAO employerDAO = new EmployerDAO();
        Employer employer = employerDAO.getEmployerByName(username);
        int employerId = employer.getEmployerId();

        JobPost job = new JobPost();
        job.setEmployer_ID(employerId);
        job.setTitle(title);
        job.setDescription(description);
        job.setCategory(category);
        job.setPosition(position);
        job.setLocation(location);
        job.setOffer_Min(offerMin);
        job.setOffer_Max(offerMax);
        job.setNumber_exp(numberExp);
        job.setTypeJob(typeJob);
        job.setVisible(visible);

        JobPostDAO jobPostDAO = new JobPostDAO();
        boolean success = jobPostDAO.addJobPost(job);

        if (success) {
            request.setAttribute("message", "Đăng tin thành công!");
            request.getRequestDispatcher("jobPost_view/createJob.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Đăng tin thất bại!");
            request.getRequestDispatcher("jobPost_view/createJob.jsp").forward(request, response);
        }

    }

    private double parseDoubleSafe(String value) {
        try {
            return Double.parseDouble(value);
        } catch (Exception e) {
            return 0;
        }
    }

    private int parseIntSafe(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return 0;
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
