<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrazione Utente</title>
</head>
<body>
    <h1>Registrazione Nuovo Utente</h1>
    <form action="Register" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br>

        <label for="email">Email:</label>
        <input type="text" id="email" name="email" required><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

        <label for="name">Nome:</label>
        <input type="text" id="name" name="name" required><br>

        <label for="address">Indirizzo:</label>
        <input type="text" id="address" name="address"><br>

        <button type="submit">Registrati</button>
    </form>

    <%-- Mostra eventuali messaggi di errore --%>
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <p style="color: red;"><%= error %></p>
    <% } %>
</body>
</html>
