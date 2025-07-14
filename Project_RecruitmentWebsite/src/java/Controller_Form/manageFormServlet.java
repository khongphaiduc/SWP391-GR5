/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Form;

import DAO.EmployerDAO;
import DAO.FormDAO;
import DAO.OrderDAO;
import DAO.QuestionDAO;
import Models.Form;
import Models.Question;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author PC
 */
public class manageFormServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet manageFormServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet manageFormServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession();
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            String action = req.getParameter("action");
            if (username == null || !"Employer".equals(role)) {
                req.getRequestDispatcher("log/login.jsp").forward(req, resp);
                return;
            } else {
                EmployerDAO employerDAO = new EmployerDAO();

                FormDAO formDAO = new FormDAO();
                List<Form> forms = formDAO.getFormsByEmployerId(employerDAO.getEmployerByName(username).getEmployerId());

                req.setAttribute("forms", forms);
                if (action != null) {
                    if (action.equals("choose")) {
                        req.setAttribute("email", req.getParameter("email"));
                        req.getRequestDispatcher("form_view/choose_form.jsp").forward(req, resp);

                    }
                }
                req.getRequestDispatcher("form_view/manage_forms.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi: " + e.getMessage());
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        FormDAO formDAO = new FormDAO();
        if (action.equals("view")) {
            int formId = Integer.parseInt(request.getParameter("formId"));
            try {
                QuestionDAO questionDAO = new QuestionDAO();
                List<Question> questions = questionDAO.getQuestionsByFormId(formId);
                request.setAttribute("formId", formId);

                Form form = formDAO.getFormsById(formId);
                request.setAttribute("form", form);
                request.getRequestDispatcher("/form_view/preview_form.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (action.equals("edit")) {

        } else if (action.equals("Delete")) {
            int formId = Integer.parseInt(request.getParameter("formId"));
            formDAO.deleteForm(formId);
            response.sendRedirect(request.getContextPath() + "/manageForm");
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
