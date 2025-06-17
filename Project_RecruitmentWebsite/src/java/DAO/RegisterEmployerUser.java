package DAO;

import Models.EncodePassword;
import MyService.MyEmail;
import dal.DBContext;
import java.sql.*;
import java.util.Random;

public class RegisterEmployerUser extends DBContext {

    // kiểm tra mail bên employer   (đã test)
    public boolean isEmaiEmployerUser(String mail) {
        try {

            String query = "SELECT [Employer_ID]\n"
                    + "      ,[Email]\n"
                    + "  FROM [dbo].[Employer]\n"
                    + "  where Email=?";

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

    // lấy tên đăng nhập bằng email
    public String getNamAcountByEmailofEmployer(String mail) {
        try {

            String query = "SELECT   [EmployerName]\n"
                    + "  FROM [dbo].[Employer]\n"
                    + "  Where Email =?";
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, mail);
            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                return rs.getString("EmployerName");

            }
        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());
        }
        return " ";
    }

    // kiểm tra tài khoản đã tồn tại yet  (dadx test)
    public boolean isEmployertUser(String account) {
        try {
            String query = "SELECT [Employer_ID]\n"
                    + "      ,[EmployerName]\n"
                    + "  FROM [dbo].[Employer]\n"
                    + "  where EmployerName  =?";
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, account);
            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                String result = rs.getString("EmployerName");
                if (result.equals(account)) {
                    return true;
                }
            }
        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());
        }
        return false;
    }

    //đăng ký Employers       (đẫ test)
    public boolean registerEmployers(String account, String mail, String phone, String password) {
        try {
            String query = "INSERT INTO [dbo].[Employer]\n"
                    + "           ([EmployerName]\n"
                    + "           ,[Email]\n"
                    + "           ,[PhoneNumber]\n"
                    + "           ,[Password_hash]\n"
                    + "          )\n"
                    + "     VALUES (?,?,?,?)";

            String passwordHash = EncodePassword.encodePasswordbyHash(password);  // encode trước khi lưu vào database 

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, account);
            push.setString(2, mail);
            push.setString(3, phone);
            push.setString(4, passwordHash);

            int row = push.executeUpdate();

            System.out.println(row + " dòng đã được thêm");
            MyEmail mymail = new MyEmail();

            // gửi mail cho client thông báo là thành công
            mymail.sendEmail(mail, "Đăng Ký Tài Khoản  Thành Công ", " Chào mừng bạn đến với GenZTimViec.Vn ");
            return row != 0;
        } catch (SQLException s) {
            System.out.println("Lỗi SQL: " + s.getMessage());
        }
        return false;
    }

    // đăng nhập  Employers  (đẫ test)
    public boolean LogInAccountEmployers(String account, String password) {
        try {
            String query = "SELECT [Employer_ID]\n"
                    + "      ,[EmployerName]\n"
                    + "     \n"
                    + "      ,[Password_hash]\n"
                    + "     \n"
                    + "  FROM [dbo].[Employer]\n"
                    + "  where EmployerName =?";

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

    //lấy lại mật khẩu  bằng Mail   (đã test)
    public void resetPasswordByEmailSideEmployer(String mail) {
        try {
            StringBuilder newpassword = new StringBuilder();
            newpassword.append("dfghhdt");
            Random random = new Random();

            for (int i = 0; i < 2; i++) {
                newpassword.append(random.nextInt());
            }

            EncodePassword myencoder = new EncodePassword();
            MyEmail myMail = new MyEmail();

            String passwordHash = myencoder.encodePasswordbyHash(newpassword.toString());  // encode

            String query = "UPDATE [dbo].[Employer]\n"
                    + "SET [Password_hash] = ?\n"
                    + "WHERE [Email] = ? ";

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

    // lấy passwordHash của EmployerName  (đẫ test)
    public String getPasswordHashEmpployer(String EmployerName) {
        try {
            String passwordHash = null;
            String query = "SELECT  [Password_hash]\n"
                    + "  FROM [dbo].[Employer]\n"
                    + "  where EmployerName =?";

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, EmployerName);

            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                return passwordHash = rs.getString("Password_hash");
            }

        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());
        }
        return null;
    }

    // đổi mật khẩu client  (đẫ test)
    public boolean changePasswordEmployer(String account, String oldPassword, String newpasswordUser) {
        try {

            EncodePassword myencoder = new EncodePassword();

            String temporaryHashimputpasswordUser = myencoder.encodePasswordbyHash(oldPassword);   //hash  oldPassword

            String getoldPasswordInSysytem = getPasswordHashEmpployer(account);   // mã hash của account 

            System.out.println(temporaryHashimputpasswordUser);
            System.out.println(getoldPasswordInSysytem);

            if (!temporaryHashimputpasswordUser.equals(getoldPasswordInSysytem)) {
                System.out.println(" mật khẩu cũ không đúng");
                return false;
            }

            //bắt đầu tạo mật khẩu mới do user đặt va thêm tí mắn tí muối        
            String passwordHash = myencoder.encodePasswordbyHash(newpasswordUser);  // encode password

            String query = "update [dbo].[Employer]\n"
                    + "  set [Password_hash] = ?\n"
                    + "  where [EmployerName] = ?";

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

    // lấy id của thằng Employer (đã test)
    public String getIDbyAccountNameEmployer(String accountName) {
        try {

            String query = "SELECT [Employer_ID]\n"
                    + "      ,[EmployerName]\n"
                    + "  FROM [dbo].[Employer]\n"
                    + "  Where EmployerName=?";

            PreparedStatement push = connection.prepareStatement(query);

            push.setString(1, accountName);

            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                return rs.getString("Employer_ID");
            }
        } catch (Exception s) {
            System.out.println("Bug  SQL:" + s.getMessage());

        }
        return null;
    }

    // kiểm tra xem phone đã tồn tại yet 
    public boolean isPhoneNumberEmployer(String phone) {
        try {

            String query = "SELECT \n"
                    + " [PhoneNumber]\n"
                    + "  FROM [dbo].[Employer]\n"
                    + "  Where PhoneNumber=?";

            PreparedStatement push = connection.prepareStatement(query);

            push.setString(1, phone);

            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                return rs.getString("PhoneNumber").equals(phone);
            }
        } catch (Exception s) {
            System.out.println("Bug  SQL:" + s.getMessage());

        }
        return false;
    }

//     đăng ký bằng google
    public boolean RegisterEmployerByGoogle(String mail, String name, String phone, String nameCompany, String location) {
        try {
            // mail với tên đang nhập là 1 
            String query = "INSERT INTO [dbo].[Employer]\n"
                    + "           ([EmployerName]\n"
                    + "           ,[Name]\n"
                    + "           ,[Email]\n"
                    + "           ,[PhoneNumber]\n"
                    + "           ,[Password_hash]\n"
                    + "           ,[Company_Name]\n"
                    + "           ,[Location]\n"
                    + "		   )\n"
                    + "     VALUES  (?,?,?,?,'111111',?,?)\n"
                    + "          ";
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, mail);
            push.setString(2, name);
            push.setString(3, mail);
            push.setString(4, phone);
            push.setString(5, nameCompany);
            push.setString(6, location);
            ResultSet rs = push.executeQuery();

            while (rs.next()) {

            }
        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());
        }
        return false;
    }

    public static void main(String[] args) {
        RegisterEmployerUser o = new RegisterEmployerUser();
//        System.out.println("Mã code cũ :"+o.getPasswordHashEmpployer("phamtrungduc"));
//        System.out.println(o.changePasswordEmployer("phamtrungduc","hahahaha","123"));
//        System.out.println(o.isEmployertUser("phamtrungduc"));
//        System.out.println(o.getIDbyAccountNameEmployer("Công ty NOP"));
        // System.out.println(o.registerEmployers("phamtrungduc1", "ptrungduc1011@gmail.com", "0329255824", "12"));
        System.out.println(o.isPhoneNumberEmployer("0329255823"));
    }

}
