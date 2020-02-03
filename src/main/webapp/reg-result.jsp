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
        <button id="reg" class="float-left submit-button cool_button">Back to registration</button>
        <script type="text/javascript">
            document.getElementById("reg").onclick = function () {
                location.href = "<%= AbstractAddress.homeUrl%>/reg.html";
            };
        </script>
    <%}%>
        <button id="main" class="float-left submit-button cool_button">Main</button>
        <script type="text/javascript">
            document.getElementById("main").onclick = function () {
                location.href = "<%= AbstractAddress.homeUrl%>";
            };
        </script>
    <div id="footer">&copy; 2020</div>
</div>
</body>
</html>