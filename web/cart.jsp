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

    if (request.getParameter("id") != null && user != null) {
        String id = request.getParameter("id");
        String quantita = request.getParameter("quantita");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
        if (!quantita.equals("0")) {
            PreparedStatement ps = con.prepareStatement("UPDATE `carrello` SET `quantita` = ? WHERE `carrello`.`id` = ?");
            ps.setString(1, quantita);
            ps.setString(2, id);
            ps.executeUpdate();
        } else {
            PreparedStatement ps = con.prepareStatement("DELETE FROM `carrello` WHERE `carrello`.`id` = ?");
            ps.setString(1, id);
            ps.executeUpdate();
        }
        con.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Carrello</title>
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
                                <div class="cart_title">Carrello</div>
                                <div class="cart_items">
                                    <ul class="cart_list">
                                        <%                                            float tot = 0;
                                            //print cart
                                            if (user != null) {
                                                try {

                                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                                    ResultSet rs = con.createStatement().executeQuery("SELECT * FROM `carrello`, prodotti WHERE carrello.idProdotto = prodotti.id And carrello.idUtente LIKE " + user.getId());

                                                    while (rs.next()) {
                                                        tot += rs.getFloat("prezzoScontato") * rs.getInt("quantita");
                                        %>
                                        <form action="" method="POST" name="form_<%= rs.getInt("carrello.id")%>">
                                            <li class="cart_item clearfix">
                                                <div class="cart_item_image"><img style="height: -webkit-fill-available;" src="<%= rs.getString("foto1")%>" alt=""></div>
                                                <div class="cart_item_info d-flex flex-md-row flex-column justify-content-between">
                                                    <div class="cart_item_name cart_info_col">
                                                        <div class="cart_item_title">Nome</div>
                                                        <div class="cart_item_text"><a href="product.jsp?id=<%= rs.getInt("prodotti.id")%>"><%= rs.getString("nome")%></a></div>
                                                    </div>

                                                    <div class="cart_item_quantity cart_info_col">
                                                        <br>
                                                        <div class="product_quantity clearfix">
                                                            <span>Quantita': </span>
                                                            <input id="quantity_input_<%= rs.getInt("carrello.id")%>" type="text" pattern="[1-9]*" value="<%= rs.getInt("quantita")%>" name="quantita" onchange="document.form -<%= rs.getInt("carrello.id")%>.submit();">
                                                            <div class="quantity_buttons">
                                                                <div id="quantity_inc_button" class="quantity_inc quantity_control" onclick='
                                                                            document.getElementById("quantity_input_<%= rs.getInt("carrello.id")%>").value = "<%= rs.getInt("quantita") + 1%>";
                                                                            document.form_<%= rs.getInt("carrello.id")%>.submit();'
                                                                     ><i class="fas fa-chevron-up"></i></div>
                                                                <div id="quantity_dec_button" class="quantity_dec quantity_control" onclick='
                                                                            document.getElementById("quantity_input_<%= rs.getInt("carrello.id")%>").value = "<%= rs.getInt("quantita") - 1%>";
                                                                            document.form_<%= rs.getInt("carrello.id")%>.submit();'
                                                                     ><i class="fas fa-chevron-down"></i></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="cart_item_price cart_info_col">
                                                        <div class="cart_item_title">Prezzo</div>
                                                        <div class="cart_item_text"><%= rs.getFloat("prezzoScontato")%>€</div>
                                                    </div>
                                                    <div class="cart_item_total cart_info_col">
                                                        <div class="cart_item_title">Totale</div>
                                                        <div class="cart_item_text"><%= rs.getFloat("prezzoScontato") * rs.getInt("quantita")%>€</div>
                                                    </div>
                                                    <div class="cart_item_color cart_info_col">
                                                        <div class="cart_item_title"></div>
                                                        <div class="cart_item_text"><button onclick='
                                                                    document.getElementById("quantity_input_<%= rs.getInt("carrello.id")%>").value = "0";
                                                                    document.form_<%= rs.getInt("carrello.id")%>.submit();'>Elimina</button></div>
                                                    </div>
                                                </div>
                                            </li>
                                        <input style="display: none" name='id' value="<%= rs.getInt("carrello.id")%>">
                                        <% }
                                                    con.close();
                                                } catch (Exception e) {
                                                    out.println("<h1>Errore:" + e + " </h1>");
                                                }
                                            }

                                        %>     


                                    </ul>
                                </div>

                                <!-- Order Total -->
                                <div class="order_total">
                                    <div class="order_total_content text-md-right">
                                        <div class="order_total_title">Totale Ordine:</div>
                                        <div class="order_total_amount"><%=tot%></div>
                                        <input type="hidden" name="tot" value="<%=tot%>"/>
                                    </div>
                                </div>

                                <div class="cart_buttons">

                                    <a href="checkout.jsp" class="button cart_button_checkout">Procedi all'ordine</a>
                                </div>
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