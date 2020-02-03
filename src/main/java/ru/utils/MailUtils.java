package ru.utils;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Base64;
import java.util.Properties;

public class MailUtils {

    private static final String from = "elcoin.sprt@gmail.com";
    private static String pass;

    private static Properties getProperties() {
        Properties props = System.getProperties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable","true");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.localhost", "localhost");
        return props;
    }

    public static boolean send (String to, String title, String msg) {
        pass = new String(Base64.getDecoder().decode(
                "ssd==Ws11D21MDAw34d=FFgGhJhHytJuDYZnJlZTAwMDAwMA==loDFsgD34F56H+=678789s64dGHJ=-GFSgGkHGJhaDsFa235==g54@^46H^"
                        .substring(index(10),index(11)-5)));
        boolean sent;
        Session session = Session.getDefaultInstance(getProperties(),
                new javax.mail.Authenticator(){
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(
                                from, pass);
                    }
                });
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(title, "UTF-8");
            message.setText(msg, "UTF-8");

            Transport.send(message);
            sent = true;
        } catch (Exception e) {
            sent = false;
        }
        return sent;
    }

    private static int index(int i){
        int[] k = new int[i];
        k[0] = 0;
        k[1] = 1;
        for (int j=2; j<i; j++) {
            k[j] = k[j-2] + k[j-1];
        }
        return k[i-1];
    }
}
