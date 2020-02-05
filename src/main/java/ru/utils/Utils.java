package ru.utils;

public class Utils {

    /**
     * Обвязка на непонятно откуда взявшийся "null"
     *
     * есть предположение что из бд (getString...)
     * */
    public static boolean isNull(String value){
        return value == null || value.equals("null");
    }
}
