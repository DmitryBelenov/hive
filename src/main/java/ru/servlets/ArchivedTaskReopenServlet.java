package ru.servlets;

import ru.utils.DBUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ArchivedTaskReopenServlet", urlPatterns = "/reopen")
public class ArchivedTaskReopenServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String result;

        String taskId = req.getParameter("task_id");
        String new_state = req.getParameter("new_state");
        String task_num = req.getParameter("task_num");

        DBUtils dbu = new DBUtils();
        if (dbu.changeTaskState(taskId, new_state)){
            result = "Задача № "+task_num+" восстановлена из архива";
        } else {
            result = "При попытке воостановления из архива задачи № "+task_num+", произошла ошибка";
        }

        dbu.connectionClose();
        resp.setContentType("text");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(result);
    }
}
