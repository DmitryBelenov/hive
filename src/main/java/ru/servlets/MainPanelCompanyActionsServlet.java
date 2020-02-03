package ru.servlets;

import ru.utils.DBUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "MainPanelCompanyActionsServlet", urlPatterns = "/main_panel_action")
public class MainPanelCompanyActionsServlet extends HttpServlet {

    protected enum ActionsEnum{
        user("new_user", "addUser.jsp"),
        taskUser("task", "addTaskUser.jsp"),
        task("new_task", "addTask.jsp"),
        event("new_event", "addEvent.jsp"),
        userEvent("event", "addEventUser.jsp"),
        info("company_info", "companyInfo.jsp");

        public String action;
        public String page;

        ActionsEnum(String action, String page){
            this.action = action;
            this.page = page;
        }

        public String getAction() {
            return action;
        }

        public String getPage() {
            return page;
        }

        protected static String getPageByAction(String action){
            for (ActionsEnum e : ActionsEnum.values()){
                if (e.getAction().equals(action)) return e.getPage();
            }
            return null;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

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
            if (ActionsEnum.task.getAction().equals(action) || ActionsEnum.taskUser.getAction().equals(action)){
                Map<String, String> orgUsersMap = db.getOrgUsersMap(org_uuid);

                req.setAttribute("org_users", orgUsersMap);
            }

            RequestDispatcher view = req.getRequestDispatcher(page);
            view.forward(req, resp);

            db.connectionClose();
        }
    }
}
