package tournamentArc;


import com.sun.jdi.DoubleValue;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/NewMatch")
public class NewMatch extends HttpServlet{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        PrintWriter out = response.getWriter();

        int team1 = Integer.parseInt(request.getParameter("participant1"));
        int team2 = Integer.parseInt(request.getParameter("participant2"));
        int team1score = Integer.parseInt(request.getParameter("team1score"));
        int team2score = Integer.parseInt(request.getParameter("team2score"));
        int result = Integer.parseInt(request.getParameter("result"));
        System.out.println(team1); //for debugging
        System.out.println(team2);

        try{
            Connector objCon = new Connector();
            objCon.openConnection();

            //elo calculation
            PreparedStatement query = objCon.conn.prepareStatement("SELECT elo FROM Participants WHERE id=? or id=? ;");
            query.setInt(1, team1);
            query.setInt(2, team2);

            if(team1 == team2){
                request.setAttribute("entrou", "entrou");
                request.getRequestDispatcher("errorMatch.jsp").forward(request, response);
            }

            ResultSet rs = query.executeQuery();
            int i=0;
            int[] id = {0, 0};
            double eA;
            double eB;
            int newRatingA;
            int newRatingB;


            while (rs.next()) {
                id[i] = rs.getInt(1);//receiving elo data from database
                i++;
            }
            System.out.println("hello"+id[0]+" ; "+id[1]); //for debugging

            eA = 1/(1+Math.pow(10, ((Double.valueOf(id[1])-Double.valueOf(id[0]))/400))); //Expected score formula
            eB = 1/(1+Math.pow(10, ((Double.valueOf(id[0])-Double.valueOf(id[1]))/400)));

            if(result == 1){    //team 1 win

                newRatingA = Math.toIntExact(Math.round(id[0] + 36 * (1 - eA)));
                newRatingB = Math.toIntExact(Math.round(id[1] + 36 * (0 - eB))); //at the moment we're assuming no one's a master maybe in the future it will be implemented

            }else if (result == 2){ //team 2 win
                newRatingA = Math.toIntExact(Math.round(id[0] + 36 * (0 - eA)));
                newRatingB = Math.toIntExact(Math.round(id[1] + 36 * (1 - eB)));
            }else{  //tie
                newRatingA = Math.toIntExact(Math.round(id[0] + 36 * (0.5 - eA)));
                newRatingB = Math.toIntExact(Math.round(id[1] + 36 * (0.5 - eB)));
            }

            System.out.println(newRatingA);//for debugging
            System.out.println(newRatingB);

            //alter ELO on BD for participant 1
            PreparedStatement eloUpdateT1 = objCon.conn.prepareStatement
                    ("UPDATE `Participants` SET `elo` = ? WHERE `Participants`.`id` = ?  ");
            eloUpdateT1.setInt(1, newRatingA);
            eloUpdateT1.setInt(2, team1);

            eloUpdateT1.executeUpdate();

            //alter ELO on BD for participant 2
            PreparedStatement eloUpdateT2 = objCon.conn.prepareStatement
                    ("UPDATE `Participants` SET `elo` = ? WHERE `Participants`.`id` = ?  ");
            eloUpdateT2.setInt(1, newRatingB);
            eloUpdateT2.setInt(2, team2);

            eloUpdateT2.executeUpdate();

            //ELO CALC END, (would like to separate NewMatch Class into generic class)

            //insertion into match history
            PreparedStatement ps = objCon.conn.prepareStatement
                    ("INSERT INTO matchHistory(team1id, team2id, team1score, team2score, result) VALUES (?,?,?,?,?)");
            ps.setInt(1, team1);
            ps.setInt(2, team1score);
            ps.setInt(3, team2);
            ps.setInt(4, team2score);
            ps.setInt(5, result);

            int confirm = ps.executeUpdate();

            if(confirm>0){
                request.setAttribute("entrou", "entrou");
                request.getRequestDispatcher("personalPage.jsp").forward(request, response);
            }

        }catch(Exception e){
            out.print(e);
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
