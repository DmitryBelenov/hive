package ru.objects.roles;

import ru.objects.actions.Action;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;

public enum RolesEnum {

    Administrator("Administrator", Arrays.asList(Action.USERS_CREATE,
            Action.USERS_EDIT,
            Action.EVENT_CREATE,
            Action.EVENT_EDIT,
            Action.ORG_EDIT,
            Action.TASK_CREATE,
            Action.TASK_EDIT,
            Action.TASK_CLOSE,
            Action.ADD_ATTACHMENTS)),

    Manager("Manager", Arrays.asList(Action.USERS_EDIT,
            Action.TASK_CREATE,
            Action.TASK_EDIT,
            Action.TASK_CLOSE,
            Action.EVENT_CREATE,
            Action.ADD_ATTACHMENTS)),

    QAEngineer("QAEngineer", Arrays.asList(Action.TASK_CREATE,
            Action.TASK_EDIT,
            Action.ADD_ATTACHMENTS)),

    Developer("Developer", Arrays.asList(Action.TASK_CREATE,
            Action.TASK_EDIT,
            Action.ADD_ATTACHMENTS)),

    Support("Support", Arrays.asList(Action.TASK_CREATE,
            Action.TASK_EDIT,
            Action.ADD_ATTACHMENTS,
            Action.EVENT_CREATE,
            Action.MANAGE_APPEALS)),

    Customer("Customer", Collections.singletonList(Action.CONTENT_VIEW));

    public Role role;
    public String roleName;
    public Collection<String> actions;

    RolesEnum(String roleName, Collection<String> actions) {
        this.roleName = roleName;
        this.actions = actions;
    }

    public Collection<String> getActions() {
        return actions;
    }

    public void setActions(Collection<String> actions) {
        this.actions = actions;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public static RolesEnum getRoleByName(String roleName){
        for (RolesEnum role : RolesEnum.values()){
            if (role.getRoleName().equals(roleName)) return role;
        }
        return null;
    }
}
