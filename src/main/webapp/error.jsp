<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="header.jsp" %>
    <meta charset="UTF-8">
    <title>ERROR</title>
    <style>
        /* Estilos para la ventana emergente */
        .popup-container {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.5);
            padding: 20px;
            border-radius: 10px;
            color: white;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="popup-container" id="popup">
    <h1>Error</h1>
    <p>${error}</p>
    <button onclick="cerrarPopup()">Cerrar</button>
</div>

<!-- Script para mostrar la ventana emergente al cargar la página -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var popup = document.getElementById("popup");
        popup.style.display = "block";
    });

    function cerrarPopup() {
        var popup = document.getElementById("popup");
        popup.style.display = "none";
    }
</script>
    <%@include file="footer.jsp" %>
</body>
</html>

