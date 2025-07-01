/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Dashboard;

import DAO.CandidateDAO;
import DAO.EmployerDAO;
import Models.Candidate;
import Models.Employer;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

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

        EmployerDAO employerDAO = new EmployerDAO();
        CandidateDAO candidateDAO = new CandidateDAO();

        // Tính tổng số người dùng
        int totalCan = candidateDAO.getAllCandidates().size();
        int totalEmp = employerDAO.getAllEmployers().size();
        int totalUser = totalCan + totalEmp;

        // Lấy tham số từ request
        String type = request.getParameter("type"); // Loại user: employer | candidate
        String search = request.getParameter("search"); // Từ khóa tìm kiếm
        int page = 1;
        int recordsPerPage = 10;

        // Xử lý tham số page
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Tính offset cho phân trang
        int offset = (page - 1) * recordsPerPage;

        // Danh sách để lưu kết quả
        List<Employer> employers = new ArrayList<>();
        List<Candidate> candidates = new ArrayList<>();
        int totalRecords = 0;

        // Xử lý tìm kiếm và phân trang
        if (search != null && !search.trim().isEmpty()) {
            if ("employer".equals(type)) {
                employers = employerDAO.searchEmployersByName(search, offset, recordsPerPage);
                totalRecords = employerDAO.getTotalEmployersByName(search);
                request.setAttribute("employers", employers);
            } else if ("candidate".equals(type)) {
                candidates = candidateDAO.searchCandidatesByName(search, offset, recordsPerPage);
                totalRecords = candidateDAO.getTotalCandidatesByName(search);
                request.setAttribute("candidates", candidates);
            } else {
                // Nếu không có type, tìm kiếm cả employer và candidate
                employers = employerDAO.searchEmployersByName(search, offset, recordsPerPage);
                candidates = candidateDAO.searchCandidatesByName(search, offset, recordsPerPage);
                totalRecords = employerDAO.getTotalEmployersByName(search) + candidateDAO.getTotalCandidatesByName(search);
                request.setAttribute("employers", employers);
                request.setAttribute("candidates", candidates);
            }
        } else {
            // Nếu không có từ khóa tìm kiếm, trả về danh sách rỗng hoặc chuyển hướng
            if ("employer".equals(type)) {
                totalRecords = totalEmp;
            } else if ("candidate".equals(type)) {
                totalRecords = totalCan;
            } else {
                totalRecords = totalEmp + totalCan;
            }
            request.setAttribute("employers", employers);
            request.setAttribute("candidates", candidates);
        }

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        // Đặt các thuộc tính vào request để JSP sử dụng
        request.setAttribute("totalCan", totalCan);
        request.setAttribute("totalEmp", totalEmp);
        request.setAttribute("totalUsers", totalUser);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("type", type);
        request.setAttribute("search", search);

        // Chuyển tiếp đến JSP
        request.getRequestDispatcher("viewuser.jsp").forward(request, response);
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
        doGet(request, response); // Chuyển hướng POST về GET
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to search employers and candidates with pagination";
    }
}