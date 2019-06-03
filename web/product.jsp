<%-- 
    Document   : product
    Created on : May 27, 2019, 1:08:01 PM
    Author     : LS_Fisso
--%>


<%@page import="java.sql.PreparedStatement"%>
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
    
    if (request.getParameter("add") != null && user!=null) {
        String product = request.getParameter("add");
        String quantita = request.getParameter("quantita");
        
        
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
            PreparedStatement ps = con.prepareStatement("select * from carrello where idUtente LIKE ? and idProdotto LIKE ?");//controllo se il prodotto è già stato inserito
            ps.setString(1, Integer.toString(user.getId()));
            ps.setString(2, product);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                ps = con.prepareStatement("UPDATE `carrello` SET `quantita` = ? WHERE `carrello`.`id` = "+rs.getInt("id"));
                ps.setString(1, quantita);
                ps.executeUpdate();
            }else{
                ps = con.prepareStatement("INSERT INTO `carrello` (`id`, `idUtente`, `idProdotto`, `quantita`) VALUES (NULL, ? ,  ? ,  ? )");
                ps.setString(1, Integer.toString(user.getId()));
                ps.setString(2, product);
                ps.setString(3, quantita);
                ps.executeUpdate();
            }
            con.close();
            
        } catch (Exception e) {
            out.println("Errore:" + e + "");
        }
    }



%>




<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Single Product</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="OneTech shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
        <link rel="stylesheet" type="text/css" href="styles/product_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/product_responsive.css">

    </head>

    <body>
        <%if (user == null) {%>
        <jsp:include page="login_form.html"/>
        <jsp:include page="register_form.html"/>
        <%}%>
        <div class="super_container">

             <jsp:include page="menu.jsp"/>

            <!-- Single Product -->

            <%
                if (request.getParameter("id") != null) {
                    String id = request.getParameter("id");
                    try {

                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");

                        PreparedStatement ps = con.prepareStatement("select * from prodotti,categorie where categorie.idcategoria=prodotti.categoria AND prodotti.id LIKE ?");
                        ps.setString(1, id);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) {

            %>

            <div class="single_product">
                <div class="container">
                    <div class="row">

                        <!-- Images -->
                        <div class="col-lg-2 order-lg-1 order-2">
                            <ul class="image_list">
                                <li data-image="<%= rs.getString("foto1")%>"><img src="<%= rs.getString("foto1")%>" alt=""></li>
                                <li data-image="<%= rs.getString("foto2")%>"><img src="<%= rs.getString("foto2")%>" alt=""></li>
                                <li data-image="<%= rs.getString("foto3")%>"><img src="<%= rs.getString("foto3")%>" alt=""></li>
                            </ul>
                        </div>

                        <!-- Selected Image -->
                        <div class="col-lg-5 order-lg-2 order-1">
                            <div class="image_selected"><img src="<%= rs.getString("foto1")%>" alt=""></div>
                        </div>

                        <!-- Description -->
                        <div class="col-lg-5 order-3">
                            <div class="product_description">
                                <div class="product_category"><%= rs.getString("nomeCategoria")%></div>
                                    <div class="product_name"><%= rs.getString("nome")%></div>
                                    <!--                                <div class="rating_r rating_r_4 product_rating"><i></i><i></i><i></i><i></i><i></i></div>-->
                                    <div class="product_text"><p><%= rs.getString("descrizione")%></p></div>
                                    <div class="order_info d-flex flex-row">
                                        <form name="product.<%=rs.getString("id")%>" action="" method="POST" onsubmit="this.add.value = '<%=rs.getString("id")%>'">
                                            <div class="clearfix" style="z-index: 1000;">

                                                <!-- Product Quantity -->
                                                <div class="product_quantity clearfix">
                                                    <span>Quantità: </span>
                                                    <input id="quantity_input" type="text" pattern="[1-9]*" value="1" name="quantita">
                                                    <div class="quantity_buttons">
                                                        <div id="quantity_inc_button" class="quantity_inc quantity_control"><i class="fas fa-chevron-up"></i></div>
                                                        <div id="quantity_dec_button" class="quantity_dec quantity_control"><i class="fas fa-chevron-down"></i></div>
                                                    </div>
                                                </div>

                                                <!-- Product Color -->
                                                <!--                                            <ul class="product_color">
                                                                                                <li>
                                                                                                    <span>Color: </span>
                                                                                                    <div class="color_mark_container"><div id="selected_color" class="color_mark"></div></div>
                                                                                                    <div class="color_dropdown_button"><i class="fas fa-chevron-down"></i></div>
                                                
                                                                                                    <ul class="color_list">
                                                                                                        <li><div class="color_mark" style="background: #999999;"></div></li>
                                                                                                        <li><div class="color_mark" style="background: #b19c83;"></div></li>
                                                                                                        <li><div class="color_mark" style="background: #000000;"></div></li>
                                                                                                    </ul>
                                                                                                </li>
                                                                                            </ul>
                                                
                                                -->
                                            </div>

                                            <%
                                                if (rs.getFloat("prezzo") == rs.getFloat("prezzoScontato")) {
                                            %>
                                            <div class="product_price"><%=rs.getFloat("prezzo")%>€</div>
                                            <%
                                            } else {
                                            %>
                                            <div class="product_price"><%=rs.getFloat("prezzoScontato")%>€<span><%=rs.getFloat("prezzo")%>€</span></div>
                                            <%
                                                }
                                            %>




                                            <div class="button_container">
                                                <button type="submit" class="button cart_button" name="add">Aggiungi al carrello</button>
                                                <div class="product_fav"><i class="fas fa-heart"></i></div>
                                            </div>

                                        </form>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <%
                        } else {
                            out.println("Prodotto non trovato");
                        }
                        con.close();
                    } catch (Exception e) {
                        out.println("<h1>Errore:" + e + " </h1>");
                    }
                }
            %>


            <!-- Prodotti-->
            <div class="viewed">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="viewed_title_container">
                                <h3 class="viewed_title">Altri Prodotti</h3>
                                <div class="viewed_nav_container">
                                    <div class="viewed_nav viewed_prev"><i class="fas fa-chevron-left"></i></div>
                                    <div class="viewed_nav viewed_next"><i class="fas fa-chevron-right"></i></div>
                                </div>
                            </div>

                            <div class="viewed_slider_container">

                                <!-- Recently Viewed Slider -->

                                <div class="owl-carousel owl-theme viewed_slider">


                                    <%                                            //print 10 product
                                        try {

                                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                            ResultSet rs = con.createStatement().executeQuery("select * from prodotti");

                                            for (int i = 0; i < 10 && rs.next(); i++) {
                                    %>

                                    <!-- Recently Viewed Item -->
                                    <div class="owl-item">
                                        <div class="viewed_item discount d-flex flex-column align-items-center justify-content-center text-center">
                                            <div class="viewed_image"><img src="<%= rs.getString("foto1")%>" alt=""></div>
                                            <div class="viewed_content text-center">
                                                <%
                                                    if (rs.getFloat("prezzo") == rs.getFloat("prezzoScontato")) {
                                                %>
                                                <div class="viewed_price"><%=rs.getFloat("prezzo")%>€</div>
                                                <div class="viewed_name"><a href="#"><%= rs.getString("nome")%></a></div>
                                            </div>
                                            <ul class="item_marks"></ul>
                                                <%
                                                } else {
                                                %>
                                                <div class="viewed_price"><%=rs.getFloat("prezzoScontato")%>€<span><%=rs.getFloat("prezzo")%>€</span></div>
                                                <div class="viewed_name"><a href="#"><%= rs.getString("nome")%></a></div>
                                            </div>
                                            <ul class="item_marks">
                                                <li class="item_mark item_discount">-<%=(rs.getFloat("prezzo") - rs.getFloat("prezzoScontato")) / rs.getFloat("prezzo") * 100%>%</li>
                                            </ul>
                                                <%
                                                    }
                                                %>
                                        </div>
                                    </div>

                                    <% }
                                            con.close();
                                        } catch (Exception e) {
                                            out.println("<h1>Errore:" + e + " </h1>");
                                        }

                                    %>


                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Brands -->

            <div class="brands">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="brands_slider_container">

                                <!-- Brands Slider -->

                                <div class="owl-carousel owl-theme brands_slider">

                                    <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_1.jpg" alt=""></div></div>
                                    <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_2.jpg" alt=""></div></div>
                                    <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_3.jpg" alt=""></div></div>
                                    <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_4.jpg" alt=""></div></div>
                                    <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_5.jpg" alt=""></div></div>
                                    <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_6.jpg" alt=""></div></div>
                                    <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_7.jpg" alt=""></div></div>
                                    <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/brands_8.jpg" alt=""></div></div>

                                </div>

                                <!-- Brands Slider Navigation -->
                                <div class="brands_nav brands_prev"><i class="fas fa-chevron-left"></i></div>
                                <div class="brands_nav brands_next"><i class="fas fa-chevron-right"></i></div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Footer -->

            <jsp:include page="footer.html"/>

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
    <script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
    <script src="plugins/easing/easing.js"></script>
    <script src="js/product_custom.js"></script>
</body>

</html>
