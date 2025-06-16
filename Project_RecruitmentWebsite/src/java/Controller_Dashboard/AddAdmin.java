/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller_Dashboard;

import DAO.AdminDAO;

import Validate.ValidationRegister;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name="AddAdmin", urlPatterns={"/addAdmin"})
public class AddAdmin extends HttpServlet {
   
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
            out.println("<title>Servlet AddAdmin</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddAdmin at " + request.getContextPath () + "</h1>");
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
        processRequest(request, response);
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
         try {
            String status = " ";
            String nameAccount = request.getParameter("username");
    
            String passwordFist = request.getParameter("password1");
            String passwordSecond = request.getParameter("password2");
     

            if (nameAccount.contains(" ")) {
                status = "Tên đăng nhập không được chứa  khoảng trắng  !";
                request.setAttribute("status", status);
                request.getRequestDispatcher("adduser.jsp").forward(request, response);
                return;
            }

            ValidationRegister validation = new ValidationRegister();
             AdminDAO adminDAO = new AdminDAO();
             
              if (adminDAO.isNameUser(nameAccount)) {
                    status = "Tài khoản của bạn đã tồn tại ";
                    request.setAttribute("status", status);
                    request.getRequestDispatcher("adduser.jsp").forward(request, response);

                    // kiểm tra độ dài của password
                } else if (!validation.checkLength(passwordFist)) {
                    status = "Mật khẩu yêu cầu tối thiểu là 8 ký tự !";
                    request.setAttribute("status", status);
                    request.getRequestDispatcher("adduser.jsp").forward(request, response);
                } else if (!passwordFist.equals(passwordSecond)) {
                    status = "Mật khẩu xác nhận không khớp với mật khẩu ban đầu bạn nhập !" + passwordFist + " và " + passwordSecond;
                    request.setAttribute("status", status);
                    request.getRequestDispatcher("adduser.jsp").forward(request, response);
                } else if (!validation.checkChar(passwordFist)) {

                    status = "Mật khẩu cần 8 ký tự và các ký tự đặc biệt";
                    request.setAttribute("status", status);
                    request.getRequestDispatcher("adduser.jsp").forward(request, response);

                } else {
                    // đăng ký

                    boolean result = adminDAO.registerAdmin(nameAccount, passwordFist);

                    if (result) {
                        status = "Đăng ký thành công,mời bạn quay lại để đăng nhập !";
                        request.setAttribute("status", status);
                        response.sendRedirect("list");
                    } 
                    else {
                        status = "ối rồi ồi , đã có rác rồi nên không đăng ký thành công";
                        request.setAttribute("status", status);
                        request.getRequestDispatcher("log/login.jsp").forward(request, response);
                    }

                }
       
            
            
            
         }catch (Exception s) {
            request.getRequestDispatcher("/log/login.jsp").forward(request, response);
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
