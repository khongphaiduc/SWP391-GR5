/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Profile;

import DAO.EmployerDAO;
import Models.Employer;
import MyService.JobCategoryProvider;
import MyService.LocationProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.util.ArrayList;

/**
 *
 * @author PC
 */
@MultipartConfig
public class employerProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet employerProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet employerProfileServlet at " + request.getContextPath() + "</h1>");
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
        
        if (username == null || !"Employer".equals(role)) {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);
            return;
        }
        
        try {
            EmployerDAO employerDAO = new EmployerDAO();
            Employer employer = employerDAO.getEmployerByName(username);
            
            if (employer != null) {
                request.setAttribute("employer", employer);
                request.getRequestDispatcher("log/EmployerInfo.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/log/login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
          
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
        String role = (String) session.getAttribute("role");
        
        if (username == null || !"Employer".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/log/login.jsp");
            return;
        }
        
        try {
            String companyName = request.getParameter("companyName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            String website = request.getParameter("urlWebsite");
            
            if (companyName == null || companyName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phoneNumber == null || phoneNumber.trim().isEmpty() ||
                location == null || location.trim().isEmpty() ||
                description == null || description.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc.");
                doGet(request, response); 
                return;
            }
            
            EmployerDAO employerDAO = new EmployerDAO();
            
            if (employerDAO.isEmailExists(email.trim(), username)) {
                request.setAttribute("errorMessage", "Email này đã được sử dụng bởi tài khoản khác.");
                doGet(request, response);
                return;
            }
            
            if (employerDAO.isPhoneExists(phoneNumber.trim(), username)) {
                request.setAttribute("errorMessage", "Số điện thoại này đã được sử dụng bởi tài khoản khác.");
                doGet(request, response);
                return;
            }
            
            
            Part filePart = request.getPart("file");
            
            if (filePart != null && filePart.getSize() > 0) {
                String mimeType = filePart.getContentType();
                
                if (mimeType != null && mimeType.startsWith("image/") && filePart.getSize() < 5000000) { // 5MB limit
                    InputStream inputStream = filePart.getInputStream();
                    
                    boolean updateSuccess = employerDAO.updateEmployer(username, email, description, 
                            location, website, companyName, inputStream, phoneNumber);
                    
                    inputStream.close();
                    
                    if (updateSuccess) {
                        request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
                    } else {
                        request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật thông tin.");
                    }
                } else {
                    request.setAttribute("errorMessage", "File không hợp lệ. Vui lòng chọn file ảnh có kích thước nhỏ hơn 5MB.");
                    doGet(request, response);
                    return;
                }
            } else {
                boolean updateSuccess = employerDAO.updateEmployerWithoutImage(username, email, 
                        description, location, website, companyName, phoneNumber);
                
                if (updateSuccess) {
                    request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
                } else {
                    request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật thông tin.");
                }
            }
            
            Employer employer = employerDAO.getEmployerByName(username);
            request.setAttribute("employer", employer);
            
            request.getRequestDispatcher("log/EmployerInfo.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            
            try {
                EmployerDAO employerDAO = new EmployerDAO();
                Employer employer = employerDAO.getEmployerByName(username);
                request.setAttribute("employer", employer);
                request.getRequestDispatcher("log/EmployerInfo.jsp").forward(request, response);
            } catch (Exception ex) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Employer Profile Management Servlet";
    }// </editor-fold>
}