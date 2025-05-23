/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Log;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.*;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UserChangePassword", urlPatterns = {"/UserChangePassword"})
public class UserChangePassword extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserChangePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserChangePassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/log/ChangePassword.jsp").forward(request, response);
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
            RegisterAccount_Database o = new RegisterAccount_Database();

            String status = " ";
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            String username = " ";
            HttpSession session = request.getSession(false); // false => không tạo mới
            if (session != null) {
                username = (String) session.getAttribute("username");     // lấy session
            }

            if (!confirmPassword.equals(newPassword)) {
                status = "Mật khẩu không khớp";
                request.setAttribute("status", status);
                request.getRequestDispatcher("log/ChangePassword.jsp").forward(request, response);
            } else {

                o.changePassword(username, oldPassword, newPassword);  // đỏi mật khẩu theo client 
                status = "Thay đổi mật khẩu thành công";
                request.setAttribute("status", status);
                request.getRequestDispatcher("log/ChangePassword.jsp").forward(request, response);
            }

        } catch (Exception s) {
            request.getRequestDispatcher("/log/ChangePassword.jsp").forward(request, response);
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
