package Models;

import java.security.MessageDigest;
import java.util.Base64;
import jakarta.mail.*;


public class EncodePassword {

    public static String encodePasswordbyHash(String password) {
        String result = null;

        String salt = "qscvhierghdfghytwsthhsgdhjdfghsdrtsdfgerphamtrungduc1011";

        password += salt;

        try {

            byte[] databyte = password.getBytes("UTF-8");    // chuyển về thành mảng byte 

            MessageDigest md = MessageDigest.getInstance("SHA-1"); //   MessageDigest 1 lớp để sử dụng các thuật toán  băm

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

    public static void main(String[] args) throws MessagingException {

        System.out.println(encodePasswordbyHash("12"));
    }

}
