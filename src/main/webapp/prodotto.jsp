<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.ProductBean"%>

<%
	ProductBean product = (ProductBean) request.getSession().getAttribute("product");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title><%= product.getName() %></title>
	<link rel="stylesheet" href="css/style.css" type="text/css">
</head>
<body>
	<!-- Include della barra di navigazione -->
    <jsp:include page="navbar.jsp" />
	
	<div class="product-details-container">
		<%
			if(product != null){
		%>
			<div class="product-details-image">
				<img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
			</div>
			<div class="product-details-info">
				<h1 class="product-details-name"><%= product.getName() %></h1>
				<p class="product-details-price"><%= product.getPrice() %> €</p>
				<p class="product-details-description"><%= product.getDescription() %></p>
				<form action="AddToCartServlet" method="post">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
					<button class="product-details-add-to-cart-button">Aggiungi al carrello</button>
				</form>
			</div>
		<% } %>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>