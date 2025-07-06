package MyService;

import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ImageUtil {

    public static String saveImage(Part part, String fullUploadPath, String subFolder) throws IOException {
        String fileName = extractFileName(part);
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }

        String savedFileName = System.currentTimeMillis() + "_" + fileName;

        File uploadDir = new File(fullUploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();                                 
        }

        part.write(new File(uploadDir, savedFileName).getAbsolutePath());
        try {
            Thread.sleep(3000);
        } catch (InterruptedException ex) {
            Logger.getLogger(ImageUtil.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subFolder + "/" + savedFileName; //  lưu vào DB
    }

    /**
     * Trích xuất tên file từ Part
     */
    private static String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String s : contentDisp.split(";")) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf('=') + 2, s.length() - 1); 
            }
        }
        return null;
    }
    
    public static void deleteOldImage(String uploadRootPath, String relativePath) {
        if (relativePath == null || relativePath.trim().isEmpty()) return;

        File oldFile = new File(uploadRootPath + File.separator + relativePath.replace("/", File.separator));
        if (oldFile.exists()) {
            oldFile.delete(); 
        }
    }



    
}
