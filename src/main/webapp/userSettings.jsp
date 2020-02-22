<%@ page import="ru.objects.OrgUser" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<head>
    <title>Hive | Settings</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="jquery/jquery-3.4.1.js" type="text/javascript"></script>
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
        <form>
            <input type="text" name="user_uuid" value="<%= user.getUserId()%>" hidden>
            password:<br><input type="password" name="password" placeholder="max 50" maxlength="50" id="password" style="text-align: center">
            <br>
            new password:<br><input type="password" name="new_password" placeholder="max 50" maxlength="50" id="new_password" style="text-align: center">
            <br>
            new password confirm:<br><input type="password" name="new_password_confirm" placeholder="max 50" maxlength="50" id="new_password_confirm" style="text-align: center">
            <br><br>
            <button class="cool_button" onclick="">Change</button>
        </form>




    </div>
</div>
<div id="footer">&copy; 2020</div>
</body>
</html>