package Controller_ServicePackage;

import DAO.ServiceDAO;
import Models.Service;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ServiceForEmpServlet", urlPatterns = {"/service-for-emp"})
public class ServiceForEmpServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Tạo DAO và lấy các dịch vụ đang hiển thị (Is_Visible = 1)
        ServiceDAO dao = new ServiceDAO();
        List<Service> serviceList = dao.getVisibleServicesForEmployer();

        // Đưa danh sách vào request scope
        request.setAttribute("services", serviceList);

        // Forward tới trang JSP hiển thị dịch vụ dành cho Employer
        request.getRequestDispatcher("/page_service/servicePackageEmp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu cần hỗ trợ POST (tìm kiếm, filter), bạn có thể thêm xử lý tại đây.
        doGet(request, response); // Tạm thời chuyển về GET
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị các gói dịch vụ dành cho Employer (chỉ dịch vụ đang hoạt động)";
    }
}
