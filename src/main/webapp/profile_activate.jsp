<%@ page import ="java.util.*" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Hive | Profile activation</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<script type="text/javascript">
    function set() {
        var url = window.location.href;
        var new_url = new URL(url);

        document.getElementById("my_uuid").value = new_url.searchParams.get("uuid");
        document.getElementById("var").value = new_url.searchParams.get("var");
    };
</script>
<body onload="set()">
<div style="text-align: center;">
<div id="header" style="text-align: left">
    <h1>
        <span class="header">&nbsp;Hive</span>
        <img style="width:1.2%" src="resources/logo.png">
    </h1>
</div>
<br>
<div style="text-align: center;">
    <h1>
        Press button for activate profile:
    </h1>
    <form method="post" action="activate">
        <br><br>
        <input type="submit" class="cool_button" value="Activate">
        <input type="text" id="my_uuid" name="uuid" hidden>
        <input type="text" id="var" name="var" hidden>
    </form>
</div>
<div id="footer">&copy; 2020</div>
</div>
</body>
</html>
