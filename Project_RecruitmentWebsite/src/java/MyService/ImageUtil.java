package MyService;

import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

public class ImageUtil {

    // Thư mục chứa ảnh (tương đối với thư mục web)
    private static final String DEFAULT_UPLOAD_DIR = "img";

    
    public static String saveImage(Part part, String uploadRootPath, String subFolder) throws IOException {
        String fileName = extractFileName(part);
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }

        // Tạo tên file duy nhất
        String savedFileName = System.currentTimeMillis() + "_" + fileName;
        String uploadPath = uploadRootPath + File.separator + DEFAULT_UPLOAD_DIR + File.separator + subFolder;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Ghi file
        part.write(uploadPath + File.separator + savedFileName);

        // Trả về đường dẫn tương đối để lưu vào DB
        return subFolder + "/" + savedFileName;
    }

    /**
     * Trích xuất tên file từ Part
     */
    private static String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String s : contentDisp.split(";")) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf('=') + 2, s.length() - 1); // Bỏ dấu "
            }
        }
        return null;
    }

    /**
     * Trả về URL ảnh tương đối dùng cho <img>
     */
    public static String getImageUrl(String relativePath, String contextPath) {
        return contextPath + "/" + DEFAULT_UPLOAD_DIR + "/" + relativePath;
    }
}
