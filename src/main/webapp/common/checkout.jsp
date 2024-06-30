<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pagamento</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
    <!-- Include della barra di navigazione -->
    <jsp:include page="../navbar.jsp" />

    <h1>Pagamento</h1>
    <form action="ProcessPaymentServlet" method="post">
        <label for="cardNumber">Numero di Carta:</label>
        <input type="text" id="cardNumber" name="cardNumber" required><br>

        <label for="expiryDate">Data di Scadenza:</label>
        <input type="text" id="expiryDate" name="expiryDate" required><br>

        <label for="cvv">CVV:</label>
        <input type="text" id="cvv" name="cvv" required><br>

        <label for="cardHolderName">Nome del Titolare:</label>
        <input type="text" id="cardHolderName" name="cardHolderName" required><br>

        <input type="submit" value="Paga">
    </form>
    
</body>
</html>
