<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Aggiunta Prodotto</title>
</head>
<body>
    <h1>Aggiunta nuovo prodotto</h1>
    <form action="AddProduct" method="post" enctype="multipart/form-data">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br>

        <label for="price">Price:</label>
        <input type="number" id="price" name="price" required><br>

        <label for="description">Description:</label>
        <input type="text" id="description" name="description" required><br>

        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" required><br>
        
        <label for="image">Carica una foto:</label>
			<input type="file" id="image" name="image" class="formInput" required accept="image/*"> <br>

        <button type="submit">Aggiungi Prodotto</button>
    </form>

    <%-- Mostra eventuali messaggi di errore --%>
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <p style="color: red;"><%= error %></p>
    <% } %>
</body>
</html>
