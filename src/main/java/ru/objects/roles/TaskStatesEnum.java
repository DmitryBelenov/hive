package ru.objects.roles;

public enum  TaskStatesEnum {

    opened("opened"),
    reopened("reopened"),
    development("dev"),
    testing("test"),
    work("work"),
    review("review"),
    hold("hold"),
    closed("closed"),
    archived("arch");

    public String state;

    TaskStatesEnum(String state){
        this.state = state;
    }

    public String getState() {
        return state;
    }
}
