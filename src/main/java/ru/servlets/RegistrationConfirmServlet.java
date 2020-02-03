package ru.servlets;

import ru.utils.DBUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegistrationConfirmServlet", urlPatterns = "/activate")
public class RegistrationConfirmServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uuid = req.getParameter("uuid");
        String var = req.getParameter("var");

        DBUtils ma = new DBUtils();

        if (var.equals("user"))
            ma.updateConfirmation("org_users", "user", "user", uuid);

        if (var.equals("org"))
            ma.updateConfirmation("organizations", "email", "confirmation", uuid);

        RequestDispatcher view = req.getRequestDispatcher("activation_success.jsp");
        view.forward(req, resp);

        ma.connectionClose();
    }
}
