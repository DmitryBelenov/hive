<%@ page import="ru.objects.OrgUser" %>
<%@ page import="ru.objects.Task" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="ru.utils.Utils" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hive | Profile</title>
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
    OrgUser orgUser = (OrgUser) request.getAttribute("user");
    List<Task> taskList = (List<Task>) request.getAttribute("task_list");
    List<Task> userTaskList = (List<Task>) request.getAttribute("user_task_list");
    List<String> userTaskIds = (List<String>) request.getAttribute("user_task_ids");
%>

<body>
<div style="text-align: left;">
    <div id="header" style="text-align: left">
        <h1>
            <span class="header">&nbsp;Hive</span>
            <img style="width:1.2%" src="resources/logo.png">
            <span class="header"><%
                out.println(" / " + org_name + " / " + orgUser.getFirstName() + " " + orgUser.getLastName());
            %></span>
        </h1>
    </div>
    <br>
    <span style="font-size: 12px; font-style: normal; color: #7B5427; font-family: 'Tahoma';">
     <fieldset class="dashboard_block_style_large">
            <legend>My task list</legend>

        <form name="main_actions_form" method="post" action="main_panel_action">
            <input type="hidden" name="action"/>

            <input type="hidden" name="org_uuid" value="<%= orgUser.getOrgId()%>"/>
            <input type="hidden" name="org_name" value="<%= org_name%>"/>
            <input type="hidden" name="user_uuid" value="<%= orgUser.getUserId()%>"/>

         <div style="text-align: center">
             <span style="font-size: 12px; font-family: 'Tahoma';">
              <img style="width:2.5%" src="resources/task.png">
              <input type="button" name="task" value="task" class="cool_button"
                     onclick="{document.main_actions_form.action.value=this.value;
                       document.main_actions_form.submit();}"/>
             </span>
               &nbsp;&nbsp;&nbsp;
             <span style="font-size: 12px; font-family: 'Tahoma';">
              <img style="width:2.5%" src="resources/event.png">
              <input type="button" name="event" value="event" class="cool_button"
                     onclick="{document.main_actions_form.action.value=this.value;
                       document.main_actions_form.submit();}"/>
             </span>
              &nbsp;&nbsp;&nbsp;
             <span style="font-size: 12px; font-family: 'Tahoma';">
              <img style="width:2.5%" src="resources/settings.png">
               <input type="button" name="user_info" value="settings" class="cool_button"
                      onclick="{document.main_actions_form.action.value=this.value;
                       document.main_actions_form.submit();}"/>
             </span>
         </div>
         </form>
         <br>

         <!-- мои задачи -->
          <div class="scroll_block_task_user">
              <%
                  if (userTaskList.size() > 0) {
              %>
         <table>
             <%
                 String deadlineColor;
                 for (Task task : userTaskList) {
                     deadlineColor = Utils.getDeadLineColor(task);
             %>
             <tr>
                <form method="post" action="open_task">
                 <input type="hidden" name="task_id" value="<%= task.getId()%>"/>
                 <input type="hidden" name="org_uuid" value="<%= orgUser.getOrgId()%>"/>
                 <input type="hidden" name="user_uuid" value="<%= orgUser.getUserId()%>"/>

                <td valign="top" align="center" width="30"><img style="height: 100%" src="resources/<%= task.getPriority()%>.jpg"></td>
                <td valign="top" align="center" width="40"><span style="font-size: 12px; color: #043509; font-family: 'Tahoma'; font-weight: bold"><%= task.getState()%></span></td>
                <td><span
                        style="font-size: 14px; color: #043509; font-family: 'Tahoma';"><%= task.getHeadLine()%></span></td>
                 <td><span style="font-size: 12px; color: <%= deadlineColor%>; font-family: 'Tahoma';">
                         dl: <%= new SimpleDateFormat("dd:MM:yyyy").format(task.getDeadLine())%></span></td>
                <td valign="top" align="center" width="50"><button
                        class="float-left submit-button cool_button">open</button></td>
              </form>
             </tr>
             <%
                 }
             %>
             </table>
              <%
              } else {
              %>
              <span style="font-size: 12px; color: #7B5427; font-family: 'Tahoma';">
             &nbsp;&nbsp;&nbsp;No tasks in my list yet :(
              <span>
                      <%
            }%>
          </div>

     </fieldset>
     <br>
     <fieldset class="dashboard_block_style_task">
            <legend>Task Stream</legend>
         <div class="scroll_block_task_general">
            <%
                if (taskList.size() > 0) {
            %>
             <table>
             <%
                 String deadlineColor;
                 for (Task task : taskList) {
                     if (!userTaskIds.contains(task.getId())) {
                         deadlineColor = Utils.getDeadLineColor(task);
             %>
             <tr>
             <form method="post" action="open_task">
             <input type="hidden" name="task_id" value="<%= task.getId()%>"/>
             <input type="hidden" name="org_uuid" value="<%= orgUser.getOrgId()%>"/>
             <input type="hidden" name="user_uuid" value="<%= orgUser.getUserId()%>"/>

             <td valign="top" align="center" width="30"><img style="height: 100%"
                                                             src="resources/<%= task.getPriority()%>.jpg"></td>
             <td valign="top" align="center" width="40"><span style="font-size: 12px; color: #043509; font-family: 'Tahoma'; font-weight: bold"><%= task.getState()%></span></td>
             <td><span
                     style="font-size: 14px; color: #043509; font-family: 'Tahoma';"><%= task.getHeadLine()%></span></td>
                 <td><span style="font-size: 12px; color: #7B5427; font-family: 'Tahoma';">
                         <%= task.getAssign().getFirstName() + " " + task.getAssign().getLastName() + " (" + task.getAssign().getRole().getRoleName() + ")"%></span></td>
                 <td><span style="font-size: 12px; color: <%= deadlineColor%>; font-family: 'Tahoma';">
                         dl: <%= new SimpleDateFormat("dd:MM:yyyy").format(task.getDeadLine())%></span></td>
                 <td valign="top" align="center" width="50"><button
                         class="float-left submit-button cool_button">open</button></td>
              </form>
             </tr>
             <%
                 }
               }
             %>
             </table>
             <%
             } else {
             %>
              <span style="font-size: 12px; color: #7B5427; font-family: 'Tahoma';">
             &nbsp;&nbsp;&nbsp;No tasks in stream yet :(
              <span>
                      <%
            }%>
        </div>
     </fieldset>
     <br>
     <fieldset class="dashboard_block_style_event_short">
            <legend>Events</legend>
         <div class="scroll_block_events_short">
            <!-- events -->
        </div>
    </fieldset>
    </span>

</div>
<div id="footer">&copy; 2020</div>
</body>
</html>