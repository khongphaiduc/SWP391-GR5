/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Log;

import DAO.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.OutputStream;
import Models.*;
import dal.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.sql.*;

/**
 *
 * @author PC
 */
@MultipartConfig
public class viewCVServlet extends HttpServlet {

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
            out.println("<title>Servlet viewCVServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet viewCVServlet at " + request.getContextPath() + "</h1>");
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
        int cvId = Integer.parseInt(request.getParameter("cvId"));
        CVDAO cvdao = new CVDAO();

        CV cv = cvdao.getCVById(cvId);

        if (cv != null && cv.getFileData() != null) {
            // Nếu là PDF
//            response.setContentType("application/pdf");

            // Nếu là ảnh, dùng:
//            response.setContentType("image/png");
            //hoặc "image/jpeg" tùy loại
            response.setContentType(cv.getMimeType());

            InputStream inputStream = cv.getFileData();
            OutputStream out = response.getOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = inputStream.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }

            inputStream.close();
            out.flush();
        } else {
            response.getWriter().write("Không tìm thấy CV hoặc file.");
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
        try {
            int cvId = Integer.parseInt(request.getParameter("cvId"));
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
            CVDAO dao = new CVDAO();
            boolean updated = dao.editCVById(cvId, fullName, address, email,
                    position, numberExp, education,
                    field, currentSalary, birthday, nationality, gender, 
                    inputStream,mimeType);
            
//            PrintWriter out = response.getWriter();
//            out.print(updated);
            if (updated) {
                response.sendRedirect("manageCreatedCV"); 
            } else {
                request.setAttribute("error", "Không thể cập nhật CV.");
                request.getRequestDispatcher("editCV.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
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
