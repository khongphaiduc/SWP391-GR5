/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Dashboard;

import DAO.NotificationDAO;
import DAO.OrderDAO;
import DAO.ServiceDAO;
import Models.Notification;
import Models.Order;
import Models.Service;
import MyService.Paging;
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
public class notificationServlet extends HttpServlet {

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
            out.println("<title>Servlet notificationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet notificationServlet at " + request.getContextPath() + "</h1>");
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

        if (username == null || !"Admin".equals(role)) {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);
            return;
        }
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    NotificationDAO dao = new NotificationDAO();
                    Notification notification = dao.getNotificationById(id);
                    request.setAttribute("editingNotification", notification);
                } catch (Exception e) {
                    throw new ServletException(e);
                }
            }
        }

        String serviceIdStr = request.getParameter("serviceId");
        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");

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

        }

        NotificationDAO dao = new NotificationDAO();
        List<Notification> notifications = new ArrayList<>();
        try {
            notifications = dao.getAllNotifications(fromDate, toDate);
        } catch (SQLException ex) {
            Logger.getLogger(notificationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("notifications", Paging.paginate(request, session, notifications, "pageSize"));

        request.getRequestDispatcher("Admin_view/notification.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        int id = 0;
        if (idStr != null) {
            id = Integer.parseInt(idStr);
        }
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String roleTarget = request.getParameter("roleTarget");

        NotificationDAO dao = new NotificationDAO();
        if (action.equals("create")) {
            try {
                Notification n = new Notification();
                n.setTitle(title);
                n.setContent(content);
                n.setRoleTarget(roleTarget);

                dao.addNotification(n);
                response.sendRedirect("notificationServlet");
            } catch (Exception e) {
                throw new ServletException(e);
            }
        } else if (action.equals("delete")) {
            try {
                dao.deleteNotification(id);
                response.sendRedirect("notificationServlet");

            } catch (SQLException ex) {
                Logger.getLogger(notificationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equals("edit")) {
            try {
                Notification n = new Notification();
                n.setId(id);
                n.setTitle(title);
                n.setContent(content);
                n.setRoleTarget(roleTarget);

                dao.updateNotification(n);
                response.sendRedirect("notificationServlet");
            } catch (Exception e) {
                throw new ServletException(e);
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
        return "Short description";
    }// </editor-fold>

}
