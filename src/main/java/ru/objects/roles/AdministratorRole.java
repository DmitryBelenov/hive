package ru.objects.roles;

public class AdministratorRole implements Role {

    private RolesEnum role = RolesEnum.Administrator;

    @Override
    public RolesEnum getRole() {
        return this.role;
    }

    @Override
    public void setRole(RolesEnum role) {
        this.role = role;
    }
}
