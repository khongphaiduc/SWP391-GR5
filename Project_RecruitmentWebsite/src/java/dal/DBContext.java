package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    protected Connection connection;

    public DBContext() {

        try {
            String user = "sa";
            String pass = "0211";



   //         String url = "jdbc:sqlserver://DESKTOP-NQH197\\NGUYENQUANGHUYSV:1433;databaseName=swp_final6;";



            String url = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=CV10";


//            String url = "jdbc:sqlserver://LAPTOP-MK;databaseName=CV02";

//            String url = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=GenZTimViec9";
   


            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

//             String url = "jdbc:sqlserver://10.33.61.112:1433;databaseName=GenZTimViec14;user=sa;password=123";
//           Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//>>>>>>> b7aaaaddf37a469d9faf74f33f90c10c8c2134b2
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean check() {
        return connection != null ? true : false;
    }

    public static void main(String[] args) {
        DBContext s = new DBContext();
        System.out.println(s.check());
    }
}
