package ru.objects.roles;

public class QAEngineerRole implements Role {

    private RolesEnum role = RolesEnum.QAEngineer;

    @Override
    public RolesEnum getRole() {
        return this.role;
    }

    @Override
    public void setRole(RolesEnum role) {
        this.role = role;
    }
}
