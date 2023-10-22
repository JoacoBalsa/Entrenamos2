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
    <title>Agregar Dictado de Clase</title>
    <style>
        #horaClase {
            margin: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 200px;
            font-family: Arial, sans-serif;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="time"] {
            padding: 8px;
            width: 100%;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="time"]:focus {
            border-color: #3399ff;
            outline: none;
        }
    </style>
</head>

<body>
<form action="/Entrenamos.uy/AgregarDictadoClase" method="post">
    <div id="errorContainer" style="display:none;">
        <div class="alert alert-danger" id="errorText"></div>
    </div>

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
        <label for="inputNombre">Nombre de la Clase</label>
        <input type="text"
               name="nombre"
               class="form-control"
               id="inputNombre"
               placeholder="Ingrese un nombre para la actividad"
               value="">
    </div>

    <div class="form-group">
        <label for="inputFecha">Fecha de inicio</label>
        <input type="date"
               name="fecIni"
               class="form-control"
               id="inputFecha"
               placeholder="Fecha de nacimiento de usuario">
    </div>

    <div class="form-group">
        <label for="inputUrl">Url</label>
        <input type="text"
               name="url"
               class="form-control"
               id="inputUrl"
               placeholder="Url de la clase"
               value="">
    </div>

    <div id="horaClase">
        <label for="hora">Seleccione la hora:</label>
        <input type="time" id="hora" name="hora" step="3600">
    </div>

    <button type="submit" class="btn btn-primary">Agregar Actividad Dictado Clase</button>



    <!--SECCION DE SCRIPTS-->

    <!--Script para mostrar las actividades de una institución-->
    <script>
        var institucionSelect = document.getElementById("inputInst");
        var actividadSelect = document.getElementById("inputAct");

        institucionSelect.addEventListener("change", function () {
            var institucionSeleccionada = institucionSelect.value;

            // Realizar una solicitud al servidor con la institución seleccionada
            fetch('/Entrenamos.uy/AgregarDictadoClase?institucion=' + institucionSeleccionada)
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
                });
        });
    </script>

    <!--Script para mostrar error-->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var error = "<%= request.getAttribute("error") %>";
            if (error && error !== "null") {
                var errorContainer = document.getElementById("errorContainer");
                var errorText = document.getElementById("errorText");
                errorText.innerText = error;
                errorContainer.style.display = "block";
            }
        });
    </script>
</form>

<%@include file="footer.jsp" %>
</body>
</html>
