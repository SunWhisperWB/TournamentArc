package tournamentArc;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/NewParticipant")
public class NewParticipant extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

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
        try{
            Connector objCon = new Connector();
            objCon.openConnection();

            PreparedStatement ps = objCon.conn.prepareStatement("INSERT INTO Participants(name) VALUES (?)");
            ps.setString(1, name);

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