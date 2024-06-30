<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-quiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Pagina di Login</title>
	<link rel="stylesheet" href="css/style.css" type="text/css">
	<link rel="stylesheet" href="css/form.css" type="text/css">
    <meta name="viewport" content="initial-scale=1, width=device-width">
</head>

<body>
<%
List<String> errors = (List<String>) request.getAttribute("errors");
if(errors != null){
	for (String error: errors){ %>
		<%=error %> <br>
	<%
	}
}
%>
<h1>Login</h1>
<form action="Login" method="post">
<fieldset>
	<label for="username">Username</label>
	<input id="username" type="text" name="username" placeholder="Username">
	<br>
	<label for="password">Password</label>
	<input id="password" type="text" name="password" placeholder="Password">
	<br>
	<input type="submit" value="Login"/>
	<input type="reset" value="Reset"/>
</fieldset>
<div><a href="index.jsp">Ritorna alla Home</a></div>
</form>
<%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div style="color:red;"><%= error %></div>
    <%
        }
    %>
</body>
</html>