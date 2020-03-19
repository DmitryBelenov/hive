<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<head>
    <title>Hive | Company Settings</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
<div style="text-align: center;">
    <div id="header" style="text-align: left">
        <h1>
            <span class="header">&nbsp;Hive</span>
            <img style="width:1.2%" src="resources/logo.png">
            <%final String orgName =  (String) request.getAttribute("org_name");%>
            <span class="header"><%= orgName%></span>
            <span class="header"> / company settings</span>
        </h1>
    </div>
    <br>
        <span style="font-size: 24px; color: #7B5427; font-family: 'Tahoma';">
        <%= orgName%>
        </span>
    <br><br><br>
    <p>
    Здесь будут разные настройки компании
    </p>
    <br><br><br>
    <form method="post" action="main">
        <input type="text" name="type" value="organization" hidden>
        <input type="text" name="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>
        <input type="text" name="org_name" value="<%= request.getAttribute("org_name")%>" hidden>

        <button class="float-left submit-button cool_button">Main</button>
    </form>
    <div id="footer">&copy; 2020</div>
</div>
</body>
</html>