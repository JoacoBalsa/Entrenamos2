package main.servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
@WebServlet("/Entrenamos.uy/AgregarDictadoClase")
public class AgregarDictadoClaseServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AgregarDictadoClaseServ() {
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
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String institucion = request.getParameter("institucion");
        String actividad_depor = request.getParameter("actividad_depor");
        String nombre = request.getParameter("nombre");
        String fecIni = request.getParameter("fecIni");
        String url = request.getParameter("url");
        String hora = request.getParameter("hora");
        Fabrica fabrica = Fabrica.getInstancia();
        IControlador icon = fabrica.getIControlador();

        if (institucion == null || actividad_depor == null || nombre.isEmpty() || request.getParameter("fecIni") == null || url.isEmpty() || hora == null){

            request.setAttribute("error", "No puede haber campos vacíos");
            RequestDispatcher rd = request.getRequestDispatcher("/AgregarDictadoClase.jsp");
            rd.forward(request, response);
        }else{
            // Para obtener el usuario de la sesión actual
            HttpSession session = request.getSession();
            String storedUsername = (String) session.getAttribute("username");

            // Para obtener la fecha del sistema
            Date fechaReg = new Date();
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");

            Date fechaInicio;
            try {
                fechaInicio = formato.parse(fecIni);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }

            try{
                icon.altaDictadoClase(new DtClase(nombre, fechaInicio, hora, url, fechaReg), institucion, actividad_depor, storedUsername);
            } catch(DictadoRepetidoException e){
                throw new RuntimeException(e);
            }

            RequestDispatcher rd;
            request.setAttribute("mensaje", "Se ha ingresado correctamente el dictado de clase de nombre: " + nombre + " en el sistema.");
            rd = request.getRequestDispatcher("/notificacion.jsp");
            rd.forward(request, response);
        }


    }
}
