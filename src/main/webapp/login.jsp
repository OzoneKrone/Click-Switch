<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-quiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pagina di Login</title>
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
<form action="Login" method="post">
<fieldset>
	<legend>Login Custom</legend>
	<label for="username">Username</label>
	<input id="username" type="text" name="username" placeholder="Username">
	<br>
	<label for="password">Password</label>
	<input id="password" type="text" name="username" placeholder="Password">
	<br>
	<input type="submit" value="Login"/>
	<input type="reset" value="Reset"/>
</fieldset>
</form>
</body>
</html>