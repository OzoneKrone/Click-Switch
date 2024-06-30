<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection"%>
<%@ page import="model.UserBean"%>
<%@ page import="model.UserDAODataSource"%>
<%@ page import="java.sql.SQLException"%>

<%
    // Ottieni la lista degli utenti dal database
    Collection<UserBean> users = null;
    try {
        UserDAODataSource userDAO = new UserDAODataSource();
        users = userDAO.doRetrieveAll(null); // null indica nessun ordinamento
    } catch (SQLException e) {
        e.printStackTrace(); // Gestisci l'eccezione in modo appropriato
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista Utenti</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>    
	<jsp:include page="../navbar.jsp" />
    <h1>Lista Utenti</h1>
    <div class="admin-user-list">
	    <table border="1">
	        <tr>
	            <th>Username</th>
	            <th>Email</th>
	            <th>Password</th>
	            <th>Name</th>
	            <th>Address</th>
	            <th>Role</th>
	        </tr>
	        <% for (UserBean user : users) { %>
	            <tr>
	                <td><%= user.getUsername() %></td>
	                <td><%= user.getEmail() %></td>
	                <td> *** </td>
	                <td><%= user.getName() %></td>
	                <td><%= user.getAddress() %></td>
	                <td><%= user.getRole() %></td>
	            </tr>
	        <% } %>
	    </table>
    </div>

</body>
</html>
