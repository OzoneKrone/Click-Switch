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
	<script src="${pageContext.request.contextPath}/scripts/addProduct.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css" type="text/css">
</head>
<body>
	<!-- Include della barra di navigazione -->
    <jsp:include page="../navbar.jsp" />
	
	<h1>Modifica prodotto</h1>
	<form action="${pageContext.request.contextPath}/EditProduct" method="post" enctype="multipart/form-data">
    <fieldset>
        <input type="hidden" id="id" name="id" value="<%=product.getId() %>">
        
        <div>
            <label for="name">Nome:</label>
            <input type="text" id="name" name="name" value="<%=product.getName() %>" 
            	required onchange="validateFormElem(this, document.getElementById('errorName'), usernameErrorMessage)">
            <span id="errorName"></span>
        </div>
		<div>
			<label for="description">Descrizione:</label>
	        <textarea id="description" name="description" rows="4" cols="50" required><%=product.getDescription() %></textarea>
		</div>
		<div>
			<label for="price">Prezzo:</label>
			<input type="text" id="price" name="price" value="<%=product.getPrice() %>"
				required pattern="^\d+([.]\d{1,2})?$" onchange="validateFormElem(this, document.getElementById('errorPrice'), 
				priceErrorMessage)">
			<span id="errorPrice"></span>
		</div>
        <div>
            <label for="quantity">Quantità:</label>
            <input type="text" id="quantity" name="quantity" value="<%=product.getQuantity() %>" 
            	required pattern="^[0-9]+$" onchange="validateFormElem(this, document.getElementById('errorQuantity'), 
	        			quantityErrorMessage)">
            <span id="errorQuantity"></span>
        </div>
        <div>
            <label for="image">Carica una foto:</label>
            <input type="file" id="image" name="image" class="formInput" value="<%=product.getImageUrl() %>" required accept="image/*">
            <span id="errorImage"></span>
        </div>
    </fieldset>
    <button type="submit">Conferma Modifiche</button>
    <div><a href="${pageContext.request.contextPath}/index.jsp">Ritorna alla Home</a></div>
	</form>


    <%-- Mostra eventuali messaggi di errore --%>
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <p style="color: red;"><%= error %></p>
    <% } %>
</body>
</html>