package Validate;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ValidationRegister {

    // lấy thời gian hiện tại 
    public static String getTimeNow() {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        return now.format(formatter);
    }

    // kiểm tra độ dài
    public boolean checkLength(String check) {
        return check.length() >= 8;
    }

    public static boolean checkChar(String password) {
        return password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?]).{8,}$");
    }

    public static void main(String[] args) {
        ValidationRegister o = new ValidationRegister();
        System.out.println(checkChar("123456789@Aa"));
    }

}
