/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlller_Stattictis;

import DAO.StatictisDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import com.google.gson.Gson;
import java.time.LocalDate;

@WebServlet(name = "StatictisData", urlPatterns = {"/StatictisData"})
public class StatictisData extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StatictisData</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StatictisData at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            LocalDate currentDate = LocalDate.now();
            String yearString = request.getParameter("year");
            int year;
            if (yearString == null) {
                year = currentDate.getYear();
            }else{
                year = Integer.parseInt(yearString);
            }

            

            int currentMonth = currentDate.getMonthValue(); // Lấy tháng hiện tại (1 - 12)

            StatictisDAO myStatictis = new StatictisDAO();
            List<Integer> ListDataRegisterOfCandidate = myStatictis.GetStatictisNumberCandidate(year);
            List<Integer> ListDataRegisterOfEmployer = myStatictis.GetStatictisNumberEmployer(year);
            List<Integer> ListDataNumberJobPostOfYear = myStatictis.StatictisNumberJobPostOfYear(year);
            List<Double> ListProFix = myStatictis.StatisticProfixOfYear(year);
            List<Integer> ListReportOfYear = myStatictis.StatictisNumberReportfYear(year);

            double totalProfix = myStatictis.TotalProfix(ListProFix);
            int numberCandidateCurrent = myStatictis.GetNumberOfNewRegisterCadidate(currentMonth, year);
            int numberEmployerCurrent = myStatictis.GetNumberOfNewRegisterEmployer(currentMonth, year);
            int numerJobPostInCurrentMonth = myStatictis.GetNumberJobPost(currentMonth, year);

            String candidateJson = new Gson().toJson(ListDataRegisterOfCandidate);        // đăng ký  mới candidate
            String employerJson = new Gson().toJson(ListDataRegisterOfEmployer);         // thằng đăng ký mới employuer
            String StatictisProFix = new Gson().toJson(ListProFix);                     // doanh thu
            String StatictisJobPost = new Gson().toJson(ListDataNumberJobPostOfYear);  // số lượng tin tuyển dụng        
            String StatictisReport = new Gson().toJson(ListReportOfYear);

            request.setAttribute("candidateJson", candidateJson);
            request.setAttribute("employerJson", employerJson);
            request.setAttribute("StatictisProFix", StatictisProFix);
            request.setAttribute("StatictisJobPost", StatictisJobPost);
            request.setAttribute("StatictisReport", StatictisReport);

            request.setAttribute("numberCandidateCurrent", numberCandidateCurrent);
            request.setAttribute("numberEmployerCurrent", numberEmployerCurrent);
            request.setAttribute("numerJobPostInCurrentMonth", numerJobPostInCurrentMonth);
            request.setAttribute("totalProfix", totalProfix);
            request.getRequestDispatcher("Statictis/StatisticGeneral.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("Đã xảy ra lỗi cmnr ở Statictis :"+e.getMessage());
            request.getRequestDispatcher("Statictis/StatisticGeneral.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
