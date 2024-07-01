<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Collection"%>
<%@ page import="model.ProductBean"%>
<%@ page import="model.ProductDAODataSource"%>
<%@ page import="java.sql.SQLException"%>

<%
    // Ottieni la lista dei prodotti dal database
    ProductBean product = null;
    try {
        ProductDAODataSource productDAO = new ProductDAODataSource();
        product = productDAO.doRetrieveByKey(1); // null indica nessun ordinamento
    } catch (SQLException e) {
        e.printStackTrace(); // Gestisci l'eccezione in modo appropriato
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Banner</title>

<link rel="stylesheet" href="css/style.css" type="text/css">

<style>
#banner {
	background-image: url("../images/nk65.jpg");
}
</style>
</head>

<body>
    <div id="banner" style="background-image: url('<%= product.getImageUrl() %>');">
        <div id="banner-info">
            <div><%= product.getName() %></div>    
            	<a id="banner-button" href="ProductServlet?id=<%= product.getId() %>">
                Dettagli >
            </a>        
        </div>
    </div>
</body>
</html>
