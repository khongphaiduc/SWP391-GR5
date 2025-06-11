package Controller_CV;

import DAO.CVDAO;
import DAO.paginationDAO;
import Models.CV;
import Models.Employer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@MultipartConfig
public class paginationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    //int employerId = (int) request.getSession().getAttribute("employerId");
    int employerId = 1;
    // Lấy thông số phân trang từ request
    int page = 1;
    int pageSize = 5; // mặc định 5 CV/trang
    String pageParam = request.getParameter("page");
    if (pageParam != null) {
        page = Integer.parseInt(pageParam);
    }

    // Lấy toàn bộ CV đã ứng tuyển vào công ty
    CVDAO cvDAO = new CVDAO();
    List<CV> allCVs = cvDAO.getAppliedCVsByEmployer(employerId);

    // Tổng số CV
    int totalCVs = allCVs.size();

    // Tổng số trang
    int totalPage = (int) Math.ceil((double) totalCVs / pageSize);

    // Tính vị trí bắt đầu và kết thúc trong danh sách
    int startIndex = (page - 1) * pageSize;
    int endIndex = Math.min(startIndex + pageSize, totalCVs);

    // Lấy danh sách con cho trang hiện tại
    List<CV> appliedCVs = allCVs.subList(startIndex, endIndex);

    // Gửi dữ liệu sang JSP
    request.setAttribute("appliedCVs", appliedCVs);
    request.setAttribute("currentPage", page);
    request.setAttribute("totalPage", totalPage);
    request.setAttribute("totalCVs", totalCVs);
    request.setAttribute("startIndex", startIndex);
    request.setAttribute("endIndex", endIndex);

    request.getRequestDispatcher("view-applied-cvs.jsp").forward(request, response);
}
}
