<%@ page import="ru.objects.Task" %>
<%@ page import="ru.objects.TaskComment" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="ru.utils.Utils" %>
<%@ page import="ru.objects.roles.TaskStatesEnum" %>
<%@ page import="java.util.Map" %>
<%@ page import="ru.objects.appeals.Appeal" %>
<%@ page import="java.util.Date" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hive | Appeal</title>
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

            String head_line = appeal.getAppealNumber() + "  *  (" + appeal_create_date + ")  *  " + appeal.getPriorityLevel() + "  *  "+ appeal.getAppealState() + "  *  " + performer;
        %>
        <span style="font-size: 18px; color: #043509; font-family: 'Tahoma';"><%= head_line%></span>
        <hr>

        <div style="text-align: right">
            <form method="post" action="main_panel_action">
                <input type="text" name="action" value="appeals" hidden>
                <input type="text" name="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>
                <input type="text" name="org_name" value="<%= request.getAttribute("org_name")%>" hidden>
                <input type="text" name="user_uuid" value="<%= request.getAttribute("user_uuid")%>" hidden>

                <button class="float-left submit-button cool_button" onclick="this.disabled = true; this.form.submit();">К журналу</button> <!-- как то проверить disabled=true по нажатию -->
            </form>
        </div>

        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">Почта клиента: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= appeal.getSenderMail()%></span>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">Организация клиента: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= appeal.getSenderOrgName()%></span>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">Клиент: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= appeal.getSenderName()%></span>
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
        Комментарий создателя заявки:
        </span>
        <br>
        <span style="font-size: 15px; color: #043509; font-family: 'Tahoma';"><%= appeal.getCreatorsComment()%></span>
    </div>

</div>
<div id="footer">&copy; 2020</div>
</body>
</html>