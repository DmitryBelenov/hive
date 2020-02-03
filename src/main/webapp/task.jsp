<%@ page import="ru.objects.Task" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hive | Task</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style type="text/css">
        #task_block {
            width: 800px; background: #ECF5E4;
            margin: 0 auto;
            padding: 30px;
        }
    </style>
</head>
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
                out.println("/ " + request.getAttribute("org_name") + "/ " + task.getHeadLine().split(":")[0]);
            %></span>
        </h1>
    </div>

    <div id="task_block" style="text-align: left;">
        <input type="hidden" name="org_uuid" value="<%= task.getCreatorOrgId()%>"/>
        <span style="font-size: 30px; color: #043509; font-family: 'Tahoma';"><%= task.getHeadLine()%></span>
        <hr>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">created by: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= request.getAttribute("creator_name_role")%></span>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">create date: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= task.getCreateDate()%></span>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">
                assigned on: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= task.getAssign().getFirstName()
                + " " + task.getAssign().getLastName()
                + " (" + task.getAssign().getRole().getRoleName() + ")"%></span>
        <br><span
            style="font-size: 12px; color: #043509; font-family: 'Tahoma';">deadline: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= task.getDeadLine()%></span>
        <br><span
            style="font-size: 12px; color: #043509; font-family: 'Tahoma';">priority: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= task.getPriority()%></span>
        <img style="width: 2%; height: 1%" src="resources/<%= task.getPriority()%>.jpg">
        <br><span
            style="font-size: 12px; color: #043509; font-family: 'Tahoma';">project: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= task.getProject()%></span>
        <br><br><br>
        <span style="font-size: 18px; color: #043509; font-family: 'Tahoma';"><%= task.getDescription()%></span>
        <br><br><br>
        <% String attachmentLine = task.getAttachmentLine();

            int imgRow = 1;
            if (attachmentLine != null && !attachmentLine.equals("null")) {
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
        <br><br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">
        Comments
        </span>
        <div class="scroll_block_task_comments">

        </div>

    </div>

</div>
<div id="footer">&copy; 2020</div>
</body>
</html>