package Controller_Log;

import MyService.Google;
import Models.*;
import DAO.*;
import Models.GoogleInfo;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LogWithGoogle", urlPatterns = {"/LogWithGoogle"})
public class LogWithGoogle extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LogWithGoogle</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LogWithGoogle at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            RegisterCandidateUser candidate = new RegisterCandidateUser();
            RegisterEmployerUser employer = new RegisterEmployerUser();
            HttpSession session = request.getSession();

            Google mygoogle = new Google();

            String code = request.getParameter("code");

            String accessToken = mygoogle.getToken(code);    // lấy token từ code 

            GoogleInfo infoUser = mygoogle.getUserInfo(accessToken);   // gửi token cho thằng gg và nó gửi về josn và chuyển về object GoogleInfo
            System.out.println("email của bạn là :" + infoUser.getEmail());
            // case cả 2 đã  đăng ký trước đó
            if (candidate.isEmaiCandidateUser(infoUser.getEmail())) {
                session.setAttribute("role", "Candidate");
                session.setAttribute("username", candidate.getNamAcountByEmailofCandidate(infoUser.getEmail()));  // lấy tên đang nhập của mail
                session.setAttribute("idUser", candidate.getIDbyAccountNameCandidate(candidate.getNamAcountByEmailofCandidate(infoUser.getEmail())));
                session.setAttribute("infoUser", infoUser);
                response.sendRedirect("Index");
            } else if (employer.isEmaiEmployerUser(infoUser.getEmail())) {
                session.setAttribute("role", "Employer");
                session.setAttribute("username", employer.getNamAcountByEmailofEmployer(infoUser.getEmail()));
                session.setAttribute("idUser", candidate.getIDbyAccountNameCandidate(employer.getNamAcountByEmailofEmployer(infoUser.getEmail())));
                session.setAttribute("infoUser", infoUser);
                response.sendRedirect("Index");
            } else {
                session.setAttribute("infoUser", infoUser);    // lưu thằng vừa đăng  bằng gg vào session 
                response.sendRedirect("log/ChooesRoleLogWGoogle.jsp");
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
            response.sendRedirect("log/ChooesRoleLogWGoogle.jsp");
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
