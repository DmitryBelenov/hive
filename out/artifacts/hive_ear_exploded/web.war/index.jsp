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
     <span style="font-size: 28px; color: #7B5427; font-family: 'Tahoma';">
                Hive
     </span>
    </h1>
    <br>
    <span style="font-size: 12px; color: #7B5427; font-family: 'Tahoma';">
                task tracker for scrum development
    </span>
  </div>
  <br>
  <form method="post" action="auth">
            <span style="font-size: 12px; color: #7B5427; font-family: 'Tahoma';">
            <fieldset style="width:300px; margin: 0 auto; border: 1px solid">
                <legend>Authorization</legend>
            login:<br>
            <input type="text" name="login" id="login" style="text-align: center">
            <br>
            password:<br>
            <input type="password" name="pass" id="pass" style="text-align: center">
            <br><br>
            <button id="auth" class="float-left submit-button">Войти</button>
            <script type="text/javascript">
                document.getElementById("auth").onclick = function()
                {
                  var login = document.getElementById("login").value;
                  var pass = document.getElementById("pass").value;

                  if (login === "" || pass === "")
                  {
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
  <button id="reg" class="float-left submit-button">Регистрация</button>
  <script type="text/javascript">
    document.getElementById("reg").onclick = function () {
      location.href = "<%= AbstractAddress.homeUrl%>/reg.html";
    };
  </script>
</div>
<div id="footer"></div>
</body>
</html>