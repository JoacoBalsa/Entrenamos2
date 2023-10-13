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
                Fabrica fabrica = Fabrica.getInstancia();
                IControlador icon = fabrica.getIControlador();
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
        <label for="inputAct">Actividad deportiva</label>
        <select name="actividad_depor" class="form-control" id="inputAct">
            <option value="" selected disabled>Selecciona una actividad</option>
            <%
                fabrica = Fabrica.getInstancia();
                icon = fabrica.getIControlador();
                String inst = "Nacional";
                String[] actividades = icon.listarActividadesDeportivas(inst);
                for (String actividad : actividades) {
                    %>
                    <option value="<%= actividad %>"><%= actividad %></option>
                    <%
                }
            %>
        </select>
   </div>
    <!--    ESTE SCRIPT ESTÁ INCOMPLETO, NO FUNCA PA NA
    <script>
        var institucion = document.getElementById("inputInst");
        var actividad
        institucion.addEventListener("change", function (){
            var nomInst = institucion.value;
            for (let x=0; x<=5; x++){
                /*Apendear las opciones al menu desplegable*/
                //`<option>"hola"</option>`
            }
        })
    </script>-->
</form>

<%@include file="footer.jsp" %>
</body>
</html>
