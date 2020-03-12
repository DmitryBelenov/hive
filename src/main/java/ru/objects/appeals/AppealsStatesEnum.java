package ru.objects.appeals;

public enum AppealsStatesEnum {

    IN_WORK("В работе"),
    COMPLETED("Завершено"),
    IN_TEST("В тестировании"),
    IN_DEV("В разработке"),
    DELAYED("Отложено"),
    DENIED("Отказ");

    public String state;

    AppealsStatesEnum(String state) {
        this.state = state;
    }

    public String getState() {
        return state;
    }
}
