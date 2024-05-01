var nombre = document.getElementById("nombre");
var password = document.getElementById("password");
var error = document.getElementById("error");
error.style.color = 'red';

/*function enviarFormulario() {
    console.log("Enviando formulario...");

    var mensajeError = [];

    if (nombre.value === null || nombre.value === '') {
        mensajeError.push("Ingresa tu nombre");
    }

    if (password.value === null || password.value === '') {
        mensajeError.push("Ingresa tu contraseña");
    }

    error.innerHTML = mensajeError.join(", ")

    return false;
}*/

var form = document.getElementById("formulario");
form.addEventListener("submit", function (evt) {
    evt.preventDefault();
    var mensajeError = [];

    if (nombre.value === null || nombre.value === '') {
        mensajeError.push("Ingresa tu nombre");
    }

    if (password.value === null || password.value === '') {
        mensajeError.push("Ingresa tu contraseña");
    }

    error.innerHTML = mensajeError.join(", ")
})
