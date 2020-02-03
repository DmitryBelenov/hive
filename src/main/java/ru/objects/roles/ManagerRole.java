package ru.objects.roles;

public class ManagerRole implements Role {

    private RolesEnum role = RolesEnum.Manager;

    @Override
    public RolesEnum getRole() {
        return this.role;
    }

    @Override
    public void setRole(RolesEnum role) {
        this.role = role;
    }
}
