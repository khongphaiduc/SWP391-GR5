/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Job;

import DAO.CVDAO;
import Models.CV;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author admin
 */
@WebServlet(name = "SearchCVsServlet", urlPatterns = {"/SearchCVsServlet"})
public class SearchCVsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve parameters from the request
        String keyword = request.getParameter("keyword");
        String employerIdStr = request.getParameter("employerId");
        String address = request.getParameter("address");
        String numberExpStr = request.getParameter("numberExp");
        String position = request.getParameter("position");

        // Validate and parse employerId
        int employerId = 1;
        try {
            employerId = Integer.parseInt(employerIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Employer ID");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // Parse numberExp (optional, can be null)
        Integer numberExp = null;
        if (numberExpStr != null && !numberExpStr.trim().isEmpty()) {
            try {
                numberExp = Integer.parseInt(numberExpStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid Number of Experience");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
        }

        // Initialize CVDAO
        CVDAO cvDao = new CVDAO();

        // Call the searchCVsForEmployer method
        List<CV> appliedCVs = cvDao.searchCVsForEmployer(employerId, address, numberExp, position, keyword);

        //Log
        System.out.println("Số CV tìm thấy: " + appliedCVs.size());

        // Set the results as a request attribute
        request.setAttribute("appliedCVs", appliedCVs);
        request.setAttribute("keyword", keyword);
        request.setAttribute("employerId", employerId);
        request.setAttribute("address", address);
        request.setAttribute("numberExp", numberExp);
        request.setAttribute("position", position);

        // Forward to JSP for display
        request.getRequestDispatcher("/applied-cv-list.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward POST requests to doGet for simplicity
        doGet(request, response);
    }
}
