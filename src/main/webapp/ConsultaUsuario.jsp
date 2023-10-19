<%@ page import="interfaces.IControlador" %>
<%@ page import="interfaces.Fabrica" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale=1,shrink-to-fit=no">
    <%@include file="header.jsp" %>
    <title>Consulta Usuario</title>
</head>
<body>

    <div class="container">
    <label for="nickname">Nickname:</label>
    <input type="text" id="nickname" readonly>
    </div>

    <div class="container">
    <label for="email">E-mail:</label>
    <input type="text" id="email" readonly>
    </div>

    <div class="container">
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" readonly>
    </div>

    <div class="container">
    <label for="apellido">Apellido:</label>
    <input type="text" id="apellido" readonly>
    </div>

    <div class="container">
    <label for="fecNac">Fecha de nacimiento:</label>
    <input type="text" id="fecNac" readonly>
    </div>
<!--
        Campos de ambos:
        Nickname
        email
        Nombre
        Apellido
        Fec Nac

        Campos de Socio:
        Datos de clases q se registró

        Campos de Profesor:
        Informacion de las clases que dicta y las act depor asociadas

        Si selecciona una actividad deportiva o una clase de una actividad
        deportiva, se muestra la información detallada, tal como se indica en
        los casos de uso Consulta de Actividad Deportiva y Consulta de Dictado
        de Clases, respectivamente
     -->

    <script>
        var nickname = document.getElementById("nickname");
        var email = document.getElementById("email");
        var nombre = document.getElementById("nombre");
        var apellido = document.getElementById("apellido");
        var fecNac = document.getElementById("fecNac");

    </script>
</body>
</html>
