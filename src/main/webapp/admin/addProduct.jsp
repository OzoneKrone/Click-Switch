<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Aggiunta Prodotto</title>
    <script src="${pageContext.request.contextPath}/scripts/addProduct.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css" type="text/css">
    <meta name="viewport" content="initial-scale=1, width=device-width">
</head>
<body>
	<!-- Include della barra di navigazione -->
    <jsp:include page="../navbar.jsp" />
    <h1>Aggiunta nuovo prodotto</h1>
    <form action="AddProduct" method="post" enctype="multipart/form-data">
    	<fieldset>
    		<div>
	        	<label for="name">Nome:</label>
	        	<input type="text" id="name" name="name" 
	        	required onchange="validateFormElem(this, document.getElementById('errorName'), usernameErrorMessage)">
	        	<span id="errorName"></span>
			</div>
			<div>
				<label for="description">Descrizione:</label>
	        	<textarea id="description" name="description" rows="4" cols="50" required></textarea>
			</div>
			<div>
	        	<label for="price">Prezzo:</label>
	        	<input type="text" id="price" name="price" 
	        		required pattern="^\d+([.]\d{1,2})?$" onchange="validateFormElem(this, document.getElementById('errorPrice'), 
	        			priceErrorMessage)">
	        		<span id="errorPrice"></span>
			</div>
			<div>
				<label for="quantity">Quantità:</label>
				<input type="text" id="quantity" name="quantity" 
	        		required pattern="^[0-9]+$" onchange="validateFormElem(this, document.getElementById('errorQuantity'), 
	        			quantityErrorMessage)">
	        		<span id="errorQuantity"></span>
			</div>
			<div>
				<label for="image">Carica una foto:</label>
				<input type="file" id="image" name="image" class="formInput" required 
					accept="${pageContext.request.contextPath}/image/*">
		        	<span id="errorImage"></span>
			</div>
    	</fieldset>
        <button type="submit">Aggiungi Prodotto</button>
        <div><a href="${pageContext.request.contextPath}/index.jsp">Ritorna alla Home</a></div>
    </form>

    <%-- Mostra eventuali messaggi di errore --%>
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <p style="color: red;"><%= error %></p>
    <% } %>
</body>
</html>
