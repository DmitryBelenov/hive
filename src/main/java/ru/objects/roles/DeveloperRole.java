package ru.objects.roles;

public class DeveloperRole implements Role {

    private RolesEnum role = RolesEnum.Developer;

    @Override
    public RolesEnum getRole() {
        return this.role;
    }

    @Override
    public void setRole(RolesEnum role) {
        this.role = role;
    }
}
