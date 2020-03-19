package ru.servlets;

import ru.objects.appeals.Appeal;
import ru.utils.DBUtils;
import ru.utils.Utils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "OpenAppealServlet", urlPatterns = "/open_appeal")
public class OpenAppealServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String org_uuid = req.getParameter("org_uuid");
        String user_uuid = req.getParameter("user_uuid");

        String appeal_id = req.getParameter("appeal_id");
        String org_name = req.getParameter("org_name");

        req.setAttribute("org_uuid", org_uuid);
        req.setAttribute("user_uuid", user_uuid);

        DBUtils db = new DBUtils();

        Appeal appeal = db.getAppealById(appeal_id);

        req.setAttribute("appeal", appeal);
        req.setAttribute("org_name", org_name);

        req.setAttribute("type", Utils.isNull(user_uuid) ? DashboardRenderServlet.TypesEnum.organization : DashboardRenderServlet.TypesEnum.user);

        resp.setCharacterEncoding("UTF-8");

        RequestDispatcher view = req.getRequestDispatcher("appeal.jsp");
        view.forward(req, resp);

        db.connectionClose();
    }
}
