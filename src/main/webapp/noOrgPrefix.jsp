<%@ page import="ru.AbstractAddress" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hive | No Prefix Found</title>
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
    <h1> Not found activated organization with such prefix '<%String prefix = (String) request.getAttribute("prefix");
        out.println(prefix);
    %>'<br><br>
    </h1>
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