<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <%@include file="header.jsp" %>
    <title>Agregar Institucion Deportiva</title>

</head>

<body>
<form action="/Entrenamos.uy/AgregarInstitucion" method="post">
    <div id="errorContainer" style="display:none;">
        <div class="alert alert-danger" id="errorText"></div>
    </div>

    <div class="form-group">
        <label for="InputNombreIns">Nombre</label>
        <input type="text"
               name="nombre"
               class="form-control"
               id="InputNombreIns"
               aria-describedby="emailHelp"
               placeholder="Ingrese Nombre de la Institucion Deportiva"
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
               placeholder="Ingrese Descripción de la Institución Deportiva"
               value=""
               autocomplete="off">
    </div>

    <div class="form-group">
        <label for="InputUrl">URL</label>
        <input type="text"
               name="url"
               class="form-control"
               id="InputUrl"
               aria-describedby="emailHelp"
               placeholder="Ingrese URL de la Institución Deportiva"
               value=""
               autocomplete="off">
    </div>


    <!--SECCION DE SCRIPTS-->

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

    <div class="mt-3"></div>
    <button type="submit" class="btn btn-primary">Agregar Institución Deportiva</button>
</form>

<%@include file="footer.jsp" %>

</body>
</html>