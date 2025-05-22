package DAO;

import Models.EncodePassword;
import MyService.MyEmail;
import java.sql.*;
import dal.*;
import java.util.Random;

public class RegisterAccount_Database extends DBContext {

    // truy vấn MyEmail để điểm tra xem mail đã tồn tại trên hệ thống chưa 
    public boolean isEmailUser(String mail) {
        try {

            String query = "SELECT [Account_ID]\n"
                    + "      ,[Account_Name]\n"
                    + "      ,[Email]\n"
                    + "      ,[Password_hash]\n"
                    + "      ,[date_cr]\n"
                    + "      ,[Role]\n"
                    + "  FROM [dbo].[Account]\n"
                    + "\n"
                    + " where Email = ? ";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, mail);
            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                String result = rs.getString("Email");
                if (result.equals(mail)) {
                    return true;
                }
            }

        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());

        }
        return false;
    }

    // check xem tài khoản đã tồn tại chưa 
    public boolean isAccountUser(String account) {
        try {

            String query = "SELECT [Account_ID]\n"
                    + "      ,[Account_Name]\n"
                    + "      ,[Email]\n"
                    + "      ,[Password_hash]\n"
                    + "      ,[date_cr]\n"
                    + "      ,[Role]\n"
                    + "  FROM [dbo].[Account]\n"
                    + "\n"
                    + " where Account_Name=?";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, account);
            ResultSet rs = push.executeQuery();

            while (true) {
                String result = rs.getString("Account_Name");
                if (result.equals(account)) {
                    return true;
                }
            }

        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());

        }
        return false;
    }

    // đăng ký tài khoản 
    public boolean registerAccount(String account, String mail, String dateCreate, String password, String role) {
        try {
            String query = "INSERT INTO [dbo].[Account] "
                    + "([Account_Name], [Email], [Password_hash], [date_cr], [Role]) "
                    + "VALUES (?, ?, ?, ?, ?)";

            String passwordHash = EncodePassword.encodePasswordbyHash(password);  // encode trước khi lưu vào database 

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, account);
            push.setString(2, mail);
            push.setString(3, passwordHash);
            push.setString(4, dateCreate);
            push.setString(5, role);
            int row = push.executeUpdate();
            System.out.println(row + " dòng đã được thêm");
            MyEmail mymail = new MyEmail();
            // gửi mail cho client thông báo là thành công
            mymail.sendEmail(mail, "Đăng Ký Thành Công ", "Chào mừng bạn đến với vietchobann \n hihihihiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiih");
            return row != 0;
        } catch (SQLException s) {
            System.out.println("Lỗi SQL: " + s.getMessage());
        }
        return false;
    }

    // đăng nhập  (tested)
    public boolean LogInAccount(String account, String password) {
        try {
            String query = "SELECT [Account_ID]\n"
                    + "      ,[Account_Name]\n"
                    + "      ,[Email]\n"
                    + "      ,[Password_hash]\n"
                    + "      ,[date_cr]\n"
                    + "      ,[Role]\n"
                    + "  FROM [dbo].[Account]\n"
                    + "\n"
                    + "  where Account_Name=?";

            String passwordHash = EncodePassword.encodePasswordbyHash(password);  // encode 

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, account);

            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                String getpasswordEncodeInBase = rs.getString("Password_hash");
                if (passwordHash.equals(getpasswordEncodeInBase)) {
                    return true;
                }
            }

        } catch (SQLException s) {
            System.out.println("Lỗi SQL: " + s.getMessage());
        }
        return false;
    }

    public static void main(String[] args) {
        RegisterAccount_Database o = new RegisterAccount_Database();
        System.out.println(o.changePassword("admin", "123", "1234"));
    }

    //lấy lại mật khẩu  bằng Mail  (tested)
    public void getPasswordCaseForget(String mail) {
        try {
            StringBuilder newpassword = new StringBuilder();
            newpassword.append("dfghhdt");
            Random random = new Random();

            for (int i = 0; i < 2; i++) {
                newpassword.append(random.nextInt());
            }

            String query = "UPDATE [dbo].[Account]\n"
                    + "   SET [Password_hash] = ? \n"
                    + "        \n"
                    + " WHERE Email= ? ";

            EncodePassword myencoder = new EncodePassword();
            MyEmail myMail = new MyEmail();

            String passwordHash = myencoder.encodePasswordbyHash(newpassword.toString());  // encode

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, passwordHash);
            push.setString(2, mail);
            int row = push.executeUpdate();

            if (row != 0) {
                myMail.sendEmail(mail, "PASSWORD ", "New Your Password:" + newpassword + "\n" + " Hãy đặt lại mật để đảm bảo an toàn nhé bạn :))))");  // gửi password cho client
            }

            System.out.println(row + " đã được thêm  ");
        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());

        }
    }

    // lấy mật khẩu từ account 
    public String getPasswordAccoutn(String account) {

        try {

            String query = "SELECT [Account_ID]\n"
                    + "      ,[Account_Name]\n"
                    + "      ,[Email]\n"
                    + "      ,[Password_hash]\n"
                    + "      ,[date_cr]\n"
                    + "      ,[Role]\n"
                    + "  FROM [dbo].[Account]\n"
                    + "  where Account_Name=?";

            PreparedStatement push = connection.prepareStatement(query);

            push.setString(1, account);
            ResultSet rs = push.executeQuery();
            String codehash = null;
            while (rs.next()) {
                codehash = rs.getString("Password_hash");
            }
            return codehash;
        } catch (SQLException s) {
            System.out.println("SQL BUG :" + s.getMessage());
            return null;
        }

    }

    // đổi mật khẩu client 
    public boolean changePassword(String account, String oldPassword, String newpasswordUser) {
        try {

            EncodePassword myencoder = new EncodePassword();

            String temporaryHashimputpasswordUser = myencoder.encodePasswordbyHash(oldPassword);   //hash  oldPassword

            String getoldPasswordInSysytem = getPasswordAccoutn(account);   // mã hash của account 

            System.out.println(temporaryHashimputpasswordUser);
            System.out.println(getoldPasswordInSysytem);

            if (!temporaryHashimputpasswordUser.equals(getoldPasswordInSysytem)) {
                System.out.println(" mật khẩu cũ không đúng");
                return false;
            }

            //bắt đầu tạo mật khẩu mới do user đặt va thêm tí mắn tí muối
         

            String passwordHash = myencoder.encodePasswordbyHash(newpasswordUser);  // encode password

            String query = "UPDATE [dbo].[Account]\n"
                    + "   SET Password_hash = ? \n"
                    + " WHERE Account_Name = ? ";

            PreparedStatement push = connection.prepareStatement(query);

            push.setString(1, passwordHash);
            push.setString(2, account);

            int row = push.executeUpdate();
            System.out.println(row + " đã được impact");

            return true;
        } catch (Exception s) {
            System.out.println("Bug  SQL:" + s.getMessage());

        }
        return false;
    }

}
