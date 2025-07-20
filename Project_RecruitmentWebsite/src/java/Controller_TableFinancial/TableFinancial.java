/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_TableFinancial;

import DAO.FinancialDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Models.*;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
;

@WebServlet(name = "TableFinancial", urlPatterns = {"/TableFinancial"})
public class TableFinancial extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TableFinancial</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TableFinancial at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            HttpSession session = request.getSession();
            
            LocalDate today = LocalDate.now();
            LocalDate lastMonth = today.minusMonths(1);

            String dateStart = request.getParameter("dateStart");
            String dateEnd = request.getParameter("dateEnd");

            // Nếu không có ngày truyền vào thì lấy mặc định
            if (dateStart == null || dateStart.isEmpty()) {
                dateStart = lastMonth.toString(); // yyyy-MM-dd
            }
            if (dateEnd == null || dateEnd.isEmpty()) {
                dateEnd = today.toString();
            }

            String codeTax = request.getParameter("codeTax");

            // Truyền đúng giá trị người dùng chọn vào DAO
            List<FinancialMode> list = new ArrayList();
            FinancialDAO financialDAO = new FinancialDAO();
            list = financialDAO.GetFinancial(dateStart, dateEnd, codeTax);

            double total = 0;

            for (int i = 0; i < list.size(); i++) {
                total += list.get(i).getTotal();
            }

            request.setAttribute("TotalTable", total);
            session.setAttribute("ListFinancial", list);
            request.setAttribute("dateStart", dateStart);
            request.setAttribute("dateEnd", dateEnd);
            request.setAttribute("codeTax", codeTax);
            request.getRequestDispatcher("TableReportFinancial/FinancialReport.jsp").forward(request, response);
        } catch (Exception e) {
            // Nếu lỗi vẫn truyền ngày lên để không vỡ giao diện
            request.setAttribute("dateStart", "");
            request.setAttribute("dateEnd", "");
            request.getRequestDispatcher("TableReportFinancial/FinancialReport.jsp").forward(request, response);
            System.out.println(e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
             
        
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
