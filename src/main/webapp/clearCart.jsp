<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>

<%
    // Recupera il carrello dalla sessione
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    if (cart == null) {
        cart = new HashMap<>();
    }

    // Svuota il carrello
    cart.clear();

    // Salva il carrello aggiornato nella sessione
    session.setAttribute("cart", cart);

    // Reindirizza alla pagina del carrello
    response.sendRedirect("viewCart.jsp");
%>
