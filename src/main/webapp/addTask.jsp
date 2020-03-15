<%@ page import="java.util.Map" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<head>
    <title>Hive | New Task</title>
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
            <span class="header"> / new task</span>
        </h1>
    </div>
    <br>
    <form id="user_data" method="post" action="new_task" enctype="multipart/form-data">
        <input type="text" name="org_uuid" id="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>

        <input type="text" name="user_uuid" id="user_uuid" value="<%= request.getAttribute("user_uuid")%>" hidden>

        <span style="font-size: 12px; color: #7B5427; font-family: 'Tahoma';">
        <fieldset style="width:300px; margin: 0 auto; border: 1px solid">
            <legend>Task</legend>
        headline:<br><input type="text" pattern="^[a-zA-Zа-яА-Я0-9,-. ]+$" name="headline" id="headline" maxlength="255" style="text-align: center" size="66">
        <br><br>
        description:<br><textarea rows="15" cols="67" pattern="^[a-zA-Zа-яА-Я0-9,-.: ]+$" name="description" id="description" maxlength="3000" style="resize: none"></textarea>
        <br>
        project:&nbsp;<input type="text" pattern="^[a-zA-Zа-яА-Я0-9,-.: ]+$" name="project" id="project" maxlength="255" style="text-align: left" size="30">&nbsp;
        priority:&nbsp;<select size="1" name="priority" form="user_data" id="priority">
                        <option>low</option>
                        <option>medium</option>
                        <option>high</option>
	                </select>
            <br><br>
        deadline:&nbsp;<input type="date" name="deadline" id="deadline" max="2030-01-01">&nbsp;
        assign to:&nbsp;<select size="1" name="assign" form="user_data" id="assign">
            <%Map<String, String> orgUsers = (Map<String, String>)request.getAttribute("org_users");
                        if (orgUsers.size() > 0) {
                            for (String userId : orgUsers.keySet()){
                                %>
                                   <option value="<%= userId%>"><%= orgUsers.get(userId)%></option>
                                <%
                            }
                        }%>
	                </select>
        <br><br>
        attachment:&nbsp;<input type="file" name="attachment" id="attachment" accept="image/*" multiple onchange="checkFilesNum(this.files)">
        <button id="process" class="float-left submit-button cool_button">Create</button>
        <script type="text/javascript">
            document.getElementById("process").onclick = function () {
                var headline = document.getElementById("headline").value;
                var description = document.getElementById("description").value;
                var project = document.getElementById("project").value;
                var deadline = document.getElementById("deadline").value;
                var assign = document.getElementById("assign").value;
                var priority = document.getElementById("priority").value;

                if (headline === "" || description === "" || project === "" || deadline === "" || assign === "" || priority === "") {
                    alert("Поля формы создания задания не могут быть пустыми");
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

        <button class="float-left submit-button cool_button">Main</button>
    </form>
    <div id="footer">&copy; 2020</div>
</div>
</body>
</html>