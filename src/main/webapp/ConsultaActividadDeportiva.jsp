<%@ page import="interfaces.Fabrica" %>
<%@ page import="interfaces.IControlador" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale=1,shrink-to-fit=no">
    <title>Consulta Actividad Deportiva</title>
    <link rel="stylesheet" href="css/ConsultaActividadDeportiva.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
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
        }

        input, select {
            width: 100%;
            padding: 5px;
            margin: 5px 0;
            background-color: #363D4B;
            color: #FFFFFF;
            border: 1px solid #FFFFFF;
            filter: blur(0px); /* Ajusta el valor del desenfoque según tus preferencias */
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
    <h1>Consulta Actividad Deportiva</h1>

    <div class="form-group">
        <label for="inputActD">Actividad deportiva</label>
        <select name="actividad" class="form-control" id="inputActD">
            <option value="" selected disabled>Selecciona una Actividad Deportiva</option>
            <%
                Fabrica fabrica= Fabrica.getInstancia();
                IControlador icon = fabrica.getIControlador();
                String[] actividades = icon.obtenerTodasActividadesDeportivas();
                for (String actividadD : actividades) {
            %>
            <option value="<%= actividadD %>"><%= actividadD %></option>
            <%
                }
            %>
        </select>
    </div>

    <label for="descripcion">Descripcion:</label>
    <input type="text" id="descripcion" readonly>

    <label for="duracion">Duracion:</label>
    <input type="text" id="duracion" readonly>

    <label for="costo">Costo:</label>
    <input type="text" id="costo" readonly>

    <label for="fecha">Fecha Registro:</label>
    <input type="text" id="fecha" readonly>

    <div class="form-group">
        <label for="inputClase">Clase</label>
        <select name="clase" class="form-control" id="inputClase">
            <option value="" selected disabled>Selecciona una Clase</option>
            <!-- Aquí se llenarán las opciones de clases en base a la selección -->
        </select>
    </div>

    <!--SECCION DE SCRIPTS-->
    <script>
        var actividadSelect = document.getElementById("inputActD");
        var descripcionInput = document.getElementById("descripcion");
        var duracionInput = document.getElementById("duracion");
        var costoInput = document.getElementById("costo");
        var fechaInput = document.getElementById("fecha");
        var claseSelect = document.getElementById("inputClase"); // Cambiado a "inputClase"

        actividadSelect.addEventListener("change", function () {
            var actividadSeleccionada = actividadSelect.value;

            // Limpiar los campos antes de actualizar
            descripcionInput.value = '';
            duracionInput.value = '';
            costoInput.value = '';
            fechaInput.value = '';
            claseSelect.innerHTML = ''; // Limpiar el select de clases

            // Realizar la solicitud para obtener los datos de la actividad
            fetch('/Entrenamos.uy/ConsultaActividadDeportiva?tipo=dt&actividad=' + actividadSeleccionada)
                .then(response => response.json())
                .then(data => {
                    descripcionInput.value = data.descripcion;
                    duracionInput.value = data.duracion;
                    costoInput.value = data.costo;
                    fechaInput.value = data.fecReg;

                    // Luego de obtener los datos de la actividad, obtener la lista de clases
                    return fetch('/Entrenamos.uy/ConsultaActividadDeportiva?tipo=clases&actividad=' + actividadSeleccionada);
                })
                .then(response => response.json())
                .then(data => {
                    data.forEach(clase => {
                        var option = document.createElement("option");
                        option.text = clase;
                        option.value = clase;
                        claseSelect.appendChild(option);
                    });
                })
                .catch(error => {
                    console.error('Error al obtener los datos:', error);
                });
        });
    </script>

</div>
<%@include file="footer.jsp" %>
</body>
</html>