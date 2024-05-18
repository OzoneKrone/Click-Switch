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
    <link rel="stylesheet" href="css/style.css" type="text/css">
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
        <a href="#"><img src="images/cart_icon.png" alt="Cart" width="24" height="24"></a>
        <% if (currentUser == null) { %>
        <a href="login.jsp">Login</a>
        <% } else {%>
        <a href="Logout">Logout</a>
        <% }%>
    </div>
	</nav>
</body>
</html>