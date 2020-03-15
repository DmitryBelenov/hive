package ru;

public class AbstractAddress {
    public static String homeUrl;
    public static String dbUrl;
    public static String filesHome = System.getProperty("user.home")+"/AppData/Local/hive/files/";

    public static String getHomeUrl() {
        return homeUrl;
    }

    public static void setHomeUrl(String homeUrl) {
        AbstractAddress.homeUrl = homeUrl;
    }

    public static String getDbUrl() {
        return dbUrl;
    }

    public static void setDbUrl(String dbUrl) {
        AbstractAddress.dbUrl = dbUrl;
    }
}
