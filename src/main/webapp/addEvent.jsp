<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<head>
    <title>Hive | New Event</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<script>
    function checkFilesNum(files) {
        if(files.length>20) {
            alert("Не более 20 изображений!");
            document.getElementById("attachment").value = "";

            return false;
        }
    }
</script>

<body>
<div style="text-align: center;">
    <div id="header" style="text-align: left">
        <h1>
            <span class="header">&nbsp;Hive</span>
            <img style="width:1.2%" src="resources/logo.png">
            <span class="header"><%= request.getAttribute("org_name")%></span>
            <span class="header"> / new event</span>
        </h1>
    </div>
    <br>
    <form id="user_data" method="post" action="new_task" enctype="multipart/form-data">
        <input type="text" name="uuid" id="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>

        <span style="font-size: 12px; color: #7B5427; font-family: 'Tahoma';">
        <fieldset style="width:300px; margin: 0 auto; border: 1px solid">
            <legend>Event</legend>
        headline:<br><input type="text" name="headline" id="headline" maxlength="255" style="text-align: center" size="66">
        <br><br>
        description:<br><textarea rows="15" cols="67" name="description" id="description" maxlength="3000" style="resize: none"></textarea>
        <br><br>
        attachment:&nbsp;<input type="file" name="attachment" id="attachment" accept="image/*" multiple onchange="checkFilesNum(this.files)">
        <br><br><br>
        <button id="process" class="float-left submit-button cool_button">Create</button>
        <script type="text/javascript">
            document.getElementById("process").onclick = function () {
                var headline = document.getElementById("headline").value;
                var description = document.getElementById("description").value;

                if (headline === "" || description === "") {
                    alert("Поля формы создания события не могут быть пустыми");
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
        <input type="text" name="user_uuid" value="<%= request.getAttribute("user_uuid")%>" hidden>

        <button class="float-left submit-button cool_button">Main</button>
    </form>
    <div id="footer">&copy; 2020</div>
</div>
</body>
</html>