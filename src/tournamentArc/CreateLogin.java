package tournamentArc;

import java.io.PrintWriter;
import java.security.MessageDigest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CreateLogin {

    public boolean validaLogin(String nome, String password){

        boolean status = false;
        try{
            Connector ObjCon = new Connector();
            ObjCon.openConnection();
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte []messageDigest = md.digest(password.getBytes("UTF-8"));   //setting charset

            StringBuilder sb = new StringBuilder();

            for(byte b : messageDigest){
                sb.append(String.format("%02x", 0xFF & b));
            }

            password = sb.toString();

            //preparing database statement for login
            PreparedStatement ps = ObjCon.conn.prepareStatement("SELECT * FROM Clients WHERE name=? AND pwd=?;");
            ps.setString(1, nome);
            ps.setString(2, password);

            //checking if username password combo exist
            ResultSet rs = ps.executeQuery();
            status = rs.next();
            System.out.println(status);


        }catch(Exception e){
            System.out.println(e);
        }

        return status;

    }

}