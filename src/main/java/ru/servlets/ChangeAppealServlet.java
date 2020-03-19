package ru.servlets;

import ru.utils.DBUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ChangeAppealServlet", urlPatterns = "/appealChange")
public class ChangeAppealServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");

        String result;

        String appeal_id = req.getParameter("appeal_id");
        String new_state = req.getParameter("new_state");
        String new_priority = req.getParameter("new_priority");
        String new_comment = req.getParameter("new_comment");

        DBUtils dbu = new DBUtils();

        if (dbu.saveAppealChanges(appeal_id, new_state, new_priority, new_comment)){
            result = "Изменения сохранены";
        } else {
            result = "При сохранении изменений на сервере произошла ошибка, обратитесь к администратору.";
        }

        dbu.connectionClose();
        resp.setContentType("text");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(result);
    }
}
