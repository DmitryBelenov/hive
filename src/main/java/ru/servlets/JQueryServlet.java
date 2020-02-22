package ru.servlets;

import org.json.JSONObject;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ajaxRequest")
public class JQueryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");

        String userName = req.getParameter("userName");
        String greetings = "Hello %s, welcome to ajax via POST..!";

        JSONObject list = new JSONObject();
        list.put(userName, String.format(greetings, userName));
        list.put("Vasya",String.format(greetings, "Vasya Pupkin"));
        list.put("Ivan",String.format(greetings, "Ivan Ivanov"));
        list.put("Petr",String.format(greetings, "Petr Petrov"));

        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(list.toString());
    }
}
