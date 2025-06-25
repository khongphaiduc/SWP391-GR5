/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Apply;

import DAO.*;
import Models.*;
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
public class searchListApplyServlet extends HttpServlet {

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
            out.println("<title>Servlet searchListApplyServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet searchListApplyServlet at " + request.getContextPath() + "</h1>");
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
        try {

            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");

            String status = null;
            String salary = request.getParameter("salary");
            if (salary == null) {
                salary = "0";
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


            // -------------------------------------------------------
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");

            if (username == null || !"Candidate".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/log/login.jsp");
                return;
            }
            CandidateDAO candidateDAO = new CandidateDAO();
            ApplyDAO applyDAO = new ApplyDAO();

            Candidate candidate = candidateDAO.getCandidateByName(username);

            int candidateID = candidate.getCandidateId();
            List<Apply> applies = applyDAO.filterAppliesByCandidate(candidateID,
                    salary, location, career, experience, typeJob, searchKeyTrim);

            // -------------------------------------------------------

            // tìm kiếm bên trong 
            session.setAttribute("selectedSalary", salary);
            session.setAttribute("location", location);
            session.setAttribute("career", career);
            session.setAttribute("exp", experience);
            session.setAttribute("typeJob", typeJob);
            session.setAttribute("searchKey", searchKey);
            request.setAttribute("keySearch", searchKey);

            //Paging
            String pageParam = request.getParameter("page");
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
            // Set pagesize
            int pageSize = 5;
            if (session.getAttribute("pageSize") != null) {
                pageSize = (int) (session.getAttribute("pageSize"));
            }

            session.setAttribute("pageSize", pageSize);
            
            int totalApply = applies.size();
            int totalPages = (int) Math.ceil((double) totalApply / pageSize);
            int fromIndex = (page - 1) * pageSize;
            int toIndex = Math.min(fromIndex + pageSize, totalApply);

            if (fromIndex >= totalApply) {
                fromIndex = 0;
                toIndex = Math.min(pageSize, totalApply);
                page = 1;
            }
            List<Apply> paginatedList = applies.subList(fromIndex, toIndex);

            request.setAttribute("applies", paginatedList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            if (applies.size() == 0 || applies.isEmpty()) {
                status = "Lỗi";
                request.setAttribute("status", status);
                request.getRequestDispatcher("ApplyCV_view/candidateApplyList.jsp").forward(request, response);
                return;
            }
            request.getRequestDispatcher("ApplyCV_view/candidateApplyList.jsp").forward(request, response);
        } catch (Exception e) {
            request.getRequestDispatcher("ApplyCV_view/candidateApplyList.jsp").forward(request, response);
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
        processRequest(request, response);
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
