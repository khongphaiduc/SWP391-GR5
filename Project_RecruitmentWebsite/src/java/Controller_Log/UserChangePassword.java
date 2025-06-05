// pham trung duc
package Controller_Log;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.*;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UserChangePassword", urlPatterns = {"/UserChangePassword"})
public class UserChangePassword extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserChangePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserChangePassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/log/ChangePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
           
            RegisterCandidateUser candidateDAO = new RegisterCandidateUser();
            RegisterEmployerUser employerDAO = new RegisterEmployerUser();
            String status = " ";
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            String username = " ";
            HttpSession session = request.getSession(false); // false => không tạo mới
            if (session != null) {
                username = (String) session.getAttribute("username");     // lấy session
            }

            if (!confirmPassword.equals(newPassword)) {
                status = "Mật khẩu không khớp";
                request.setAttribute("status", status);
                request.getRequestDispatcher("log/ChangePassword.jsp").forward(request, response);
            } else {

                // kiểm tra accountName nằm bên nào 
                if (candidateDAO.isCandidatetNameUser(username)) {

                    boolean result = candidateDAO.changePasswordCandidate(username, oldPassword, newPassword);

                    if (result) {
                        status = "Thay đổi mật khẩu thành công";
                        request.setAttribute("status", status);
                        request.getRequestDispatcher("log/ChangePassword.jsp").forward(request, response);
                    } else {
                        status = "Mật Khẩu Cũ Không Đúng";
                        request.setAttribute("status", status);
                        request.getRequestDispatcher("log/ChangePassword.jsp").forward(request, response);
                    }

                } else if (employerDAO.isEmployertUser(username)) {
                    boolean result = employerDAO.changePasswordEmployer(username, oldPassword, newPassword);

                    if (result) {
                        status = "Thay đổi mật khẩu thành công";
                        request.setAttribute("status", status);
                        request.getRequestDispatcher("log/ChangePassword.jsp").forward(request, response);
                    } else {
                        status = "Mật Khẩu Cũ Không Đúng";
                        request.setAttribute("status", status);
                        request.getRequestDispatcher("log/ChangePassword.jsp").forward(request, response);
                    }
              } 
                
                else
                {
                    status = "Ối rồi ôi đã có rắc rối \n Vui lòng thử lại sau khi hệ thông của chúng tôi hoạt động trở lại !";
                    request.setAttribute("status", status);
                    request.getRequestDispatcher("log/ChangePassword.jsp").forward(request, response);
                }

            }

        } catch (Exception s) {
            request.getRequestDispatcher("/log/ChangePassword.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
