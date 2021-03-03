package tournamentArc;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/logIn")
public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8"); //setting charset
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { //processing resquest
        processRequest(request, response);
    }

    //making new login on the web app
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        PrintWriter out = response.getWriter();

        String name = request.getParameter("username");
        String pwd = request.getParameter("password");

        if(validaLogin(name, pwd)){
            request.getRequestDispatcher("personalPage.jsp").forward(request, response);
        }else{
            out.print("Error Logging in, Password or Username Incorrect");
            request.getRequestDispatcher("error.html").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

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
            System.out.println(status); //for debugging


        }catch(Exception e){
            System.out.println(e);
        }

        return status;

    }
}
