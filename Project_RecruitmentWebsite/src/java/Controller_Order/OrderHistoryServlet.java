/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Order;

import DAO.EmployerDAO;
import DAO.OrderDAO;
import Models.JobPost;
import Models.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author PC
 */
public class OrderHistoryServlet extends HttpServlet {

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
            out.println("<title>Servlet OrderHistoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderHistoryServlet at " + request.getContextPath() + "</h1>");
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
        } else {
            String serviceIdStr = request.getParameter("serviceId");
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");

            Integer serviceId = null;
            if (serviceIdStr != null && !serviceIdStr.isEmpty()) {
                try {
                    serviceId = Integer.parseInt(serviceIdStr);
                } catch (NumberFormatException e) {
                    // bỏ qua hoặc log
                }
            }

            java.sql.Date fromDate = null;
            java.sql.Date toDate = null;
            try {
                if (fromDateStr != null && !fromDateStr.isEmpty()) {
                    fromDate = java.sql.Date.valueOf(fromDateStr);
                }
                if (toDateStr != null && !toDateStr.isEmpty()) {
                    toDate = java.sql.Date.valueOf(toDateStr);
                }
            } catch (IllegalArgumentException e) {
                // log lỗi hoặc bỏ qua
            }
            List<Order> orders = new ArrayList<>();
            OrderDAO dao = new OrderDAO();
          
            EmployerDAO employerDAO = new EmployerDAO();
            int employerId = employerDAO.getEmployerByName(username).getEmployerId();
            try {
                orders = dao.getOrdersByFiltersEmp(fromDate, toDate, serviceId, employerId);
            } catch (SQLException ex) {
                Logger.getLogger(OrderHistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            //paging
            String pageParam = request.getParameter("page");
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
            int pageSize = 5;
            if (session.getAttribute("pageSize") != null) {
                pageSize = (int) (session.getAttribute("pageSize"));
            }
            if (request.getParameter("pageSize") != null) {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            }
            session.setAttribute("pageSize", pageSize);
            int totalJob = orders.size();
            int totalPages = (int) Math.ceil((double) totalJob / pageSize);
            int fromIndex = (page - 1) * pageSize;
            int toIndex = Math.min(fromIndex + pageSize, totalJob);

            if (fromIndex >= totalJob) {
                fromIndex = 0;
                toIndex = Math.min(pageSize, totalJob);
                page = 1;
            }

            List<Order> paginatedList = orders.subList(fromIndex, toIndex);

            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.setAttribute("orders", paginatedList);
            request.getRequestDispatcher("order_view/order_history.jsp").forward(request, response);
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

        OrderDAO orderDAO = new OrderDAO();
        try {
            orderDAO.deleteOrderById(Integer.parseInt(request.getParameter("orderId")));
        } catch (SQLException ex) {
            Logger.getLogger(OrderHistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect(request.getContextPath() + "/OrderHistory");

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
