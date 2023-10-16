<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<html>
<style>
	/*Color del fondo*/
	body {
		background-color: #e3e8e8;
	}
</style>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDarkDropdown" aria-controls="navbarNavDarkDropdown" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDarkDropdown">
				<ul class="navbar-nav">

					<li class="nav-item button">
						<button class="btn btn-dark" onclick="window.location.href='index.jsp'">
							Inicio
						</button>
					</li>

					<li class="nav-item dropdown">
						<button class="btn btn-dark dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
							Altas
						</button>
						<ul class="dropdown-menu dropdown-menu-dark">
							<li><a id="AgregarActDepor" class="dropdown-item" href="AgregarActividadDeportiva.jsp">Actividad Deportiva (opc)</a></li>
							<li><a id="AgregarInstitucion" class="dropdown-item" href="AgregarInstuticion.jsp">Institucion Deportiva (opc)</a></li>
							<li><a id="AgregarUser" class="dropdown-item" href="AgregarUsuario.jsp">Profesor/Socio (opc)</a></li>
							<li><a id="AgregarDicClase" class="dropdown-item" href="AgregarDictadoClase.jsp">Dictado de Clase</a></li>
							<li><a id="RegADicClase" class="dropdown-item" href="RegistroADictadoClase.jsp">Registro a dictado de Clase</a></li>
						</ul>
					</li>

					<li class="nav-item dropdown">
						<button class="btn btn-dark dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
							Modificar
						</button>
						<ul class="dropdown-menu dropdown-menu-dark">
							<li><a id="ModifActDepor" class="dropdown-item" href="ModificarActividadDeportiva.jsp">Actividad Deportiva (opc)</a></li>
							<li><a id="ModifInstDepor" class="dropdown-item" href="ModificarInstitucionDeportiva.jsp">Institucion Deportiva (opc)</a></li>
							<li><a id="ModifUser" class="dropdown-item" href="ModificarUsuario.jsp">Usuario</a></li>
							<li><a id="EliminarRegADicClase" class="dropdown-item" href="EliminarRegistroADictadoClase.jsp">Eliminar Registro a dictado de Clase</a></li>
						</ul>
					</li>

					<li class="nav-item dropdown">
					<button class="btn btn-dark dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						Consultas
					</button>
					<ul class="dropdown-menu dropdown-menu-dark">
						<li><a id="ConsultaActDepor" class="dropdown-item" href="ConsultaActividadDeportiva.jsp">Actividad Deportiva</a></li>
						<li><a id="ConsultaUser" class="dropdown-item" href="ConsultaUsuario.jsp">Usuario</a></li>
						<li><a id="ConsultaDicClase" class="dropdown-item" href="ConsultaDictadoClase.jsp">Dictado de Clase</a></li>
						<li><a id="RankingClase" class="dropdown-item" href="RankingClase.jsp">Ranking de Clases</a></li>
						<li><a id="RankingActDepor" class="dropdown-item" href="RankingActividadDeportiva.jsp">Ranking de Clases</a></li>
					</ul>
					</li>

					<li class="nav-item button">
						<button class="btn btn-dark" onclick="window.location.href='Login.jsp'">
							Cerrar Sesion
						</button>
					</li>
				</ul>
			</div>
		</div>
	</nav>
</body>

<script>
	// Supongamos que tienes una variable userType que indica el tipo de usuario
	var userType = "S"; // Puedes cambiar esto a "profesor" para probar

	// Función para mostrar u ocultar elementos del menú según el tipo de usuario
	function toggleMenuItems() {
		var AgregarActDepor = document.getElementById("AgregarActDepor");
		var AgregarInstitucion = document.getElementById("AgregarInstitucion");
		var AgregarUser = document.getElementById("AgregarUser");
		var AgregarDicClase = document.getElementById("AgregarActDepor");
		var ModifActDepor = document.getElementById("ModifActDepor");
		var ModifInstDepor = document.getElementById("ModifInstDepor");
		var ModifUser = document.getElementById("ModifUser");
		var ConsultaActDepor = document.getElementById("ConsultaActDepor");
		var ConsultaUser = document.getElementById("ConsultaUser");
		var ConsultaDicClase = document.getElementById("ConsultaDicClase");
		var RankingClase = document.getElementById("RankingClase");
		var RankingActDepor = document.getElementById("RankingActDepor");
		var RegADicClase = document.getElementById("RegADicClase");
		var EliminarRegADicClase = document.getElementById("EliminarRegADicClase");

		if (userType === "P") {
			// Mostrar elementos específicos para profesores
			AgregarActDepor.style.display = "block";		//No hay que implementarla para esta tarea. Aparecen en los dos
			AgregarInstitucion.style.display = "block";		//No hay que implementarla para esta tarea. Aparecen en los dos
			AgregarUser.style.display = "block";			//No hay que implementarla para esta tarea. Aparecen en los dos
			AgregarDicClase.style.display = "block";
			ModifActDepor.style.display = "none";			//No hay que implementarla para esta tarea. Aparecen en los dos
			ModifInstDepor.style.display = "none";			//No hay que implementarla para esta tarea. Aparecen en los dos
			ModifUser.style.display = "block";
			ConsultaActDepor.style.display = "block";
			ConsultaUser.style.display = "block";
			ConsultaDicClase.style.display = "block";
			RankingClase.style.display = "block";
			RankingActDepor.style.display = "block";
			RegADicClase.style.display = "none";
			EliminarRegADicClase.style.display = "none";
		} else if (userType === "S") {
			// Mostrar elementos específicos para socios
			AgregarActDepor.style.display = "block";		//No hay que implementarla para esta tarea. Aparecen en los dos
			AgregarInstitucion.style.display = "block";		//No hay que implementarla para esta tarea. Aparecen en los dos
			AgregarUser.style.display = "block";			//No hay que implementarla para esta tarea. Aparecen en los dos
			AgregarDicClase.style.display = "none";
			ModifActDepor.style.display = "none";			//No hay que implementarla para esta tarea. Aparecen en los dos
			ModifInstDepor.style.display = "none";			//No hay que implementarla para esta tarea. Aparecen en los dos
			ModifUser.style.display = "block";
			ConsultaActDepor.style.display = "block";
			ConsultaUser.style.display = "block";
			ConsultaDicClase.style.display = "none";
			RankingClase.style.display = "none";
			RankingActDepor.style.display = "none";
			RegADicClase.style.display = "block";
			EliminarRegADicClase.style.display = "none";
		}
	}

	// Llamar a la función para inicializar el menú
	toggleMenuItems();
</script>
</html>