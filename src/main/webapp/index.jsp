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
</head>
<body>
    <h1>Homepage</h1>
    
    <% if (currentUser != null) { %>
        <p>Buongiorno, <%= currentUser.getName() %>!</p>
        <a href="Logout">Logout</a>
        <% if (currentUser.getRole().equals("admin")) { %>
        	<p>Sei un Admin!<p>
        	<p><a href="listaUtenti.jsp">Visualizza lista utenti</a></p>
        <% } %>
    <% } else { %>
        <p>Benvenuto, ospite!</p>
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
    <% } %>
	
	<h1>Benvenuto su Click &amp; Switch</h1>
    <p>Sei pronto per esplorare la nostra selezione di prodotti?</p>
    <!-- Aggiungi un link per visualizzare la lista dei prodotti -->
    <p><a href="listaProdotti.jsp">Visualizza lista prodotti</a></p>
    <!-- Rest of your homepage content -->
</body>
</html>
