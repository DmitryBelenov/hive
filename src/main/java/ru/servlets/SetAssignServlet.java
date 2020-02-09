package ru.servlets;

import ru.utils.DBUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "SetAssignServlet", urlPatterns = "/set_assign")
public class SetAssignServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String newAssignId = req.getParameter("new_assign");
        String taskId = req.getParameter("task_id");
        String orgId = req.getParameter("org_uuid");
        String userId = req.getParameter("user_uuid");

        DBUtils dbu = new DBUtils();

        dbu.setTaskAssignById(taskId, newAssignId);

        OpenTaskServlet.openTaskProcess(req, resp, taskId, orgId, userId, dbu);

        dbu.connectionClose();
    }
}
