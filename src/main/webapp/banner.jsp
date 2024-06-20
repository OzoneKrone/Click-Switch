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
        product = productDAO.doRetrieveByKey(7); // null indica nessun ordinamento
    } catch (SQLException e) {
        e.printStackTrace(); // Gestisci l'eccezione in modo appropriato
    }
%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div id="banner">
		<div id="banner-info">
			<a><%= product.getName() %></a>	
			<div id="banner-button">
			<a href="listaProdotti.jsp">Dettagli</a>
			</div>		
		</div>
	</div>
</body>
</html>