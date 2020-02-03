package ru.handlers;

import ru.AbstractAddress;
import ru.utils.CryptoUtils;
import ru.utils.DBUtils;
import ru.utils.MailUtils;

import java.security.NoSuchAlgorithmException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Registration {

    private static final String home = AbstractAddress.homeUrl;
    private static final String reg_link = home + "/profile_activate.jsp?uuid=";

    private static final Pattern email_regex = Pattern.compile("^[\\w!#$%&’*+/=?`{|}~^-]+(?:\\.[\\w!#$%&’*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$");

    public static Map<Boolean, String> register(String name, String address, String email, String login, String password, String prefix) {
        String message = "Success!\nTo complete your registration check your email at '" + email + "'";

        DBUtils ma = new DBUtils();

        if (ma.isExists(login, "login")) {
            message = "Sorry, but login '" + login + "' already used<br>Try another one please";
            ma.connectionClose();
            return Collections.singletonMap(false, message);
        }

        Matcher matcher = email_regex.matcher(email);

        if (!matcher.matches()) {
            message = "Sorry, but email '" + email + "' is not valid<br>Try correct one please";
            ma.connectionClose();
            return Collections.singletonMap(false, message);
        }

        if (ma.isExists(email, "email")) {
            message = "Sorry, but email '" + email + "' already used<br>Try another one please";
            ma.connectionClose();
            return Collections.singletonMap(false, message);
        }

        if (ma.isExists(prefix, "prefix")) {
            message = "Sorry, but prefix '" + prefix + "' already used<br>Try another one please";
            ma.connectionClose();
            return Collections.singletonMap(false, message);
        }

        String hexPassword = null;
        try {
            hexPassword = CryptoUtils.getHex(password);
        } catch (NoSuchAlgorithmException nse) {
            System.out.println("Get hex of password error! " + nse);
        }

        if (hexPassword == null) {
            message = "Sorry, but server can't convert your password to safe hash<br>Try another one please" +
                    "<br>(Hive policy - all passwords need to be kept safe and private)";
            ma.connectionClose();
            return Collections.singletonMap(false, message);
        }

        byte[] passBase64Bytes = Base64.getEncoder().encode(hexPassword.getBytes());
        String passBase64 = new String(passBase64Bytes);

        String confirmation_uuid = UUID.randomUUID().toString();

        boolean addOrg = ma.insert(name, address, email, login, passBase64, confirmation_uuid);

        if (!addOrg) {
            message = "Server error, organization not registered.<br>Ask administrator please";
            ma.connectionClose();
            return Collections.singletonMap(false, message);
        }

        String email_message = "Hello, " + name + "!\nFollow this link for open profile activation page:\n" + reg_link + confirmation_uuid + "&var=org";
        try {
            MailUtils.send(email, "Hive registration", email_message);
        } catch (Exception e) {
            System.out.println("Send mail error: " + e);
            message = "Sorry, we can't sent mail with confirmation link on '" + email + "'. Please try again";

            ma.deleteOrgEmail(email);
            ma.connectionClose();

            return Collections.singletonMap(false, message);
        }

        return Collections.singletonMap(true, message);
    }

    public static Map<Boolean, String> registerUser(String org_uuid, String first, String last, String role, String e_mail, String icon, String login) {
        String message;

        DBUtils ma = new DBUtils();
        String org_email = ma.getValueFromOrganizationByUUID("org_email", org_uuid);
        if (org_email == null) {
            message = "Organization email not found!<br>Check " + org_uuid;
            ma.connectionClose();
            return Collections.singletonMap(false, message);
        }

        message = "Success!\nTo complete user registration check your email at '" + org_email + "'";

        if (ma.isExistsUsers(login, "user_login")) {
            message = "User login '" + login + "' already used<br>Try another one please";
            ma.connectionClose();
            return Collections.singletonMap(false, message);
        }

        Matcher matcher = email_regex.matcher(e_mail);

        if (!matcher.matches()) {
            message = "User email '" + e_mail + "' is not valid<br>Try correct one please";
            ma.connectionClose();
            return Collections.singletonMap(false, message);
        }

        if (ma.isExistsUsers(e_mail, "user_email")) {
            message = "E-mail '" + e_mail + "' already used<br>Try another one please";
            ma.connectionClose();
            return Collections.singletonMap(false, message);
        }

        String password = generateUserPassword();

        String hexPassword = null;
        try {
            hexPassword = CryptoUtils.getHex(password);
        } catch (NoSuchAlgorithmException nse) {
            System.out.println("Get password hex error! " + nse);
        }

        if (hexPassword == null) {
            message = "Sorry, server can't create password for user<br>Try again please";
            ma.connectionClose();
            return Collections.singletonMap(false, message);
        }

        byte[] passBase64Bytes = Base64.getEncoder().encode(hexPassword.getBytes());
        String passBase64 = new String(passBase64Bytes);

        String user_uuid = UUID.randomUUID().toString();

        boolean addUser = ma.insertUsers(org_uuid, user_uuid, first, last, role, e_mail, login, passBase64, icon);

        if (!addUser) {
            message = "Server error, user not registered.<br>Ask administrator please";
            ma.connectionClose();
            return Collections.singletonMap(false, message);
        }

        String email_message = "Access for user " + first + " " + last
                + ":\n\nlogin: "+login+"\npassword: " + password
                + "\n\nFollow this link for open user profile activation page:\n" + reg_link + user_uuid + "&var=user";

        boolean sentToOrg = MailUtils.send(org_email, "Hive user registration", email_message);
        boolean sentToUser = MailUtils.send(e_mail, "Hive registration", "Hello, " + first + " " + last
                + "!\nYour access bellow:\n\nlogin: "+login+"\npassword: " + password
                + "\n\nAsk administrator about profile activation!");

        if (!sentToOrg || !sentToUser){
            message = "Can't sent confirmation on email.<br>Please check organization and user email's";

            ma.deleteUserEmail(e_mail);
            ma.connectionClose();

            return Collections.singletonMap(false, message);
        }

        ma.connectionClose();
        return Collections.singletonMap(true, message);
    }

    private static String generateUserPassword(){
        char[] alphabet_numbers = {'7', 'a', 'A', 'b', 'B', 'c', 'C', 'd', '1', 'D', 'e', 'E', 'f', 'F', 'g', 'G', '2', 'h', 'H', '9', 'i', 'I', 'j', 'J',
                'k', 'K', 'l', 'L', '3', 'm', 'M', 'n', 'N', 'o', 'O', 'p', 'P', 'q', 'Q', 'r', '4', 'R', 's', 'S', 't', 'T', 'u', 'U', '5', 'v', 'V', 'w', 'W', 'x', 'X', 'y', '6','Y', 'z', 'Z' , '8'};

        int passwordLength = 9;
        StringBuilder sb = new StringBuilder();

        for (int i=0; i<passwordLength; i++){
            Random r = new Random();
            int element = r.nextInt(alphabet_numbers.length);

            sb.append(alphabet_numbers[element]);
        }

        return sb.toString();
    }
}
