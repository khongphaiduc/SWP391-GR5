package Controller_Profile;

import Models.Candidate;
import DAO.CandidateDAO;
import DAO.RegisterCandidateUser;
import DAO.RegisterEmployerUser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for handling candidate profile operations Supports both displaying
 * and updating candidate profile information
 */
@MultipartConfig
public class candidateProfileServlet extends HttpServlet {

    private CandidateDAO candidateDAO = new CandidateDAO();
    private RegisterCandidateUser rCandidateDAO = new RegisterCandidateUser();

    /**
     * Handles GET requests - displays candidate profile
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"Candidate".equals(role)) {
            request.getRequestDispatcher("log/login.jsp").forward(request, response);
            return;
        } else {
            Candidate candidate = candidateDAO.getCandidateByName(username);

            request.setAttribute("candidate", candidate);
            request.getRequestDispatcher("/log/profile.jsp").forward(request, response);
        }

    }

    /**
     * Handles POST requests - updates candidate profile
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"Candidate".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/log/login.jsp");
            return;
        }

        Candidate candidate = candidateDAO.getCandidateByName(username);

        try {
            String candidateName = getParameterSafely(request, "candidateName");
            String email = getParameterSafely(request, "email");
            String address = getParameterSafely(request, "address");
            String nationality = getParameterSafely(request, "nationality");
            String birthdayStr = getParameterSafely(request, "birthday");

            if (rCandidateDAO.isCandidatetNameUser(candidateName) && !candidateName.equals(username)) {
                throw new IllegalArgumentException("Tên đăng nhập đã tồn tại");
            }
            if (rCandidateDAO.isEmaiCandidateUser(email) && !email.equals(candidate.getEmail())) {
                throw new IllegalArgumentException("Email đã tồn tại");
            }

            if (isEmptyOrNull(candidateName) || isEmptyOrNull(email)
                    || isEmptyOrNull(address) || isEmptyOrNull(nationality)) {
                throw new IllegalArgumentException("Vui lòng điền đầy đủ thông tin bắt buộc");
            }

            if (!isValidEmail(email)) {
                throw new IllegalArgumentException("Định dạng email không hợp lệ");
            }

            Date birthday = null;
            if (!isEmptyOrNull(birthdayStr)) {
                birthday = parseDate(birthdayStr);
                if (!isValidAge(birthday)) {
                    throw new IllegalArgumentException("Tuổi phải từ 16 đến 65 tuổi");
                }
            }

            candidate.setCandidateName(candidateName.trim());
            candidate.setEmail(email.trim().toLowerCase());
            candidate.setAddress(address.trim());
            candidate.setNationality(nationality.trim());
            candidate.setBirthday(birthday);

            Part avatarPart = request.getPart("avatar");
            if (avatarPart != null && avatarPart.getSize() > 0) {
                InputStream inputStream = avatarPart.getInputStream();
                candidate.setAvatar(inputStream);
            }

            boolean updateSuccess = candidateDAO.updateCandidate(candidate);

            request.setAttribute("candidate", candidate);
            if (updateSuccess) {
                session.setAttribute("candidate", candidate);
                request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
            }

        } catch (IllegalArgumentException ex) {
            // Gửi lỗi về JSP
            request.setAttribute("candidate", candidate);
            request.setAttribute("errorMessage", ex.getMessage());
        }

        // Hiển thị lại trang hồ sơ
        request.getRequestDispatcher("/log/profile.jsp").forward(request, response);
    }

    /**
     * Process avatar file upload
     */
    private byte[] processAvatarUpload(Part avatarPart) throws IOException, ServletException {
        // Validate file size (max 5MB)
        if (avatarPart.getSize() > 5 * 1024 * 1024) {
            throw new IllegalArgumentException("File ảnh không được vượt quá 5MB");
        }

        // Validate content type
        String contentType = avatarPart.getContentType();
        if (!isValidImageType(contentType)) {
            throw new IllegalArgumentException("Chỉ chấp nhận file ảnh (JPG, PNG, GIF)");
        }

        // Read file data
        try (InputStream inputStream = avatarPart.getInputStream()) {
            return inputStream.readAllBytes();
        }
    }

    /**
     * Validate image content type
     */
    private boolean isValidImageType(String contentType) {
        return contentType != null && (contentType.equals("image/jpeg")
                || contentType.equals("image/jpg")
                || contentType.equals("image/png")
                || contentType.equals("image/gif"));
    }

    /**
     * Parse date string to SQL Date
     */
    private Date parseDate(String dateStr) {
        if (isEmptyOrNull(dateStr)) {
            return null;
        }

        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            formatter.setLenient(false);
            java.util.Date utilDate = formatter.parse(dateStr);
            return new Date(utilDate.getTime());
        } catch (ParseException e) {
            throw new IllegalArgumentException("Định dạng ngày sinh không hợp lệ");
        }
    }

    /**
     * Validate age is between 16 and 65
     */
    private boolean isValidAge(Date birthday) {
        if (birthday == null) {
            return true;
        }

        long currentTime = System.currentTimeMillis();
        long birthTime = birthday.getTime();
        long ageInMillis = currentTime - birthTime;
        long ageInYears = ageInMillis / (365L * 24 * 60 * 60 * 1000);

        return ageInYears >= 16 && ageInYears <= 65;
    }

    /**
     * Validate email format using regex
     */
    private boolean isValidEmail(String email) {
        if (isEmptyOrNull(email)) {
            return false;
        }

        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        return email.matches(emailRegex);
    }

    /**
     * Safely get parameter from request
     */
    private String getParameterSafely(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        return value != null ? value.trim() : "";
    }

    /**
     * Check if string is null or empty
     */
    private boolean isEmptyOrNull(String str) {
        return str == null || str.trim().isEmpty();
    }

    /**
     * Handle error by forwarding to profile page with error message
     */
    @Override
    public String getServletInfo() {
        return "CandidateProfileServlet - Handles candidate profile display and updates";
    }
}
