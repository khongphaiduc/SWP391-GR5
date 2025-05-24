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

    // kiểm tra độ dài của account 
    public boolean checkLengthAccount(String account) {
            return account.length()>8;
    }
     // kiểm tra độ dài của Password 
    public boolean checkLenghPassword(String password) {
        return password.length()>8;
    }
    
    
    public  static boolean checkSecurityPassword(String password){
        return password.matches("(?=.*[a-z])");
    }

    
    
    
    public static void main(String[] args) {
        System.out.println(checkSecurityPassword("usdfsdfsdfsdfs"));
    }
}
