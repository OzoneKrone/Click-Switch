<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrazione Utente</title>
    <script src="scripts/registration.js"></script>
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet" href="css/form.css" type="text/css">
    <meta name="viewport" content="initial-scale=1, width=device-width">
</head>
<body>
    <h1>Registrazione Nuovo Utente</h1>
    <form action="Register" method="post">
    	<fieldset>
    		<legend>Informazioni Utente</legend>
    		<div>
	        	<label for="username">Username:</label>
	        	<input type="text" id="username" name="username" 
	        	required pattern="^[A-Za-z0-9]+$" onchange="validateFormElem(this, 
	        		document.getElementById('errorUsername'), usernameErrorMessage)">
	        	<span id="errorUsername"></span>
			</div>
	        <div>
				<label for="email">Email:</label><input type="email" name="email"
					required pattern="^\S+@\S+\.\S+$" onchange="validateFormElem(this, 
						document.getElementById('errorEmail'), emailErrorMessage)"
					id="email"><span id="errorEmail"></span>
			</div>
	
	        <div>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" 
                    required minlength="8" onchange="validateFormElem(this, 
                        document.getElementById('errorPassword'), passwordErrorMessage)">
                <span id="errorPassword"></span>
            </div>
            <div>
                <label for="name">Nome e Cognome:</label>
                <input type="text" id="name" name="name" 
                    required pattern="^[A-Za-z\s]+$" onchange="validateFormElem(this, 
                        document.getElementById('errorName'), nameErrorMessage)">
                <span id="errorName"></span>
            </div>
            <div>
                <label for="address">Indirizzo:</label>
                <input type="text" id="address" name="address" 
                    required onchange="validateFormElem(this, 
                        document.getElementById('errorAddress'), addressErrorMessage)">
                <span id="errorAddress"></span>
            </div>
	
	        <div>
				<input type="submit" value="Register" onclick="return validate()">
				<input type="reset" value="Reset">
			</div>
        </fieldset>
        <div><a href="index.jsp">Ritorna alla Home</a></div>
    </form>
</body>
</html>
