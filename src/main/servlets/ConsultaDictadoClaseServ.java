package main.servlets;

import java.io.IOException;

import com.google.gson.Gson;
import datatypes.DtClase;
import datatypes.DtProfesor;
import datatypes.DtSocio;
import datatypes.DtUsuario;
import excepciones.DictadoRepetidoException;
import excepciones.UsuarioRepetidoException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import interfaces.Fabrica;
import interfaces.IControlador;
import logica.Clase;

@WebServlet("/Entrenamos.uy/ConsultaDictadoClase")
public class ConsultaDictadoClaseServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ConsultaDictadoClaseServ() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Aquí obtienes la instancia de la fábrica y del controlador
        Fabrica fabrica = Fabrica.getInstancia();
        IControlador icon = fabrica.getIControlador();
        String strclase = request.getParameter("clase");
        Clase clase = icon.obtenerClaseR(strclase);

        Gson gson = new Gson();
        String json = gson.toJson(clase);

        // Enviar la respuesta JSON al cliente
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

    }


}