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
        product = productDAO.doRetrieveByKey(5); // null indica nessun ordinamento
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
	background-size: cover;
	background-repeat: no-repeat;
	/*background-attachment: fixed;*/
	background-position: center;
   	height: 300px;
   	width: 100%;
   	resize: both;
   	/*margin: 10px;*/
   	position: relative;
   	border-radius: 12px;
    border: 1px solid #ddd;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

#banner-info{
	width:150px;
	height:120px;
	background-color: #efe6dd;
	position: absolute;
	right: 30px;
	top: 80px;
	border-radius: 12px;
	margin: 0 10px;
    color: #19231a;
    font-size: 16px;
    font-weight: bold;
    text-decoration: none;
    text-align: center;
    padding: 10px;
    padding-top: 25px;   
}

#banner-button {
    width: 130px;
    height: 50px;
    background-color: #3c7a89;
    position: absolute;
    bottom: 10px;
    border-radius: 12px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top:10px;
    color: white;
    text-decoration: none;
    font-family: "Segoe";
    font-size: 16px;
    font-weight: normal;
}

</style>
</head>

<body>
    <div id="banner" style="background-image: url('<%= product.getImageUrl() %>');">
        <div id="banner-info">
            <div><%= product.getName() %></div>    
            	<a id="banner-button" href="listaProdotti.jsp">
                Dettagli >
            </a>        
        </div>
    </div>
</body>
</html>
