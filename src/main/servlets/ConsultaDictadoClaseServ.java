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

        // Obtienes el parámetro de la institución desde la solicitud
        String institucionSeleccionada = request.getParameter("institucion");

        if (institucionSeleccionada != null && !institucionSeleccionada.isEmpty()) {
            // Obtienes las actividades deportivas para la institución seleccionada
            String[] actividades = icon.listarActividadesDeportivas(institucionSeleccionada);

            // Conviertes el array de cadenas a un formato JSON
            Gson gson = new Gson();
            String actividadesJson = gson.toJson(actividades);

            // Estableces el tipo de contenido de la respuesta como JSON
            response.setContentType("application/json");

            // Escribe la respuesta JSON al flujo de salida
            response.getWriter().write(actividadesJson);

        }
        String claseSeleccionada = request.getParameter("clase");

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

    }


}