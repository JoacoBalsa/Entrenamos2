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

    <div class="container">
        <label for="Clases">Clases</label>
        <select name="clase" class="form-control" id="Clases">
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

    <div class="container"
            id="tablaClasesContainer">
    </div>

    <div class="container">
        <label for="Actividades">Actividades deportivas</label>
        <select name="Actividades" class="form-control" id="Actividades">
            <option value="" selected disabled>Selecciona una actividad</option>
            <%
                // Obtienes las clases del atributo de solicitud
                String[] actividades = (String[]) request.getAttribute("clases");
                if (actividades != null) {
                    for (String act : actividades) {
            %>
            <option value="<%= act %>"><%= act %></option>
            <%
                    }
                }
            %>
        </select>
    </div>

    <script>
        <%String nick = (String) session.getAttribute("username");
        DtUsuario user = icon.obtenerUsuario(nick);%>
        var user = {
            nombre: "<%= user.getNombre() %>",
            apellido: "<%= user.getApellido() %>",
            email: "<%= user.getEmail() %>",
            fecNac: "<%= user.getFecNac() %>",
        };

        var nickInput = document.getElementById("nickname");
        var nombreInput = document.getElementById("nombre");
        var apellidoInput = document.getElementById("apellido");
        var emailInput = document.getElementById("email");
        var fechaInput = document.getElementById("fecNac");
        var clasesInput = document.getElementById("Clases")

        nickInput.value = "<%= nick %>";
        nombreInput.value = user.nombre;
        apellidoInput.value = user.apellido;
        emailInput.value = user.email;
        fechaInput.value = user.fecNac;

        fetch('/Entrenamos.uy/ConsultaUsuario?user=' + "<%= nick %>", {
            method: 'GET',
        })
            .then(response => response.json())
            .then(data => {
                // Limpiar el select de clases
                clasesInput.innerHTML = '';

                // Iterar sobre las clases obtenidas y agregarlas al select
                for (let i = 0; i < data.length; i++) {
                    let clase = data[i];

                    // Crear un nuevo elemento de opción
                    let option = document.createElement("option");
                    option.value = clase;
                    option.text = clase;

                    // Agregar la opción al select
                    clasesInput.appendChild(option);
                }

                // Disparar el evento "change" en clasesInput para activar la siguiente actualización si es necesario
                let event = new Event("change");
                clasesInput.dispatchEvent(event);
            });
    </script>

    <!--Script para mostrar o no las actividades-->
    <script>
        var actividades = document.getElementById("Actividades");
        var userType; // Esto es lo que obtienes de la JSP
        <%	fabrica = Fabrica.getInstancia();
            icon = fabrica.getIControlador();
            session = request.getSession();
            nickname = (String) session.getAttribute("username");
            if(icon.esSocio(nickname)){
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
            actividades.style.display = "none";
        }
    </script>

    <!--Script para actualizar los datos de la tabla de clases-->
    <script>
        var claseSelect = document.getElementById("Clases");
        function actualizarTablaClases(claseSeleccionada) {
            console.log("Clase seleccionada: " + claseSeleccionada);
            // Limpiar el contenedor de la tabla
            var tablaContainer = document.getElementById("tablaClasesContainer");
            tablaContainer.innerHTML = '';
            if (claseSeleccionada) {
                // Realizar una solicitud al servidor con la clase seleccionada
                fetch('/Entrenamos.uy/ConsultaDictadoClase?tipo=dtclase&clase=' + claseSeleccionada)
                    .then(response => response.json())
                    .then(data => {
                        // Limpiar el contenedor de la tabla
                        var tablaContainer = document.getElementById("tablaClasesContainer");
                        tablaContainer.innerHTML = '';

                        // Crear y agregar la tabla al contenedor
                        var table = document.createElement("table");
                        var thead = table.createTHead();
                        var row = thead.insertRow();
                        var headers = ["Nombre", "URL", "Fecha", "Hora"];

                        for (var i = 0; i < headers.length; i++) {
                            var th = document.createElement("th");
                            th.innerHTML = headers[i];
                            row.appendChild(th);
                        }

                        var tbody = table.createTBody();
                        var newRow = tbody.insertRow();

                        var cell1 = newRow.insertCell(0);
                        var cell2 = newRow.insertCell(1);
                        var cell3 = newRow.insertCell(2);
                        var cell4 = newRow.insertCell(3);

                        cell1.innerHTML = data.nombre;
                        cell2.innerHTML = data.url;
                        cell3.innerHTML = data.fecha;
                        cell4.innerHTML = data.horaInicio;

                        tablaContainer.appendChild(table);
                    });
            }
        }

        claseSelect.addEventListener("change", function () {
            var claseSeleccionada = claseSelect.value;
            // Llamar a la función para actualizar la tabla
            actualizarTablaClases(claseSeleccionada);
        });
    </script>

    <%@include file="footer.jsp" %>
</body>
</html>
