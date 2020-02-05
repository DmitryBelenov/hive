package ru.servlets;

import org.apache.commons.io.FileUtils;
import ru.AbstractAddress;
import ru.objects.TaskComment;
import ru.objects.OrgUser;
import ru.objects.Task;
import ru.utils.DBUtils;
import ru.utils.Utils;

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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@MultipartConfig
@WebServlet(name = "NewTaskServlet", urlPatterns = "/new_task")
public class NewTaskServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String org_uuid = req.getParameter("org_uuid");
        String user_uuid = req.getParameter("user_uuid");

        DBUtils db = new DBUtils();

        Task task = getTaskFromRequest(req, db, user_uuid, org_uuid);

        List<Part> imageParts = new ArrayList<>();
        Collection<Part> parts = req.getParts();

        if (parts != null) {
            for (Part part : parts) {
                if (part.getName().equals("attachment") && part.getSize() > 0) {
                    imageParts.add(part);
                }
            }

            String taskHead = task.getHeadLine();
            String [] splitHead = taskHead.split(":");
            String taskHeadPrefix = splitHead[0];
            String imageAllNames = storeFiles(imageParts, org_uuid, task.getId(), taskHeadPrefix, "image", ".jpg");

            if (imageAllNames.length() > 0)
                task.setAttachmentLine(imageAllNames);
            else
                task.setAttachmentLine(null);
        }

        db.addNewTask(task);

        req.setAttribute("org_uuid", org_uuid);
        req.setAttribute("org_name", db.getOrgNameById(org_uuid));

        List<Task> taskList = db.getShortOrgTaskList(org_uuid);
        req.setAttribute("task_list", taskList);


        // если нет id пользоваетля, значит мы под организацией и рендерим ее главную страницу
        RequestDispatcher view;
        if (Utils.isNull(user_uuid)) {
            view = req.getRequestDispatcher(DashboardRenderServlet.TypesEnum.organization.getPage());
        } else {
            OrgUser orgUser = db.getOrgUserById(user_uuid);
            req.setAttribute("user", orgUser);

            List<Task> userTaskList = db.getUserShortTaskList(orgUser.getUserId());
            req.setAttribute("user_task_list", userTaskList);

            List<String> userTaskIds = new ArrayList<>();
            if (userTaskList.size() > 0) {
                for (Task userTask : userTaskList) {
                    userTaskIds.add(userTask.getId());
                }
            }
            req.setAttribute("user_task_ids", userTaskIds);

            view = req.getRequestDispatcher(DashboardRenderServlet.TypesEnum.user.getPage());
        }

        view.forward(req, resp);

        db.connectionClose();
    }

    private String storeFiles(List<Part> fileParts, String org_uuid, String taskId, String taskHeadPrefix, String typeFolder, String type){
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
                            +"task"
                            +"\\"
                            +taskId
                            +"\\"
                            +taskHeadPrefix+(fileParts.size()>1 ? "-"+i : "") + type);
                    FileUtils.copyInputStreamToFile(fileContent, targetFile);

                    names.append(taskHeadPrefix)
                            .append(fileParts.size() > 1 ? "-" + i + (i == fileParts.size() ? "" : ":") : "");

                    i++;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return names.toString();
    }

    private Task getTaskFromRequest(HttpServletRequest req, DBUtils db, String user_uuid, String org_uuid){
        Task task = new Task();
        task.setId(UUID.randomUUID().toString());
        task.setCreatorId(user_uuid == null ? org_uuid : user_uuid);
        task.setCreatorOrgId(org_uuid);

        String taskPrefix = getNextTaskPrefix(db, org_uuid);
        task.setHeadLine(taskPrefix + ": " + req.getParameter("headline"));
        task.setDescription(req.getParameter("description"));
        task.setProject(req.getParameter("project"));
        try {
            task.setDeadLine(new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("deadline")));
        } catch (ParseException e) {
            //если каким то чудом не получили дату с формы, ставим задаче deadline три дня
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_MONTH, 3);
            Date date = cal.getTime();

            task.setDeadLine(date);
        }

        String assignId = req.getParameter("assign");

        OrgUser assign = db.getOrgUserById(assignId);
        task.setAssign(assign);
        task.setCreateDate(new Date());
        task.setPriority(req.getParameter("priority"));

        List<TaskComment> taskComments = new ArrayList<>(); // комментариев при создании задачи у нас нет
        task.setTaskComments(taskComments);

        return task;
    }

    private String getNextTaskPrefix(DBUtils db, String org_uuid){
        String lastPrefix = db.getLastTaskPrefix(org_uuid);

        // получаем номер последней добавленной задачи
        String[] prefixArray = lastPrefix.split("HV");
        int lastNum = Integer.parseInt(prefixArray[1]);

        String next = "HV"+(lastNum + 1);
        db.addLastTaskPrefix(org_uuid, next);

        return next;
    }
}
