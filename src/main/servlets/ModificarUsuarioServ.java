package main.servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import datatypes.DtProfesor;
import datatypes.DtUsuario;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import interfaces.Fabrica;
import interfaces.IControlador;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Entrenamos.uy/ModificarUsuario")
public class ModificarUsuarioServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ModificarUsuarioServ() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nuevoNombre");
        String apellido = request.getParameter("nuevoApellido");
        String fecha = request.getParameter("nuevaFecNac");
        HttpSession session = request.getSession();
        String nick = (String) session.getAttribute("username");
        Fabrica fabrica = Fabrica.getInstancia();
        IControlador icon = fabrica.getIControlador();
        SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
        Date fecNacDate;
        try {
            fecNacDate = sdf.parse(fecha);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        DtUsuario user = icon.obtenerUsuario(nick);
        if(user instanceof DtProfesor) {
            icon.ModificarUsuario(nick, nombre, apellido, fecNacDate, ((DtProfesor) user).getDescripcion(),((DtProfesor) user).getBiografia(),((DtProfesor) user).getSitioWeb());
        }
        else{
            icon.ModificarUsuario(nick,nombre,apellido,fecNacDate,"","","");
        }
        RequestDispatcher rd;
        request.setAttribute("mensaje", "Se ha modificado correctamente el usuario " + nick);
        rd = request.getRequestDispatcher("/notificacion.jsp");
        rd.forward(request, response);

    }
}