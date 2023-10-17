package main.servlets;

import java.io.IOException;
import java.text.SimpleDateFormat;

import com.google.gson.Gson;
import datatypes.DtActividadDeportiva;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import interfaces.Fabrica;
import interfaces.IControlador;

@WebServlet("/Entrenamos.uy/ConsultaActividadDeportiva")
public class ConsultaActividadDeportivaServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ConsultaActividadDeportivaServ() {
        super();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Aquí obtienes la instancia de la fábrica y del controlador
        Fabrica fabrica = Fabrica.getInstancia();
        IControlador icon = fabrica.getIControlador();

        // Obtienes el parámetro de la actividad desde la solicitud
        String actividadSeleccionada = request.getParameter("actividad");

        if (actividadSeleccionada != null && !actividadSeleccionada.isEmpty()) {
            // Obtienes el DtActividadDeportiva
            String ins = icon.obtenerInstitucionActividad(actividadSeleccionada);
            DtActividadDeportiva dt = icon.obtenerActividad(ins, actividadSeleccionada);

            // Conviertes el objeto DtActividadDeportiva a JSON
            Gson gson = new Gson();
            String actividadJson = gson.toJson(dt);

            // Estableces el tipo de contenido de la respuesta como JSON
            response.setContentType("application/json");

            // Escribe la respuesta JSON al flujo de salida
            response.getWriter().write(actividadJson);
        }
    }


}
