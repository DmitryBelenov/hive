<%@ page import ="java.util.*" %>
<%@ page import="ru.AbstractAddress" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Hive | Reg results</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
<div style="text-align: center;">
    <div id="header" style="text-align: left">
        <h1>
            <span class="header">&nbsp;Hive</span>
            <img style="width:1.2%" src="resources/logo.png">
        </h1>
    </div>
    <br>
    <%
        Map<Boolean,String> result =  (Map<Boolean,String>) request.getAttribute("reg_result");
        Boolean success = false;
        String message = "No results from server";
        for (Boolean key : result.keySet()){
            success = key;
            message = result.get(key);
        }

        out.println("<h1>"+message+"</h1><br><br>");
        if (!success) { %>
    <input type="submit" class="cool_button" value="Back" onclick="window.history.go(-1); return false;">
    <%}%>
    <br>
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