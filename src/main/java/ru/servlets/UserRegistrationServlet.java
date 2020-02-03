package ru.servlets;

import ru.handlers.Registration;
import ru.utils.DBUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "UserRegistrationServlet", urlPatterns = "/register_user")
public class UserRegistrationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String uuid = req.getParameter("uuid");

        String first_name = req.getParameter("first_name");
        String last_name = req.getParameter("last_name");
        String role = req.getParameter("role");
        String e_mail = req.getParameter("e_mail");
        String icon = req.getParameter("icon");
        String login = req.getParameter("login");

        Map<Boolean, String> regResult = Registration.registerUser(uuid, first_name, last_name, role, e_mail, icon, login);

        req.setAttribute("reg_result", regResult);
        req.setAttribute("org_uuid", uuid);

        DBUtils du = new DBUtils();

        req.setAttribute("org_name", du.getOrgNameById(uuid));
        du.connectionClose();

        RequestDispatcher view = req.getRequestDispatcher("reg-result2.jsp");

        view.forward(req, resp);
    }
}
