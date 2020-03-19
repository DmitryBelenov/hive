package ru.servlets;

import ru.AbstractAddress;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

@WebServlet(name = "SystemInitializationServlet", urlPatterns = "/systemInit")
public class SystemInitializationServlet extends HttpServlet {

    private final String propertiesPath = System.getProperty("user.home") + "/Hive";
    private final String propertiesFile = propertiesPath + "/hive.properties";

    // for test only!
//    private final String propertiesFile = System.getProperty("user.home") + "/Hive/hive_test.properties";

    private String dataBaseUrlFormat = "jdbc:postgresql:%s?user=%s&password=%s"; // hive_db / postgres / 123

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String result = "OK";

        Properties properties = getSystemProperties();

        if(properties == null){
            result = "Ошибка инициализации файла настроек\nУбедитесь в наличии hive.properties в папке Users/<current_user>/Hive";

            File file = new File(propertiesPath);
            if (!file.exists()) {
                boolean pathCreated = file.mkdir();
                 if (!pathCreated){
                     result = "Недостаточно прав на создание каталога настроек в папке Users";
                 }
            }
        } else {
            String ip = properties.getProperty("hive.server.ip");
            String port = properties.getProperty("hive.server.port");
            String dbName = properties.getProperty("hive.db.name");
            String dbUser = properties.getProperty("hive.db.user");
            String dbPassword = properties.getProperty("hive.db.password");
            String urlPrefix = properties.getProperty("hive.http.type");
            String appName = properties.getProperty("hive.app.deploy.name");

            AbstractAddress.setHomeUrl(urlPrefix + ip + ":" + port + "/" + appName);

            String dataBaseURL = String.format(dataBaseUrlFormat, dbName, dbUser, dbPassword);
            AbstractAddress.setDbUrl(dataBaseURL);
        }

        response.setContentType("text");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(result);
    }

    private Properties getSystemProperties(){
        try (InputStream input = new FileInputStream(propertiesFile)) {
            Properties prop = new Properties();
            prop.load(input);

            return prop;
        } catch (IOException ex) {
            System.out.println("Ошибка инициализации файла настроек системы" + ex);
            return null;
        }
    }
}
