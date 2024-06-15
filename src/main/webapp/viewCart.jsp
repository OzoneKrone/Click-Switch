<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Map.Entry"%>
<%@ page import="model.ProductBean"%>
<%@ page import="model.ProductDAODataSource"%>
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
    double total = 0.0;
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

    <h1>Carrello</h1>
    <table border="1">
        <tr>
            <th>ID Prodotto</th>
            <th>Nome</th>
            <th>Quantità</th>
            <th>Prezzo Unitario</th>
            <th>Prezzo Totale</th>
        </tr>
        <% if (cart != null) {
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                int productId = entry.getKey();
                int quantity = entry.getValue();
                
                ProductBean product = null;
                try {
                    product = productDAO.doRetrieveByKey(productId);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                
                if (product != null) {
                    double totalPrice = product.getPrice() * quantity;
                    total += totalPrice;
        %>
        <tr>
            <td><%= product.getId() %></td>
            <td><%= product.getName() %></td>
            <td><%= quantity %></td>
            <td><%= product.getPrice() %></td>
            <td><%= totalPrice %></td>
        </tr>
        <%          }
            }
        } %>
    </table>

    <h2>Totale: <%= total %></h2>

    <form action="checkout.jsp" method="get">
        <input type="submit" value="Procedi al Pagamento">
    </form>
</body>
</html>
