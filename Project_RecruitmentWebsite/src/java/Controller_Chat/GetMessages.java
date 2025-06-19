package Controller_Chat;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import DAO_Chat.*;
import Models.LiveChat;
import com.google.gson.Gson;
import java.util.List;

@WebServlet(name = "GetMessages", urlPatterns = {"/GetMessages"})
public class GetMessages extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GetMessages</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetMessages at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            String senderID = request.getParameter("senderID");
            String reciverID = request.getParameter("reciverID");
            int messageID =  Integer.parseInt(request.getParameter("Message_ID"));
            GetMessage loadmessage = new GetMessage();

           List<LiveChat> listMessage = loadmessage.getNewMessages(senderID, reciverID, messageID);

            Gson gson = new Gson();
            String json = gson.toJson(listMessage);

            response.getWriter().write(json);
        } catch (Exception e) {
            response.setStatus(500);
            response.getWriter().write("{\"error\":\"Lỗi khi lấy tin nhắn\"}");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
