package Controller_ReloadMessageSideUser;

import DAO_Chat.getUserListChatWithSupport;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "ReloadUserListSideSupprter", urlPatterns = {"/ReloadUserListSideSupprter"})
public class ReloadUserListSideSupprter extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReloadUserListSideSupprter</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReloadUserListSideSupprter at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            getUserListChatWithSupport dbUserList = new getUserListChatWithSupport();
            String support = request.getParameter("support");  // tìm  những thằng nào đã từng chát với user

            List<String> listUser = dbUserList.getUserListChatWithSupports(support);

            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();

            for (String s : listUser) {
                arrayBuilder.add(Json.createObjectBuilder()
                        .add("id", s)
                        .add("name", s)
                        .add("avatar", " "));
            }
            response.setContentType("application/json");
            response.getWriter().write(arrayBuilder.build().toString());
        } catch (Exception e) {
            System.out.println("Bug tại Servlet ReloadUserListSideSupprter : " + e.getMessage());
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
