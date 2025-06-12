/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller_CV;

import DAO.PotentialDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
@WebServlet(name="SavePotentialCVsServlet", urlPatterns={"/save-potential-cvs"})
public class SavePotentialCVsServlet extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int cvId = Integer.parseInt(request.getParameter("cvId"));
            Integer employerId = (Integer) request.getSession().getAttribute("employerId");

            if (employerId == null) {
                request.setAttribute("error", "Bạn cần đăng nhập để thực hiện hành động này.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            PotentialDAO dao = new PotentialDAO();
            if (dao.addPotentialCV(cvId, employerId)) {
                request.setAttribute("message", "Đã save CV khỏi danh sách tiềm năng thành công!");
            } else {
                request.setAttribute("error", "Không thể save CV vào danh sách tiềm năng.");
            }

            response.sendRedirect("potential-cvs");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID CV không hợp lệ.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}