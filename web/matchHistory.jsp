
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="ISO-8859-1" import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>Tournament Arc - Personal Page</title>
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
    <!-- header -->
    <header id="header" class="header-transparent">
        <div class="container">

            <div id="logo" class="pull-left">
                <a href="index.jsp"><img src="assets/img/logo.png" alt=""></a>
            </div>

            <nav id="nav-menu-container">
                <ul class="nav-menu">
                    <li><a href="index.jsp" >Logout</a></li>
                </ul>
            </nav><!-- #nav-menu-container -->
        </div>
    </header><!-- End Header -->


    <section id="hero">
        <div class="hero-container" data-aos="zoom-in" data-aos-delay="100">
            <!-- Connection -->
            <%   Connection connector;
                Class.forName("com.mysql.jdbc.Driver");

                connector = DriverManager.getConnection("jdbc:mysql://localhost:3306/TournamentArc", "root", "");;

                int count=0;

                try {

                    PreparedStatement ps = connector.prepareStatement
                            ("SELECT Participants.name  AS 'Team 1 Name',       " +
                                    "matchHistory.team1score,\n" +
                            "       matchHistory.team2score,\n" +
                            "       myTable.`name` AS 'Team 2 Name'\n" +
                            "FROM matchHistory\n" +
                            "JOIN Participants ON matchHistory.team1id = Participants.id\n" +
                            "JOIN Participants AS myTable ON matchHistory.team2id = myTable.id;");

                    ResultSet rs = ps.executeQuery();

            %>
            <div class="container-generic"> <!-- getting match history -->
                <%
                    while (rs.next()) {

                        String name1 = rs.getString(1);
                        int score1 = Integer.parseInt(rs.getString(2));
                        int score2 = Integer.parseInt(rs.getString(3));
                        String name2 = rs.getString(4);
                        count++;
                %>
                <button type="submit" class="btn-get-started"><%=name1%> - <%=score1%> vs <%=score2%> - <%=name2%> </button>

                <%
                    if(count == 3){
                %> <br> <%
                    }
                %>
                <%
                    }
                %>
            </div>
            <%
                } catch (SQLException e) {
                    System.out.println("Erro na conex�o � base de dados" + e);
                }
            %>
            <a href="personalPage.jsp" class="btn-get-started">Back</a>
        </div>
    </section><!-- End Hero Section -->

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
