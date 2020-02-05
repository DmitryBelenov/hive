<%@ page import="ru.objects.roles.RolesEnum" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<head>
    <title>Hive | New User</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<style>
    select {
        width: 173px;
        text-align-last: center;
    }
</style>

<body>
<div style="text-align: center;">
    <div id="header" style="text-align: left">
        <h1>
            <span class="header">&nbsp;Hive</span>
            <img style="width:1.2%" src="resources/logo.png">
            <span class="header"><%= request.getAttribute("org_name")%></span>
            <span class="header"> / new user</span>
        </h1>
    </div>
    <br>
    <form id="user_data" method="post" action="register_user">
        <input type="text" name="uuid" id="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>

        <span style="font-size: 12px; color: #7B5427; font-family: 'Tahoma';">
        <fieldset style="width:300px; margin: 0 auto; border: 1px solid">
            <legend>User data</legend>
        first name:<br>
            <input type="text" name="first_name" id="first_name" placeholder="max 100" maxlength="100"
                   style="text-align: center">
        <br>
        last name:<br>
            <input type="text" name="last_name" id="last_name" placeholder="max 100" maxlength="100"
                   style="text-align: center">
        <br>
        role:<br>
            <select id="roles" size="1" name="role" form="user_data">
                <% for (RolesEnum role : RolesEnum.values()) {
                    String roleName = role.getRoleName();
                %><option><%= roleName%></option><%
                }%>
	        </select>
        <br>
        e-mail:<br>
            <input type="text" name="e_mail" id="e_mail" placeholder="max 100" maxlength="100"
                   style="text-align: center">
        <br>
        icon:<br>
            <select name="icon" size="1" form="user_data">
                <option>male</option>
                <option>female</option>
	        </select>
        <br>
        login:<br>
            <input type="text" name="login" id="login" placeholder="max 50" maxlength="50" style="text-align: center">
        <br><br>
        <button id="process" class="float-left submit-button cool_button">Register user</button>
        <script type="text/javascript">
            document.getElementById("process").onclick = function () {
                var first = document.getElementById("first_name").value;
                var last = document.getElementById("last_name").value;
                var roles = document.getElementById("roles").value;
                var e_mail = document.getElementById("e_mail").value;
                var login = document.getElementById("login").value;

                if (first === "" || last === "" || roles === "" || e_mail === "" || login === "") {
                    alert("Поля формы регистрации не могут быть пустыми");
                    return false;
                } else {
                    return true;
                }
            }
        </script>
            </fieldset>
            </span>
    </form>
    <br>
    <form method="post" action="main">
        <input type="text" name="type" value="organization" hidden>
        <input type="text" name="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>
        <input type="text" name="org_name" value="<%= request.getAttribute("org_name")%>" hidden>

        <button class="float-left submit-button cool_button">Main</button>
    </form>
    <br><br><br>
    <img src="resources/bee.png">
    <div id="footer">&copy; 2020</div>
</div>
</body>
</html>