<%@ page import="ru.objects.Task" %>
<%@ page import="ru.utils.Utils" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hive | Archive</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style type="text/css">
        TABLE {
            width: 100%;
            border-collapse: collapse; /* Убираем двойные линии между ячейками */
        }

        TD, TH {
            padding: 5px; /* Поля вокруг содержимого таблицы */
            border: 1px solid #DFDFDF; /* Параметры рамки */
        }
    </style>
</head>
<%
    String org_name = (String) request.getAttribute("org_name");
//    OrgUser orgUser = (OrgUser) request.getAttribute("user");
    List<Task> taskList = (List<Task>) request.getAttribute("task_list");
//    List<Task> userTaskList = (List<Task>) request.getAttribute("user_task_list");
//    List<String> userTaskIds = (List<String>) request.getAttribute("user_task_ids");
%>

<body>
<div style="text-align: left;">
    <div id="header" style="text-align: left">
        <h1>
            <span class="header">&nbsp;Hive</span>
            <img style="width:1.2%" src="resources/logo.png">
            <span class="header"><%
                out.println(org_name + " / archive");
            %></span>
        </h1>
    </div>
    <br>
    <span style="font-size: 12px; font-family: 'Century Gothic';">
     <fieldset class="archive_dashboard_block_style_task" style=" border-radius: 3px">
            <legend>Archive</legend>
         <div class="archive_scroll_block_task">
            <%
                if (taskList.size() > 0) {
            %>
             <table>
               <tbody>
             <%
                 String deadlineColor;
                 for (Task task : taskList) {
                     deadlineColor = Utils.getDeadLineColor(task);
             %>
             <tr>
             <form method="post" action="open_archived_task">
             <input type="hidden" name="task_id" value="<%= task.getId()%>"/>
             <%--<input type="hidden" name="org_uuid" value="<%= orgUser.getOrgId()%>"/>--%>
             <%--<input type="hidden" name="user_uuid" value="<%= orgUser.getUserId()%>"/>--%>

             <td align="center" width="30" style="color: #ecf5e4"><img style="height: 100%"
                                                                       src="resources/<%= task.getPriority()%>.jpg"></td>
             <td align="center" width="40"><span
                     style="font-size: 12px; color: #043509; font-family: 'Tahoma'; font-weight: bold"><%= task.getState()%></span></td>
             <td><span
                     style="font-size: 14px; color: #043509; font-family: 'Tahoma';"><%= task.getHeadLine()%></span></td>
                 <td><span style="font-size: 12px; color: #7B5427; font-family: 'Tahoma';">
                         <%= task.getAssign().getFirstName() + " " + task.getAssign().getLastName() + " (" + task.getAssign().getRole().getRoleName() + ")"%></span></td>
                 <td><span style="font-size: 12px; color: <%= deadlineColor%>; font-family: 'Tahoma';">
                         <%= new SimpleDateFormat("dd:MM:yyyy").format(task.getDeadLine())%></span></td>
                 <td align="center" width="50"><button
                         class="float-left submit-button cool_button">open</button></td>
              </form>
             </tr>
             <%

                 }
             %>
              </tbody>
             </table>
             <%
             } else {
             %>
              <span style="font-size: 12px; color: #7B5427; font-family: 'Tahoma';">
             &nbsp;&nbsp;&nbsp;No tasks in archive yet :(
              <span>
                      <%
            }%>
        </div>
     </fieldset>
    </span>

</div>
<div id="footer">&copy; 2020</div>
</body>
</html>