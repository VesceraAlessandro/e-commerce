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
<!-- HEADER E MENU VERSIONE 1.4 -->

<header class="header">

    <!-- Top Bar -->

    <div class="top_bar">
        <div class="container">
            <div class="row">
                <div class="col d-flex flex-row">
                    <div class="top_bar_contact_item"><div class="top_bar_icon"><img src="images/phone.png" alt=""></div>+39 3392591919</div>
                    <div class="top_bar_contact_item"><div class="top_bar_icon"><img src="images/mail.png" alt=""></div><a href="support@eshop.com">support@eshop.com</a></div>
                    <div class="top_bar_content ml-auto">
                        <!--<div class="top_bar_menu">
                            <ul class="standard_dropdown top_bar_dropdown">
                                <li>
                                    <a href="#">$ US dollar<i class="fas fa-chevron-down"></i></a>
                                    <ul>
                                        <li><a href="#">EUR Euro</a></li>
                                        <li><a href="#">GBP British Pound</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>-->
                        <div class="top_bar_user" style="line-height: 56px;">
                            <div class="user_icon"><img src="images/user.svg" alt=""></div>
                                <%if (user == null) {%>
                            <div><a href="#" onclick="setRegisterDisplay('block')">Register</a></div>
                            <div><a href="#" onclick="setLoginDisplay('block')">Sign in</a></div>
                            <%} else {%>
                            <jsp:include page="userview.jsp"/>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>        
    </div>

    <!-- Header Main -->

    <div class="header_main">
        <div class="container">
            <div class="row">

                <!-- Logo -->
                <div class="col-lg-2 col-sm-3 col-3 order-1">
                    <div class="logo_container">
                        <div class="logo"><a href="index.jsp"><i>STech</i></a></div>
                    </div>
                </div>

                <!-- Search -->
                <div class="col-lg-6 col-12 order-lg-2 order-3 text-lg-left text-right">
                    <div class="header_search">
                        <div class="header_search_content">
                            <div class="header_search_form_container">
                                <form action="shop.jsp" method="GET" class="header_search_form clearfix">
                                    <input type="search" name="searchText" required="required" class="header_search_input" placeholder="Search for products...">
                                    <div class="custom_dropdown" style="display: none">
                                        <div class="custom_dropdown_list">
                                            <span class="custom_dropdown_placeholder clc">All Categories</span>
                                            <i class="fas fa-chevron-down"></i>
                                            <ul class="custom_list clc">
                                                <li><a class="clc" href="#">All Categories</a></li>
                                                <li><a class="clc" href="#">Computers</a></li>
                                                <li><a class="clc" href="#">Laptops</a></li>
                                                <li><a class="clc" href="#">Cameras</a></li>
                                                <li><a class="clc" href="#">Hardware</a></li>
                                                <li><a class="clc" href="#">Smartphones</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <button type="submit" class="header_search_button trans_300" value="Submit"><img src="images/search.png" alt=""></button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-9 order-lg-3 order-2 text-lg-left text-right">
                    <div class="wishlist_cart d-flex flex-row align-items-center justify-content-end">
                        <%if (user != null) {%>
                        <!-- Cart -->
                        <div class="cart">
                            <div class="cart_container d-flex flex-row align-items-center justify-content-end">
                                <div class="cart_icon">
                                    <img src="images/cart.png" alt="">
                                    <%
                                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                        ResultSet rs = con.createStatement().executeQuery("SELECT SUM(quantita) FROM carrello WHERE idUtente = " + user.getId());

                                        if (rs.next()) {
                                            %> <div class="cart_count"><span> <%=rs.getInt(1)%> </span></div> <%
                                        }
                                    %>
                                </div>
                                <div class="cart_content">
                                    <div class="cart_text"><a href="cart.jsp">Cart</a></div>
                                    <div class="cart_price"></div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Navigation -->

    <nav class="main_nav">
        <div class="container">
            <div class="row">
                <div class="col">

                    <div class="main_nav_content d-flex flex-row">

                        <!-- Categories Menu -->

                        <div class="cat_menu_container">
                            <div class="cat_menu_title d-flex flex-row align-items-center justify-content-start">
                                <div class="cat_burger"><span></span><span></span><span></span></div>
                                <div class="cat_menu_text">categories</div>
                            </div>

                            <ul class="cat_menu">
                                <%                                                    //print categories
                                    try {

                                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                        ResultSet rs = con.createStatement().executeQuery("SELECT DISTINCT * FROM `categorie`");

                                        while (rs.next()) {
                                %>
                                <li><a href="shop.jsp?category=<% out.print(rs.getString("idCategoria")); %>"><% out.print(rs.getString("nomeCategoria"));; %> <i class="fas fa-chevron-right ml-auto"></i></a></li>
                                        <%      }
                                                con.close();
                                            } catch (Exception e) {
                                                out.println("<h1>Errore:" + e + " </h1>");
                                            }

                                        %>
                            </ul>
                        </div>

                        <!-- Main Nav Menu -->

                        <div class="main_nav_menu ml-auto">
                            <ul class="standard_dropdown main_nav_dropdown">
                                <li><a href="index.jsp">Home<i class="fas fa-chevron-down"></i></a></li>
                                <li><a href="shop.jsp">Shop<i class="fas fa-chevron-down"></i></a></li>
                                <% if (user != null) { %><li><a href="storico.jsp">Storico<i class="fas fa-chevron-down"></i></a></li> <% }%>
                                <li><a href="contact.jsp">Contact<i class="fas fa-chevron-down"></i></a></li>
                            </ul>
                        </div>

                        <!-- Menu Trigger -->

                        <div class="menu_trigger_container ml-auto">
                            <div class="menu_trigger d-flex flex-row align-items-center justify-content-end">
                                <div class="menu_burger">
                                    <div class="menu_trigger_text">menu</div>
                                    <div class="cat_burger menu_burger_inner"><span></span><span></span><span></span></div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Menu -->

    <div class="page_menu">
        <div class="container">
            <div class="row">
                <div class="col">

                    <div class="page_menu_content">

                        <div class="page_menu_search">
                            <form action='#'>
                                <input type="search" id="searchText" required="required" class="page_menu_search_input" placeholder="Search for products...">
                            </form>
                        </div>
                        <ul class="page_menu_nav">

                            <li class="page_menu_item">
                                <a href="index.jsp">Home<i class="fa fa-angle-down"></i></a>
                            </li>
                            <li class="page_menu_item"><a href="contact.jsp">contact<i class="fa fa-angle-down"></i></a></li>
                        </ul>

                        <div class="menu_contact">
                            <div class="menu_contact_item"><div class="menu_contact_icon"><img src="images/phone_white.png" alt=""></div>+38 068 005 3570</div>
                            <div class="menu_contact_item"><div class="menu_contact_icon"><img src="images/mail_white.png" alt=""></div><a href="mailto:fastsales@gmail.com">fastsales@gmail.com</a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</header>

<!-- FINE HEADER E MENU -->