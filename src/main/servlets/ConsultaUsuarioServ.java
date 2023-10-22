package main.servlets;

import com.google.gson.Gson;
import interfaces.Fabrica;
import interfaces.IControlador;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/Entrenamos.uy/ConsultaUsuario")

public class ConsultaUsuarioServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ConsultaUsuarioServ() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Fabrica fabrica = Fabrica.getInstancia();
        IControlador icon = fabrica.getIControlador();

        HttpSession session = request.getSession();
        String nick = (String) session.getAttribute("username");
        String[] clases = icon.usuarioEnClase(nick);

        // Conviertes el array de cadenas a un formato JSON
        Gson gson = new Gson();
        String clasesJson = gson.toJson(clases);

        // Estableces el tipo de contenido de la respuesta como JSON
        response.setContentType("application/json");

        // Escribe la respuesta JSON al flujo de salida
        response.getWriter().write(clasesJson);
    }
}
