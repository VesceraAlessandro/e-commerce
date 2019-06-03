<%-- 
    Document   : index
    Created on : 7-mag-2019, 10.43.35
    Author     : stefano.rizzi
--%>

<%@page import="java.sql.*"%>


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

    if (request.getParameter("add") != null) {
        String product = request.getParameter("add");

        

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
            PreparedStatement ps = con.prepareStatement("select * from carrello where idUtente LIKE ? and idProdotto LIKE ?");//controllo se il prodotto è già stato inserito
            ps.setString(1, Integer.toString(user.getId()));
            ps.setString(2, product);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                con.createStatement().executeUpdate("UPDATE `carrello` SET `quantita` = '" + (rs.getInt("quantita") + 1) + "' WHERE `carrello`.`id` = " + rs.getInt("id"));
            } else {
                out.println(product);
                ps = con.prepareStatement("INSERT INTO `carrello` (`id`, `idUtente`, `idProdotto`, `quantita`) VALUES (NULL, ? ,  ? ,  1 )");
                ps.setString(1, Integer.toString(user.getId()));
                ps.setString(2, product);
                ps.executeUpdate();
            }

        } catch (Exception e) {
            out.println("Errore:" + e + "");
        }
    }

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>SevenTech</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="OneTech shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
        <link rel="stylesheet" type="text/css" href="plugins/slick-1.8.0/slick.css">
        <link rel="stylesheet" type="text/css" href="styles/main_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/responsive.css">

    </head>

    <body>
        <%if (user == null) {%>
        <jsp:include page="login_form.html"/>
        <jsp:include page="register_form.html"/>
        <%}%>

        <div class="super_container">

            <jsp:include page="menu.jsp"/>

            <!-- Banner -->

            <div class="banner">
                <div class="banner_background" style="background-image:url(images/banner_background.jpg)"></div>
                <div class="container fill_height">
                    <div class="row fill_height">
                        <div class="banner_product_image"><img src="images/banner_product.png" alt=""></div>
                        <div class="col-lg-5 offset-lg-4 fill_height">
                            <div class="banner_content">
                                <h1 class="banner_text">la nuova era degli smartphone</h1>
                                <div class="banner_price"><span>$530</span>$460</div>
                                <div class="banner_product_name">Apple Iphone 6s</div>
                                <div class="button banner_button"><a href="#">Compra ora</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Characteristics -->

            <div class="characteristics">
                <div class="container">
                    <div class="row">

                        <!-- Char. Item -->
                        <div class="col-lg-3 col-md-6 char_col">

                            <div class="char_item d-flex flex-row align-items-center justify-content-start">
                                <div class="char_icon"><img src="images/char_1.png" alt=""></div>
                                <div class="char_content">
                                    <div class="char_title">Spedizione gratuita</div>
                                    <div class="char_subtitle">da $50</div>
                                </div>
                            </div>
                        </div>

                        <!-- Char. Item -->
                        <div class="col-lg-3 col-md-6 char_col">

                            <div class="char_item d-flex flex-row align-items-center justify-content-start">
                                <div class="char_icon"><img src="images/char_2.png" alt=""></div>
                                <div class="char_content">
                                    <div class="char_title">Resi facili</div>
                                    <div class="char_subtitle">direttamente da casa tua</div>
                                </div>
                            </div>
                        </div>

                        <!-- Char. Item -->
                        <div class="col-lg-3 col-md-6 char_col">

                            <div class="char_item d-flex flex-row align-items-center justify-content-start">
                                <div class="char_icon"><img src="images/char_3.png" alt=""></div>
                                <div class="char_content">
                                    <div class="char_title">Pagamento PayPal</div>
                                    <div class="char_subtitle">da $0</div>
                                </div>
                            </div>
                        </div>

                        <!-- Char. Item -->
                        <div class="col-lg-3 col-md-6 char_col">

                            <div class="char_item d-flex flex-row align-items-center justify-content-start">
                                <div class="char_icon"><img src="images/char_4.png" alt=""></div>
                                <div class="char_content">
                                    <div class="char_title">Offerte esclusive</div>
                                    <div class="char_subtitle">prezzi più bassi del web</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Banner 2-->

            <div class="banner_2">
                <div class="banner_2_background" style="background-image:url(images/banner_2_background.jpg)"></div>
                <div class="banner_2_container">
                    <div class="banner_2_dots"></div>
                    <!-- Banner 2 Slider -->

                    <div class="owl-carousel owl-theme banner_2_slider">
                        <%                                                    //print banner 2
                            try {

                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                ResultSet rs = con.createStatement().executeQuery("select * from prodotti, caratteristiche, categorie where categorie.idcategoria=prodotti.categoria AND prodotti.id = caratteristiche.idProdotto AND caratteristiche.tipo LiKE 'Banner 2'");

                                while (rs.next()) {
                        %>

                        <!-- Banner 2 Slider Item -->
                        <div class="owl-item">
                            <div class="banner_2_item">
                                <div class="container fill_height">
                                    <div class="row fill_height">
                                        <div class="col-lg-4 col-md-6 fill_height">
                                            <div class="banner_2_content">
                                                <div class="banner_2_category"><%= rs.getString("nomeCategoria")%></div>
                                                <div class="banner_2_title"><%= rs.getString("nome")%></div>
                                                <div class="banner_2_text"><%= rs.getString("descrizione")%></div>
                                                <!--                                                <div class="rating_r rating_r_4 banner_2_rating"><i></i><i></i><i></i><i></i><i></i></div>-->
                                                <div class="button banner_2_button"><a href="product.jsp?id=<%= rs.getInt("id")%>">Di più</a></div>
                                            </div>

                                        </div>
                                        <div class="col-lg-8 col-md-6 fill_height">
                                            <div class="banner_2_image_container">
                                                <div class="banner_2_image"><img src="<%= rs.getString("foto1")%>" alt=""></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>            
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

            <!-- Popular Categories -->

            <div class="popular_categories">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="popular_categories_content">
                                <div class="popular_categories_title">Categorie popolari</div>
                                <div class="popular_categories_slider_nav">
                                    <div class="popular_categories_prev popular_categories_nav"><i class="fas fa-angle-left ml-auto"></i></div>
                                    <div class="popular_categories_next popular_categories_nav"><i class="fas fa-angle-right ml-auto"></i></div>
                                </div>
                            </div>
                        </div>

                        <!-- Popular Categories Slider -->

                        <div class="col-lg-9">
                            <div class="popular_categories_slider_container">
                                <div class="owl-carousel owl-theme popular_categories_slider">

                                    <!-- Popular Categories Item -->
                                    <div class="owl-item">
                                        <div class="popular_category d-flex flex-column align-items-center justify-content-center">
                                            <div class="popular_category_image"><img src="images/popular_1.png" alt=""></div>
                                            <div class="popular_category_text">Smartphones & Tablets</div>
                                        </div>
                                    </div>

                                    <!-- Popular Categories Item -->
                                    <div class="owl-item">
                                        <div class="popular_category d-flex flex-column align-items-center justify-content-center">
                                            <div class="popular_category_image"><img src="images/popular_2.png" alt=""></div>
                                            <div class="popular_category_text">Computers & Laptops</div>
                                        </div>
                                    </div>

                                    <!-- Popular Categories Item -->
                                    <div class="owl-item">
                                        <div class="popular_category d-flex flex-column align-items-center justify-content-center">
                                            <div class="popular_category_image"><img src="images/popular_3.png" alt=""></div>
                                            <div class="popular_category_text">Gadgets</div>
                                        </div>
                                    </div>

                                    <!-- Popular Categories Item -->
                                    <div class="owl-item">
                                        <div class="popular_category d-flex flex-column align-items-center justify-content-center">
                                            <div class="popular_category_image"><img src="images/popular_4.png" alt=""></div>
                                            <div class="popular_category_text">Video Games & Console</div>
                                        </div>
                                    </div>

                                    <!-- Popular Categories Item -->
                                    <div class="owl-item">
                                        <div class="popular_category d-flex flex-column align-items-center justify-content-center">
                                            <div class="popular_category_image"><img src="images/popular_5.png" alt=""></div>
                                            <div class="popular_category_text">Accessori</div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Hot New Arrivals -->

            <div class="new_arrivals">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="tabbed_container">
                                <div class="tabs clearfix tabs-right">
                                    <div class="new_arrivals_title">Nuovi arrivi</div>
                                    <ul class="clearfix">
                                        <li class="active"></li>
                                        <!--                                        <li>Audio & Video</li>
                                                                                <li>Laptops & Computers</li>-->
                                    </ul>
                                    <div class="tabs_line"><span></span></div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-9" style="z-index:1;">

                                        <!-- Product Panel -->
                                        <div class="product_panel panel active">
                                            <div class="arrivals_slider slider">

                                                <%                                                    //print hot new arraval page 1
                                                    try {

                                                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                                        ResultSet rs = con.createStatement().executeQuery("select * from prodotti, caratteristiche where prodotti.id = caratteristiche.idProdotto AND caratteristiche.tipo LiKE 'Hot New Arrivals'");

                                                        while (rs.next()) {
                                                %>


                                                <!--Slider Item--> 
                                                <div class="arrivals_slider_item">
                                                    <div class="border_active"></div>
                                                    <div class="product_item is_new d-flex flex-column align-items-center justify-content-center text-center">

                                                        <!--immagine-->
                                                        <div class="product_image d-flex flex-column align-items-center justify-content-center"><img style="height: -webkit-fill-available;" src="<%= rs.getString("foto1")%>" alt=""></div>

                                                        <div class="product_content">
                                                            <!--prezzo--> 
                                                            <div class="product_price"><%=rs.getFloat("prezzo")%>€</div>

                                                            <!--nome-->
                                                            <div class="product_name"><div><a href="product.jsp?id=<%= rs.getInt("id")%>"><%=rs.getString("nome")%></a></div></div>

                                                            <div class="product_extras">
                                                                <!--                                                                <div class="product_color">
                                                                                                                                    <input type="radio" checked name="product_color" style="background:#b19c83">
                                                                                                                                    <input type="radio" name="product_color" style="background:#000000">
                                                                                                                                    <input type="radio" name="product_color" style="background:#999999">
                                                                                                                                </div>-->

                                                                <form name="product.<%=rs.getString("id")%>" action="" method="POST" onsubmit="this.add.value = '<%=rs.getString("id")%>'">
                                                                    <input class="product_cart_button" type="submit" value="Add to cart" name="add" />
                                                                    <!--                                                                    <button class="product_cart_button">Add to Cart</button>-->
                                                                </form>





                                                            </div>

                                                        </div>
                                                        <div class="product_fav"><i class="fas fa-heart"></i></div>
                                                        <ul class="product_marks">
                                                            <li class="product_mark product_discount">-25%</li>
                                                            <li class="product_mark product_new">new</li>
                                                        </ul>
                                                    </div>
                                                </div>

                                                <% }
                                                        con.close();
                                                    } catch (Exception e) {
                                                        out.println("<h1>Errore:" + e + " </h1>");
                                                    }

                                                %>



                                            </div>
                                            <div class="arrivals_slider_dots_cover"></div>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>        
                </div>

                <!-- Best Sellers -->

                <div class="best_sellers">
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <div class="tabbed_container">
                                    <div class="tabs clearfix tabs-right">
                                        <div class="new_arrivals_title">Best Sellers</div>
                                        <ul class="clearfix">
                                            <li class="active"></li>
                                        </ul>
                                        <div class="tabs_line"><span></span></div>
                                    </div>

                                    <div class="bestsellers_panel panel active">

                                        <!-- Best Sellers Slider -->

                                        <div class="bestsellers_slider slider">

                                            <%                                            //print hot new arraval page 1
                                                try {

                                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                                    ResultSet rs = con.createStatement().executeQuery("select * from prodotti, caratteristiche, categorie where categorie.idcategoria=prodotti.categoria AND prodotti.id = caratteristiche.idProdotto AND caratteristiche.tipo LiKE 'Hot Best Sellers'");

                                                    while (rs.next()) {
                                            %>

                                            <!-- Best Sellers Item -->
                                            <div class="bestsellers_item discount">
                                                <div class="bestsellers_item_container d-flex flex-row align-items-center justify-content-start">
                                                    <div class="bestsellers_image"><img src="<%= rs.getString("foto1")%>" alt=""></div>
                                                    <div class="bestsellers_content">
                                                        <div class="bestsellers_category"><a href="#"><%= rs.getString("nomeCategoria")%></a></div>
                                                        <div class="bestsellers_name"><a href="product.jsp?id=<%= rs.getInt("id")%>"><%= rs.getString("nome")%></a></div>
                                                        <!--                                                    <div class="rating_r rating_r_4 bestsellers_rating"><i></i><i></i><i></i><i></i><i></i></div>-->
                                                        <div class="bestsellers_price discount"><%=rs.getFloat("prezzoScontato")%>€<span><%=rs.getFloat("prezzo")%>€</span></div>
                                                    </div>
                                                </div>
                                                <!--                                            <div class="bestsellers_fav active"><i class="fas fa-heart"></i></div>-->
                                                <ul class="bestsellers_marks">
                                                    <li class="bestsellers_mark bestsellers_discount">-<%=(rs.getFloat("prezzo") - rs.getFloat("prezzoScontato")) / rs.getFloat("prezzo") * 100%>%</li>
                                                    <li class="bestsellers_mark bestsellers_new">new</li>
                                                </ul>
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
                </div>

                <!-- Adverts -->

                <div class="adverts">
                    <div class="container">
                        <div class="row">

                            <div class="col-lg-4 advert_col">

                                <!-- Advert Item -->

                                <div class="advert d-flex flex-row align-items-center justify-content-start">
                                    <div class="advert_content">
                                        <div class="advert_title"><a href="#">Trends 2019</a></div>
                                        <div class="advert_text">Prodotti di tendenza nel 2019</div>
                                    </div>
                                    <div class="ml-auto"><div class="advert_image"><img src="images/adv_1.png" alt=""></div></div>
                                </div>
                            </div>

                            <div class="col-lg-4 advert_col">

                                <!-- Advert Item -->

                                <div class="advert d-flex flex-row align-items-center justify-content-start">
                                    <div class="advert_content">
                                        <div class="advert_subtitle">Trends 2018</div>
                                        <div class="advert_title_2"><a href="#">Sale -45%</a></div>
                                        <div class="advert_text">Lorem ipsum dolor sit amet, consectetur.</div>
                                    </div>
                                    <div class="ml-auto"><div class="advert_image"><img src="images/adv_2.png" alt=""></div></div>
                                </div>
                            </div>

                            <div class="col-lg-4 advert_col">

                                <!-- Advert Item -->

                                <div class="advert d-flex flex-row align-items-center justify-content-start">
                                    <div class="advert_content">
                                        <div class="advert_title"><a href="#">Trends 2018</a></div>
                                        <div class="advert_text">Lorem ipsum dolor sit amet, consectetur.</div>
                                    </div>
                                    <div class="ml-auto"><div class="advert_image"><img src="images/adv_3.png" alt=""></div></div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Trends -->

                <div class="trends">
                    <div class="trends_background" style="background-image:url(images/trends_background.jpg)"></div>
                    <div class="trends_overlay"></div>
                    <div class="container">
                        <div class="row">

                            <!-- Trends Content -->
                            <div class="col-lg-3">
                                <div class="trends_container">
                                    <h2 class="trends_title">Trends 2019</h2>
                                    <div class="trends_text"><p>I migliori prodotti in tendenza</p></div>
                                    <div class="trends_slider_nav">
                                        <div class="trends_prev trends_nav"><i class="fas fa-angle-left ml-auto"></i></div>
                                        <div class="trends_next trends_nav"><i class="fas fa-angle-right ml-auto"></i></div>
                                    </div>
                                </div>
                            </div>

                            <!-- Trends Slider -->
                            <div class="col-lg-9">
                                <div class="trends_slider_container">

                                    <!-- Trends Slider -->

                                    <div class="owl-carousel owl-theme trends_slider">

                                        <%                                                    //print Tend Item
                                            try {

                                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                                ResultSet rs = con.createStatement().executeQuery("select * from prodotti, caratteristiche, categorie where categorie.idcategoria=prodotti.categoria AND prodotti.id = caratteristiche.idProdotto AND caratteristiche.tipo LiKE 'Trend 2019'");

                                                while (rs.next()) {
                                        %>

                                        <!-- Trends Slider Item -->
                                        <div class="owl-item">
                                            <div class="trends_item is_new">
                                                <div class="trends_image d-flex flex-column align-items-center justify-content-center"><img style="height: -webkit-fill-available;" src="<%= rs.getString("foto1")%>" alt=""></div>
                                                <div class="trends_content">
                                                    <div class="trends_category"><a href="#"><%= rs.getString("nomeCategoria")%></a></div>
                                                    <div class="trends_info clearfix">
                                                        <div class="trends_name"><a href="product.jsp?id=<%= rs.getInt("id")%>"><%= rs.getString("nome")%></a></div>
                                                        <div class="trends_price"><%=rs.getFloat("prezzoScontato")%></div>
                                                    </div>
                                                </div>

                                                <div class="trends_fav"><i class="fas fa-heart"></i></div>
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

            <script src="js/jquery-3.3.1.min.js"></script>
            <script src="styles/bootstrap4/popper.js"></script>
            <script src="styles/bootstrap4/bootstrap.min.js"></script>
            <script src="plugins/greensock/TweenMax.min.js"></script>
            <script src="plugins/greensock/TimelineMax.min.js"></script>
            <script src="plugins/scrollmagic/ScrollMagic.min.js"></script>
            <script src="plugins/greensock/animation.gsap.min.js"></script>
            <script src="plugins/greensock/ScrollToPlugin.min.js"></script>
            <script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
            <script src="plugins/slick-1.8.0/slick.js"></script>
            <script src="plugins/easing/easing.js"></script>
            <script src="js/custom.js"></script>
    </body>

</html>