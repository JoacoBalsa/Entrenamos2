<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>LogIn | Entrenamos.uy</title>
    <link rel="stylesheet" href="css/login.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
    <div id="errorContainer" style="display:none;">
        <div class="alert alert-danger" id="errorText"></div>
    </div>
    <div class="contenedor">
    <form action="/Entrenamos.uy/Login" method="post">
        <h1>Login</h1>
        <div class="input-box">
            <input type="text" placeholder="Nickname" name="nickname" required>
            <i class='bx bxs-user'></i>
        </div>
        <div class="input-box">
            <input type="password" placeholder="Password" name="password" required>
            <i class='bx bxs-lock-alt' ></i>
        </div>
        <button type="submit" class="btn">Login</button>

        <div class="register">
            <p>No tenes cuenta chinchulin <a href="AgregarUsuario.jsp">Registrarse</a></p>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var error = "<%= request.getAttribute("error") %>";
                if (error && error !== "null") {
                    var errorContainer = document.getElementById("errorContainer");
                    var errorText = document.getElementById("errorText");
                    errorText.innerText = error;
                    errorContainer.style.display = "block"; /* Mostramos el contenedor de error */
                }
            });
        </script>

    </form>
    </div>
</body>
</html>

