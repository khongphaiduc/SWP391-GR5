/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Dashboard;

import DAO.CandidateDAO;
import DAO.EmployerDAO;
import DAO.OrderDAO;
import DAO.PromotionDAO;
import DAO.ServiceDAO;
import Models.CV;
import Models.Candidate;
import Models.Employer;
import Models.Order;
import Models.Promotion;
import Models.Service;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class adminService extends HttpServlet {

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
            out.println("<title>Servlet adminService</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminService at " + request.getContextPath() + "</h1>");
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
        if (session.getAttribute("role").equals("Admin")) {
            ServiceDAO serviceDAO = new ServiceDAO();

            // Lấy danh sách tất cả dịch vụ
            List<Service> serviceList = serviceDAO.getAllService();

            OrderDAO dao = new OrderDAO();
            List<Order> orders = dao.getAllOrdersWithEmployerAndService();
            request.setAttribute("orders", orders);
            
            //paging
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

            int totalCV = serviceList.size();
            int totalPages = (int) Math.ceil((double) totalCV / pageSize);
            int fromIndex = (page - 1) * pageSize;
            int toIndex = Math.min(fromIndex + pageSize, totalCV);

            if (fromIndex >= totalCV) {
                fromIndex = 0;
                toIndex = Math.min(pageSize, totalCV);
                page = 1;
            }

            List<Service> paginatedList = serviceList.subList(fromIndex, toIndex);


            request.setAttribute("serviceList", paginatedList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("Admin_view/adminService.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);

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
