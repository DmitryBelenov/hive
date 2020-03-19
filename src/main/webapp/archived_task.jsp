<%@ page import="ru.objects.Task" %>
<%@ page import="ru.objects.TaskComment" %>
<%@ page import="ru.utils.Utils" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hive | Task</title>
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
</head>
<script>
    function reopenArchivedTask(num, id) {
        if (window.confirm('Вы уверены, что хотите переоткрыть задачу № ' + num)){
            var json =
                {
                    task_id: id,
                    new_state: 'reopened',
                    task_num: num
                };

            $.ajax({
                url: "reopen",
                type: "POST",
                data: json,
                dataType: "text",
                error: function (msg) {
                    alert("Ошибка сервера:\n" + msg);
                },
                success: function (msg) {
                    alert(msg);
                    window.close();
                }
            });
        }
    }
</script>

<%
    Task task = (Task) request.getAttribute("task");
%>

<body>
<div style="text-align: left;">
    <div id="header" style="text-align: left">
        <h1>
            <span class="header">&nbsp;Hive</span>
            <img style="width:1.2%" src="resources/logo.png">
            <span class="header"><%
                out.println(request.getAttribute("org_name") + " / " + task.getHeadLine().split(":")[0]);
            %></span>
        </h1>
    </div>

    <div id="task_block" style="text-align: left;">
        <input type="hidden" name="org_uuid" value="<%= task.getCreatorOrgId()%>"/>
        <span style="font-size: 30px; color: #043509; font-family: 'Tahoma';"><%= task.getHeadLine()%></span>
        <hr>

        <%
        String [] taskHead = task.getHeadLine().split(":");
        String taskNum = taskHead[0];
        %>

        <div style="text-align: right">
        <input type="submit" class="cool_button" value="Восстановить" onclick="reopenArchivedTask('<%= taskNum%>', '<%= task.getId()%>')">
        <input type="submit" class="cool_button" value="К архиву" onclick="window.history.go(-1); return false;">
        </div>

        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">priority: </span><span
            style="font-size: 14px; font-family: 'Tahoma';"><%= task.getPriority()%></span> <img
            style="width: 2%; height: 1%" src="resources/task/<%= task.getPriority()%>.jpg">
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">state: </span><span
            style="font-size: 14px; font-family: 'Tahoma';"><%= task.getState()%></span>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">last assign: </span><span
            style="font-size: 14px; font-family: 'Tahoma';"><%= task.getAssign().getFirstName() + " " + task.getAssign().getLastName()%></span>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">created by: </span><span
            style="font-size: 14px; font-family: 'Tahoma';"><%= request.getAttribute("creator_name_role")%></span>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">create date: </span><span
            style="font-size: 14px; font-family: 'Tahoma';"><%= task.getCreateDate()%></span>
        <br><span
            style="font-size: 12px; color: #043509; font-family: 'Tahoma';">deadline: </span><span
            style="font-size: 14px; font-family: 'Tahoma'; color: <%= Utils.getDeadLineColor(task)%>"><%= task.getDeadLine()%></span>
        <br><span
            style="font-size: 12px; color: #043509; font-family: 'Tahoma';">project: </span><span
            style="font-size: 14px; font-family: 'Tahoma';"><%= task.getProject()%></span>
        <br><br><br>
        <span style="font-size: 18px; color: #043509; font-family: 'Tahoma';"><%= task.getDescription()%></span>
        <br><br><br>
        <% String attachmentLine = task.getAttachmentLine();
            int imgRow = 1;
            if (!Utils.isNull(attachmentLine)) {
                String[] attachArray = attachmentLine.split(":");
                for (String name : attachArray) {
        %>
        <a href="${pageContext.request.contextPath}/attach/<%= task.getCreatorOrgId()%>/<%= task.getId()%>/<%= name%>">
            <img style="width: 100px"
                 src="${pageContext.request.contextPath}/attach/<%= task.getCreatorOrgId()%>/<%= task.getId()%>/<%= name%>"></a>
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
        Comments
        </span>
        <div class="scroll_block_task_comments">
            <%
                List<TaskComment> comments = task.getTaskComments();
                if (comments.size() > 0) {
                    for (TaskComment comment : comments) {
            %>
            <span style="font-size: 10px; color: #043509; font-family: 'Tahoma';"><%= comment.getPersonName() + " " + comment.getCreateDate()%>:</span><br>
            <span style="font-size: 15px; color: #043509; font-family: 'Tahoma';"><%= comment.getContent()%></span>
            <br><br>
            <%
                }
            } else {
            %>
            <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">
            No comments in this task :(
            </span>
            <%
                }
            %>
        </div>
    </div>

</div>
<div id="footer">&copy; 2020</div>
</body>
</html>