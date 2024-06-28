<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="model.ProductBean" %>
<%@ page import="model.ProductDAODataSource" %>
<%@ page import="java.sql.SQLException"%>
    
<%
	ProductBean product = null;
	String productIdStr = request.getParameter("productId");
	int productId = 0;
	try{
		productId = Integer.parseInt(productIdStr);
	} catch (NumberFormatException e){
		out.println("id non valido");
	}
	try {
        ProductDAODataSource productDAO = new ProductDAODataSource();    
        product = productDAO.doRetrieveByKey(productId);
    } catch (SQLException e) {
        e.printStackTrace(); // Gestisci l'eccezione in modo appropriato
    }
%>    

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Modifica Prodotto</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
	<!-- Include della barra di navigazione -->
    <jsp:include page="../navbar.jsp" />
	
	<h1>Modifica prodotto</h1>
    <form action="${pageContext.request.contextPath}/EditProduct" method="post" enctype="multipart/form-data">
    	<input type="hidden" id="id" name="id" value="<%=product.getId() %>">
    	
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="<%=product.getName() %>" required><br>

        <label for="price">Price:</label>
        <input type="number" id="price" name="price" value="<%=product.getPrice() %>"required><br>

        <label for="description">Description:</label>
        <input type="text" id="description" name="description" value="<%=product.getDescription() %>" required><br>

        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" value="<%=product.getQuantity() %>" required><br>
        
        <label for="image">Carica una foto:</label>
			<input type="file" id="image" name="image" class="formInput" value="<%=product.getImageUrl() %>" required accept="image/*"> <br>

        <button type="submit">Conferma Modifiche</button>
    </form>

    <%-- Mostra eventuali messaggi di errore --%>
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <p style="color: red;"><%= error %></p>
    <% } %>
</body>
</html>