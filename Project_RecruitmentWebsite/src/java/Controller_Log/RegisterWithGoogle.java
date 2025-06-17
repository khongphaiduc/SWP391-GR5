package Controller_Log;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.*;
import Models.*;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RegisterWithGoogle", urlPatterns = {"/RegisterWithGoogle"})
public class RegisterWithGoogle extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterWithGoogle</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterWithGoogle at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // thằng get thì đăng ký candidate
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            RegisterCandidateUser candidate = new RegisterCandidateUser();

            GoogleInfo userInfo = (GoogleInfo) session.getAttribute("infoUser");
            String role = request.getParameter("role");

            // case thằng user chọn candidate
            if (role.equals("Candidate")) {
                candidate.RegisterCandidateByGoogle(userInfo.getEmail());
                session.setAttribute("role", "Candidate");
                session.setAttribute("username", candidate.getNamAcountByEmailofCandidate(userInfo.getEmail()));  // lấy tên đang nhập của mail
                session.setAttribute("idUser", candidate.getIDbyAccountNameCandidate(candidate.getNamAcountByEmailofCandidate(userInfo.getEmail())));
                response.sendRedirect("Index");
            } else {

            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }

    // thằng get thì đăng ký employer
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            RegisterEmployerUser employer = new RegisterEmployerUser();
            String name = request.getParameter("fullname");
            String phoneNumber = request.getParameter("phone");
            String companyName = request.getParameter("company");
            String location = request.getParameter("location");

            GoogleInfo userInfo = (GoogleInfo) session.getAttribute("infoUser");

            // check thằng số điện thoại
            if (employer.isPhoneNumberEmployer(phoneNumber)) {
                request.setAttribute("inform", "Số điện thoại này đã được sử dụng với 1 tài khoản khác ");
                request.setAttribute("fullname", name);
                request.setAttribute("company", companyName);
                request.setAttribute("location", location);
                request.getRequestDispatcher("log/FormEmployer.jsp").forward(request, response);
                return;
            }

            boolean result = employer.RegisterEmployerByGoogle(userInfo.getEmail(), name, phoneNumber, companyName, location);

            System.out.println(result == true ? "đăng ký thành công " : "đang ký thất bại ");

            session.setAttribute("role", "Employer");
            session.setAttribute("username", employer.getNamAcountByEmailofEmployer(userInfo.getEmail()));  // lấy tên đang nhập của mail
            session.setAttribute("idUser", employer.getIDbyAccountNameEmployer(employer.getNamAcountByEmailofEmployer(userInfo.getEmail())));
            response.sendRedirect("Index");

        } catch (Exception e) {
            System.out.println(e.getMessage());
            response.sendRedirect("log/login.jsp");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
