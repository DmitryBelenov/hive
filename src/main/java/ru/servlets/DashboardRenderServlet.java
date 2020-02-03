package ru.servlets;

import ru.objects.OrgUser;
import ru.objects.Task;
import ru.utils.DBUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "DashboardRenderServlet", urlPatterns = "/main")
public class DashboardRenderServlet extends HttpServlet {

    public enum TypesEnum{
        user("user", "user_dashboard.jsp"),
        organization("organization", "org_dashboard.jsp");

        public String type;
        public String page;

        TypesEnum(String type, String page){
            this.type = type;
            this.page = page;
        }

        public String getType() {
            return type;
        }

        public String getPage() {
            return page;
        }

        protected static String getPageByAction(String type){
            for (TypesEnum e : TypesEnum.values()){
                if (e.getType().equals(type)) return e.getPage();
            }
            return null;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String type = req.getParameter("type");

        String name = req.getParameter("org_name");
        req.setAttribute("org_name", name);

        String org_uuid = req.getParameter("org_uuid");
        req.setAttribute("org_uuid", org_uuid);

        String page = TypesEnum.getPageByAction(type);

        DBUtils db = new DBUtils();
        List<Task> taskList = db.getShortOrgTaskList(org_uuid);
        req.setAttribute("task_list", taskList);


        if (page != null) {
            if (type.equals(TypesEnum.user.getType())){
                String userId = req.getParameter("user_uuid");
                OrgUser userOrg = db.getOrgUserById(userId);

                req.setAttribute("user", userOrg);

                List<Task> userTaskList = db.getUserShortTaskList(userOrg.getUserId());
                req.setAttribute("user_task_list", userTaskList);

                List<String> userTaskIds = new ArrayList<>();
                if (userTaskList.size() > 0) {
                    for (Task task : userTaskList) {
                        userTaskIds.add(task.getId());
                    }
                }
                req.setAttribute("user_task_ids", userTaskIds);
            }

            RequestDispatcher view = req.getRequestDispatcher(page);
            view.forward(req, resp);
        }

        db.connectionClose();
    }
}

