<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">

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
						<li><a class="dropdown-item" href="AgregarActividadDeportiva.jsp">Actividad Deportiva</a></li>
						<li><a class="dropdown-item" href="AgregarInstuticion.jsp">Institucion Deportiva</a></li>
						<li><a class="dropdown-item" href="AgregarUsuario.jsp">Profesor/Socio</a></li>
						<li><a class="dropdown-item" href="AltaDictadoClase.jsp">Dictado de Clase</a></li>
					</ul>
				</li>

				<li class="nav-item dropdown">
					<button class="btn btn-dark dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						Modificar
					</button>
					<ul class="dropdown-menu dropdown-menu-dark">
						<li><a class="dropdown-item" href="ModificarActividadDeportiva.jsp">Actividad Deportiva</a></li>
						<li><a class="dropdown-item" href="ModificarInstitucionDeportiva.jsp">Institucion Deportiva</a></li>
						<li><a class="dropdown-item" href="ModificarUsuario.jsp">Usuario</a></li>
					</ul>
				</li>

				<li class="nav-item dropdown">
				<button class="btn btn-dark dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
					Consultas
				</button>
				<ul class="dropdown-menu dropdown-menu-dark">
					<li><a class="dropdown-item" href="ConsultaActividadDeportiva.jsp">Actividad Deportiva</a></li>
					<li><a class="dropdown-item" href="ConsultaUsuario.jsp">Usuario</a></li>
					<li><a class="dropdown-item" href="ConsultaDictadoClase.jsp">Dictado de Clase</a></li>
					<li><a class="dropdown-item" href="RankingClase.jsp">Ranking de Clases</a></li>
				</ul>
				</li>
			</ul>
		</div>
	</div>
</nav>
</body>
</html>