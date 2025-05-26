package Controller_Log;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.*;
import Validate.ValidationRegister;


@WebServlet(name = "RegisterAccount", urlPatterns = {"/RegisterAccount"})
public class RegisterAccount extends HttpServlet {
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterAccount at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
  
  

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          
    }
    
    
    // đăng ký 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            
            String status = " ";
            String name = request.getParameter("username");
            String email = request.getParameter("email");
            String passwordFist = request.getParameter("password1");
            String passwordSecond = request.getParameter("Password2");
            String role = request.getParameter("role");
            
            RegisterAccount_Database rgt = new RegisterAccount_Database();
            ValidationRegister validation = new ValidationRegister();
            boolean checkAccountName = rgt.isAccountUser(name);
            if (passwordFist.equals(passwordSecond)) {
                request.getRequestDispatcher("login/login.jsp").forward(request, response);
                // check accountName xem nó tồn tại hay chưa
            } else if (checkAccountName) {               
                status = "Tài Khoản đã tồn tại !";                
                request.setAttribute("status", status);
                request.getRequestDispatcher("login/login.jsp").forward(request, response);

                // check Email đã được đăng ký hay chưa
            } else if (rgt.isEmailUser(email)) {                
                status = "Email đã tồn tại !";              
                request.setAttribute("status", status);
                request.getRequestDispatcher("log/login.jsp").forward(request, response);
                
            } else {
                // đăng ký tài khoản

                boolean result = rgt.registerAccount(name, email, validation.getTimeNow(), passwordFist, role);
                
                if (result) {
                    status = "Đăng ký tài khoản thành công ! >3";
                    request.setAttribute("status", status);
                    request.getRequestDispatcher("log/login.jsp").forward(request, response);
                    
                } else {
                    status = "Đăng ký tài khoản không  thành công ! >3";
                }
            }
            
        } catch (Exception s) {
            request.getRequestDispatcher("/log/login.jsp").forward(request, response);
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }
    
}
