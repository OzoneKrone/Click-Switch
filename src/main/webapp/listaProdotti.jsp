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
</head>
<body>
    <h1>Lista Prodotti</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Descrizione</th>
            <th>Prezzo</th>
            <th>Quantità</th>
        </tr>
        <% for (ProductBean product : products) { %>
            <tr>
                <td><%= product.getId() %></td>
                <td><%= product.getName() %></td>
                <td><%= product.getDescription() %></td>
                <td><%= product.getPrice() %></td>
                <td><%= product.getQuantity() %></td>
            </tr>
        <% } %>
    </table>
</body>
</html>
