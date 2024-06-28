<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection"%>
<%@ page import="model.ProductBean"%>
<%@ page import="model.ProductDAODataSource"%>
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
	
	<!-- Sezione dei prodotti -->
    <div class="product-grid-catalogo">
    <% if (products != null && !products.isEmpty()) {
        int count = 0; // Contatore per il numero di prodotti visualizzati
        for (ProductBean product : products) { 
            if (count >= 24) {
                break; // Interrompi il ciclo se sono stati visualizzati 6 prodotti
            }
            if (product.getIsAvailable()){
            	count++; // Incrementa il contatore
    %>
            <a class="product-item-catalogo" href="ProductServlet?id=<%= product.getId() %>">
                <div class="product-image">
                    <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                </div>
                <div class="product-name">
                    <%= product.getName() %>
                </div>
                <div class="product-price">
                    <%= product.getPrice() %> €
                </div>
            </a>
    <% 		}	
    	}
    } else { %>
        <p>Non ci sono prodotti disponibili al momento.</p>
    <% } %>
	</div>
	
	
	<!--  
	<p>OLD PAGE</p>
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
	                <td><img src=<%= product.getImageUrl() %> alt="Missing Image" width="300" ></td>
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
    -->
</body>
</html>
