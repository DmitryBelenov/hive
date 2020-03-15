package ru.servlets;

import ru.handlers.Authorization;
import ru.objects.OrgUser;
import ru.objects.Task;
import ru.utils.CryptoUtils;
import ru.utils.DBUtils;
import ru.utils.Utils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AuthServlet", urlPatterns = "/auth")
public class AuthServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String login = req.getParameter("login").trim();
        String password = req.getParameter("pass").trim();

        String prefix = req.getParameter("prefix").trim();

        DBUtils db = new DBUtils();

        resp.setCharacterEncoding("UTF-8");

        if (Utils.isNull(prefix) || prefix.isEmpty()) {
            if (!Authorization.auth(login, password, db)) {
                req.setAttribute("org_name", login);

                RequestDispatcher view = req.getRequestDispatcher("noOrg.jsp");
                view.forward(req, resp);
            } else {
                String name = db.getOrgName(login);
                req.setAttribute("org_name", name);

                String conf_uuid = db.getConfirmationUuid(login);
                req.setAttribute("org_uuid", conf_uuid);

                List<Task> taskList = db.getShortOrgTaskList(conf_uuid);
                req.setAttribute("task_list", taskList);

                RequestDispatcher view = req.getRequestDispatcher("org_dashboard.jsp");
                view.forward(req, resp);
            }
        } else {
            if (!Authorization.authPrefix(prefix, db)){
                req.setAttribute("prefix", prefix);

                RequestDispatcher view = req.getRequestDispatcher("noOrgPrefix.jsp");
                view.forward(req, resp);
            } else {
                String encodedPass = null;
                try {
                    encodedPass = CryptoUtils.getHexBase64(password);
                } catch (NoSuchAlgorithmException nsa){
                    req.setAttribute("cryptoError", "It's looks like server throw error while convert your password to hex<br>Ask your administrator");

                    RequestDispatcher view = req.getRequestDispatcher("passNotConverted.jsp");
                    view.forward(req, resp);
                }

                if (encodedPass != null) {
                    OrgUser user = db.getOrgUserByLoginPassPrefix(login, encodedPass, prefix);

                    if (user != null) {
                        req.setAttribute("user", user);

                        String orgId = user.getOrgId();

                        String name = db.getOrgNameById(orgId);
                        req.setAttribute("org_name", name);

                        List<Task> taskList = db.getShortOrgTaskList(orgId);
                        req.setAttribute("task_list", taskList);

                        List<Task> userTaskList = db.getUserShortTaskList(user.getUserId());
                        req.setAttribute("user_task_list", userTaskList);

                        List<String> userTaskIds = new ArrayList<>();
                        if (userTaskList.size() > 0) {
                            for (Task task : userTaskList) {
                                userTaskIds.add(task.getId());
                            }
                        }
                        req.setAttribute("user_task_ids", userTaskIds);

                        RequestDispatcher view = req.getRequestDispatcher("user_dashboard.jsp");
                        view.forward(req, resp);
                    } else {
                        req.setAttribute("noUserFound", "No activated users by login '"+login+"' in organization with prefix '"+prefix+"'<br>Ask your administrator");

                        RequestDispatcher view = req.getRequestDispatcher("noUserFound.jsp");
                        view.forward(req, resp);
                    }
                }
            }
        }

        db.connectionClose();
    }
}
