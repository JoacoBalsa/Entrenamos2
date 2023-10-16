package main.servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import datatypes.DtProfesor;
import datatypes.DtSocio;
import datatypes.DtUsuario;
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

import javax.swing.*;

@WebServlet("/Entrenamos.uy/AgregarUsuario")
public class AgregarUsuarioServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AgregarUsuarioServ() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nickname = request.getParameter("nickname");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String fecha = request.getParameter("fecNac");
        String tipo = request.getParameter("tipoUsuario");
        SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
        Date fecNacDate;
        DtUsuario dtU = null;
        if (nombre.isEmpty() || nickname.isEmpty() || apellido.isEmpty() || fecha.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "No puede haber campos vacíos");
            RequestDispatcher rd = request.getRequestDispatcher("/AgregarUsuario.jsp");
            rd.forward(request, response);
        }
        else {
            try {
                fecNacDate = sdf.parse(fecha);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
            Fabrica fabrica = Fabrica.getInstancia();
            IControlador icon = fabrica.getIControlador();
            try {
                if (tipo.equals("P")) {
                    String bio = request.getParameter("biografia");
                    String desc = request.getParameter("descripcion");
                    String institucion = request.getParameter("institucion");
                    String web = request.getParameter("web");
                    if(bio.isEmpty() || institucion.isEmpty() || desc.isEmpty() || web.isEmpty()){
                        request.setAttribute("error", "No puede haber campos vacíos");
                        RequestDispatcher rd = request.getRequestDispatcher("/AgregarUsuario.jsp");
                        rd.forward(request, response);
                    }
                    else {
                        dtU = new DtProfesor(nickname, nombre, apellido, email, password, fecNacDate, desc, bio, web);
                        icon.agregarUsuario(dtU, institucion);
                    }
                } else if (tipo.equals("S")) {
                    dtU = new DtSocio(nickname, nombre, apellido, email, password, fecNacDate);
                    icon.agregarUsuario(dtU, "");
                }
            } catch (UsuarioRepetidoException e) {
                request.setAttribute("error", "El usuario de nick " + nickname + " ya existe");
                RequestDispatcher rd = request.getRequestDispatcher("/AgregarUsuario.jsp");
                rd.forward(request, response);
            }
            RequestDispatcher rd;
            request.setAttribute("mensaje", "Se ha ingresado correctamente el usuario " + nombre + " en el sistema.");
            rd = request.getRequestDispatcher("/notificacion.jsp");
            rd.forward(request, response);
        }
    }
}