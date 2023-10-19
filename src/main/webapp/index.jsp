<%@ page import="interfaces.Fabrica" %>
<%@ page import="interfaces.IControlador" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width", initial-scale=1,shrink-to-fit=no">
	<%@include file="header.jsp"%>
	<title>Entrenamos.uy</title>
	<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
<h1 style="text-align: center; color: white;">Bienvenido a Entrenamos.uy</h1>
<style>
	body {
		background-image: url("css/fondo.jpg");
		background-size: cover;
		background-repeat: no-repeat;
	}

	/* Aplica el desenfoque y la opacidad a toda la página */
	body::before {
		content: '';
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-image: url("css/fondo.jpg");
		background-size: cover;
		background-repeat: no-repeat;
		filter: blur(5px); /* Aplica el efecto de desenfoque al fondo */
		opacity: 0.9; /* Ajusta la opacidad del fondo */
		z-index: -1; /* Coloca el fondo detrás de los otros elementos */
	}
</style>
<%@include file="footer.jsp" %>
<head>
</body>
</html>