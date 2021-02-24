package tournamentArc;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/logIn"})
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
        CreateLogin lg = new CreateLogin();

        String name = request.getParameter("username");
        String pwd = request.getParameter("password");

        if(lg.validaLogin(name, pwd)){
            request.getRequestDispatcher("loja.jsp").forward(request, response);
        }else{
            out.print("Error Logging in, Password or Username Incoorrect");
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
