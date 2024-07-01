const cardNumberErrorMessage = "Numero carta non valido";
const expiryDateErrorMessage = "Data di scadenza non valida";
const cvvErrorMessage = "Formato cvv non valido";
const nameErrorMessage = "Il nome non può contenere caratteri speciali o numeri!";
const emptyFieldErrorMessage = "Questo campo non può essere vuoto";

function validateFormElem(formElem, span, errorMessage) {
	if(formElem.checkValidity()){
		formElem.classList.remove("error");
		span.style.color = "black";
		span.innerHTML = "";
		return true;
	}
	formElem.classList.add("error");
	span.style.color = "red";
	if (formElem.validity.valueMissing){
		span.innerHTML = emptyFieldErrorMessage;
	} else {
		span.innerHTML = errorMessage;
	}
	return false;
}

function validate() {
	let valid = true;	
	let form = document.getElementById("regForm");
	
	let spanCardNumber = document.getElementById("errorCardNumber");
	if(!validateFormElem(form.cardNumber, spanCardNumber, cardNumberErrorMessage)){
		valid = false;
	}
	
	let spanExpiryDate = document.getElementById("errorExpiryDate");
	if (!validateFormElem(form.expiryDate, spanExpiryDate, expiryDateErrorMessage)){
		valid = false;
	}
	
	let spanCvv = document.getElementById("errorCvv");
	if (!validateFormElem(form.cvv, spanCvv, cvvErrorMessage)){
		valid = false;
	}
	
	let spanName = document.getElementById("errorName");
	if (!validateFormElem(form.cardHolderName, spanName, nameErrorMessage)){
		valid = false;
	}
	return valid;
}