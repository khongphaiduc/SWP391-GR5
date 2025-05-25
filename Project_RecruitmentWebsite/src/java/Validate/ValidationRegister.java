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

    public boolean checkLength(String check) {
        return check.length() > 8;
    }

}
