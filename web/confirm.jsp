<%-- 
    Document   : cart
    Created on : May 27, 2019, 4:47:58 PM
    Author     : LS_Fisso
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Class.forName("com.mysql.jdbc.Driver");
%>
<%@ page import="servlets.User"%>
<%
    if (request.getParameter("logout") != null) {
        session.removeAttribute("user");
    }
    User user = null;
    if (session.getAttribute("user") != null) {
        user = (User) session.getAttribute("user");
    }
    
    if(request.getParameter("indirizzo") != null){
         try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
            PreparedStatement ps = con.prepareStatement("INSERT INTO `ordine` (`idOrdine`, `idUtente`, `data`, `totale`, `indirizzoSpedizione`) VALUES (NULL, ?, ?, ?, ?); ");
            /*SELECT LAST_INSERT_ID(); per avere l'idOrdine appena inserito (da usare in insert into storico*/
            ps.setString(1, Integer.toString(user.getId()));
            java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
            ps.setTimestamp(2, date);
            ps.setString(3, request.getParameter("tot"));
            ps.setString(4, request.getParameter("indirizzo"));
            ps.execute();
            ResultSet idOrdine = ps.getResultSet();
            
            /*foreach(request.){
            PreparedStatement ps2 = con.prepareStatement("INSERT INTO `storico` (`id`, `idOrdine`, `idProdotto`, `quantita`) VALUES (NULL, ?, ?, ?)");
            ps2.setInt(1, idOrdine.getInt("idOrdine"));
            ps2.setInt(2, );
            }*/
            
            con.close();
            

        } catch (Exception e) {
            out.println("Errore:" + e + "");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Checkout</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="OneTech shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">

        
        <link rel="stylesheet" type="text/css" href="styles/contact_styles.css">

        <link rel="stylesheet" type="text/css" href="styles/product_styles.css">

    </head>

    <body>

        <div class="super_container">

            <jsp:include page="menu.jsp"/>

            <!-- Cart -->

            <div class="cart_section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-10 offset-lg-1">
                            <div class="cart_container">
                                <h2>Ordine effettuato con successo</h2>
                                <br> <h4>Grazie per aver acquistato su STech</h4><br>
                                <a href="index.jsp" class="button cart_button_checkout">Torna alla home</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Footer -->

            <jsp:include page="footer.html"/>

            <!-- Copyright -->

            <div class="copyright">
                <div class="container">
                    <div class="row">
                        <div class="col">

                            <div class="copyright_container d-flex flex-sm-row flex-column align-items-center justify-content-start">
                                <div class="copyright_content"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                    Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                </div>
                                <div class="logos ml-sm-auto">
                                    <ul class="logos_list">
                                        <li><a href="#"><img src="images/logos_1.png" alt=""></a></li>
                                        <li><a href="#"><img src="images/logos_2.png" alt=""></a></li>
                                        <li><a href="#"><img src="images/logos_3.png" alt=""></a></li>
                                        <li><a href="#"><img src="images/logos_4.png" alt=""></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/greensock/TweenMax.min.js"></script>
        <script src="plugins/greensock/TimelineMax.min.js"></script>
        <script src="plugins/scrollmagic/ScrollMagic.min.js"></script>
        <script src="plugins/greensock/animation.gsap.min.js"></script>
        <script src="plugins/greensock/ScrollToPlugin.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="js/cart_custom.js"></script>



    </body>

</html>