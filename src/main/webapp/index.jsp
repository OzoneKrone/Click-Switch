<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.UserBean" %>
<%@ page import="java.util.Collection"%>
<%@ page import="model.ProductBean"%>
<%@ page import="model.ProductDAODataSource"%>
<%@ page import="java.sql.SQLException"%>

<%
    UserBean currentUser = (UserBean) session.getAttribute("currentUser");
	//Ottieni la lista dei prodotti dal database
	Collection<ProductBean> products = null;
	try {
	    ProductDAODataSource productDAO = new ProductDAODataSource();
	    products = productDAO.doRetrieveAll("ID DESC"); // null indica nessun ordinamento
	} catch (SQLException e) {
	    e.printStackTrace(); // Gestisci l'eccezione in modo appropriato
	}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Click &amp; Switch Homepage</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <meta name="viewport" content="initial-scale=1, width=device-width">
</head>
<body>
	<!-- Include della barra di navigazione -->
    <jsp:include page="navbar.jsp" />
	<jsp:include page="banner.jsp" />
	
	<h2>Nuovi Prodotti</h2>
	<!-- Sezione dei prodotti -->
    <div class="product-grid">
    <% if (products != null && !products.isEmpty()) {
        int count = 0; // Contatore per il numero di prodotti visualizzati
        for (ProductBean product : products) { 
            if (count >= 8) {
                break; // Interrompi il ciclo se sono stati visualizzati 6 prodotti
            }
            if (product.getIsAvailable()){
            count++; // Incrementa il contatore
    %>
            <a class="product-item" href="ProductServlet?id=<%= product.getId() %>">
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
	<jsp:include page="footer.jsp" />
</body>
</html>
