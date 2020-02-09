package ru.servlets;

import ru.utils.DBUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "SetStateServlet", urlPatterns = "/set_state")
public class SetStateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String state = req.getParameter("state");
        String taskId = req.getParameter("task_id");
        String orgId = req.getParameter("org_uuid");
        String userId = req.getParameter("user_uuid");

        DBUtils dbu = new DBUtils();

        dbu.setTaskStateById(taskId, state);

        OpenTaskServlet.openTaskProcess(req, resp, taskId, orgId, userId, dbu);

        dbu.connectionClose();
    }
}
