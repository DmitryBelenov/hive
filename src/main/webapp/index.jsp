<%@ page import="ru.AbstractAddress" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hive | Welcome</title>
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
    <form method="post" action="auth">
            <span style="font-size: 12px; font-family: 'Century Gothic';">
            <fieldset style="width:300px; margin: 0 auto; border: 1px solid; border-radius: 3px">
                <legend>Authorization</legend>
            login:<br>
            <input type="text" name="login" id="login" style="text-align: center; max-width: 158px; border-radius: 4px">
            <br>
            password:<br>
            <input type="text" name="prefix" id="prefix" placeholder="prefix" style="text-align: center; max-width: 60px; border-radius: 4px">&nbsp;<input type="password" name="pass" id="pass" style="text-align: center; max-width: 90px; border-radius: 4px">
            <br><br>
            <button id="auth" class="float-left submit-button cool_button">Log In</button>
            <script type="text/javascript">
                document.getElementById("auth").onclick = function () {
                    var login = document.getElementById("login").value;
                    var pass = document.getElementById("pass").value;

                    if (login === "" || pass === "") {
                        alert("Поля логин/пароль не могут быть пустыми");
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
    <button id="reg" class="float-left submit-button cool_button">Registration</button>
    <script type="text/javascript">
        document.getElementById("reg").onclick = function () {
            location.href = "<%= AbstractAddress.homeUrl%>/reg.html";
        };
    </script>
    <br><br>
    <span style="font-size: 14px; font-family: 'Century Gothic';">
                Your task tracker for scrum development
    </span>
    <br>
    <img src="resources/hive.jpg">
    </div>
<div id="footer">&copy; 2020</div>
</body>
</html>