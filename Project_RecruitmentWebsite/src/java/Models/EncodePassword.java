package Models;

import java.security.MessageDigest;
import java.util.Base64;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import jakarta.activation.*;

public class EncodePassword {

    public static String encodePasswordbyHash(String password) {
        String result = null;

        String salt = "qscvhierghdfghytwsthhsgdhjdfghsdrtsdfgerphamtrungduc1011";

        password += salt;

        try {

            byte[] databyte = password.getBytes("UTF-8");    // chuyển về thành mảng byte , mỗi ký tự sẽ có 1 byte (8 bit)

            MessageDigest md = MessageDigest.getInstance("MD5"); //   MessageDigest 1 lớp để sử dụng các thuật toán  băm

            result = Base64.getEncoder().encodeToString(md.digest(databyte));  // Base64 giúp mã hóa dữ liệu nhị phân (byte/số) thành chuỗi ký tự dễ đọc, dễ lưu trữ.

//            byte[] t = md.digest(databyte);
//
//            for (byte k : t) {
//                System.out.println(k);
//            }
        } catch (Exception s) {
            System.out.println(s.getMessage());
        }

        return result;
    }

    
     // gửi Email
    public static void sendEmail(String toEmail, String title, String body) {
        final String fromEmail = "vietchobann@gmail.com"; // Email gửi
        final String password = "pmvj jlwe izxh qgou"; // App password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            msg.setSubject(title);
            msg.setText(body);

            Transport.send(msg);

            System.out.println("📬 Gửi email thành công tới " + toEmail);

        } catch (MessagingException e) {
            System.out.println("❌ Gửi email thất bại: " + e.getMessage());

        }
    }

    public static void main(String[] args) throws MessagingException {

      //  sendEmail("anhkdhe186606@fpt.edu.vn", "VietChoBan.hihi", "Chào mừng bạn đã đăng ký tài khoản tại website vietchobann của chúng tôi. Nếu bạn không thực hiện hành động này, vui lòng bỏ qua email này \n Goodnight");
        sendEmail("phucndhe187145@fpt.edu.vn", "Thông Báo", "Tài khoản của bạn đã được thêm vào BlackList của chúng tôi \n Trân Trọng Thông Báo Đến Bạn");
        System.out.println(encodePasswordbyHash("phamtrungduc"));
    }

}
