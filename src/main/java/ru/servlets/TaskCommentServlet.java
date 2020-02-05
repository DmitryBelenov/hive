package ru.servlets;

import ru.utils.DBUtils;
import ru.utils.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "TaskCommentServlet", urlPatterns = "/add_comment")
public class TaskCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String orgId = req.getParameter("org_uuid");
        String userId = req.getParameter("user_uuid");
        String taskId = req.getParameter("task_id");
        String content = req.getParameter("content");

        DBUtils dbu = new DBUtils();

        dbu.addTaskComment(orgId, (!Utils.isNull(userId) ? userId : orgId), taskId, content);

        OpenTaskServlet.openTaskProcess(req, resp, taskId, orgId, userId, dbu);

        dbu.connectionClose();
    }
}
