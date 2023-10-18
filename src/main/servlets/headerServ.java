package main.servlets;

import java.io.IOException;
import java.rmi.UnexpectedException;

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

@WebServlet("/Entrenamos.uy/HeaderServ")
public class headerServ {
    private static final long serialVersionUID = 1L;

    public headerServ() {
        super();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipoUser;
        Fabrica fabrica = Fabrica.getInstancia();
        IControlador icon = fabrica.getIControlador();

        HttpSession session = request.getSession();
        String nickname = (String) session.getAttribute("username");
        if(icon.esSocio(nickname)){
            tipoUser = "S";
        }
        else{
            tipoUser = "P";
        }
        request.setAttribute("tipoUser", tipoUser);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/header.jsp");
        dispatcher.forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
