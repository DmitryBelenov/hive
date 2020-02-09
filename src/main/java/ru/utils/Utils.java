package ru.utils;

import ru.objects.Task;

import java.util.Calendar;
import java.util.Date;

public class Utils {

    /**
     * Обвязка на непонятно откуда взявшийся "null"
     *
     * есть предположение что из бд (getString...)
     * */
    public static boolean isNull(String value){
        return value == null || value.equals("null");
    }

    /**
     * Задачет цвет дате окончания срока выполнения задачи
     * */
    public static String getDeadLineColor(Task task){
        String deadlineColor = "#007D1C";
        if (task.getDeadLine().before(new Date())) {
            deadlineColor = "#FF0D00";
        } else {
            Calendar deadLine = Calendar.getInstance();
            deadLine.setTime(task.getDeadLine());
            deadLine.add(Calendar.DAY_OF_MONTH, -3);

            Date yellowSign = deadLine.getTime();
            if (new Date().after(yellowSign)){
                deadlineColor = "#FF9E00";
            }
        }
        return deadlineColor;
    }
}
