<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection"%>
<%@ page import="model.UserOrderBean"%>
<%@ page import="model.UserOrderDAODataSource"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="model.UserBean" %>

<%
    // Ottieni la lista degli ordini dal database
    Collection<UserOrderBean> orders = null;
	UserBean currentUser = (UserBean) session.getAttribute("currentUser");

    try {
        UserOrderDAODataSource orderDAO = new UserOrderDAODataSource();
        if (currentUser.getRole().equals("admin")) {
        	orders = orderDAO.doRetrieveAll(null); // null indica nessun ordinamento
        } else {
        	orders = orderDAO.doRetrieveByUsername(null, currentUser.getUsername()); // null indica nessun ordinamento
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Gestisci l'eccezione in modo appropriato
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista Ordini</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
</head>
<body>
	<!-- Include della barra di navigazione -->
    <jsp:include page="navbar.jsp" />
	
    <h1>Lista Ordini</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Data</th>
            <th>Stato</th>
            <th>Totale</th>
            <th></th>
        </tr>
        <% for (UserOrderBean order : orders) { %>
            <tr>
                <td><%= order.getId() %></td>
                <td><%= order.getUsername() %></td>
                <td><%= order.getDateTime() %></td>
                <td><%= order.getStatus() %></td>
                <td><%= order.getTotal() %></td>
                <td>
                	<form action="viewOrderDetails.jsp" method="post">
                        <input type="hidden" name="orderId" value="<%= order.getId() %>">
                        <button type="submit">Dettagli</button>
                    </form>
				</td>
            </tr>
        <% } %>
    </table>
</body>
</html>
