package ru.servlets;

import ru.objects.OrgUser;
import ru.objects.appeals.Appeal;
import ru.utils.DBUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@MultipartConfig
@WebServlet(name = "NewAppealServlet", urlPatterns = "/new_appeal")
public class NewAppealServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String org_name = req.getParameter("org_name");//1
        String org_uuid = req.getParameter("org_uuid");//2
        String user_uuid = req.getParameter("user_uuid");//3
        String org_users = req.getParameter("org_users"); //4

        String appeal_content = req.getParameter("appeal_content");
        String appeal_comment = req.getParameter("appeal_comment");
        String customer_org_name = req.getParameter("customer_org_name");
        String customer_name = req.getParameter("customer_name");
        String customer_mail = req.getParameter("customer_mail");
        String executor_id = req.getParameter("executor");
        String priority_level = req.getParameter("priority_level");

        String appeal_attachment = req.getParameter("appeal_attachment"); // тут контент вложений а не String
        //todo обработка вложений

        Appeal appeal = new Appeal();
        appeal.setAppealId(UUID.randomUUID().toString());
        appeal.setPriorityLevel(priority_level);

        appeal.setAppealNumber("номер присвоить");
        //todo обработка номера заявки

        appeal.setAppealContent(appeal_content);
        appeal.setSenderOrgName(customer_org_name);
        appeal.setSenderName(customer_name);
        appeal.setSenderMail(customer_mail);

        DBUtils db = new DBUtils();
        OrgUser performer = db.getOrgUserById(executor_id);

        appeal.setPerformer(performer);
        appeal.setCreatorsComment(appeal_comment);
        appeal.setAttachmentLine(""); // тут линия вложений

        db.addNewAppeal(appeal);

        List<Appeal> appeals = db.getAppealsList(org_uuid);
        req.setAttribute("appeals",appeals); //5

        req.setAttribute("org_name", org_name);
        req.setAttribute("org_uuid", org_uuid);
        req.setAttribute("user_uuid", user_uuid);
        req.setAttribute("org_users", org_users);

        RequestDispatcher view = req.getRequestDispatcher("appeals.jsp");
        view.forward(req, resp);

        db.connectionClose();
    }
}
