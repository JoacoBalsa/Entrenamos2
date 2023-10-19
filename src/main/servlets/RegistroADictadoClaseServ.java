package main.servlets;

import com.google.gson.Gson;
import excepciones.RegistroAClaseRepetidoException;
import interfaces.Fabrica;
import interfaces.IControlador;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;

@WebServlet("/Entrenamos.uy/RegistroADictadoClase")
public class RegistroADictadoClaseServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegistroADictadoClaseServ() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Aquí obtienes la instancia de la fábrica y del controlador
        Fabrica fabrica = Fabrica.getInstancia();
        IControlador icon = fabrica.getIControlador();

        // Obtienes el parámetro de la institución desde la solicitud
        String institucionSeleccionada = request.getParameter("institucion");
        String actividadSeleccionada = request.getParameter("actividad_depor");

        if (actividadSeleccionada != null && !actividadSeleccionada.isEmpty()) {
            // Obtienes las actividades deportivas para la institución seleccionada
            String[] clases = icon.listarClases(institucionSeleccionada, actividadSeleccionada);

            // Conviertes el array de cadenas a un formato JSON
            Gson gson = new Gson();
            String clasesJson = gson.toJson(clases);

            // Estableces el tipo de contenido de la respuesta como JSON
            response.setContentType("application/json");

            // Escribe la respuesta JSON al flujo de salida
            response.getWriter().write(clasesJson);
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Fabrica fabrica = Fabrica.getInstancia();
        IControlador icon = fabrica.getIControlador();
        String clase = request.getParameter("clase");
        HttpSession session = request.getSession();
        String nick = (String)session.getAttribute("username");
        Date date = new Date();
        try {
            icon.registroADictadoClase(nick, clase,date);
        } catch (RegistroAClaseRepetidoException e) {
            request.setAttribute("error", "El usuario de nick " + nick + " ya esta en la clase " + clase);
            RequestDispatcher rd = request.getRequestDispatcher("/RegistroADictadoClase.jsp");
            rd.forward(request, response);
        }
        RequestDispatcher rd;
        request.setAttribute("mensaje", "Se ha ingresado correctamente el usuario " + nick + " en la clase " + clase);
        rd = request.getRequestDispatcher("/notificacion.jsp");
        rd.forward(request, response);
    }
}
