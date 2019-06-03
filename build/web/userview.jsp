<%@ page import="servlets.User"%>
<%User user= (User)session.getAttribute("user");%>
    <div class="usr-style">
    <%= user.getName() + " " + user.getLastname()%>
</div>
<div>
    <form name="form_logout" action="#" method="POST">
        <button type="submit" name="logout" class="usr-style usr-button">Esci</button>
    </form>
</div>
<link rel="stylesheet" type="text/css" href="styles/userview_styles.css">