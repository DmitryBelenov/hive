package ru.servlets;

import org.apache.commons.io.FileUtils;
import ru.AbstractAddress;
import ru.utils.DBUtils;
import ru.utils.Utils;

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
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@MultipartConfig
@WebServlet(name = "AddAttachmentToTaskServlet", urlPatterns = "/add_attachment")
public class AddAttachmentToTaskServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String taskId = req.getParameter("task_id");
        String org_uuid = req.getParameter("org_uuid");
        String user_uuid = req.getParameter("user_uuid");

        List<Part> attachParts = new ArrayList<>();
        Collection<Part> parts = req.getParts();

        if (parts != null) {
            for (Part part : req.getParts()) {
                if (part.getName().equals("attachment") && part.getSize() > 0) {
                    attachParts.add(part);
                }
            }

            DBUtils dbu = new DBUtils();
            String attachmentLine = dbu.getTaskAttachmentLine(taskId);

            if (!Utils.isNull(attachmentLine)) {
                String taskHeadPrefix;
                int numOfAttaches;

                StringBuilder newAttachmentLine = new StringBuilder();
                if (attachmentLine.contains(":")) {
                    String[] attachArray = attachmentLine.split(":");
                    String lastAttachName = attachArray[attachArray.length - 1];

                    String[] lastAttachArr = lastAttachName.split("-");

                    taskHeadPrefix = lastAttachArr[0];
                    numOfAttaches = Integer.parseInt(lastAttachArr[1]);

                    newAttachmentLine.append(attachmentLine).append(":");
                } else {
                    taskHeadPrefix = attachmentLine.split("-")[0];
                    numOfAttaches = 1;

                    newAttachmentLine.append(taskHeadPrefix).append("-1:");
                }

                int i = 1;
                for (Part filePart : attachParts) {
                    numOfAttaches++;

                    InputStream fileContent;

                    fileContent = filePart.getInputStream();

                    File targetFile = new File(AbstractAddress.filesHome
                            + org_uuid
                            + "/image/task/"
                            + taskId + "/" + taskHeadPrefix + "-" + numOfAttaches + ".jpg");

                    FileUtils.copyInputStreamToFile(fileContent, targetFile);

                    newAttachmentLine.append(taskHeadPrefix).append("-").append(numOfAttaches).append(i == attachParts.size() ? "" : ":");

                    i++;
                }

                dbu.updateTaskAttachmentLine(taskId, newAttachmentLine.toString());
            } else {
                String taskHeadPrefix = dbu.getTaskPrefixById(taskId);
                String attachesNames = NewTaskServlet.storeFiles(attachParts, org_uuid, taskId, taskHeadPrefix, "image", ".jpg");

                dbu.updateTaskAttachmentLine(taskId, attachesNames);
            }

            OpenTaskServlet.openTaskProcess(req, resp, taskId, org_uuid, user_uuid, dbu);

            dbu.connectionClose();
        }
    }
}
