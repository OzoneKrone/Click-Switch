<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.UserBean" %>

<%
    UserBean currentUser = (UserBean) session.getAttribute("currentUser");
%>

<!DOCTYPE html>
<html>
<head>
	<title>Navbar</title>
	<meta charset="UTF-8">
    <title>Click &amp; Switch Homepage</title>
</head>
<body>
	<nav class="navbar">
    <div class="logo">
        <a href="index.jsp"><img src="images/logo.png" alt="Logo"></a>
    </div>
    <div class="links">
        <a href="index.jsp">Home</a>
        <a href="listaProdotti.jsp">Prodotti</a>
    </div>
    <div class="actions">   
        <a href="viewCart.jsp"><img src="images/cart_icon.png" alt="Cart" width="24" height="24"></a>
        <div id="menu-user">
        	<img src="images/menu_icon.png" alt="Menu" width="24" height="24">
	        <div id="dropdown-user">
	        <ul>
	        	<% if (currentUser == null) { %>
		        <li><a href="login.jsp">Login</a><li>
		        <li><a href="register.jsp">Registrati</a><li>		        
		        <% } else {%>
		        <li><a href="Logout">Logout</a></li>
		        <li><a href="listaOrdini.jsp">Ordini</a></li>
		        <% if (currentUser.getRole().equals("admin")) { %>
		        	<li><a href="listaProdottiAdmin.jsp">Modifica catalogo</a></li>
		        	<li><a href="listaOrdiniAdmin.jsp">Visualizza Ordini</a></li>
		        	<li><a href="listaUtenti.jsp">Visualizza Utenti</a></li>
		        	<li><a href="addProduct.jsp">Aggiungi prodotto</a></li>		        	
		        <% }	} %>
		    </ul>
	        </div>
	    </div>
    </div>
	</nav>
</body>
</html>