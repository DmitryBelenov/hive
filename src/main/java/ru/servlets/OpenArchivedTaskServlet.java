package ru.servlets;

import ru.objects.OrgUser;
import ru.objects.Task;
import ru.objects.TaskComment;
import ru.utils.DBUtils;
import ru.utils.Utils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OpenArchivedTaskServlet", urlPatterns = "/open_archived_task")
public class OpenArchivedTaskServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String taskId = req.getParameter("task_id");

        DBUtils db = new DBUtils();

        openTaskProcess(req, resp, taskId, db);

        db.connectionClose();
    }

    private void openTaskProcess(HttpServletRequest req,
                                 HttpServletResponse resp,
                                 String taskId,
                                 DBUtils db) throws ServletException, IOException {
        Task task = db.getTaskById(taskId);
        task.setId(taskId);

        req.setAttribute("task", task);

        String orgName = db.getOrgNameById(task.getCreatorOrgId());
        req.setAttribute("org_name", orgName);

        String creatorId = task.getCreatorId();
        if (Utils.isNull(creatorId)) {
            req.setAttribute("creator_name_role", orgName + " (Org)");
        } else {
            OrgUser creator = db.getOrgUserById(creatorId);
            String creatorNameRole = creator.getFirstName() + " " + creator.getLastName() + " (" + creator.getRole().getRoleName() + ")";

            req.setAttribute("creator_name_role", creatorNameRole);
        }

        List<TaskComment> comments = db.getTaskCommentsById(taskId);
        task.setTaskComments(comments);

        resp.setCharacterEncoding("UTF-8");
        RequestDispatcher view = req.getRequestDispatcher("archived_task.jsp");
        view.forward(req, resp);
    }
}
