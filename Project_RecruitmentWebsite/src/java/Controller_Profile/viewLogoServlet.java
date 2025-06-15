/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Profile;

import DAO.CVDAO;
import DAO.CandidateDAO;
import DAO.EmployerDAO;
import Models.CV;
import Models.Candidate;
import Models.Employer;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.InputStream;
import java.io.OutputStream;

/**
 *
 * @author PC
 */
public class viewLogoServlet extends HttpServlet {

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
            out.println("<title>Servlet viewLogoServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet viewLogoServlet at " + request.getContextPath() + "</h1>");
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
        String role = (String) session.getAttribute("role");

        if ("Employer".equals(role)) {
            String name = request.getParameter("name");
            EmployerDAO edao = new EmployerDAO();
            Employer employer = edao.getEmployerByName(name);
            if (employer != null && employer.getImgLogo() != null) {
                InputStream inputStream = employer.getImgLogo();
                OutputStream out = response.getOutputStream();
                response.setContentType("image/jpeg");
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                inputStream.close();
                out.flush();
            } else {
                response.getWriter().write("Không tìm thấy file.");
            }
        } else if ("Candidate".equals(role)) {
            String name = request.getParameter("name");
            CandidateDAO cdao = new CandidateDAO();
            Candidate candidate = cdao.getCandidateByName(name);
            if (candidate != null && candidate.getAvatar()!= null) {
                InputStream inputStream = candidate.getAvatar();
                OutputStream out = response.getOutputStream();
                response.setContentType("image/jpeg");
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                inputStream.close();
                out.flush();
            } else {
                response.getWriter().write("Không tìm thấy file.");
            }
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
