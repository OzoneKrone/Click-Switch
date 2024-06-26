<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>

<%
    // Recupera il carrello dalla sessione
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    if (cart == null) {
        cart = new HashMap<>();
    }

    // Ottieni l'ID del prodotto e la nuova quantità dal form
    int productId = Integer.parseInt(request.getParameter("productId"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    // Aggiorna la quantità nel carrello
    if (quantity > 0) {
        cart.put(productId, quantity);
    } else {
        cart.remove(productId); // Rimuovi il prodotto dal carrello se la quantità è zero
    }

    // Salva il carrello aggiornato nella sessione
    session.setAttribute("cart", cart);

    // Reindirizza alla pagina del carrello
    response.sendRedirect("viewCart.jsp");
%>
