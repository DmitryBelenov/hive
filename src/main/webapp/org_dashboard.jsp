<%@ page import="ru.AbstractAddress" %>
<%@ page import="ru.objects.Task" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="ru.utils.Utils" %>
<%@ page import="ru.objects.roles.TaskStatesEnum" %>
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
    String org_uuid = (String) request.getAttribute("org_uuid");
    String org_name = (String) request.getAttribute("org_name");
    List<Task> taskList = (List<Task>) request.getAttribute("task_list");
    // id пользователя здесь нет и быть не должно, это страница менджмента корневой организации
%>
<script type="text/javascript">
    function set() {
        document.getElementById("uuid").value = <%= org_uuid%>;
    }
</script>

<body onload="set()">
<div style="text-align: left;">
    <div id="header" style="text-align: left">
        <h1>
            <span class="header">&nbsp;Hive</span>
            <img style="width:1.2%" src="resources/logo.png">
            <span class="header"><%
                out.println(org_name);
            %></span>
        </h1>
    </div>
    <br>
    <input type="text" name="uuid" id="uuid" hidden>

    <span style="font-size: 12px; font-style: normal; color: #7B5427; font-family: 'Tahoma';">
     <fieldset class="dashboard_block_style_small" style=" border-radius: 3px">
            <legend>Administration</legend>

        <form name="main_actions_form" method="post" action="main_panel_action">
            <input type="hidden" name="action"/>
            <input type="hidden" name="org_uuid" value="<%= org_uuid%>"/>
            <input type="hidden" name="org_name" value="<%= org_name%>"/>
         <div style="text-align: center">
             <span style="font-size: 12px; font-family: 'Tahoma';">
              <img style="width:4%" src="resources/team.png">
                <input type="button" name="user" value="new_user" class="cool_button"
                       onclick="{document.main_actions_form.action.value=this.value;
                       document.main_actions_form.submit();}" />
             </span>
               &nbsp;&nbsp;&nbsp;
             <span style="font-size: 12px; font-family: 'Tahoma';">
              <img style="width:2.5%" src="resources/task.png">
              <input type="button" name="task" value="new_task" class="cool_button"
                     onclick="{document.main_actions_form.action.value=this.value;
                       document.main_actions_form.submit();}" />
             </span>
               &nbsp;&nbsp;&nbsp;
             <%--<span style="font-size: 12px; font-family: 'Tahoma';">--%>
              <%--<img style="width:2.5%" src="resources/event.png">--%>
              <%--<input type="button" name="event" value="new_event" class="cool_button"--%>
                     <%--onclick="{document.main_actions_form.action.value=this.value;--%>
                       <%--document.main_actions_form.submit();}" />--%>
             <%--</span>--%>
             <%--&nbsp;&nbsp;&nbsp;--%>
             <span style="font-size: 12px; font-family: 'Tahoma';">
              <img style="width:2.8%" src="resources/appeals.png">
               <input type="button" name="appeals" value="appeals" class="cool_button"
                      onclick="{document.main_actions_form.action.value=this.value;
                       document.main_actions_form.target='_blank';
                       document.main_actions_form.submit();
                       document.main_actions_form.target='';}"/>
             </span>
             &nbsp;&nbsp;&nbsp;
             <span style="font-size: 12px; font-family: 'Tahoma';">
              <img style="width:2.5%" src="resources/archive.png">
              <input type="button" name="archive" value="archive" class="cool_button"
                     onclick="{document.main_actions_form.action.value=this.value;
                       document.main_actions_form.target='_blank';
                       document.main_actions_form.submit();
                       document.main_actions_form.target='';}"/>
             </span>
                &nbsp;&nbsp;&nbsp;
             <span style="font-size: 12px; font-family: 'Tahoma';">
              <img style="width:2.5%" src="resources/settings.png">
               <input type="button" name="info" value="company_settings" class="cool_button"
                      onclick="{document.main_actions_form.action.value=this.value;
                       document.main_actions_form.submit();}" />
             </span>
         </div>
         </form>

     </fieldset>
     <br>
     <fieldset class="org_dashboard_block_style_task" style=" border-radius: 3px">
            <legend>Task Stream</legend>
         <div class="org_scroll_block_task">
            <%if (taskList.size() > 0) {
                %>
             <table>
             <%
                 String deadlineColor;
               for (Task task : taskList) {
                   if (!task.getState().equals(TaskStatesEnum.archived.getState())){
                   deadlineColor = Utils.getDeadLineColor(task);
                   %>
             <tr>
             <form method="post" action="open_task">
             <input type="hidden" name="task_id" value="<%= task.getId()%>"/>
             <input type="hidden" name="org_uuid" value="<%= org_uuid%>"/>

             <td align="center" width="30"><img style="height: 100%" src="resources/<%= task.getPriority()%>.jpg"></td>
             <td align="center" width="40"><span style="font-size: 12px; color: #043509; font-family: 'Tahoma'; font-weight: bold"><%= task.getState()%></span></td>
             <td><span style="font-size: 14px; color: #043509; font-family: 'Tahoma';"><%= task.getHeadLine()%></span></td>
                 <td><span style="font-size: 12px; color: #7B5427; font-family: 'Tahoma';">
                         <%= task.getAssign().getFirstName() + " " + task.getAssign().getLastName() + " ("+ task.getAssign().getRole().getRoleName()+")"%></span></td>
                 <td><span style="font-size: 12px; color: <%= deadlineColor%>; font-family: 'Tahoma';">
                         dl: <%= new SimpleDateFormat("dd:MM:yyyy").format(task.getDeadLine())%></span></td>
                 <td align="center" width="50"><button class="float-left submit-button cool_button">open</button></td>
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

        <%-- пока ленты событий не будет --%>
     <%--<br>--%>
     <%--<fieldset class="dashboard_block_style_event" style=" border-radius: 3px">--%>
            <%--<legend>Events</legend>--%>
         <%--<div class="scroll_block_events">--%>
            <%--<!-- events -->--%>
        <%--</div>--%>
    <%--</fieldset>--%>
    </span>
</div>
<div id="footer">&copy; 2020</div>
</body>
</html>