package Controller_Action_Menu;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import DAO.*;

@WebServlet(name = "FeedBackSV", urlPatterns = {"/FeedBackSV"})
public class FeedBackSV extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FeedBackSV</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedBackSV at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("ViewActionMenu/Feedback.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            String statusSendFeedback = " ";
            String idUser = (String) session.getAttribute("idUser");
            String roleUser = (String) session.getAttribute("role");

            String title = request.getParameter("titel");
            String content = request.getParameter("content");
            String idAdminSupprt = "1";

            FeedBackDAO feedback = new FeedBackDAO();

            boolean resut = feedback.sendFeedBack(idUser, roleUser, title, content, idAdminSupprt);

            if (resut) {
                statusSendFeedback = "Chúng Tôi Đã Ghi Nhận Ý Kiến Của Bạn !";
                request.setAttribute("statusSendFeedback", statusSendFeedback);
                request.getRequestDispatcher("ViewActionMenu/Feedback.jsp").forward(request, response);
                return;
            } else {
                statusSendFeedback = "Gửi Thất Bại !";
                request.setAttribute("statusSendFeedback", statusSendFeedback);
                request.getRequestDispatcher("ViewActionMenu/Feedback.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            request.getRequestDispatcher("ViewActionMenu/Feedback.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
