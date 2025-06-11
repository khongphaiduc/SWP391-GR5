// pham truung duc lần cuối test 10:07  28/5/2025
package Controller_Log;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.*;

@WebServlet(name = "GetForgetPassword", urlPatterns = {"/GetForgetPassword"})
public class GetForgetPassword extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GetForgetPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetForgetPassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // ptrungduc1011@gmail.com
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgetPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String status = " ";
            String mail = request.getParameter("email");


            RegisterCandidateUser candidateDAO = new RegisterCandidateUser();
            RegisterEmployerUser employerDAO = new RegisterEmployerUser();

            // kiểm tra tồn tồn tại bên Candidate trước 
            if (candidateDAO.isEmaiCandidateUser(mail)) {
                candidateDAO.resetPasswordByEmailSideCandidate(mail);
                status = "Reset Password Thành Công Vui Lòng Check Mail";
              
                request.setAttribute("status", status);
                request.getRequestDispatcher("forgetPassword.jsp").forward(request, response);
                // kiểm tra bên employers
            } else if (employerDAO.isEmaiEmployerUser(mail)) {
                employerDAO.resetPasswordByEmailSideEmployer(mail);
                status = "Reset Password Thành Công Vui Lòng Check Mail";
               
                request.setAttribute("status", status);
                request.getRequestDispatcher("forgetPassword.jsp").forward(request, response);
            } else {
                status = "Email chưa được đăng ký với hệ thống !";
                request.setAttribute("status", status);
                request.getRequestDispatcher("forgetPassword.jsp").forward(request, response);
            }

        } catch (Exception s) {
            request.getRequestDispatcher("forgetPassword.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
