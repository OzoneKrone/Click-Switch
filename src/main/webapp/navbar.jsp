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
        <a href="${pageContext.request.contextPath}/index.jsp"><img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo"></a>
    </div>
    <div class="links">
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/listaProdotti.jsp">Prodotti</a>
    </div>
    <div class="actions">   
        <a href="viewCart.jsp"><img src="${pageContext.request.contextPath}/images/cart_icon.png" alt="Cart" width="24" height="24"></a>
        <div id="menu-user">
        	<img src="${pageContext.request.contextPath}/images/menu_icon.png" alt="Menu" width="24" height="24">
	        <div id="dropdown-user">
	        <ul>
	        	<% if (currentUser == null) { %>
		        <li><a href="${pageContext.request.contextPath}/login.jsp">Login</a><li>
		        <li><a href="${pageContext.request.contextPath}/register.jsp">Registrati</a><li>		        
		        <% } else {%>
		        <li><a href="${pageContext.request.contextPath}/Logout">Logout</a></li>
		        <li><a href="${pageContext.request.contextPath}/common/listaOrdini.jsp">Ordini</a></li>
		        <% if (currentUser.getRole().equals("admin")) { %>
		        	<li><a href="${pageContext.request.contextPath}/admin/listaProdottiAdmin.jsp">Modifica catalogo</a></li>
		        	<li><a href="${pageContext.request.contextPath}/admin/listaOrdiniAdmin.jsp">Visualizza Ordini</a></li>
		        	<li><a href="${pageContext.request.contextPath}/admin/listaUtenti.jsp">Visualizza Utenti</a></li>
		        	<li><a href="${pageContext.request.contextPath}/admin/addProduct.jsp">Aggiungi prodotto</a></li>		        	
		        <% }	} %>
		    </ul>
	        </div>
	    </div>
    </div>
	</nav>
</body>
</html>