/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Apply;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.*;
import Models.*;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author PC
 */
public class applyServlet extends HttpServlet {

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
            out.println("<title>Servlet ApplyServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApplyServlet at " + request.getContextPath() + "</h1>");
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
        if (username == null || !"Candidate".equals(role)) {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);
            return;
        } else {

            CandidateDAO candidateDAO = new CandidateDAO();
            Candidate candidate = candidateDAO.getCandidateByName(username);
            int candidateId = candidate.getCandidateId();

            CVDAO cvdao = new CVDAO();
            List<CV> cvList = cvdao.getCVByCandidate(candidateId);

            String pageParam = request.getParameter("page");
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
            // Set pagesize
            int pageSize = 5;
            if (session.getAttribute("pageSize") != null) {
                pageSize = (int) (session.getAttribute("pageSize"));
            }
            if (request.getParameter("pageSize") != null) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }
            session.setAttribute("pageSize", pageSize);

            int totalCV = cvList.size();
            int totalPages = (int) Math.ceil((double) totalCV / pageSize);
            int fromIndex = (page - 1) * pageSize;
            int toIndex = Math.min(fromIndex + pageSize, totalCV);

            if (fromIndex >= totalCV) {
                fromIndex = 0;
                toIndex = Math.min(pageSize, totalCV);
                page = 1;
            }

            List<CV> paginatedList = cvList.subList(fromIndex, toIndex);

            request.setAttribute("cvList", paginatedList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("ApplyCV_view/applyCVList.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        CandidateDAO cdao = new CandidateDAO();

        int jobId = Integer.parseInt(request.getParameter("jobId"));

        int candidateID = cdao.getCandidateByName(username).getCandidateId();
        int cvID = Integer.parseInt(request.getParameter("cvId"));

        ApplyDAO applyDAO = new ApplyDAO();

        JobPostDAO jobPostDAO = new JobPostDAO();
        JobPost jobPost = jobPostDAO.getJobPostById(jobId);
        if (!applyDAO.hasApplied(candidateID, jobId)) {
            Apply apply = new Apply();
            apply.setJobPost_ID(jobId);
            apply.setCandidate_ID(candidateID);
            apply.setCV_ID(cvID);
            apply.setStatus("Đã nộp");
            apply.setStep("Chờ duyệt");

            applyDAO.insertApply(apply);
            request.setAttribute("message", "Ứng tuyển thành công!");
        } else {
            request.setAttribute("message", "Bạn đã ứng tuyển công việc này rồi.");
        }
        request.setAttribute("jobPost", jobPostDAO.getJobPostWithEmployerById(jobId));
        request.getRequestDispatcher("jobPost_view/job-detail.jsp").forward(request, response);
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
