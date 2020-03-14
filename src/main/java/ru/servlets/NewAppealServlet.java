package ru.servlets;

import org.apache.commons.io.FileUtils;
import ru.AbstractAddress;
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
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

@MultipartConfig
@WebServlet(name = "NewAppealServlet", urlPatterns = "/new_appeal")
public class NewAppealServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String org_name = req.getParameter("org_name");//1
        String org_uuid = req.getParameter("org_uuid");//2
        String user_uuid = req.getParameter("user_uuid");//3

        String appeal_content = req.getParameter("appeal_content");
        String appeal_comment = req.getParameter("appeal_comment");
        String customer_org_name = req.getParameter("customer_org_name");
        String customer_name = req.getParameter("customer_name");
        String customer_mail = req.getParameter("customer_mail");
        String executor_id = req.getParameter("executor");
        String priority_level = req.getParameter("priority_level");

        Appeal appeal = new Appeal();
        appeal.setAppealId(UUID.randomUUID().toString());
        appeal.setOrgId(org_uuid);
        appeal.setPriorityLevel(priority_level);

        appeal.setAppealContent(appeal_content);
        appeal.setSenderOrgName(customer_org_name);
        appeal.setSenderName(customer_name);
        appeal.setSenderMail(customer_mail);

        DBUtils db = new DBUtils();
        OrgUser performer = db.getOrgUserById(executor_id);

        appeal.setPerformer(performer);
        appeal.setCreatorsComment(appeal_comment);
        appeal.setAttachmentLine(""); // тут линия вложений

        String appealPrefix = getNextAppealPrefix(db, org_uuid);
        appeal.setAppealNumber(appealPrefix);

        List<Part> imageParts = new ArrayList<>();
        Collection<Part> parts = req.getParts();

        if (parts != null) {
            for (Part part : parts) {
                if (part.getName().equals("appeal_attachment") && part.getSize() > 0) {
                    imageParts.add(part);
                }
            }

            String appealNumber = appeal.getAppealNumber();
            String imageAllNames = storeFiles(imageParts, org_uuid, appeal.getAppealId(), appealNumber, "image", ".jpg");

            if (imageAllNames.length() > 0)
                appeal.setAttachmentLine(imageAllNames);
            else
                appeal.setAttachmentLine(null);
        }

        db.addNewAppeal(appeal);

        List<Appeal> appeals = db.getAppealsList(org_uuid);
        req.setAttribute("appeals",appeals); //5

        Map<String, String> orgUsersMap = db.getOrgUsersMap(org_uuid);

        req.setAttribute("org_name", org_name);
        req.setAttribute("org_uuid", org_uuid);
        req.setAttribute("user_uuid", user_uuid);
        req.setAttribute("org_users", orgUsersMap);

        resp.setCharacterEncoding("UTF-8");
        RequestDispatcher view = req.getRequestDispatcher("appeals.jsp");
        view.forward(req, resp);

        db.connectionClose();
    }

    private String getNextAppealPrefix(DBUtils db, String org_uuid){
        String lastPrefix = db.getLastAppealPrefix(org_uuid);

        // получаем номер последней добавленной заявки
        String[] prefixArray = lastPrefix.split("AP");
        int lastNum = Integer.parseInt(prefixArray[1]);

        String next = "AP"+(lastNum + 1);
        db.addLastAppealPrefix(org_uuid, next);

        return next;
    }

    static String storeFiles(List<Part> fileParts, String org_uuid, String appealId, String appealNumber, String typeFolder, String type){
        StringBuilder names = new StringBuilder();
        if (fileParts.size() > 0) {
            try {
                int i = 1;
                for (Part filePart : fileParts) {
                    InputStream fileContent;

                    fileContent = filePart.getInputStream();

                    File targetFile = new File(AbstractAddress.filesHome
                            +org_uuid
                            +"\\"
                            +typeFolder
                            +"\\"
                            +"appeal"
                            +"\\"
                            + appealId
                            +"\\"
                            + appealNumber + "-" + i + type);
                    FileUtils.copyInputStreamToFile(fileContent, targetFile);

                    names.append(appealNumber)
                            .append("-")
                            .append(i)
                            .append(i == fileParts.size() ? "" : ":");

                    i++;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return names.toString();
    }
}
