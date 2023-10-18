<%@ page import="interfaces.IControlador" %>
<%@ page import="interfaces.Fabrica" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<html>
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale=1,shrink-to-fit=no">
    <%@include file="header.jsp" %>
    <title>Consulta Dictado de Clase</title>

</head>
<body>
<form action="/Entrenamos.uy/ConsultaDictadoClase" method="post">
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



  <script>
        var institucionSelect = document.getElementById("inputInst");
        var actividadSelect = document.getElementById("inputAct");

        institucionSelect.addEventListener("change", function () {
            var institucionSeleccionada = institucionSelect.value;

            // Realizar una solicitud al servidor con la institución seleccionada
            fetch('/Entrenamos.uy/ConsultaDictadoClase?institucion=' + institucionSeleccionada)
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

    <script>
        var institucionSelect = document.getElementById("inputInst");
        var actividadSelect = document.getElementById("inputAct");
        var claseSelect = document.getElementById("inputClase");

        // Escucha cambios en el select de actividades
        actividadSelect.addEventListener("change", function () {
            var institucionSeleccionada = institucionSelect.value;
            var actividadSeleccionada = actividadSelect.value;

            // Realizar una solicitud al servidor con la institución y actividad seleccionadas
            fetch('/Entrenamos.uy/ConsultaDictadoClase?institucion=' + institucionSeleccionada + '&actividad=' + actividadSeleccionada)
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
                });
        });
    </script>


</form>
</body>
</html>
