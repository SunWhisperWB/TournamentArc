package tournamentArc;


import java.sql.Connection;
import java.sql.DriverManager;


public class Connector {

    Connection conn;
    /* default values declared on connector */
    private String url = "jdbc:mysql://localhost:3306/javaweb_pf";
    private String user = "root";
    private String password = "";

    /* connection method to database */
    public void openConnection(){

        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
        }catch(Exception e){
            System.out.println(e);
        }

    }
    /*getters and setters for private variables*/
    public String getUser(){
        return user;
    }

    public String getPassword(){
        return password;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}