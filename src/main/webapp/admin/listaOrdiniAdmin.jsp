<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection"%>
<%@ page import="model.UserOrderBean"%>
<%@ page import="model.UserOrderDAODataSource"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="model.UserBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%
    // Ottieni la lista degli ordini dal database
    Collection<UserOrderBean> orders = null;
    UserBean currentUser = (UserBean) session.getAttribute("currentUser");

    String username = request.getParameter("username");
    String startDateStr = request.getParameter("startDate");
    String endDateStr = request.getParameter("endDate");

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date startDate = null;
    Date endDate = null;

    try {
        if (startDateStr != null && !startDateStr.isEmpty()) {
            startDate = dateFormat.parse(startDateStr);
        }
        if (endDateStr != null && !endDateStr.isEmpty()) {
            endDate = dateFormat.parse(endDateStr);
        }
    } catch (Exception e) {
        e.printStackTrace(); // Gestisci l'eccezione in modo appropriato
    }

    try {
        UserOrderDAODataSource orderDAO = new UserOrderDAODataSource();
        orders = orderDAO.doRetrieveByUsernameAndDateRange(username, startDate, endDate);
    } catch (SQLException e) {
        e.printStackTrace(); // Gestisci l'eccezione in modo appropriato
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista Ordini Admin</title>
    <link rel="stylesheet" href="../css/style.css" type="text/css">
</head>
<body>
    <!-- Include della barra di navigazione -->
    <jsp:include page="../navbar.jsp" />
    
    <h1>Lista Ordini Admin</h1>

    <!-- Modulo per selezionare l'intervallo di date -->
    <div>
        <form method="get" action="listaOrdiniAdmin.jsp">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" value="<%= username %>">
            
            <label for="startDate">Data inizio:</label>
            <input type="date" id="startDate" name="startDate" value="<%= startDateStr %>">
            
            <label for="endDate">Data fine:</label>
            <input type="date" id="endDate" name="endDate" value="<%= endDateStr %>">
            
            <button type="submit">Filtra</button>
        </form>
    </div>

    <div class="order-list">
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Data</th>
            <th>Stato</th>
            <th>Totale</th>
            <th></th>
        </tr>
        <% if (orders != null) { %>
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
        <% } else { %>
            <tr>
                <td colspan="6">Nessun ordine trovato.</td>
            </tr>
        <% } %>
    </table>
    </div>
</body>
</html>
