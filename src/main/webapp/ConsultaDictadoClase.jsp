<%@ page import="interfaces.IControlador" %>
<%@ page import="interfaces.Fabrica" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1,shrink-to-fit=no">
    <%@include file="header.jsp" %>
    <title>Consulta Dictado de Clase</title>
    <style>

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

    </style>
</head>
<body>
<form action="/Entrenamos.uy/ConsultaDictadoClase" method="post">
    <div class="form-group">
        <label for="inputInst">Institucion</label>
        <select name="institucion" class="form-control" id="inputInst">
            <option value="" selected disabled>Selecciona una institucion</option>
            <%
                fabrica = Fabrica.getInstancia();
                icon = fabrica.getIControlador();
                String[] institutos = icon.listarInstitutos();
                for (String instituto : institutos) {
            %>
            <option value="<%= instituto %>"><%= instituto %></option>
            <%
                }
            %>
        </select>
    </div>

    <!-- Aquí puedes mostrar las actividades deportivas correspondientes a la institución seleccionada -->
    <div class="form-group">
        <label for="inputAct">Actividad deportiva</label>
        <select name="actividad_depor" class="form-control" id="inputAct">
            <option value="" selected disabled>Selecciona una actividad</option>
            <%
                // Obtienes las actividades deportivas del atributo de solicitud
                String[] actividades = (String[]) request.getAttribute("actividades");
                if (actividades != null) {
                    for (String actividad : actividades) {
            %>
            <option value="<%= actividad %>"><%= actividad %></option>
            <%
                    }
                }
            %>
        </select>
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


    <div id="tablaClasesContainer"></div>
    <div id="tablaSociosContainer"></div>


    <script>
        var institucionSelect = document.getElementById("inputInst");
        var actividadSelect = document.getElementById("inputAct");
        var claseSelect = document.getElementById("inputClase");

        institucionSelect.addEventListener("change", function () {
            var institucionSeleccionada = institucionSelect.value;

            // Realizar una solicitud al servidor con la institución seleccionada
            fetch('/Entrenamos.uy/ConsultaDictadoClase?tipo=inst&institucion=' + institucionSeleccionada)
                .then(response => response.json())
                .then(data => {
                    // Limpiar el select de actividades
                    actividadSelect.innerHTML = '';

                    // Agregar las opciones de actividad al select
                    data.forEach(actividad => {
                        var option = document.createElement("option");
                        option.text = actividad;
                        option.value = actividad;
                        actividadSelect.appendChild(option);
                    });

                    // Disparar el evento "change" en actividadSelect para activar la siguiente actualización
                    var event = new Event("change");
                    actividadSelect.dispatchEvent(event);
                });
        });
        actividadSelect.addEventListener("change", function () {
            var institucionSeleccionada = institucionSelect.value;
            var actividadSeleccionada = actividadSelect.value;

            // Realizar una solicitud al servidor con la institución y actividad seleccionadas
            fetch('/Entrenamos.uy/ConsultaDictadoClase?tipo=act&institucion=' + institucionSeleccionada + '&actividad=' + actividadSeleccionada)
                .then(response => response.json())
                .then(data => {
                    // Limpiar el select de clases
                    claseSelect.innerHTML = '';

                    // Agregar las opciones de clase al select
                    data.forEach(clase => {
                        var option = document.createElement("option");
                        option.text = clase;
                        option.value = clase;
                        claseSelect.appendChild(option);
                    });

                    // Disparar el evento "change" en claseSelect para activar la siguiente actualización
                    var event = new Event("change");
                    claseSelect.dispatchEvent(event);
                });
        });
        function actualizarTablaClases(claseSeleccionada) {
            // Limpiar el contenedor de la tabla
            var tablaContainer = document.getElementById("tablaClasesContainer");
            tablaContainer.innerHTML = '';
            var tablaContainer2 = document.getElementById("tablaSociosContainer");
            tablaContainer2.innerHTML = '';
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
                // Realizar una solicitud al servidor con la clase seleccionada
                fetch('/Entrenamos.uy/ConsultaDictadoClase?tipo=dtsocio&clase=' + claseSeleccionada)
                    .then(response => response.json())
                    .then(data => {
                        // Limpiar el contenedor de la tabla

                        // Crear y agregar la tabla al contenedor
                        var table = document.createElement("table");
                        var thead = table.createTHead();
                        var row = thead.insertRow();
                        var headers = ["Nombre de Socios"];

                        for (var i = 0; i < headers.length; i++) {
                            var th = document.createElement("th");
                            th.innerHTML = headers[i];
                            row.appendChild(th);
                        }

                        var tbody = table.createTBody();

                        data.forEach(function (data) {
                            var newRow = tbody.insertRow();
                            var cell1 = newRow.insertCell(0);

                            // Llena las celdas con los datos del socio
                            cell1.innerHTML = data;
                        });

                        tablaContainer2.appendChild(table);
                    });
            }
        }

        claseSelect.addEventListener("change", function () {
            var claseSeleccionada = claseSelect.value;
            // Llamar a la función para actualizar la tabla
            actualizarTablaClases(claseSeleccionada);
        });
    </script>
    <script>
        // Analiza los parámetros de la URL
        const urlParams = new URLSearchParams(window.location.search);
        const instituciones = urlParams.get('institucion');
        const actividades = urlParams.get('actividad');
        const clases = urlParams.get('clase');
        if (actividades) {
            institucionSelect.value = instituciones;
            actividadSelect.value = actividades;
            claseSelect.value = clases;
            // Crear un nuevo elemento para la lista de actividades y establecer el valor
            const nuevaActividad = document.createElement("option");
            nuevaActividad.value = actividades;
            nuevaActividad.text = actividades;
            actividadSelect.appendChild(nuevaActividad);
            // Crear un nuevo elemento para la lista de clases y establecer el valor
            const nuevaClase = document.createElement("option");
            nuevaClase.value = clases;
            nuevaClase.text = clases;
            claseSelect.appendChild(nuevaClase);
            var claseSeleccionada2 = claseSelect.value;
            actualizarTablaClases(claseSeleccionada2);
        }

    </script>
</form>
<%@include file="footer.jsp" %>
</body>
</html>
