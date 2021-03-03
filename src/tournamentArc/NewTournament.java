package tournamentArc;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/NewTournament")
public class NewTournament extends HttpServlet{
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

        String name = request.getParameter("name");
        Integer type = Integer.parseInt(request.getParameter("tournamentType"));
        try{
            Connector objCon = new Connector();
            objCon.openConnection();

            PreparedStatement ps = objCon.conn.prepareStatement("INSERT INTO Tournaments(name, type) VALUES (?,?)");
            ps.setString(1, name);
            ps.setInt(2, type);

            int i = ps.executeUpdate();

            if(i>0){
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
