/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_CV;

import DAO.CVDAO;
import DAO.CandidateDAO;
import Models.*;
import MyService.ImageUtil;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.sql.Date;

/**
 *
 * @author PC
 */
@MultipartConfig
public class submitCVServlet extends HttpServlet {

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
            out.println("<title>Servlet submitCVServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet submitCVServlet at " + request.getContextPath() + "</h1>");
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
        CandidateDAO candidateDAO = new CandidateDAO();
        if (username == null || !"Candidate".equals(role)) {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);
            return;
        } else {
            request.setAttribute("isEdit", false);
            request.setAttribute("candidate", candidateDAO.getCandidateByName(username));
            request.getRequestDispatcher("candidateCV_view/fillCVInfo.jsp").forward(request, response);
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
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String position = request.getParameter("position");
        int numberExp = Integer.parseInt(request.getParameter("numberExp"));
        String education = request.getParameter("education");
        String field = request.getParameter("field");

        String salaryStr = request.getParameter("currentSalary");
        salaryStr = salaryStr.replace(".", "").replace(",", "");

        double currentSalary = Double.parseDouble(salaryStr);

        Date birthday = Date.valueOf(request.getParameter("birthday"));
        String nationality = request.getParameter("nationality");
        String gender = request.getParameter("gender");

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        CandidateDAO candidateDAO = new CandidateDAO();
        Candidate candidate = candidateDAO.getCandidateByName(username);
        int candidateId = candidate.getCandidateId();

        CVDAO cvdao = new CVDAO();

        Part filePart = request.getPart("CVFile");
        InputStream inputStream = filePart.getInputStream();
        String mimeType = filePart.getContentType();
        if (mimeType.startsWith("image/") && filePart.getSize() < 3000000) {

            String buildPath = request.getServletContext().getRealPath("/");
            File webFolder = new File(buildPath).getParentFile().getParentFile();
            String uploadPath = webFolder.getAbsolutePath() + "/web/img/cvs";
            String savedRelativePath = ImageUtil.saveImage(filePart, uploadPath, "cvs");

            boolean success = cvdao.addCV(fullName, address, email, position, numberExp, education,
                    field, currentSalary, birthday, candidateId, nationality, gender, savedRelativePath, mimeType);

            if (success) {
                request.setAttribute("successMessage", "Lưu CV thành công");
                request.getRequestDispatcher("candidateCV_view/fillCVInfo.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Lưu CV thất bại");
                request.getRequestDispatcher("candidateCV_view/fillCVInfo.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("message", "Bạn cần chọn file ảnh(.png, jpg) nhỏ hơn 1MB để đăng lên");
            request.getRequestDispatcher("candidateCV_view/fillCVInfo.jsp").forward(request, response);
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
