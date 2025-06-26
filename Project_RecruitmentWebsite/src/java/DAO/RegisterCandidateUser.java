package DAO;

import Models.EncodePassword;
import MyService.MyEmail;
import dal.DBContext;
import java.sql.*;
import java.util.Random;

public class RegisterCandidateUser extends DBContext {

    // kiểm tra mail bên Candidate   (đã test)
    public boolean isEmaiCandidateUser(String mail) {
        try {

            String query = "SELECT [Email]\n"
                    + "FROM [dbo].[Candidate] s1\n"
                    + "Where s1.Email= ?";
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
    public String getNamAcountByEmailofCandidate(String mail) {
        try {

            String query = "SELECT [CandidateName]\n"
                    + "  FROM [dbo].[Candidate]\n"
                    + "  Where Email = ? ";
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, mail);
            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                return rs.getString("CandidateName");

            }
        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());
        }
        return " ";
    }

    // kiểm tra tài khoản đã tồn tại yet  (dadx test)
    public boolean isCandidatetNameUser(String account) {
        try {
            String query = "SELECT [CandidateName]  \n"
                    + "  FROM [dbo].[Candidate]\n"
                    + "  where CandidateName = ?";
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, account);
            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                String result = rs.getString("CandidateName");
                if (result.equals(account)) {
                    return true;
                }
            }

        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());
        }
        return false;
    }

    //đăng ký Employers    (đẫ test)
    public boolean registerCandidate(String account, String mail, String password) {
        try {
            String query = "INSERT INTO [dbo].[Candidate]\n"
                    + "           ([CandidateName]          \n"
                    + "           ,[Email]                   \n"
                    + "           ,[Password_hash] )\n"
                    + "     VALUES (?,?,?)";

            String passwordHash = EncodePassword.encodePasswordbyHash(password);  // encode trước khi lưu vào database 

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, account);
            push.setString(2, mail);
            push.setString(3, passwordHash);

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

    // đăng nhập  Candidate (đẫ test)
    public boolean LogInAccountCandidate(String account, String password) {
        try {
            String query = "SELECT s1.Password_hash,s1.CandidateName\n"
                    + "  FROM [dbo].[Candidate] s1\n"
                    + "  where s1.CandidateName =?";

            String passwordHash = EncodePassword.encodePasswordbyHash(password);  // encode 

            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, account);
            ResultSet rs = push.executeQuery();

            while (rs.next()) {
                String getpasswordEncodeInBase = rs.getString("Password_hash");
                if (passwordHash.equals(getpasswordEncodeInBase)) {              // so sánh code hash của 2 thàngqư 
                    return true;
                }
            }

        } catch (SQLException s) {
            System.out.println("Lỗi SQL: " + s.getMessage());
        }
        return false;
    }

    //lấy lại mật khẩu  bằng Mail   (đã test)
    public void resetPasswordByEmailSideCandidate(String mail) {
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

            String query = "update [dbo].[Candidate]\n"
                    + "set [Password_hash] = ? \n"
                    + "where [Email]  = ? \n";

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

    // lấy passwordHash của Candidate (đẫ test)
    public String getPasswordHashCandidate(String EmployerName) {
        try {
            String passwordHash = null;
            String query = "SELECT [Password_hash]\n"
                    + "  FROM [dbo].[Candidate]\n"
                    + "  where CandidateName = ?";

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

//    public static void main(String[] args) {
//        RegisterCandidateUser o = new RegisterCandidateUser();
//        System.out.println(o.getPasswordHashCandidate("phamthea"));
//    }
    // đổi mật khẩu client bên  (đẫ test)
    public boolean changePasswordCandidate(String account, String oldPassword, String newpasswordUser) {
        try {

            EncodePassword myencoder = new EncodePassword();

            String temporaryHashimputpasswordUser = myencoder.encodePasswordbyHash(oldPassword);   //hash  oldPassword

            String getoldPasswordInSysytem = getPasswordHashCandidate(account);   // mã hash của account 

            System.out.println(temporaryHashimputpasswordUser);
            System.out.println(getoldPasswordInSysytem);

            if (!temporaryHashimputpasswordUser.equals(getoldPasswordInSysytem)) {
                System.out.println(" mật khẩu cũ không đúng");
                return false;
            }

            //bắt đầu tạo mật khẩu mới do user đặt va thêm tí mắn tí muối        
            String passwordHash = myencoder.encodePasswordbyHash(newpasswordUser);  // encode password

            String query = "UPDATE [dbo].[Candidate]\n"
                    + "   SET [Password_hash]=?\n"
                    + " WHERE [CandidateName]=?";

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

    // lấy id của thằng Candidate (đã test)
    public String getIDbyAccountNameCandidate(String accountName) {
        try {

            String query = "SELECT [Candidate_ID]\n"
                    + "      ,[CandidateName] \n"
                    + "  FROM [dbo].[Candidate]\n"
                    + "  Where CandidateName = ?";

            PreparedStatement push = connection.prepareStatement(query);

            push.setString(1, accountName);

            ResultSet rs = push.executeQuery();
            while (rs.next()) {
                return rs.getString("Candidate_ID");
            }
        } catch (Exception s) {
            System.out.println("Bug  SQL:" + s.getMessage());

        }
        return null;
    }

    // đăng ký tài khoản bằng google cho thằng candidate  (đã test)
    public boolean RegisterCandidateByGoogle(String mail) {
        try {

            String query = "INSERT INTO [dbo].[Candidate]\n"
                    + "           ([CandidateName]\n"
                    + "           ,[Email]\n"
                    + "           ,[Password_hash]\n"
                    + "		   )\n"
                    + "     VALUES  (?,?,'111111111111111')";
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, mail);
            push.setString(2, mail);
            int row = push.executeUpdate();
            System.out.println(row != 0 ? "Thêm Thành Công" : "Thêm thất bại");
            return row != 0;
        } catch (SQLException s) {
            System.out.println("Bug  SQL:" + s.getMessage());
        }
        return false;
    }

    public static void main(String[] args) {
        RegisterCandidateUser o = new RegisterCandidateUser();
//        System.out.println(o.LogInAccountCandidate("phamtrungduc", "12345"));
        // System.out.println(o.changePasswordEmployer("phamtrungduc", "dfghhdt-926226851550952879", "12345"));
        //     System.out.println(o.isCandidatetNameUser("phamtrungduc"));
//        System.out.println(o.getIDbyAccountNameCandidate("phamtrungduc"));
        System.out.println(o.RegisterCandidateByGoogle("ducchimto@gmail.com"));

    }
}
