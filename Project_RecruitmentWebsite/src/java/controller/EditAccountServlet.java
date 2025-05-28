/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Models.Account;

/**
 *
 * @author Admin
 */
@WebServlet(name="EditAccountServlet", urlPatterns={"/editAccount"})
public class EditAccountServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet EditAccountServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditAccountServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
       String id_raw = request.getParameter("id");

    try {
        int id = Integer.parseInt(id_raw);
        AccountDAO dao = new AccountDAO();
        Account acc = dao.getAccountById(id); // ← cần có hàm này trong DAO

        if (acc != null) {
            request.setAttribute("account", acc);
            request.getRequestDispatcher("edituser.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Account not found");
        }
    } catch (NumberFormatException e) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid account ID");
    }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
            AccountDAO d = new AccountDAO();
           String accountId = request.getParameter("id");
        String accountName = request.getParameter("username");
        String passwordHash = request.getParameter("password");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        // Kiểm tra dữ liệu hợp lệ
        if (accountId != null && accountName != null && passwordHash != null && email != null && role != null) {
            try {
                // Tạo đối tượng Account
                Account acc = new Account();
                acc.setAccountId(Integer.parseInt(accountId));  // set ID từ form
                acc.setAccountName(accountName);
                acc.setPasswordHash(passwordHash); // Mã hóa mật khẩu trước khi lưu nếu cần
                acc.setEmail(email);
                acc.setRole(role);

                // Gọi DAO để cập nhật tài khoản và nhận kết quả
                boolean updated = d.updateAccount(acc);

                if (updated) {
                    // Nếu cập nhật thành công, chuyển hướng về trang danh sách tài khoản
                    response.sendRedirect("list");  // Trang danh sách tài khoản sau khi cập nhật thành công
                } else {
                    // Nếu không cập nhật được, hiển thị thông báo lỗi và quay lại form sửa
                    request.setAttribute("errorMessage", "Failed to update account.");
                    request.getRequestDispatcher("editAccount.jsp").forward(request, response);
                }

            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Account ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing form data");
        }
    
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
