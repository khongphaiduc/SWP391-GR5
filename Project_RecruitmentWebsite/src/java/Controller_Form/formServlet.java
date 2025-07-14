/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller_Form;

import DAO.CVDAO;
import DAO.CandidateDAO;
import DAO.EmployerDAO;
import DAO.FormDAO;
import DAO.QuestionDAO;
import Models.CV;
import Models.Candidate;
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
public class formServlet extends HttpServlet {

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
            out.println("<title>Servlet formServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet formServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username != null && "Employer".equals(session.getAttribute("role"))) {
            request.getRequestDispatcher("form_view/form_creator.jsp").forward(request, response);

        }
        request.getRequestDispatcher("login.jsp").forward(request, response);

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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String username = (String) session.getAttribute("username");

        EmployerDAO employerDAO = new EmployerDAO();

        int employerID=employerDAO.getEmployerByName(username).getEmployerId();

        String title = req.getParameter("formTitle");
        String[] questions = req.getParameterValues("questionText");
        String[] types = req.getParameterValues("questionType");
        String[] answers = req.getParameterValues("answer");

        Form form = new Form(title, employerID);
        for (int i = 0; i < questions.length; i++) {
            form.addQuestion(new Question(questions[i], types[i], answers[i]));
        }

        try {
            FormDAO formDAO = new FormDAO();
            QuestionDAO questionDAO = new QuestionDAO();

            int formId = formDAO.saveForm(form);
            for (Question q : form.getQuestions()) {
                questionDAO.saveQuestion(q, formId);
            }

            req.setAttribute("form", form);
            req.setAttribute("succes", "Tạo form thành công");
            req.getRequestDispatcher("form_view/form_creator.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi khi lưu form: " + e.getMessage());
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
