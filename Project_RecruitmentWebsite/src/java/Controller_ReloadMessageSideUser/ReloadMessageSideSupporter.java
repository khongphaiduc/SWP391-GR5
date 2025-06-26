package Controller_ReloadMessageSideUser;

import DAO_Chat.GetMessageTwoSide;
import Models.Message;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

// reload lại message  bên support 
@WebServlet(name = "ReloadMessageSideSupporter", urlPatterns = {"/ReloadMessageSideSupporter"})
public class ReloadMessageSideSupporter extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReloadMessageSideSupporter</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReloadMessageSideSupporter at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String user1 = request.getParameter("user1");
            String user2 = request.getParameter("user2");

            GetMessageTwoSide messagedao = new GetMessageTwoSide();

            List<Message> messages = messagedao.getMessagesBetween(user1, user2);

            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();

            for (Message msg : messages) {
                arrayBuilder.add(Json.createObjectBuilder()
                        .add("from", msg.getFrom())
                        .add("message", msg.getMessage())
                        .add("avatar", msg.getImage()));
            }
            response.setContentType("application/json");
            response.getWriter().write(arrayBuilder.build().toString());
            System.out.println("Debug 1 :"+arrayBuilder.toString());
        } catch (Exception e) {
            System.out.println("Bug tại Servlet ReloadMessageSideUser : " + e.getMessage());
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
    }

}
