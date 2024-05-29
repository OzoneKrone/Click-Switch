<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.UserBean" %>

<%
    UserBean currentUser = (UserBean) session.getAttribute("currentUser");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Click &amp; Switch Homepage</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
</head>
<body>
	<!-- Include della barra di navigazione -->
    <jsp:include page="navbar.jsp" />
	
	<p></p>
    <h1>Homepage</h1>
    
    <% if (currentUser != null) { %>
        <p>Buongiorno, <%= currentUser.getName() %>!</p>
        <p><a href="listaOrdini.jsp">Visualizza lista Ordini</a></p>
        <% if (currentUser.getRole().equals("admin")) { %>
        	<p>Sei un Admin!<p>
        	<p><a href="listaUtenti.jsp">Visualizza lista utenti</a></p>
        	<p><a href="addProduct.jsp">Aggiungi un nuovo prodotto</a></p>
        	
        <% } %>
        
    <% } else { %>
        <p>Benvenuto, ospite!</p>
    <% } %>
	
	<h1>Benvenuto su Click &amp; Switch</h1>

</body>
</html>
