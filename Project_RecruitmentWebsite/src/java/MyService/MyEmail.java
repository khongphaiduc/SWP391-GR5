
package MyService;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;


public class MyEmail {
    
    // gửi mail 
      public static void sendEmail(String toEmail, String title, String body) {
        final String fromEmail = "vietchobann@gmail.com"; // MyEmail gửi
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

            System.out.println(" Gửi email thành công tới " + toEmail);

        } catch (MessagingException e) {
            System.out.println(" Gửi email thất bại: " + e.getMessage());

        }
    }
      
      
      public static void main(String[] args) {
         sendEmail("ptrungduc1011@gmail.com","Test","ádfedgadsrfgsdfgsdfgsetyhsdfghsdfgvnbscfghsdfghsfghdfgh");
    }
}
