package main.servlets;

import excepciones.InstitucionDeportivaRepetidaException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import main.publicadores.ControladorPublish;
import main.publicadores.ControladorPublishService;
import main.publicadores.ControladorPublishServiceLocator;

import java.io.IOException;

@WebServlet("/Entrenamos.uy/AgregarInstitucion")
public class AgregarInstitucionServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AgregarInstitucionServ() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String url = request.getParameter("url");

        if (nombre.isEmpty() || descripcion.isEmpty() || url.isEmpty()){
            request.setAttribute("error", "No puede haber campos vacíos");
            RequestDispatcher rd = request.getRequestDispatcher("/AgregarInstuticion.jsp");
            rd.forward(request, response);
        }
        try {
            agregarInstitucion(nombre,descripcion,url);
        } catch (Exception e) {
            request.setAttribute("error", "No se puede agregar la institucion");
            RequestDispatcher rd = request.getRequestDispatcher("/AgregarInstuticion.jsp");
            rd.forward(request, response);
            throw new RuntimeException(e);
        }
        RequestDispatcher rd;
        request.setAttribute("mensaje", "Se ha ingresado correctamente la institucion deportiva " + nombre + " en el sistema.");
        rd = request.getRequestDispatcher("/notificacion.jsp");
        rd.forward(request, response);
    }

    public void agregarInstitucion(String nombre,String descripcion,String url) throws Exception {
        ControladorPublishService cps = new ControladorPublishServiceLocator();
        ControladorPublish port = cps.getControladorPublishPort();
        port.altaInstitucion(nombre,descripcion,url);
    }
}