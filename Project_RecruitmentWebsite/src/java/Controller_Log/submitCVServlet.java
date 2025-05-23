/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Log;

import DAO.CVDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
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
        processRequest(request, response);
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
        double currentSalary = Double.parseDouble(request.getParameter("currentSalary"));
        Date birthday = Date.valueOf(request.getParameter("birthday"));
        String nationality = request.getParameter("nationality");
        String gender = request.getParameter("gender");

        Part filePart = request.getPart("CVFile");
        InputStream inputStream = filePart.getInputStream();
        String mimeType = filePart.getContentType(); 

//        PrintWriter out = response.getWriter();
        CVDAO cvdao = new CVDAO();
        if (cvdao.addCV(fullName, address, email, position, numberExp, education, 
                field, currentSalary, birthday, nationality, gender, inputStream, mimeType)) {
            request.setAttribute("message", "Lưu CV thành công");
            request.getRequestDispatcher("fillCVInfo.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Lưu CV thất bại");
            request.getRequestDispatcher("fillCVInfo.jsp").forward(request, response);
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
