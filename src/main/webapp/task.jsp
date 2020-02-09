<%@ page import="ru.objects.Task" %>
<%@ page import="ru.objects.TaskComment" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="ru.utils.Utils" %>
<%@ page import="ru.objects.roles.TaskStatesEnum" %>
<%@ page import="java.util.Map" %>
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
<script>
    function checkFilesNum(files) {
        if(files.length>5) {
            alert("Добавить можно не более 5 изображений!");
            document.getElementById("attachment").value = "";

            return false;
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
                out.println("/ " + request.getAttribute("org_name") + "/ " + task.getHeadLine().split(":")[0]);
            %></span>
        </h1>
    </div>

    <div id="task_block" style="text-align: left;">
        <input type="hidden" name="org_uuid" value="<%= task.getCreatorOrgId()%>"/>
        <span style="font-size: 30px; color: #043509; font-family: 'Tahoma';"><%= task.getHeadLine()%></span>
        <hr>

        <div style="text-align: right">
        <form method="post" action="main">
            <input type="text" name="type" value="<%= request.getAttribute("type")%>" hidden>
            <input type="text" name="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>
            <input type="text" name="org_name" value="<%= request.getAttribute("org_name")%>" hidden>
            <input type="text" name="user_uuid" value="<%= request.getAttribute("user_uuid")%>" hidden>

            <button class="float-left submit-button cool_button" onclick="this.disabled = true; this.form.submit();">Main</button> <!-- как то проверить disabled=true по нажатию -->
        </form>
        </div>

        <span
            style="font-size: 12px; color: #043509; font-family: 'Tahoma';">priority: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= task.getPriority()%></span>
        <img style="width: 2%; height: 1%" src="resources/<%= task.getPriority()%>.jpg">&nbsp;&nbsp;<span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">state: </span>
        <span style="font-size: 15px; color: #043509; font-family: 'Tahoma'; font-weight: bold"><%= task.getState()%></span>

        <form id="task_states" method="post" action="set_state">
            <input type="text" name="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>
            <input type="text" name="user_uuid" value="<%= request.getAttribute("user_uuid")%>" hidden>
            <input type="text" name="task_id" value="<%= task.getId()%>" hidden>

                <select size="1" name="state" form="task_states" id="state">
                    <%for (TaskStatesEnum state : TaskStatesEnum.values()){
                        if (!state.getState().equals(task.getState())) {
                    %>
                    <option><%= state.getState()%></option>
                    <%
                            }
                        }%>
                </select>
                <button class="float-left submit-button cool_button">set state</button>
         </form>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">
                assigned on: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= task.getAssign().getFirstName()
            + " " + task.getAssign().getLastName()
            + " (" + task.getAssign().getRole().getRoleName() + ")"%></span>
        <form id="assigns" method="post" action="set_assign">
            <input type="text" name="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>
            <input type="text" name="user_uuid" value="<%= request.getAttribute("user_uuid")%>" hidden>
            <input type="text" name="task_id" value="<%= task.getId()%>" hidden>

            <select size="1" name="new_assign" form="assigns" id="new_assign">
                <%
                    Map<String, String> orgUsers = (Map<String, String>)request.getAttribute("org_users");
                    if (orgUsers.size() > 0) {
                        for (String userId : orgUsers.keySet()){
                            if (!task.getAssign().getUserId().equals(userId)) {
                %>
                <option value="<%= userId%>"><%= orgUsers.get(userId)%></option>
                <%
                            }
                        }
                    }%>
            </select>
            <button class="float-left submit-button cool_button">assign</button>
        </form>

        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">created by: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= request.getAttribute("creator_name_role")%></span>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">create date: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= task.getCreateDate()%></span>
        <br><span
            style="font-size: 12px; color: #043509; font-family: 'Tahoma';">deadline: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= task.getDeadLine()%></span>
        <br><span
            style="font-size: 12px; color: #043509; font-family: 'Tahoma';">project: </span><span style="font-size: 14px; font-family: 'Tahoma';"><%= task.getProject()%></span>
        <br><br><br>
        <span style="font-size: 18px; color: #043509; font-family: 'Tahoma';"><%= task.getDescription()%></span>
        <br><br><br>
        <% String attachmentLine = task.getAttachmentLine();
            int numOfAttachments = 0;

            int imgRow = 1;
            if (!Utils.isNull(attachmentLine)) {
                String[] attachArray = attachmentLine.split(":");
                numOfAttachments = attachArray.length;
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

        <%
        boolean isAttachesMaxNum = numOfAttachments >= 25; // проверка на max кол-во файлов
        %>
        <form method="post" action="add_attachment" enctype="multipart/form-data">
            <input type="text" name="task_id" value="<%= task.getId()%>" hidden>
            <input type="text" name="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>
            <input type="text" name="user_uuid" value="<%= request.getAttribute("user_uuid")%>" hidden>
            <div style="text-align: right">
                <input type="file" name="attachment" id="attachment" accept="image/*" multiple onchange="checkFilesNum(this.files)">
                <button id="add_attach" class="float-left submit-button cool_button">attach</button>   <!-- disabled= проверка на max кол-во файлов -->
                <script>
                    document.getElementById("add_attach").onclick = function()
                    {
                        var attaches = document.getElementById("attachment").files.length;
                        if (attaches === 0)
                        {
                            alert("Необходимо выбрать вложение");
                            return false;
                        } else {
                            return true;
                        }
                    }
                </script>
            </div>
        </form>
        <br>
        <span style="font-size: 12px; color: #043509; font-family: 'Tahoma';">
        Comments
        </span>
        <div class="scroll_block_task_comments">

            <form method="post" action="add_comment">
            <input type="text" name="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>
            <input type="text" name="user_uuid" value="<%= request.getAttribute("user_uuid")%>" hidden>
            <input type="text" name="task_id" value="<%= task.getId()%>" hidden>

            <textarea rows="2" cols="106" name="content" id="comment" maxlength="1000" style="resize: none"></textarea>
            <div style="text-align: right">
            <button class="float-left submit-button cool_button" id="add_comment">comment</button>
                <script>
                    document.getElementById("add_comment").onclick = function()
                    {
                        var comment = document.getElementById("comment").value;
                        if (comment.trim() === "")
                        {
                            alert("Комментарий не может быть пустым");
                            return false;
                        } else {
                            return true;
                        }
                    }
                </script>
            </div>
            <hr>
            </form>
            <%
            List<TaskComment> comments = task.getTaskComments();
            if (comments.size() > 0 ) {
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
            No comments yet :(
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