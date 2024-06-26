<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>

<%
    // Recupera il carrello dalla sessione
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    if (cart == null) {
        cart = new HashMap<>();
    }

    // Ottieni l'ID del prodotto dal form
    int productId = Integer.parseInt(request.getParameter("productId"));

    // Rimuovi il prodotto dal carrello
    cart.remove(productId);

    // Salva il carrello aggiornato nella sessione
    session.setAttribute("cart", cart);

    // Reindirizza alla pagina del carrello
    response.sendRedirect("viewCart.jsp");
%>
