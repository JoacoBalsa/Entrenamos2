package main.servlets;

import com.google.gson.Gson;
import interfaces.Fabrica;
import interfaces.IControlador;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@WebServlet("/Entrenamos.uy/ConsultaUsuario")

public class ConsultaUsuarioServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ConsultaUsuarioServ() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Fabrica fabrica = Fabrica.getInstancia();
        IControlador icon = fabrica.getIControlador();
        String[] clases;

        String nick = request.getParameter("user");
        String tipo = request.getParameter("tipo");
        if(icon.esSocio(nick)){
            clases = icon.usuarioEnClase(nick);
        }else {
            clases = icon.clasesProfe(nick);
        }
        if("actividad".equals(tipo)){
            // Utilizar un conjunto para mantener un registro de los valores únicos
            Set<String> actividadesSet = new HashSet<>();

            for (int i = 0; i < clases.length; ++i) {
                // Obtener el nombre de la actividad de la clase
                String actividadNombre = icon.obtenerClaseR(clases[i]).getActividad().getNombre();

                // Agregar el nombre de la actividad al conjunto
                actividadesSet.add(actividadNombre);
            }
            // Convertir el conjunto de actividades nuevamente a un arreglo
            clases = actividadesSet.toArray(new String[0]);
        }
        // Conviertes el array de cadenas a un formato JSON
        Gson gson = new Gson();
        String clasesJson = gson.toJson(clases);

        // Estableces el tipo de contenido de la respuesta como JSON
        response.setContentType("application/json");

        // Escribe la respuesta JSON al flujo de salida
        response.getWriter().write(clasesJson);
    }
}
