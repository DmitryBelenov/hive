package ru.servlets;

import ru.objects.OrgUser;
import ru.objects.Task;
import ru.objects.TaskComment;
import ru.utils.DBUtils;
import ru.utils.Utils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@MultipartConfig
@WebServlet(name = "OpenTaskServlet", urlPatterns = "/open_task")
public class OpenTaskServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String taskId = req.getParameter("task_id");
        String org_uuid = req.getParameter("org_uuid");
        String user_uuid = req.getParameter("user_uuid");

        DBUtils db = new DBUtils();

        openTaskProcess(req, resp, taskId, org_uuid, user_uuid, db);

        db.connectionClose();
    }

    static void openTaskProcess(HttpServletRequest req,
                                       HttpServletResponse resp,
                                       String taskId,
                                       String org_uuid,
                                       String user_uuid,
                                       DBUtils db ) throws ServletException, IOException{
        Task task = db.getTaskById(taskId);
        task.setId(taskId);

        if (task != null) {
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

            req.setAttribute("org_uuid", org_uuid);
            req.setAttribute("user_uuid", user_uuid);

            //если зашли под организацией то id пользователя нет и тип ставим 'организация'
            req.setAttribute("type", Utils.isNull(user_uuid) ? DashboardRenderServlet.TypesEnum.organization : DashboardRenderServlet.TypesEnum.user);

            Map<String, String> orgUsersMap = db.getOrgUsersMap(org_uuid);
            req.setAttribute("org_users", orgUsersMap);

            List<TaskComment> comments = db.getTaskCommentsById(taskId);
            task.setTaskComments(comments);

            resp.setCharacterEncoding("UTF-8");

            RequestDispatcher view = req.getRequestDispatcher("task.jsp");
            view.forward(req, resp);
        } else {
            System.out.println("НЕ ПОЛУЧИЛИ ЗАДАЧУ ПО id");
        }
    }
}

