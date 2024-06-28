<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Collection"%>
<%@ page import="model.UserOrderBean"%>
<%@ page import="model.UserOrderDAODataSource"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="model.UserBean" %>
    
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
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dettagli Ordine</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
	<!-- Include della barra di navigazione -->
    <jsp:include page="../navbar.jsp" />
    <h1>Dettagli ordine #<%= order.getId() %></h1>
    <div class="order-details">
	    <table border="1">    
	    <tr><th>Utente</th><th><%= order.getUsername() %></th></tr>
	    <tr><th>ID Ordine</th><th><%= order.getId() %></th></tr>
	    <tr><th>Data e ora</th><th><%= order.getDateTime() %></th></tr>
	    <tr><th>Stato</th><th><%= order.getStatus() %></th></tr>
	    <tr><th>Totale</th><th><%= order.getTotal() %></th></tr>
	    </table>
    </div>
</body>
</html>