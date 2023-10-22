<%@ page import="interfaces.IControlador" %>
<%@ page import="interfaces.Fabrica" %>
<%@ page import="datatypes.DtUsuario" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale=1,shrink-to-fit=no">
    <%@include file="header.jsp" %>
    <title>Consulta Usuario</title>
    <style>
        body {
            background-image: url('https://wallpapercave.com/dwp1x/wp3006474.jpg');
            background-size: cover; /* Cambiado de 'contain' a 'cover' para rellenar la pantalla */
            background-attachment: fixed;
            background-repeat: no-repeat;
            background-position: center top; /* Alineado en la parte superior */
        }
        body {
            background-color: #363D4B;
            color: #FFFFFF;
            font-family: Arial, sans-serif;
        }

        .container {
            margin: 0 auto;
            max-width: 600px;
            padding: 20px;
        }

        label {
            display: block;
            margin-top: 10px;
            color: #FFFFFF; /* Color del texto de las etiquetas en blanco */
        }

        input, select {
            width: 100%;
            padding: 5px;
            margin: 5px 0;
            background-color: #FFFFFF; /* Color de fondo blanco */
            color: #000000; /* Color del texto en negro */
            border: 1px solid #000000; /* Borde en negro */
        }

        /* Evita que se aplique el desenfoque al enfocar los campos de entrada */
        input:focus, select:focus {
            filter: none; /* Elimina el desenfoque al enfocar */
            outline: none;
            border: 1px solid #007BFF;
        }
    </style>
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

    <div class="form-group">
        <label for="inputClase">Clase</label>
        <select name="clase" class="form-control" id="inputClase">
            <option value="" selected disabled>Selecciona una clase</option>
            <%
                // Obtienes las clases del atributo de solicitud
                String[] clases = (String[]) request.getAttribute("clases");
                if (clases != null) {
                    for (String clase : clases) {
            %>
            <option value="<%= clase %>"><%= clase %></option>
            <%
                    }
                }
            %>
        </select>
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
        <%String nick = (String) session.getAttribute("username");
        DtUsuario user = icon.obtenerUsuario(nick);%>
        var user = {
            nombre: "<%= user.getNombre() %>",
            apellido: "<%= user.getApellido() %>",
            email: "<%= user.getEmail() %>",
            fecNac: "<%= user.getFecNac() %>"
        };

        var nickInput = document.getElementById("nickname");
        var nombreInput = document.getElementById("nombre");
        var apellidoInput = document.getElementById("apellido");
        var emailInput = document.getElementById("email");
        var fechaInput = document.getElementById("fecNac");
        var clases = document.getElementById("inputClase");

        nickInput.value = "<%= nick %>";
        nombreInput.value = user.nombre;
        apellidoInput.value = user.apellido;
        emailInput.value = user.email;
        fechaInput.value = user.fecNac;

        var userType; // Esto es lo que obtienes de la JSP
        <%if(icon.esSocio(nickname)){
        %>
        userType = "S";
        <%
            }else{
                %>
                userType = "P";
                <%
            }
        %>

        if(userType === "S"){
            clases.style.display = "block"
        } else{
            clases.style.display = "none"
        }
    </script>

    <%@include file="footer.jsp" %>
</body>
</html>
