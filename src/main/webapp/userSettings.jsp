<%@ page import="ru.objects.OrgUser" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<head>
    <title>Hive | Settings</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="jquery/jquery-3.4.1.js" type="text/javascript"></script>
    <script>
        function changePassword(user, org) {
            var password = document.getElementById("password").value;
            var new_password = document.getElementById("new_password").value;
            var new_password_confirm = document.getElementById("new_password_confirm").value;

            if (password === "" || new_password === "" || new_password_confirm === "")
            {
                alert("Для смены пароля необходимо заполнить все поля");
            } else {
                if (new_password !== new_password_confirm){
                    alert("Пароли не совпадают");
                } else {
                    if (password === new_password) {
                        alert("Новый пароль должен отличаться от старого");
                    } else {
                        if (window.confirm("Вы уверены что хотите изменить пароль?")) {

                            var json =
                                {
                                    user: user,
                                    org: org,
                                    password: password,
                                    new_password: new_password
                                };

                            $.ajax({
                                url: "passwordChange",
                                type: "POST",
                                data: json,
                                dataType: "text",
                                error: function (msg) {
                                    alert("Ошибка сервера:\n" + msg);
                                },
                                success: function (msg) {
                                    alert(msg);
                                }
                            });

                        }
                    }
                }
            }
        }
    </script>
    <style type="text/css">
        #user_settings_block {
            width: 500px;
            margin: 0 auto;
            padding: 30px;
        }
    </style>
</head>

<%
    OrgUser user = (OrgUser) request.getAttribute("user");
%>

<body>
<div style="text-align: center;">
    <div id="header" style="text-align: left">
        <h1>
            <span class="header">&nbsp;Hive</span>
            <img style="width:1.2%" src="resources/logo.png">
            <%final String orgName =  (String) request.getAttribute("org_name");%>
            <span class="header"><%= orgName%></span>
            <span class="header"> / <%= user.getFirstName() + " " + user.getLastName()%></span>
            <span class="header"> / settings</span>
        </h1>
    </div>
    <br>
    <span style="font-size: 24px; color: #7B5427; font-family: 'Tahoma';">
        <%= user.getFirstName() + " " + user.getLastName()%>
        </span>
    <br><br>
    <form method="post" action="main">
        <input type="text" name="type" value="user" hidden>
        <input type="text" name="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>
        <input type="text" name="org_name" value="<%= request.getAttribute("org_name")%>" hidden>
        <input type="text" name="user_uuid" value="<%= user.getUserId()%>" hidden>

        <button class="float-left submit-button cool_button">Main</button>
    </form>
    <div id="user_settings_block" style="text-align: left;">
        <br><br>
        <span style="font-size: 18px; color: #043509; font-family: 'Tahoma';">
        Password change
        </span>
        <hr>
        <%--<form>--%>
            <span style="font-size: 14px; color: #043509; font-family: 'Tahoma';">
            <input type="text" name="user_uuid" value="<%= user.getUserId()%>" hidden>
            password:<br><input type="password" name="password" maxlength="50" id="password" style="text-align: center; border-radius: 4px">
            <br>
            new password:<br><input type="password" name="new_password" maxlength="50" id="new_password" style="text-align: center; border-radius: 4px">
            <br>
            new password confirm:<br><input type="password" name="new_password_confirm" maxlength="50" id="new_password_confirm" style="text-align: center; border-radius: 4px">
            </span>
            <br><br>
            <button class="cool_button" onclick="changePassword('<%= user.getUserId()%>', '<%= user.getOrgId()%>')">Change</button>
        <%--</form>--%>




    </div>
</div>
<div id="footer">&copy; 2020</div>
</body>
</html>