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
public class submitFormServlet extends HttpServlet {

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
            out.println("<title>Servlet submitFormServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet submitFormServlet at " + request.getContextPath() + "</h1>");
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

        if (username != null && "Candidate".equals(session.getAttribute("role"))) {
            int formId = Integer.parseInt(request.getParameter("formId"));

            try {
                QuestionDAO questionDAO = new QuestionDAO();
                List<Question> questions = questionDAO.getQuestionsByFormId(formId);
                request.setAttribute("formId", formId);
                request.setAttribute("questions", questions);

                request.getRequestDispatcher("form_view/answer_form.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Lỗi: " + e.getMessage());
            }
        } else {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);

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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int formId = Integer.parseInt(req.getParameter("formId"));
        FormDAO formDAO = new FormDAO();
        EmployerDAO employerDAO = new EmployerDAO();
        int total = Integer.parseInt(req.getParameter("total"));
        int score = 0;

        try {
            QuestionDAO questionDAO = new QuestionDAO();
            List<Question> questions = questionDAO.getQuestionsByFormId(formId);

            for (int i = 0; i < total; i++) {
                String userAnswer = req.getParameter("answer" + i);
                String correct = questions.get(i).getAnswer();
                if (correct != null && correct.equalsIgnoreCase(userAnswer)) {
                    score++;
                }
            }

            req.setAttribute("score", score);
            req.setAttribute("total", total);
//            req.getRequestDispatcher("result.jsp").forward(req, resp);
            String email = employerDAO.getEmployerById(formDAO.getFormsById(formId).getEmployerId()).getEmail();
             String url ="http://localhost:9999/Project_RecruitmentWebsite/answerForm?score="+score+"?total="+total;
                MyService.MyEmail.sendEmail(email, "Bạn có câu trả lời cho form", url);
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Lỗi khi chấm điểm: " + e.getMessage());
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
