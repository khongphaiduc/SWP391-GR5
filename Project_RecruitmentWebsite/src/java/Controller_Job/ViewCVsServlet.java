package Controller_Job;

import DAO.CVDAO;
import Models.CV;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/view-cvs")
public class ViewCVsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Gán tạm employerId và jobPostId để test
        int employerId = 1;
        int jobPostId = 1;

        CVDAO dao = new CVDAO();
        List<CV> cvList = dao.getSecureCVsByJobPost(jobPostId, employerId);

        if (cvList.isEmpty()) {
            request.setAttribute("error", "Không có CV nào được ứng tuyển hoặc bài đăng không thuộc bạn.");
        } else {
            request.setAttribute("cvList", cvList);
        }

        request.getRequestDispatcher("/view-cvs.jsp").forward(request, response);
    }
}
        