package main.servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;

import datatypes.DtActividadDeportiva;
import excepciones.ActividadDeportivaRepetidaException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import excepciones.InstitucionDeportivaRepetidaException;
import interfaces.Fabrica;
import interfaces.IControlador;

@WebServlet("/Entrenamos.uy/AgregarActividad")
public class AgregarActividadServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AgregarActividadServ() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String institucion = request.getParameter("institucion");
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String duracion = request.getParameter("duracion");
        String costo = request.getParameter("costo");
        String fecha = request.getParameter("fecAlta");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date fecAlta;

        if (nombre.isEmpty() || descripcion.isEmpty() || duracion.isEmpty() || fecha.isEmpty() || costo.isEmpty() || institucion == null || institucion.isEmpty()){
            request.setAttribute("error", "No puede haber campos vacíos");
            RequestDispatcher rd = request.getRequestDispatcher("/AgregarActividadDeportiva.jsp");
            rd.forward(request, response);
        }
        if (duracion.isEmpty() || fecha.isEmpty() || costo.isEmpty() || institucion.isEmpty()) {
            request.setAttribute("error", "No puede haber campos vacíos");
            RequestDispatcher rd = request.getRequestDispatcher("/AgregarActividadDeportiva.jsp");
            rd.forward(request, response);
        }

        Fabrica fabrica = Fabrica.getInstancia();
        IControlador icon = fabrica.getIControlador();

        try {
            fecAlta = sdf.parse(fecha);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        int duracionInt;
        try {
            duracionInt = Integer.parseInt(duracion);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "La Duración debe ser un numero");
            RequestDispatcher rd = request.getRequestDispatcher("/AgregarActividadDeportiva.jsp");
            rd.forward(request, response);
            return;
        }
        float costoFloat;
        try {
            costoFloat = Float.parseFloat(costo);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "El Costo debe ser un número");
            RequestDispatcher rd = request.getRequestDispatcher("/AgregarActividadDeportiva.jsp");
            rd.forward(request, response);
            return;
        }

        DtActividadDeportiva dt = null;
        dt = new DtActividadDeportiva(nombre,descripcion,duracionInt,costoFloat,fecAlta);

        try{
            icon.altaActividadDeportiva(institucion,dt);
        } catch (ActividadDeportivaRepetidaException e) {
            request.setAttribute("error", "La actividad deportiva ya existe");
            RequestDispatcher rd = request.getRequestDispatcher("/AgregarActividadDeportiva.jsp");
            rd.forward(request, response);
            throw new RuntimeException(e);
        }
        RequestDispatcher rd;
        request.setAttribute("mensaje", "Se ha ingresado correctamente la actividad deportiva " + nombre + " en el sistema.");
        rd = request.getRequestDispatcher("/notificacion.jsp");
        rd.forward(request, response);
    }
}