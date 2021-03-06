<%-- 
    Document   : cart
    Created on : May 27, 2019, 4:47:58 PM
    Author     : LS_Fisso
--%>

<%@page import="com.sun.xml.internal.messaging.saaj.packaging.mime.Header"%>
<%@page import="javafx.scene.control.Alert"%>
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
                                <div class="cart_title">Checkout</div>
                                <br>
                                <form method="GET" action="confirm.jsp">
                                    Indirizzo:
                                    <div class="contact_form_text">
                                        <textarea id="contact_form_message" class="text_field contact_form_message" name="indirizzo" rows="4" placeholder="Indirizzo" required="required" data-error="Inserire l'indirizzo."></textarea>
                                    </div>
                                    <br>


                                    <%
                                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/SevenTechData", "root", "");
                                        ResultSet rs = con.createStatement().executeQuery("SELECT * FROM `carrello`, prodotti WHERE carrello.idProdotto = prodotti.id And carrello.idUtente LIKE " + user.getId());
                                        float tot = 0;
                                        while (rs.next()) {
                                            tot += rs.getFloat("prezzoScontato") * rs.getInt("quantita");
                                        }
                                        if(tot == 0){
                                            response.sendRedirect("cart.jsp");
                                        }
                                    %>

                                    <h3>Totale: <%=tot%></h3><br>
                                    <input type="hidden" name="tot" value=" <%=tot%>">
                                    <%
                                        con.close();
                                    %>
                                    Pagamento:
                                    <br>

                                    <div id="paypal"></div>
                                    <script src="https://www.paypal.com/sdk/js?client-id=sb"></script>
                                    <script>paypal.Buttons().render('#paypal');</script>
                                    <br><br>
                                    <button type="submit" class="button cart_button_checkout">Conferma ordine</button>
                                </form>
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