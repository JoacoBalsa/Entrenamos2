package main.servlets;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import datatypes.DtActividadDeportiva;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import interfaces.Fabrica;
import interfaces.IControlador;
import logica.Clase;

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
        // Obtienes el parámetro "tipo" desde la solicitud
        String tipo = request.getParameter("tipo");

        if (actividadSeleccionada != null && !actividadSeleccionada.isEmpty()) {
            if ("dt".equals(tipo)) {
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
            else if ("clases".equals(tipo)){
                // Obtienes el arreglo de clases correspondientes a la actividad
                String ins = icon.obtenerInstitucionActividad(actividadSeleccionada);
                String[] clases  = icon.listarClases(ins,actividadSeleccionada);

                // Conviertes el arreglo de clases a JSON utilizando Gson
                Gson gson = new Gson();
                String clasesJson = gson.toJson(clases);

                // Estableces el tipo de contenido de la respuesta como JSON
                response.setContentType("application/json");

                // Escribe la respuesta JSON al flujo de salida
                response.getWriter().write(clasesJson);
            }
            else if ("nomIns".equals(tipo)) {
                // Obtienes la institución correspondiente a la actividad
                String ins = icon.obtenerInstitucionActividad(actividadSeleccionada);

                // Estableces el tipo de contenido de la respuesta como JSON
                response.setContentType("application/json");

                // Escribe la respuesta JSON al flujo de salida
                response.getWriter().write(ins);
            }
        }
    }
}