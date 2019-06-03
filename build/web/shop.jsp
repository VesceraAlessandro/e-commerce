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
    if (request.getParameter("username") != null) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        //creating connection with the database 
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
            PreparedStatement ps = con.prepareStatement("select * from utenti where username=? and password=?");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            boolean st = rs.next();
            con.close();

            if (st) {
                out.println("<h1>Ciao " + username + " " + password + "</h1>");
            } else {
                out.println("<h1>Non valido</h1>");
            }
        } catch (Exception e) {
            out.println("<h1>Errore connesione:" + e + " </h1>");
        }

    }

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Shop</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="OneTech shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
        <link rel="stylesheet" type="text/css" href="plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
        <link rel="stylesheet" type="text/css" href="styles/shop_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/shop_responsive.css">

    </head>

    <body>
        <%if (user == null) {%>
        <jsp:include page="login_form.html"/>
        <jsp:include page="register_form.html"/>
        <%}%>
        <div class="super_container">

            <jsp:include page="menu.jsp"/>

            <!-- Home -->

            <div class="home">
                <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/shop_background.jpg"></div>
                <div class="home_overlay"></div>
                <div class="home_content d-flex flex-column align-items-center justify-content-center">
                    <h2 class="home_title">
                        <%                                                    //print category name
                            try {
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                String sql = "";
                                if (request.getParameterMap().containsKey("category")) {
                                    sql = "select categorie.nomeCategoria from categorie WHERE idCategoria = '" + request.getParameter("category") + "'";
                                    ResultSet rs = con.createStatement().executeQuery(sql);
                                    while (rs.next()) {
                        %>
                        <% out.print(rs.getString("nomeCategoria")); %>
                            <%      }
                                    con.close();
                                    }
                                else{
                                    %> Shop <%
                                }
                             } catch (Exception e) {
                                    out.println("<h1>Errore:" + e + " </h1>");
                             }
                            %>
                    </h2>
                </div>
            </div>

            <!-- Shop -->

            <div class="shop">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3">

                            <!-- Shop Sidebar -->
                            <div class="shop_sidebar">
                                <div class="sidebar_section">
                                    <div class="sidebar_title">Categorie</div>
                                    <ul class="sidebar_categories">
                                        <li><a href="shop.jsp">All</a></li>
                                            <%                                                    //print categories
                                                try {
                                                    
                                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                                    ResultSet rs = con.createStatement().executeQuery("SELECT DISTINCT * FROM `categorie`");

                                                    while (rs.next()) {
                                            %>
                                        <li><a href="shop.jsp?category=<% out.print(rs.getString("idCategoria")); %>"><% out.print(rs.getString("nomeCategoria"));; %> </a></li>
                                            <%      }
                                                    con.close();
                                                } catch (Exception e) {
                                                    out.println("<h1>Errore:" + e + " </h1>");
                                                }

                                            %>
                                    </ul>
                                </div>
                                <div class="sidebar_section filter_by_section">
                                    <div class="sidebar_title">Filtra per</div>
                                    <div class="sidebar_subtitle">Prezzo</div>
                                    <div class="filter_price">
                                        <div id="slider-range" class="slider_range"></div>
                                        <p>Range: </p>
                                        <p><input type="text" id="amount" class="amount" readonly style="border:0; font-weight:bold;"></p>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-9">

                            <!-- Shop Content -->

                            <div class="shop_content">
                                <div class="shop_bar clearfix">
                                    <!--<div class="shop_product_count"><span>186</span> products found</div>-->
                                    <div class="shop_sorting">
                                        <span>Ordina per:</span>
                                        <ul>
                                            <li>
                                                <span class="sorting_text">default<i class="fas fa-chevron-down"></span></i>
                                                <ul>
                                                    <li class="shop_sorting_button" data-isotope-option='{ "sortBy": "original-order" }'>default</li>
                                                    <li class="shop_sorting_button" data-isotope-option='{ "sortBy": "name" }'>nome</li>
                                                    <li class="shop_sorting_button"data-isotope-option='{ "sortBy": "price" }'>prezzo</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="product_grid">
                                    <div class="product_grid_border"></div>

                                    <!-- Product Item NUOVO
                                    <div class="product_item is_new">
                                            <div class="product_border"></div>
                                            <div class="product_image d-flex flex-column align-items-center justify-content-center"><img src="images/new_5.jpg" alt=""></div>
                                            <div class="product_content">
                                                    <div class="product_price">$225</div>
                                                    <div class="product_name"><div><a href="#" tabindex="0">Philips BT6900A</a></div></div>
                                            </div>
                                            <div class="product_fav"><i class="fas fa-heart"></i></div>
                                            <ul class="product_marks">
                                                    <li class="product_mark product_discount">-25%</li>
                                                    <li class="product_mark product_new">new</li>
                                            </ul>
                                    </div>-->

                                    <!-- Product Item SCONTATO
                                    <div class="product_item discount">
                                            <div class="product_border"></div>
                                            <div class="product_image d-flex flex-column align-items-center justify-content-center"><img src="images/featured_1.png" alt=""></div>
                                            <div class="product_content">
                                                    <div class="product_price">$225<span>$300</span></div>
                                                    <div class="product_name"><div><a href="#" tabindex="0">Huawei MediaPad...</a></div></div>
                                            </div>
                                            <div class="product_fav"><i class="fas fa-heart"></i></div>
                                            <ul class="product_marks">
                                                    <li class="product_mark product_discount">-25%</li>
                                                    <li class="product_mark product_new">new</li>
                                            </ul>
                                    </div>-->

                                    <%                                            //print product
                                        try {

                                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                            String sql = "";
                                            if (request.getParameterMap().containsKey("searchText")) {
                                                sql = "select * from prodotti WHERE LOWER(prodotti.nome) LIKE '%" + request.getParameter("searchText") + "%'";
                                            } else if (request.getParameterMap().containsKey("category")) {
                                                sql = "select * from prodotti WHERE prodotti.categoria = '" + request.getParameter("category") + "'";
                                            } else {
                                                sql = "select * from prodotti";
                                            }
                                            ResultSet rs = con.createStatement().executeQuery(sql);
                                            while (rs.next()) {
                                    %>

                                    <!-- Product Item -->
                                    <div class="product_item">
                                        <div class="product_border"></div>
                                        <div class="product_image d-flex flex-column align-items-center justify-content-center"><img style="height: -webkit-fill-available;" src="<%= rs.getString("foto1")%>" alt=""></div>
                                        <div class="product_content">
                                            <div class="product_price"><%= rs.getFloat("prezzoScontato")%><span><%= rs.getFloat("prezzo")%></span></div>
                                            <div class="product_name"><div><a href="product.jsp?id=<%= rs.getString("id")%>" tabindex="0"><%= rs.getString("nome")%></a></div></div>
                                        </div>
                                        <!--									<div class="product_fav"><i class="fas fa-heart"></i></div>-->
                                        <ul class="product_marks">
                                            <li class="product_mark product_discount">-25%</li>
                                            <li class="product_mark product_new">new</li>
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

                            <!-- Shop Page Navigation -->

                            <div class="shop_page_nav d-flex flex-row">
                                <div class="page_prev d-flex flex-column align-items-center justify-content-center"><i class="fas fa-chevron-left"></i></div>
                                <ul class="page_nav d-flex flex-row">
                                    <li><a href="#">1</a></li>
                                    <li><a href="#">2</a></li>
                                    <li><a href="#">3</a></li>
                                    <li><a href="#">...</a></li>
                                    <li><a href="#">21</a></li>
                                </ul>
                                <div class="page_next d-flex flex-column align-items-center justify-content-center"><i class="fas fa-chevron-right"></i></div>
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

        <!-- Newsletter -->

        <div class="newsletter">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="newsletter_container d-flex flex-lg-row flex-column align-items-lg-center align-items-center justify-content-lg-start justify-content-center">
                            <div class="newsletter_title_container">
                                <div class="newsletter_icon"><img src="images/send.png" alt=""></div>
                                <div class="newsletter_title">Sign up for Newsletter</div>
                                <div class="newsletter_text"><p>...and receive %20 coupon for first shopping.</p></div>
                            </div>
                            <div class="newsletter_content clearfix">
                                <form action="#" class="newsletter_form">
                                    <input type="email" class="newsletter_input" required="required" placeholder="Enter your email address">
                                    <button class="newsletter_button">Subscribe</button>
                                </form>
                                <div class="newsletter_unsubscribe_link"><a href="#">unsubscribe</a></div>
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
    <script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
    <script src="plugins/easing/easing.js"></script>
    <script src="plugins/Isotope/isotope.pkgd.min.js"></script>
    <script src="plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
    <script src="plugins/parallax-js-master/parallax.min.js"></script>
    <script src="js/shop_custom.js"></script>
</body>

</html>