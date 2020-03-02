package ru.servlets;

import ru.utils.CryptoUtils;
import ru.utils.DBUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = "/passwordChange")
public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String result = "no results";

        String user_uuid = req.getParameter("user");
        String org_uuid = req.getParameter("org");
        String password = req.getParameter("password");
        String new_password = req.getParameter("new_password");

        DBUtils dbu = new DBUtils();
        String userPassBase64 = dbu.getUserPassBase64ById(user_uuid, org_uuid);

        if (userPassBase64 != null) {
            try {
                String hexPassword = CryptoUtils.getHex(password);

                byte[] passBase64Bytes = Base64.getEncoder().encode(hexPassword.getBytes());
                String passBase64 = new String(passBase64Bytes);

                if (passBase64.equals(userPassBase64)) {
                    String hexNewPassword = CryptoUtils.getHex(new_password);

                    byte[] newPassBase64Bytes = Base64.getEncoder().encode(hexNewPassword.getBytes());
                    String newPassBase64 = new String(newPassBase64Bytes);

                    if (dbu.updateUserPassBase64ById(user_uuid, org_uuid, newPassBase64)){
                        result = "Пароль изменен";
                    } else {
                        result = "Пароль не изменен, обратитесь к администратору.";
                    }
                } else {
                    result = "Текущий пароль введен не верно";
                }
            } catch (NoSuchAlgorithmException e) {
                result = "Пароль не изменен. Ошибка сервера, обратитесь к администратору.";
            }
        }

        dbu.connectionClose();
        resp.setContentType("text");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(result);
    }
}
