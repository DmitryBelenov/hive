package ru.handlers;

import ru.utils.CryptoUtils;
import ru.utils.DBUtils;

import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class Authorization {
    public static boolean auth(String login, String password, DBUtils mu){
        String passHex = null;
        try {
           passHex = CryptoUtils.getHex(password);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        if (passHex == null) return false;

        byte[] base64passHex = Base64.getEncoder().encode(passHex.getBytes());
        String base64pass = new String(base64passHex);

        return mu.isOrgProfileExists(login, base64pass);
    }

    public static boolean authPrefix(String prefix, DBUtils db){
        return db.isOrgPrefixExists(prefix);
    }
}
