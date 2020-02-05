package ru.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@MultipartConfig
@WebServlet(name = "AddAttachmentToTaskServlet", urlPatterns = "/add_attachment")
public class AddAttachmentToTaskServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String taskId = req.getParameter("task_id");

        List<Part> imageParts = new ArrayList<>();
        Collection<Part> parts = req.getParts();

        if (parts != null) {
            //todo логика добавления вложений к задаче
        }
    }
}
