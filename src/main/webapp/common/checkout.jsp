<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pagamento</title>
    <script src="${pageContext.request.contextPath}/scripts/checkout.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css" type="text/css">
    <meta name="viewport" content="initial-scale=1, width=device-width">
</head>
<body>
    <!-- Include della barra di navigazione -->
    <jsp:include page="../navbar.jsp" />

    <h1>Pagamento</h1>
    <form action="ProcessPaymentServlet" method="post">
    	<fieldset>
    		<div>
		        <label for="cardNumber">Numero di Carta:</label>
		        <input type="text" id="cardNumber" name="cardNumber" 
		        	required pattern="^\d{16}$" onchange="validateFormElem(this, 
                        document.getElementById('errorCardNumber'), cardNumberErrorMessage)">
				<span id="errorCardNumber"></span>
			</div>
			<div>
		        <label for="expiryDate">Data di Scadenza:</label>
		        <input type="text" id="expiryDate" name="expiryDate" 
		        	required pattern="^(0[1-9]|1[0-2])\/\d{2}$" onchange="validateFormElem(this, 
	                        document.getElementById('errorExpiryDate'), expiryDateErrorMessage)">
				<span id="errorExpiryDate"></span>
            </div>
			<div>
		        <label for="cvv">CVV:</label>
		        <input type="text" id="cvv" name="cvv" 
		        	required pattern="^\d{3}$" onchange="validateFormElem(this, 
	                        document.getElementById('errorCvv'), cvvErrorMessage)">
				<span id="errorCvv"></span>
			</div>
			<div>
		        <label for="cardHolderName">Nome del Titolare:</label>
		        <input type="text" id="cardHolderName" name="cardHolderName" 
		        required pattern="^[A-Za-z\s]+$" onchange="validateFormElem(this, 
	                        document.getElementById('errorName'), nameErrorMessage)">
	                <span id="errorName"></span>
			</div>
			
	        <input type="submit" value="Paga">
       	</fieldset>
    </form>
    
</body>
</html>
