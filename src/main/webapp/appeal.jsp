<%@ page import="ru.objects.appeals.Appeal" %>
<%@ page import="ru.objects.appeals.AppealsStatesEnum" %>
<%@ page import="ru.utils.Utils" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hive | Appeal</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="jquery/jquery-3.4.1.js" type="text/javascript"></script>
    <style type="text/css">
        #task_block {
            width: 800px;
            background: #ECF5E4;
            margin: 0 auto;
            padding: 30px;
        }
    </style>
    <style type="text/css">
        textarea { border: none; }
    </style>
    <script>
        function commentEditable() {
            var checkBox = document.getElementById("edit_comment");
            var comment = document.getElementById("appeal_comment");
            var button = document.getElementById("save_button");

            if (checkBox.checked === true) {
                comment.style.backgroundColor = "#FFFFFF";
                comment.readOnly = false;
                button.disabled = false;
            } else {
                comment.style.backgroundColor = "#ECF5E4";
                comment.readOnly = true;
            }
        }
    </script>
    <script>
        function onValueChange() {
            document.getElementById("save_button").disabled = false;
        }
    </script>
    <script>
        function saveAppealChanges(state, priority, comment, appeal_id) {
            var new_state = document.getElementById("appeal_state").value;
            var new_priority = document.getElementById("priority_level").value;
            var new_comment = document.getElementById("appeal_comment").value;

            if (new_state === state && new_priority === priority && new_comment === comment){
                alert('Внесите изменения..');
            } else {
                var json =
                    {
                        appeal_id: appeal_id,
                        new_state: new_state,
                        new_priority: new_priority,
                        new_comment: new_comment
                    };

                $.ajax({
                    url: "appealChange",
                    type: "POST",
                    data: json,
                    dataType: "text",
                    error: function (msg) {
                        alert("Ошибка сервера:\n" + msg);
                    },
                    success: function (msg) {
                        location.reload();
                        alert(msg);
                    }
                });
            }
        }
    </script>
</head>

<%
    Appeal appeal = (Appeal) request.getAttribute("appeal");
%>

<body>
<div style="text-align: left;">
    <div id="header" style="text-align: left">
        <h1>
            <span class="header">&nbsp;Hive</span>
            <img style="width:1.2%" src="resources/logo.png">
            <span class="header"><%
                out.println(request.getAttribute("org_name") + " / appeals / " + appeal.getAppealNumber());
            %></span>
        </h1>
    </div>

    <div id="task_block" style="text-align: left;">
        <%
            Date date = appeal.getAppealRegDate();
            String appeal_create_date = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(date);

            String performer = appeal.getPerformer().getLastName() + " " + appeal.getPerformer().getFirstName() + " (" + appeal.getPerformer().getUserEmail() + ")";

            String head_line = appeal.getAppealNumber() + "  *  (" + appeal_create_date + ")  *  " + appeal.getPriorityLevel() + "  *  " + appeal.getAppealState() + "  *  " + performer;
        %>
        <span style="font-size: 18px; color: #043509; font-family: 'Tahoma';"><%= head_line%></span>
        <hr>

        <div style="text-align: right">
            <form method="post" action="main_panel_action">
                <input type="text" name="action" value="appeals" hidden>
                <input type="text" name="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>
                <input type="text" name="org_name" value="<%= request.getAttribute("org_name")%>" hidden>
                <input type="text" name="user_uuid" value="<%= request.getAttribute("user_uuid")%>" hidden>

                <button class="float-left submit-button cool_button"
                        onclick="this.disabled = true; this.form.submit();">К журналу
                </button> <!-- как то проверить disabled=true по нажатию -->
            </form>
        </div>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">Статус заявки: </span>
        <select size="1" name="appeal_state" id="appeal_state" style="border-radius: 3px" onchange="onValueChange()">
            <%
                for (AppealsStatesEnum state : AppealsStatesEnum.values()) {
                    if (state.getState().equals(appeal.getAppealState())) {
            %>
            <option selected><%= state.getState()%>
            </option>
            <%
            } else {
            %>
            <option><%= state.getState()%>
            </option>
            <%
                    }
                }%>
        </select>
        &nbsp;&nbsp;
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">Уровень приоритета: </span>
        <select size="1" name="priority_level" id="priority_level" style="border-radius: 3px" onchange="onValueChange()">
            <%
                List<String> priorityLevel = Arrays.asList("П1","П2","П3");
                for (String level : priorityLevel){
                    if (level.equals(appeal.getPriorityLevel())) {
            %>
            <option selected><%= level%>
            </option>
            <%
                    } else {
            %>
            <option><%= level%></option>
            <%
                }
                }
            %>
        </select>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">Почта клиента: </span><span
            style="font-size: 14px; font-family: 'Tahoma';"><%= appeal.getSenderMail()%></span>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">Организация клиента: </span><span
            style="font-size: 14px; font-family: 'Tahoma';"><%= appeal.getSenderOrgName()%></span>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">Клиент: </span><span
            style="font-size: 14px; font-family: 'Tahoma';"><%= appeal.getSenderName()%></span>
        <br><br><br>
        <span style="font-size: 18px; color: #043509; font-family: 'Tahoma';"><%= appeal.getAppealContent()%></span>
        <br><br><br>
        <% String attachmentLine = appeal.getAttachmentLine();
            int imgRow = 1;
            if (!Utils.isNull(attachmentLine)) {
                String[] attachArray = attachmentLine.split(":");
                for (String name : attachArray) {
        %>
        <a href="${pageContext.request.contextPath}/appeal_attach/<%= appeal.getOrgId()%>/<%= appeal.getAppealId()%>/<%= name%>">
            <img style="width: 100px"
                 src="${pageContext.request.contextPath}/appeal_attach/<%= appeal.getOrgId()%>/<%= appeal.getAppealId()%>/<%= name%>"></a>
        <%
            if (imgRow % 5 == 0) {%>
        <br>
        <%
                    }
                    imgRow++;
                }
            }
            ;
        %>
        <br><br><br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">
        Комментарий:
        </span>
        <br>
        <textarea readonly rows="5" cols="110" name="appeal_comment" id="appeal_comment" maxlength="3000"
                  style="resize: none; border-radius: 3px; background-color: #ECF5E4"><%= appeal.getCreatorsComment()%></textarea>
        <div style="text-align: left">
            <input type="checkbox" id="edit_comment" onclick="commentEditable()"><span
                style="font-size: 12px; color: #043509; font-family: 'Tahoma';">редактировать</span><Br>
        </div>
        <br><br>
        <div style="text-align: right">
            <button id="save_button" class="float-left submit-button cool_button" disabled onclick="saveAppealChanges('<%= appeal.getAppealState()%>', '<%= appeal.getPriorityLevel()%>', '<%= appeal.getCreatorsComment()%>', '<%= appeal.getAppealId()%>')">Сохранить</button>
        </div>
    </div>

</div>
<div id="footer">&copy; 2020</div>
</body>
</html>