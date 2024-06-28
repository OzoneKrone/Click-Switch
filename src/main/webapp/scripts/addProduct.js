const nameErrorMessage = "Il nome utente può contenere solo caratteri alfanumerici";
const priceErrorMessage = "Prezzo non valido";
const quantityErrorMessage = "Quantità non valida";

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
	
	let spanUsername = document.getElementById("errorUsername");
	if(!validateFormElem(form.username, spanUsername, usernameErrorMessage)){
		valid = false;
	}
	let spanEmail = document.getElementById("errorEmail");
	if (!validateFormElem(form.email, spanEmail, emailErrorMessage)){
		valid = false;
	}
	let spanPassword = document.getElementById("errorPassword");
	if (!validateFormElem(form.password, spanPassword, passwordErrorMessage)){
		valid = false;
	}
	let spanName = document.getElementById("errorName");
	if (!validateFormElem(form.name, spanName, nameErrorMessage)){
		valid = false;
	}
	let spanAddress = document.getElementById("errorAddress");
	if (!validateFormElem(form.address, spanAddress, addressErrorMessage)){
		valid = false;
	}
	return valid;
}