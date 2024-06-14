<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Map.Entry"%>
<%@ page import="model.ProductBean"%>
<%@ page import="control.ProductDAODataSource"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.HashMap"%>

<%
    // Recupera il carrello dalla sessione
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    if (cart == null) {
        cart = new HashMap<>();
    }

    // Ottieni i dettagli dei prodotti dal database
    ProductDAODataSource productDAO = new ProductDAODataSource();
    Map<ProductBean, Integer> productsInCart = new HashMap<>();

    try {
        for (Entry<Integer, Integer> entry : cart.entrySet()) {
            ProductBean product = productDAO.doRetrieveByKey(entry.getKey());
            if (product != null) {
                productsInCart.put(product, entry.getValue());
            }
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Gestisci l'eccezione in modo appropriato
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrello</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
</head>
<body>
    <!-- Include della barra di navigazione -->
    <jsp:include page="navbar.jsp" />
    
    <h1>Il tuo Carrello</h1>
    <table border="1">
        <tr>
            <th>Nome</th>
            <th>Descrizione</th>
            <th>Prezzo</th>
            <th>Quantità</th>
            <th>Totale</th>
        </tr>
        <% double total = 0; %>
        <% for (Entry<ProductBean, Integer> entry : productsInCart.entrySet()) { %>
            <tr>
                <td><%= entry.getKey().getName() %></td>
                <td><%= entry.getKey().getDescription() %></td>
                <td><%= entry.getKey().getPrice() %></td>
                <td><%= entry.getValue() %></td>
                <td><%= entry.getKey().getPrice() * entry.getValue() %></td>
            </tr>
            <% total += entry.getKey().getPrice() * entry.getValue(); %>
        <% } %>
        <tr>
            <td colspan="4">Totale</td>
            <td><%= total %></td>
        </tr>
    </table>
</body>
</html>
