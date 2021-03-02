
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html" pageEncoding="ISO-8859-1" import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Loja</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./styles.css"/>
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <script src="./cartScript.js" defer></script>
    </head>
    <body>
    <!-- header -->
    <header id="header" class="header-transparent">
        <div class="container">

            <div id="logo" class="pull-left">
                <a href="index.jsp"><img src="assets/img/logo.png" alt=""></a>
            </div>

            <nav id="nav-menu-container">
                <ul class="nav-menu">
                    <li class="menu-active"><a href="index.jsp">Home</a></li>
                    <li><a href="#about">About Us</a></li>
                    <li><a href="#team">Team</a></li>
                    <li class="menu-has-children"><a href="">Drop Down</a>
                        <ul>
                            <li><a href="#">Drop Down 1</a></li>
                            <li class="menu-has-children"><a href="#">Drop Down 2</a>
                                <ul>
                                    <li><a href="#">Deep Drop Down 1</a></li>
                                    <li><a href="#">Deep Drop Down 2</a></li>
                                    <li><a href="#">Deep Drop Down 3</a></li>
                                    <li><a href="#">Deep Drop Down 4</a></li>
                                    <li><a href="#">Deep Drop Down 5</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Drop Down 3</a></li>
                            <li><a href="#">Drop Down 4</a></li>
                            <li><a href="#">Drop Down 5</a></li>
                        </ul>
                    </li>
                </ul>
            </nav><!-- #nav-menu-container -->
        </div>
    </header><!-- End Header -->
    <section id="hero">
        <div class="hero-container" data-aos="zoom-in" data-aos-delay="100">
            <%   Connection Connector;
                Class.forName("com.mysql.jdbc.Driver");

                Connector = DriverManager.getConnection("jdbc:mysql://localhost:3306/javaweb_pf", "root", "");;

                try {

                    PreparedStatement ps = Connector.prepareStatement("Select name, precoVenda, foto from produtos");

                    ResultSet rs = ps.executeQuery();

            %>
            <div class="container-generic">
                <%
                    while (rs.next()) {

                        String nome = rs.getString(1);
                        float preco = rs.getFloat(2);
                        String foto = rs.getString(3);
                %>
                <div class="card col-3">
                    <div class="add-to-cart">
                        <img src="<%=foto%>">
                        <button class="add-to-cart-button">Adicionar ao carrinho</button>
                    </div>
                    <h4><%=nome%></h4>
                    <h5><%=preco%></h5>
                </div>
                <%
                    }
                %>
            </div>
            <%
                } catch (SQLException e) {
                    System.out.println("Erro na conexão à base de dados" + e);
                }
            %>
        </div>
    </section><!-- End Hero Section -->
        <main>          
           <%   Connection Connector;
            Class.forName("com.mysql.jdbc.Driver");

            Connector = DriverManager.getConnection("jdbc:mysql://localhost:3306/javaweb_pf", "root", "");;

            try {

                PreparedStatement ps = Connector.prepareStatement("Select nome, precoVenda, foto from produtos");

                ResultSet rs = ps.executeQuery();

                %>
                <div class="container-store">
                <%
                while (rs.next()) {

                    String nome = rs.getString(1);
                    float preco = rs.getFloat(2);
                    String foto = rs.getString(3);
                %>
                  <div class="card col-3">
                        <div class="add-to-cart">
                            <img src="<%=foto%>">
                            <button class="add-to-cart-button">Adicionar ao carrinho</button>
                        </div>
                        <h4><%=nome%></h4>
                        <h5><%=preco%></h5>
                    </div>
                  <%
                }
                %>
                </div>
                <%

            } catch (SQLException e) {
                System.out.println("Erro na conexão à base de dados" + e);
            }


        %>

            

        </main>
        
        <!-- Modal -->
        <div id="registarModal" class="modal">

          <!-- Modal conteúdo -->
          <div class="modal-content">
            <span class="close">&times;</span>
            <h3>Faça registo aqui</h3>
            <form action="registar" method="post">
                <div>
                    <div class="row">
                        <label>Nome de utilizador: </label>
                        <input type="text" name="username" required>
                    </div>
                    <div class="row">
                        <label>Palavra-passe: </label>
                        <input type="password" name="password" required>
                    </div>
                </div>
                <button id="btn_registar" type="submit">Registo</button>
            </form>
          </div>

        </div>
        
        <script>
        const entrou = <%=request.getAttribute("entrou")%>
        if(entrou === "entrou") btnRegistar.disabled = true; 
        </script>
        <script src="./modal.js"></script>
    </body>
</html>
