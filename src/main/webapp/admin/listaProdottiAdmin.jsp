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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
	<!-- Include della barra di navigazione -->
    <jsp:include page="../navbar.jsp" />
	
    <h1>Lista Prodotti</h1>
    <div class="admin-product-list">
	    <table border="1">
	        <tr>
	            <th>ID</th>
	            <th>Nome</th>
	            <th>Descrizione</th>
	            <th>Prezzo</th>
	            <th>Quantità</th>
	            <th>Disponibile</th>
	            <th>Immagine</th>
	        </tr>
	        <% for (ProductBean product : products) { %>
	            <tr>
	                <td><%= product.getId() %></td>
	                <td><%= product.getName() %></td>
	                <td><%= product.getDescription() %></td>
	                <td><%= product.getPrice() %></td>
	                <td><%= product.getQuantity() %></td>
	                <td><%= product.getIsAvailable() ? "yes" : "no" %></td>
	                <td><img src="${pageContext.request.contextPath}/<%= product.getImageUrl() %>" alt="Missing Image" width="50"></td>
	                <td>
	                	<%if (product.getIsAvailable()) {%>
	                	<a href="${pageContext.request.contextPath}/admin/editProduct.jsp?productId=<%=product.getId()%>"><button>Modifica</button></a>
	                    <form action="${pageContext.request.contextPath}/DeleteProduct" method="post" onsubmit="return confirm('Sei sicuro di voler eliminare questo prodotto?');">
	                        <input type="hidden" name="productId" value="<%= product.getId() %>">
	                        <button type="submit">Elimina</button>
	                    </form>
	                    <%}%>
	                </td>
	            </tr>
	        <% } %>
	    </table>
    </div>
</body>
</html>
