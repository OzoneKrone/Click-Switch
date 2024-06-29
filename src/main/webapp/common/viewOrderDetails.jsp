<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Collection"%>
<%@ page import="model.UserOrderBean"%>
<%@ page import="model.UserOrderDAODataSource"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="model.UserBean" %>
<%@ page import="model.OrderItemBean" %>
<%@ page import="model.OrderItemDAODataSource" %>
    
<%
    // Ottieni l'ordine dal database
    UserOrderBean order = null;
	UserBean currentUser = (UserBean) session.getAttribute("currentUser");
	String orderIdStr = request.getParameter("orderId");
	int orderId = 0;
	try{
		orderId = Integer.parseInt(orderIdStr);
	} catch (NumberFormatException e){
		out.println("id non valido");
	}
	
    try {
        UserOrderDAODataSource orderDAO = new UserOrderDAODataSource();    
        order = orderDAO.doRetrieveByKey(orderId);
    } catch (SQLException e) {
        e.printStackTrace(); // Gestisci l'eccezione in modo appropriato
    }
    
 	// Ottieni i prodotti dell'ordine dal database
    Collection<OrderItemBean> items = null;
    try {
        OrderItemDAODataSource orderItemDAO = new OrderItemDAODataSource();
        items = orderItemDAO.doRetrieveOrderItems(orderId);
    } catch (SQLException e) {
        e.printStackTrace(); // Gestisci l'eccezione in modo appropriato
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dettagli Ordine</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orderDetails.css" type="text/css">
</head>
<body>
	<!-- Include della barra di navigazione -->
    <jsp:include page="../navbar.jsp" />
    
    <h1>Dettagli ordine #<%= order.getId() %></h1>
        
    <div class="order-items-table">
	    <table>
            <tr>
                <th>Nome Prodotto</th>
                <th>Quantità</th>
                <th>Prezzo</th>
            </tr>
            <%
                if (items != null) {
                    for (OrderItemBean item : items) {
            %>
            <tr>
                <td><%= item.getName() %></td>
                <td><%= item.getQuantity() %></td>
                <td><%= item.getPrice() %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="3">Nessun prodotto trovato per questo ordine.</td>
            </tr>
            <%
                }
            %>
       	</table>
	    <div class="order-details">
			<table>
	        <tr><th>Utente</th><td><%= order.getUsername() %></td></tr>
	        <tr><th>ID Ordine</th><td><%= order.getId() %></td></tr>
	        <tr><th>Data e ora</th><td><%= order.getDateTime() %></td></tr>
	        <tr><th>Stato</th><td><%= order.getStatus() %></td></tr>
	        <tr><th>Totale</th><td><%= order.getTotal() %></td></tr>
	    	</table>
	    </div>
    </div>
</body>
</html>
