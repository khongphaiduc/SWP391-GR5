package Controller_Profile;

import DAO.EmployerDAO;
import Models.Employer;
import MyService.ImageUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

@MultipartConfig
public class employerProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"Employer".equals(role)) {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);
            return;
        }

        try {
            EmployerDAO employerDAO = new EmployerDAO();
            Employer employer = employerDAO.getEmployerByName(username);

            if (employer != null) {
                request.setAttribute("employer", employer);
                request.getRequestDispatcher("log/EmployerInfo.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/log/login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"Employer".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/log/login.jsp");
            return;
        }

        try {
            String companyName = request.getParameter("companyName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            String website = request.getParameter("urlWebsite");
            String taxCode = request.getParameter("taxCode");

            if (companyName == null || companyName.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || phoneNumber == null || phoneNumber.trim().isEmpty()
                    || location == null || location.trim().isEmpty()
                    || description == null || description.trim().isEmpty()
                    || taxCode == null || taxCode.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc.");
                doGet(request, response);
                return;
            }

            EmployerDAO employerDAO = new EmployerDAO();

            if (employerDAO.isEmailExists(email.trim(), username)) {
                request.setAttribute("errorMessage", "Email này đã được sử dụng bởi tài khoản khác.");
                doGet(request, response);
                return;
            }

            if (employerDAO.isPhoneExists(phoneNumber.trim(), username)) {
                request.setAttribute("errorMessage", "Số điện thoại này đã được sử dụng bởi tài khoản khác.");
                doGet(request, response);
                return;
            }

            Part filePart = request.getPart("file");

            boolean updateSuccess;
            if (filePart != null && filePart.getSize() > 0) {
                String mimeType = filePart.getContentType();
                if (mimeType != null && mimeType.startsWith("image/") && filePart.getSize() < 5000000) {
                    Employer oldEmployer = employerDAO.getEmployerByName(username); 
                    String oldImgPath = oldEmployer.getImgLogo(); 

                    String buildPath = request.getServletContext().getRealPath("/");
                    File webFolder = new File(buildPath).getParentFile().getParentFile();
                    String uploadPath = webFolder.getAbsolutePath() + "/web/img/employers";

                    ImageUtil.deleteOldImage(uploadPath.replace("/employers", ""), oldImgPath);


                    response.getWriter().print(uploadPath);
                    String savedRelativePath = ImageUtil.saveImageToWeb(filePart, uploadPath, "employers");

                    updateSuccess = employerDAO.updateEmployer(
                            username, email, description, location,
                            website, companyName, savedRelativePath, phoneNumber, taxCode
                    );

                } else {
                    request.setAttribute("errorMessage", "File không hợp lệ. Vui lòng chọn ảnh nhỏ hơn 5MB.");
                    doGet(request, response);
                    return;
                }
            } else {
                updateSuccess = employerDAO.updateEmployerWithoutImage(
                        username, email, description, location,
                        website, companyName, phoneNumber, taxCode
                );
            }

            if (updateSuccess) {
                request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật thông tin.");
            }

            Employer employer = employerDAO.getEmployerByName(username);
            request.setAttribute("employer", employer);
            request.getRequestDispatcher("log/EmployerInfo.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            try {
                EmployerDAO employerDAO = new EmployerDAO();
                Employer employer = employerDAO.getEmployerByName(username);
                request.setAttribute("employer", employer);
                request.getRequestDispatcher("log/EmployerInfo.jsp").forward(request, response);
            } catch (Exception ex) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Employer Profile Management Servlet";
    }
}
