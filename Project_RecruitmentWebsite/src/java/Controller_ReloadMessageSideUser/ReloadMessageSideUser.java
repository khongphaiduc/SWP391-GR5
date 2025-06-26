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

@WebServlet(name = "ReloadMessageSideUser", urlPatterns = {"/ReloadMessageSideUser"})
public class ReloadMessageSideUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReloadMessageSideUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReloadMessageSideUser at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try {
            String user = request.getParameter("username");
            String support = "ducadmin";  // hoặc có thể linh động theo hệ thống

            GetMessageTwoSide messagedao = new GetMessageTwoSide();

            List<Message> messages = messagedao.getMessagesBetween(user, support);

            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();

            for (Message msg : messages) {
                arrayBuilder.add(Json.createObjectBuilder()
                        .add("from", msg.getFrom())
                        .add("message", msg.getMessage())
                        .add("avatar", msg.getImage()));
            }       
            response.setContentType("application/json");
            response.getWriter().write(arrayBuilder.build().toString());
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
