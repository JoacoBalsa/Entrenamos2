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
        </select>
    </div>

    <div class="mt-3"></div>



    <label for="fecha">Fecha:</label>
    <input type="text" id="fecha" value="<%= request.getAttribute("fecha") %>" readonly>

    <label for="hora">Hora:</label>
    <input type="text" id="hora" value="<%= request.getAttribute("hora") %>" readonly>

    <label for="fechaReg">Fecha de Registro:</label>
    <input type="text" id="fechaReg" value="<%= request.getAttribute("fechaRegistro") %>" readonly>

    <label for="url">URL:</label>
    <input type="text" id="url" value="<%= request.getAttribute("url") %>" readonly>


    <!--SECCION DE SCRIPTS-->
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
                    actividadSelect.value = data[0];
                    actualizarClases();
                });


            // Llamar a la función para actualizar las clases después de cargar las actividades
        });
    </script>

    <!-- Agrega este bloque de script en tu página RegistroADictadoClase.jsp -->
    <script>
        var institucionSelect = document.getElementById("inputInst");
        var actividadSelect = document.getElementById("inputAct");
        var clasesContainer = document.getElementById("inputClase");

        // Función para actualizar las clases
        function actualizarClases() {
            console.log("actualizarClases llamada");
            var institucionSeleccionada = institucionSelect.value;
            var actividadSeleccionada = actividadSelect.value;

            // Realizar una solicitud al servidor con la institución y actividad seleccionadas
            fetch('/Entrenamos.uy/RegistroADictadoClase?institucion=' + institucionSeleccionada + '&actividad_depor=' + actividadSeleccionada)
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    // Limpiar el select de clases
                    clasesContainer.innerHTML = '';

                    // Agregar las clases al select
                    data.forEach(clase => {
                        var option = document.createElement("option");
                        option.text = clase;
                        option.value = clase;
                        clasesContainer.appendChild(option);
                    });
                    claseSelect.value = data[0];
                });
        }

        // Event listener para cuando cambia la institución o la actividad
        institucionSelect.addEventListener("change", actualizarClases);
        actividadSelect.addEventListener("change", actualizarClases);
    </script>
    <script>
        document.getElementById("inputClase").addEventListener("change", function() {
            var selectedClass = this.value;

            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/Entrenamos.uy/ConsultaDictadoClase?clase=" + selectedClass);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    var data = JSON.parse(xhr.responseText);

                    // Actualiza los campos con los datos recibidos
                    document.getElementById("fecha").value = data.fecha;
                    document.getElementById("hora").value = data.hora;
                    document.getElementById("fechaReg").value = data.fechaRegistro;
                    document.getElementById("url").value = data.url;
                }
            };
            xhr.send();
        });

    </script>

</form>
<%@include file="footer.jsp" %>
</body>
</html>