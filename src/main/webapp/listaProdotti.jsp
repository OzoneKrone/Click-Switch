<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection"%>
<%@ page import="model.ProductBean"%>
<%@ page import="control.ProductDAODataSource"%>
<%@ page import="java.sql.SQLException"%>

<%
    // Ottieni la lista dei prodotti dal database
    Collection<ProductBean> products = null;
    try {
        ProductDAODataSource productDAO = new ProductDAODataSource();
        products = productDAO.doRetrieveAll(null); // null indica nessun ordinamento
    } catch (SQLException e) {
        e.printStackTrace(); // Gestisci l'eccezione in modo appropriato
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista Prodotti</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
</head>
<body>
	<!-- Include della barra di navigazione -->
    <jsp:include page="navbar.jsp" />
	
    <h1>Lista Prodotti</h1>
    <table border="1">
        <tr>
            <th>Nome</th>
            <th>Descrizione</th>
            <th>Prezzo</th>
            <th>Immagine</th>
            <th>Aggiungi al Carrello</th>
        </tr>
        <% for (ProductBean product : products) { %>
            <tr>
            	<%if (product.getIsAvailable()) {%>
	                <td><%= product.getName() %></td>
	                <td><%= product.getDescription() %></td>
	                <td><%= product.getPrice() %></td>
	                <td><img src=<%= product.getImageUrl() %> alt="No Image"></td>
	                <td>
                    <form action="AddToCartServlet" method="post">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <button type="submit">Aggiungi al Carrello</button>
                    </form>
               		</td>
	            <%} %>
            </tr>
        <% } %>
    </table>
</body>
</html>
