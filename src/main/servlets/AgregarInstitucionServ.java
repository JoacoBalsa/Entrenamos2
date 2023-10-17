package main.servlets;

import java.io.IOException;

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
        Fabrica fabrica = Fabrica.getInstancia();
        IControlador icon = fabrica.getIControlador();

        if (nombre.isEmpty() || descripcion.isEmpty() || url.isEmpty()){
            request.setAttribute("error", "No puede haber campos vacíos");
            RequestDispatcher rd = request.getRequestDispatcher("/AgregarInstuticion.jsp");
            rd.forward(request, response);
        }
        try {
            icon.altaInstitucion(nombre,descripcion,url);
        } catch (InstitucionDeportivaRepetidaException e) {
            request.setAttribute("error", "La Institucion Deportiva ya existe");
            RequestDispatcher rd = request.getRequestDispatcher("/AgregarInstuticion.jsp");
            rd.forward(request, response);
            throw new RuntimeException(e);
        }
        RequestDispatcher rd;
        request.setAttribute("mensaje", "Se ha ingresado correctamente la institucion deportiva " + nombre + " en el sistema.");
        rd = request.getRequestDispatcher("/notificacion.jsp");
        rd.forward(request, response);
    }
}