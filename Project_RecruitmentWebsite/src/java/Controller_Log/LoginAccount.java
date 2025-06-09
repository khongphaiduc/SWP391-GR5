// pham truung duc lần cuối test 10:07  28/5/2025
package Controller_Log;

import DAO.IsAdminDAO;
import DAO.RegisterCandidateUser;
import DAO.RegisterEmployerUser;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginAccount", urlPatterns = {"/LoginAccount"})
public class LoginAccount extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginAccount at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            HttpSession session = request.getSession();

            String status = " ";
            String nameAccount = request.getParameter("username");
            String password = request.getParameter("password");

            RegisterCandidateUser candidateDAO = new RegisterCandidateUser();
            RegisterEmployerUser employerDAO = new RegisterEmployerUser();
            IsAdminDAO adminDAO = new IsAdminDAO();
            // kiểm tra xem có tồn tại trong Candidate trước          
            if (candidateDAO.isCandidatetNameUser(nameAccount)) {

                boolean result = candidateDAO.LogInAccountCandidate(nameAccount, password);
                String idCandidate = candidateDAO.getIDbyAccountNameCandidate(nameAccount);
                if (result) {
                    session.setAttribute("username", nameAccount);   // lưu account name 
                    session.setAttribute("role", "Candidate");       // lưu id
                    session.setAttribute("idUser", idCandidate);     // lưu role
                    response.sendRedirect("Index");
                } else {
                    status = "Tài Khoản hoặc Mật khẩu của bạn không chính xác";
                    request.setAttribute("status", status);
                    request.setAttribute("username", nameAccount);
                    request.getRequestDispatcher("/log/login.jsp").forward(request, response);
                }
                // Kiểm tra xem trong employerr
            } else if (employerDAO.isEmployertUser(nameAccount)) {

                boolean result = employerDAO.LogInAccountEmployers(nameAccount, password);
                String idEmployer = employerDAO.getIDbyAccountNameEmployer(nameAccount);
                if (result) {
                    session.setAttribute("username", nameAccount);
                    session.setAttribute("idUser", idEmployer);
                    session.setAttribute("role", "Employer");
                    response.sendRedirect("Index");
                } else {
                    status = "Tài Khoản hoặc Mật khẩu của bạn không chính xác";
                    request.setAttribute("username", nameAccount);
                    request.setAttribute("status", status);
                    request.getRequestDispatcher("/log/login.jsp").forward(request, response);
                }
            } // kiểm tra  role admin
            else if (adminDAO.isAdmin(nameAccount)) {

                boolean result = adminDAO.LogInAccountAdmin(nameAccount, password);
                if (result) {
                    session.setAttribute("username", nameAccount);
                    session.setAttribute("role", "Admin");

                    response.sendRedirect("list"); // sua tu index.jsp chay thang sang ListServlet(se chay den admin dashboard) voi url /list

                } else {
                    status = "Tài Khoản hoặc Mật khẩu của bạn không chính xác";
                    request.setAttribute("username", nameAccount);
                    request.setAttribute("status", status);
                    request.getRequestDispatcher("/log/login.jsp").forward(request, response);
                }
                // cả 3 thằng đều không phải 
            } else {
                status = "Tài Khoản hoặc Mật khẩu của bạn không chính xác";
                request.setAttribute("username", nameAccount);
                request.setAttribute("status", status);
                request.getRequestDispatcher("/log/login.jsp").forward(request, response);
            }

        } catch (Exception s) {
            request.getRequestDispatcher("Index").forward(request, response);
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
