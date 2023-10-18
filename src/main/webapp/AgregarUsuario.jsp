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
    <title>Agregar Usuario</title>
</head>

<body>
    <form action="/Entrenamos.uy/AgregarUsuario" method="post">
        <div id="errorContainer" style="display:none;">
            <div class="alert alert-danger" id="errorText"></div>
        </div>
        <div class="form-group">
            <label for="inputNickname">Nickname</label>
            <input type="text"
                   name="nickname"
                   class="form-control"
                   id="inputNickname"
                   aria-describedby="emailHelp"
                   placeholder="Nickname de usuario"
                   value="">
        </div>

        <div class="form-group">
            <label for="inputEmail">E-mail</label>
            <input type="text"
                   name="email"
                   class="form-control"
                   id="inputEmail"
                   placeholder="E-mail de usuario"
                   value="">
        </div>

        <div class="form-group">
            <label for="inputNombre">Nombre</label>
            <input type="text"
                   name="nombre"
                   class="form-control"
                   id="inputNombre"
                   placeholder="Nombre de usuario"
                   value="">
        </div>

        <div class="form-group">
            <label for="inputApellido">Apellido</label>
            <input type="text"
                   name="apellido"
                   class="form-control"
                   id="inputApellido"
                   placeholder="Apellido de usuario"
                   value="">
        </div>

        <div class="form-group">
            <label for="inputFechaNacim">Fecha de nacimiento</label>
            <input type="date"
                   name="fecNac"
                   class="form-control"
                   id="inputFechaNacim"
                   placeholder="Fecha de nacimiento de usuario">
        </div>

        <div class="form-group">
            <label for="tipoUsuario">Tipo de Usuario</label>
            <select name="tipoUsuario" id="tipoUsuario" class="form-control">
                <option value=""selected disabled>Selecciona una opción</option>
                <option value="S">Socio</option>
                <option value="P">Profesor</option>
            </select>
        </div>

        <div class="form-group">
            <label for="inputPassword">Password</label>
            <input type="text"
                   name="password"
                   class="form-control"
                   id="inputPassword"
                   placeholder="Password de usuario"
                   value="">
        </div>

        <!-- Campos exclusivos de profesor -->
        <div id="camposProfesor" style="display: none;">

            <div class="form-group">
                <label for="inputBio">Biografia</label>
                <input type="text"
                       name="biografia"
                       class="form-control"
                       id="inputBio"
                       placeholder="Biografia de profesor">
            </div>

            <div class="form-group">
                <label for="inputWeb">Web</label>
                <input type="text"
                       name="web"
                       class="form-control"
                       id="inputWeb"
                       placeholder="Web del profesor">
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


            <div class="form-group">
                <label for="inputDesc">Descripcion</label>
                <input type="text"
                       name="descripcion"
                       class="form-control"
                       id="inputDesc"
                       placeholder="Descripcion de profesor"
                       value="">
            </div>
        </div>

        <!--SECCION DE SCRIPTS-->
        <script>
            document.getElementById("tipoUsuario").addEventListener("change", function () {
                var camposProfesor = document.getElementById("camposProfesor");
                if (this.value === "P") {
                    camposProfesor.style.display = "block"; // Mostrar campos adicionales
                } else {
                    camposProfesor.style.display = "none"; // Ocultar campos adicionales
                }
            });
        </script>

        <!--Script para deseleccionar la opción al cargar la página -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var selectTipoUsuario = document.getElementById("tipoUsuario");
                selectTipoUsuario.selectedIndex = -1; // Deseleccionar todas las opciones
            });
        </script>

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

        <button type="submit" class="btn btn-primary">Agregar Usuario</button>
    </form>
<%@include file="footer.jsp" %>
</body>
</html>