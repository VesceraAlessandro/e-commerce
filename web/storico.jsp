<%-- 
    Document   : storico
    Created on : May 27, 2019, 11:27:48 PM
    Author     : LS_Fisso
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="servlets.User"%>
<%
    if (request.getParameter("logout") != null) {
        session.removeAttribute("user");
    }
    User user = null;
    if (session.getAttribute("user") != null) {
        user = (User) session.getAttribute("user");
    }
%>



<%
//loading drivers for mysql
    Class.forName("com.mysql.jdbc.Driver");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Storico</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="OneTech shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/cart_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/cart_responsive.css">


        <link rel="stylesheet" type="text/css" href="styles/product_styles.css">

    </head>

    <body>
        <%if (user == null) {%>
        <jsp:include page="login_form.html"/>
        <jsp:include page="register_form.html"/>
        <%}%>
        <div class="super_container">

            <jsp:include page="menu.jsp"/>

            <!-- Cart -->

            <div class="cart_section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-10 offset-lg-1">
                            <div class="cart_container">
                                <div class="cart_title">Storico Ordini</div>
                                <%
                                    if (user != null) {
                                        try {
                                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                            ResultSet rsO = con.createStatement().executeQuery("SELECT * FROM `ordine` WHERE idUtente LIKE " + user.getId());
                                            while (rsO.next()) {
                                %>
                                <div class="cart_items">
                                    <ul class="cart_list">

                                        <%
                                            ResultSet rsP = con.createStatement().executeQuery("SELECT * FROM storico , prodotti WHERE  prodotti.id=storico.idProdotto AND idOrdine LIKE " + rsO.getInt("idOrdine"));

                                            while (rsP.next()) {
                                        %>
                                            <li class="cart_item clearfix">
                                                <div class="cart_item_image"><img style="height: -webkit-fill-available;" src="<%= rsP.getString("foto1")%>" alt=""></div>
                                                <div class="cart_item_info d-flex flex-md-row flex-column justify-content-between">
                                                    <div class="cart_item_name cart_info_col">
                                                        <div class="cart_item_title">Nome</div>
                                                        <div class="cart_item_text"><a href="product.jsp?id=<%= rsP.getInt("prodotti.id")%>"><%= rsP.getString("nome")%></a></div>
                                                    </div>

                                                    <div class="cart_item_quantity cart_info_col">
                                                        <div class="cart_item_title">Quantita</div>
                                                        <div class="cart_item_text"><%= rsP.getInt("quantita")%></div>
                                                    </div>




                                                </div>
                                            </li>
                                        <% }%>     


                                    </ul>
                                </div>

                                <!-- Order Total -->
                                <div class="order_total">
                                    <div class="order_total_content text-md-right">
                                        <div class="order_total_title">Indirizzo:</div>
                                        <div class="order_total_amount"><%= rsO.getString("indirizzoSpedizione") %></div>
                                        <div class="order_total_title"></div>
                                        <div class="order_total_amount"></div>
                                        <div class="order_total_title">Data:</div>
                                        <div class="order_total_amount"><%= rsO.getString("data") %></div>
                                        <div class="order_total_title"></div>
                                        <div class="order_total_amount"></div>
                                        <div class="order_total_title">Totale Ordine:</div>
                                        <div class="order_total_amount"><%= rsO.getFloat("totale") %>€</div>
                                    </div>
                                </div>
                                <%
                                            }
                                            con.close();
                                        } catch (Exception e) {
                                            out.println("<h1>Errore:" + e + " </h1>");
                                        }
                                    }
                                %>
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