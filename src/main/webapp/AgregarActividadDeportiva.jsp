<%@ page import="interfaces.Fabrica" %>
<%@ page import="interfaces.IControlador" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale=1,shrink-to-fit=no">
    <%@include file="header.jsp" %>
    <title>Agregar Actividad</title>
</head>

<body>
    <form action="/Entrenamos.uy/AgregarActividad" method="post">
        <div id="errorContainer" style="display:none;">
            <div class="alert alert-danger" id="errorText"></div>
        </div>
        <div class="form-group">
            <label for="inputInst">Institucion</label>
            <select name="institucion" class="form-control" id="inputInst">
                <option value="" disabled selected>Selecciona una institución</option>
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


        <div class="form-group">
            <label for="InputNombreActD">Nombre</label>
            <input type="text"
                   name="nombre"
                   class="form-control"
                   id="InputNombreActD"
                   aria-describedby="emailHelp"
                   placeholder="Ingrese Nombre de la Actividad Deportiva"
                   value=""
                   autocomplete="off">
        </div>

        <div class="form-group">
            <label for="InputDescripcion">Descripción</label>
            <input type="text"
                   name="descripcion"
                   class="form-control"
                   id="InputDescripcion"
                   aria-describedby="emailHelp"
                   placeholder="Ingrese descripción de la Actividad Deportiva"
                   value=""
                   autocomplete="off">
        </div>

        <div class="form-group">
            <label for="InputDuracion">Duracion</label>
            <input type="text"
                   name="duracion"
                   class="form-control"
                   id="InputDuracion"
                   aria-describedby="emailHelp"
                   placeholder="Ingrese duracion de la Actividad Deportiva"
                   value=""
                   autocomplete="off">
        </div>

        <div class="form-group">
            <label for="InputCosto">Costo</label>
            <input type="text"
                   name="costo"
                   class="form-control"
                   id="InputCosto"
                   aria-describedby="emailHelp"
                   placeholder="Ingrese Costo de la Actividad Deportiva"
                   value=""
                   autocomplete="off">
        </div>

        <div class="form-group">
            <label for="inputFechaAlta">Fecha de Alta</label>
            <input type="date"
                   name="fecAlta"
                   class="form-control"
                   id="inputFechaAlta"
                   placeholder="Fecha de alta de la Actividad Deportiva">
        </div>
        <div class="mt-3"></div>

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

        <button type="submit" class="btn btn-primary">Agregar Actividad Deportiva</button>
    </form>

    <%@include file="footer.jsp" %>
    </body>
</html>