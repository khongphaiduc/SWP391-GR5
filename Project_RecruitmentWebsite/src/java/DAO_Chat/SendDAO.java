
package DAO_Chat;

import dal.DBContext;
import java.sql.*;

public class SendDAO extends DBContext {

    public boolean insertMessage(String senderID, String senderRole, String reciverID, String reciverRolem, String content) {

        try {
            String query = "INSERT INTO [dbo].[ChatMessage]\n"
                    + "           ([Sender_ID]\n"
                    + "           ,[Sender_Role]\n"
                    + "           ,[Receiver_ID]\n"
                    + "           ,[Receiver_Role]\n"
                    + "           ,[Content])\n"
                    + "          VALUES  (?,?,?,?,?)";
            PreparedStatement push = connection.prepareStatement(query);
            push.setString(1, senderID);
            push.setString(2, senderRole);
            push.setString(3, reciverID);
            push.setString(4, reciverRolem);
            push.setString(5, content);

            int row = push.executeUpdate();

            return row != 0 ? true : false;
        } catch (Exception e) {

        }
        return false;
    }
    
    
    public static void main(String[] args) {
        SendDAO o = new SendDAO();
     //   System.out.println(o.insertMessage("21", "Candidate", "1", "Admin", "anh đức đây"));
          System.out.println(o.insertMessage("1", "Admin", "21", "Candidate", "clm emssasdasd"));
    }

}
