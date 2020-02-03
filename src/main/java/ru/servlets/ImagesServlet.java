package ru.servlets;

import ru.AbstractAddress;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet("/attach/*")
public class ImagesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String info = request.getPathInfo();
        String[] paramArr = info.split("/");

        String org_uuid = paramArr[1];
        String taskId = paramArr[2];
        String img_name = paramArr[3];

        File file = new File(AbstractAddress.filesHome + "\\" + org_uuid + "\\image\\task\\" + taskId + "\\"+ img_name+".jpg");

        if (file.exists()) {
            byte[] content = Files.readAllBytes(file.toPath());
            response.setContentType(getServletContext().getMimeType(img_name));
            response.setContentLength(content.length);
            response.getOutputStream().write(content);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
        }
    }
}
