package ru.servlets;

import ru.objects.OrgUser;
import ru.objects.Task;
import ru.utils.DBUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@MultipartConfig
@WebServlet(name = "OpenTaskServlet", urlPatterns = "/open_task")
public class OpenTaskServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String taskId = req.getParameter("task_id");

        DBUtils db = new DBUtils();
        Task task = db.getTaskById(taskId);
        task.setId(taskId);

        if (task != null) {
            req.setAttribute("task", task);

            String orgName = db.getOrgNameById(task.getCreatorOrgId());
            req.setAttribute("org_name", orgName);

            String creatorId = task.getCreatorId();
            if (creatorId == null || creatorId.equals("null")) {
                req.setAttribute("creator_name_role", orgName + " (Org)");
            } else {
                OrgUser creator = db.getOrgUserById(creatorId);
                String creatorNameRole = creator.getFirstName() + " " + creator.getLastName() + " (" + creator.getRole().getRoleName() + ")";

                req.setAttribute("creator_name_role", creatorNameRole);
            }

            RequestDispatcher view = req.getRequestDispatcher("task.jsp");
            view.forward(req, resp);
        } else {
            System.out.println("НЕ ПОЛУЧИЛИ ЗАДАЧУ ПО id");
        }

        db.connectionClose();
    }
}

