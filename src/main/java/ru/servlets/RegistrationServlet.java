package ru.servlets;
import ru.handlers.Registration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "RegistrationServlet", urlPatterns = "/register")
public class RegistrationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String email = req.getParameter("email");
        String login = req.getParameter("login");
        String password = req.getParameter("password");
        String prefix = req.getParameter("prefix");

        Map<Boolean, String> regResult = Registration.register(name, address, email, login, password, prefix);

        req.setAttribute("reg_result", regResult);
        RequestDispatcher view = req.getRequestDispatcher("reg-result.jsp");

        view.forward(req, resp);
    }
}
