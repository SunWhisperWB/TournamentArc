<!DOCTYPE html>
<%@ page import="tournamentArc.*" %>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="ISO-8859-1" import="java.sql.*" %>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Tournament Arc - New Tournament</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="assets/img/favicon.png" rel="icon">
    <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Poppins:300,400,500,700" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="assets/vendor/venobox/venobox.css" rel="stylesheet">
    <link href="assets/vendor/aos/aos.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">

</head>

<body>
<div>
    <header id="header" class="header-transparent">
        <div class="container">

            <div id="logo" class="pull-left">
                <a href="index.jsp"><img src="assets/img/logo.png" alt=""></a>
            </div>

            <nav id="nav-menu-container">
                <ul class="nav-menu">
                    <li class="menu-active"><a href="index.jsp">Home</a></li>
                    <li><a href="#about">About Us</a></li>
                    <li><a href="#services">Services</a></li>
                    <li><a href="#portfolio">Portfolio</a></li>
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
                    <li><a href="#contact">Contact Us</a></li>
                </ul>
            </nav><!-- #nav-menu-container -->
        </div>
    </header><!-- End Header -->

    <section id="hero">
        <div class="hero-container" data-aos="zoom-in" data-aos-delay="100">
            <h1>Create a Match</h1>
            <h2>(and submit it)</h2>
            <form action="NewMatch" method="post">
                <br>
                <label>Participants: </label>
                <%   Connection connector;
                    Class.forName("com.mysql.jdbc.Driver");

                    connector = DriverManager.getConnection("jdbc:mysql://localhost:3306/TournamentArc", "root", "");;

                    try {

                        PreparedStatement ps = connector.prepareStatement("Select id, name, elo from Participants");

                        ResultSet rs = ps.executeQuery();

                %>
                <div class="container-generic">
                    <label>Participant 1: </label>
                    <select name="participant1" id="participant1">
                        <%
                            while (rs.next()) {
                                Integer id = rs.getInt(1);
                                String name = rs.getString(2);
                                Integer elo = rs.getInt(3);
                        %>
                        <option value="<%=id%>"><%=id%> - <%=name%> (<%=elo%>)</option>
                        <%
                            }
                        %>
                    </select>
                <%

                        ResultSet rs2 = ps.executeQuery();

                %>
                    <label>Participant 2: </label>
                    <select name="participant2" id="participant2">
                        <%
                            while (rs2.next()) {
                                Integer id = rs2.getInt(1);
                                String name = rs2.getString(2);
                                Integer elo = rs2.getInt(3);
                        %>
                        <option value="<%=id%>"><%=id%> - <%=name%> (<%=elo%>)</option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <%
                    } catch (SQLException e) {
                        System.out.println("Erro na conex�o � base de dados" + e);
                    }
                %>
                <br>

                <label>Score: </label>
                <label>Team1: </label>
                <input type="number" name="team1score" required placeholder="0">
                <label>Team 2: </label>
                <input type="number" name="team2score" required placeholder="0">

                <br>

                <label>Winner: </label>

                <select name="result" id="result">
                    <option value="0">Tie</option>
                    <option value="1">Team 1</option>
                    <option value="2">Team 2</option>
                </select>

                <br>
                <button type="submit" class="btn-get-started">Submit</button>
            </form>
        </div>
    </section><!-- End Hero Section -->

</div>
<!-- ======= Footer ======= -->
<footer id="footer">
    <div class="footer-top">
        <div class="container">

        </div>
    </div>

    <div class="container">
        <div class="copyright">
            &copy; Copyright <strong>Regna</strong>. All Rights Reserved
        </div>
        <div class="credits">
            <!--
            All the links in the footer should remain intact.
            You can delete the links only if you purchased the pro version.
            Licensing information: https://bootstrapmade.com/license/
            Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/buy/?theme=Regna
          -->
            Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
        </div>
    </div>
</footer><!-- End Footer -->

<!-- Vendor JS Files -->
<script src="assets/vendor/jquery/jquery.min.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/vendor/jquery.easing/jquery.easing.min.js"></script>
<script src="assets/vendor/php-email-form/validate.js"></script>
<script src="assets/vendor/counterup/counterup.min.js"></script>
<script src="assets/vendor/waypoints/jquery.waypoints.min.js"></script>
<script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="assets/vendor/superfish/superfish.min.js"></script>
<script src="assets/vendor/hoverIntent/hoverIntent.js"></script>
<script src="assets/vendor/owl.carousel/owl.carousel.min.js"></script>
<script src="assets/vendor/venobox/venobox.min.js"></script>
<script src="assets/vendor/aos/aos.js"></script>

<!-- Template Main JS File -->
<script src="assets/js/main.js"></script>

</body>
</html>
