package ru.servlets;

import ru.objects.OrgUser;
import ru.objects.Task;
import ru.objects.appeals.Appeal;
import ru.utils.DBUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@WebServlet(name = "MainPanelCompanyActionsServlet", urlPatterns = "/main_panel_action")
public class MainPanelCompanyActionsServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        String org_uuid = req.getParameter("org_uuid");
        String user_uuid = req.getParameter("user_uuid");
        String org_name = req.getParameter("org_name");

        req.setAttribute("org_name", org_name);
        req.setAttribute("org_uuid", org_uuid);
        req.setAttribute("user_uuid", user_uuid);

        String page = ActionsEnum.getPageByAction(action);

        if (page != null) {
            DBUtils db = new DBUtils();
            if (Arrays.asList(ActionsEnum.task.getAction(),
                    ActionsEnum.taskUser.getAction(),
                    ActionsEnum.appeals.getAction()).contains(action)) {
                Map<String, String> orgUsersMap = db.getOrgUsersMap(org_uuid);

                req.setAttribute("org_users", orgUsersMap);
            }

            if (ActionsEnum.userSettings.getAction().equals(action)) {
                OrgUser orgUser = db.getOrgUserById(user_uuid);
                req.setAttribute("user", orgUser);
            }

            if (ActionsEnum.appeals.getAction().equals(action)) {
                List<Appeal> appeals = db.getAppealsList(org_uuid);
                req.setAttribute("appeals", appeals);
            }

            if (ActionsEnum.archive.getAction().equals(action)) {
                List<Task> taskList = db.getShortOrgArchivedTaskList(org_uuid);
                req.setAttribute("task_list", taskList);
            }

            RequestDispatcher view = req.getRequestDispatcher(page);
            view.forward(req, resp);

            db.connectionClose();
        }
    }

    protected enum ActionsEnum {
        user("new_user", "addUser.jsp"),
        taskUser("task", "addTaskUser.jsp"),
        task("new_task", "addTask.jsp"),
        event("new_event", "addEvent.jsp"),
        userEvent("event", "addEventUser.jsp"),
        settings("company_settings", "companySettings.jsp"),
        userSettings("settings", "userSettings.jsp"),
        appeals("appeals", "appeals.jsp"),
        archive("archive", "archive.jsp");

        public String action;
        public String page;

        ActionsEnum(String action, String page) {
            this.action = action;
            this.page = page;
        }

        protected static String getPageByAction(String action) {
            for (ActionsEnum e : ActionsEnum.values()) {
                if (e.getAction().equals(action)) return e.getPage();
            }
            return null;
        }

        public String getAction() {
            return action;
        }

        public String getPage() {
            return page;
        }
    }
}
