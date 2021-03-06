<%@ page import="java.util.*" %>
<%@ page import="ru.objects.appeals.Appeal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hive | Appeals</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style type="text/css">
        #appeals_block {
            width: 800px;
            background: #ECF5E4;
            margin: 0 auto;
            padding: 30px;
        }
    </style>
    <style type="text/css">
        TABLE {
            width: 100%;
            border-collapse: collapse; /* Убираем двойные линии между ячейками */
        }

        TD, TH {
            padding: 5px; /* Поля вокруг содержимого таблицы */
            border: 1px solid rgba(96, 105, 88, 0.62); /* Параметры рамки */
        }
    </style>
</head>
<script>
    function checkFilesNum(files) {
        if(files.length>5) {
            alert("Не более 5 вложений!");
            document.getElementById("appeal_attachment").value = "";

            return false;
        }
    }
</script>

<%
    List<Appeal> appeals = (List<Appeal>) request.getAttribute("appeals");
%>

<body>
<div style="text-align: left;">
    <div id="header" style="text-align: left">
        <h1>
            <span class="header">&nbsp;Hive</span>
            <img style="width:1.2%" src="resources/logo.png">
            <span class="header"><%
                out.println(request.getAttribute("org_name") + " / appeals");
            %></span>
        </h1>
    </div>

    <div id="appeals_block" style="text-align: left; font-size: 12px; color: #043509; font-family: 'Tahoma';">
        <span style="font-size: 20px; color: #043509; font-family: 'Tahoma';">Заявки технической поддержки</span>
        <hr>

        <!-- appeals table -->
        <fieldset class="appeals_list_block_style" style=" border-radius: 3px;  background: #FFFFFF;">
            <legend>Журнал заявок</legend>
            <div class="scroll_block_appeals">
                <%
                    if (appeals.size() > 0) {
                %>
                <table>
                    <tbody>
                    <%
                        for (Appeal appeal : appeals) {
                            Date date = appeal.getAppealRegDate();
                            String appeal_create_date = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy").format(date);

                            String appealContent = appeal.getAppealContent();

                            if (appealContent.length() > 31) {
                                appealContent = appealContent.substring(0, 30);
                            }

                            String performer = appeal.getPerformer().getLastName() + " " + appeal.getPerformer().getFirstName() + " (" + appeal.getPerformer().getUserEmail() + ")";
                    %>
                    <tr>
                        <form method="post" action="open_appeal">
                            <input type="hidden" name="appeal_id" value="<%= appeal.getAppealId()%>"/>
                            <input type="text" name="org_name" value="<%= request.getAttribute("org_name")%>" hidden>
                            <input type="text" name="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>
                            <input type="text" name="user_uuid" value="<%= request.getAttribute("user_uuid")%>" hidden>

                            <td align="center" width="10"><span style="font-size: 11px; color: #043509; font-family: 'Century Gothic'; font-weight: bold"><%= appeal.getAppealNumber()%></span></td>
                            <td align="center" width="5"><span style="font-size: 11px; color: #043509; font-family: 'Century Gothic'; font-weight: bold"><%= appeal.getPriorityLevel()%></span></td>
                            <td align="center" width="10"><span style="font-size: 11px; color: #043509; font-family: 'Century Gothic'; font-weight: bold"><%= appeal_create_date%></span></td>
                            <td align="center"><span style="font-size: 11px; color: #043509; font-family: 'Century Gothic'; font-weight: bold"><%= appealContent%></span></td>

                            <td align="center"><span style="font-size: 11px; color: #043509; font-family: 'Century Gothic'; font-weight: bold"><%= appeal.getSenderOrgName()%> / <%= appeal.getSenderName()%> / <%= appeal.getSenderMail()%></span></td>
                            <td align="center" width="10"><span style="font-size: 11px; color: #043509; font-family: 'Century Gothic'; font-weight: bold"><%= appeal.getAppealState()%></span></td>
                            <td align="center" width="40"><span style="font-size: 11px; color: #043509; font-family: 'Century Gothic'; font-weight: bold"><%= performer%></span></td>

                            <td align="center" width="20"><button class="float-left submit-button cool_button">open</button></td>
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
             &nbsp;&nbsp;&nbsp;У организации пока нет заявок :(
              <span>
                      <%
            }%>
            </div>
        </fieldset>
        <br>
        <form id="new_appeal" method="post" action="new_appeal" enctype="multipart/form-data">
            <input type="text" name="org_uuid" value="<%= request.getAttribute("org_uuid")%>" hidden>
            <input type="text" name="org_name" value="<%= request.getAttribute("org_name")%>" hidden>
            <input type="text" name="user_uuid" value="<%= request.getAttribute("user_uuid")%>" hidden>

            Содержание:<br><textarea rows="6" cols="110" name="appeal_content" id="appeal_content" maxlength="5000" style="resize: none; border-radius: 3px"></textarea>
            <br>
            Комментарий:<br><textarea rows="2" cols="110" name="appeal_comment" id="appeal_comment" maxlength="1000" style="resize: none; border-radius: 3px"></textarea>
            <br>
            Название организации:<br><input type="text" pattern="^[a-zA-Zа-яА-Я0-9,-. ]+$" name="customer_org_name" id="customer_org_name" maxlength="255" style="text-align: center; border-radius: 3px" size="33">
            <br>
            Имя заказчика:<br><input type="text" pattern="^[a-zA-Zа-яА-Я ]+$" name="customer_name" id="customer_name" maxlength="255" style="text-align: center; border-radius: 3px" size="33">
            <br>
            Почта заказчика:<br><input type="text" pattern="^[a-zA-Z0-9,-_.@]+$" name="customer_mail" id="customer_mail" maxlength="255" style="text-align: center; border-radius: 3px" size="33">
            <br><br>
            Исполнитель:<br><select size="1" name="executor" form="new_appeal" id="executor" style="border-radius: 3px">
            <%
                Map<String, String> orgUsers = (Map<String, String>)request.getAttribute("org_users");
                if (orgUsers.size() > 0) {
            %>
            <option selected value="def">выбрать..</option>
            <%
                    for (String userId : orgUsers.keySet()){
            %>
            <option value="<%= userId%>"><%= orgUsers.get(userId)%></option>
            <%
                    }
                }%>
            </select>&nbsp;&nbsp;
            Уровень приоритета:&nbsp;<select size="1" name="priority_level" form="new_appeal" id="priority_level" style="border-radius: 3px">
            <%
                List<String> priorityLevel = Arrays.asList("П1","П2","П3");
                for (String level : priorityLevel){
            %>
            <option value="<%= level%>"><%= level%></option>
            <%
                    }
            %>
            </select>&nbsp;&nbsp;
            Вложения:&nbsp;<input type="file" name="appeal_attachment" id="appeal_attachment" accept="image/*" multiple onchange="checkFilesNum(this.files)">
            <br><br>
            <div style="text-align: right">
            <button id="create_appeal" class="float-left submit-button cool_button">Создать</button>
            </div>
            <script type="text/javascript">
                document.getElementById("create_appeal").onclick = function () {
                    var appeal_content = document.getElementById("appeal_content").value;
                    var appeal_comment = document.getElementById("appeal_comment").value;
                    var customer_org_name = document.getElementById("customer_org_name").value;
                    var customer_name = document.getElementById("customer_name").value;
                    var customer_mail = document.getElementById("customer_mail").value;

                    if (appeal_content === "" || appeal_comment === "" || customer_org_name === "" || customer_name === "" || customer_mail === "") {
                        alert("Поля формы заявки не могут быть пустыми");
                        return false;
                    } else {
                        var executor = document.getElementById("executor").value;

                        if (executor === 'def') {
                            alert("Необходимо выбрать исполнителя заявки");
                            return false;
                        } else {
                        var pattern = new RegExp("^[a-zA-Zа-яА-Я0-9,-. ]+$");
                        if (!appeal_content.match(pattern) || !appeal_comment.match(pattern)) {
                            alert("В полях Содержание / Комментарий допустимы только символы (a-zA-Zа-яА-Я0-9,-. )");
                            return false;
                        }

                        return true;
                        }
                    }
                }
            </script>
        </form>
     </div>
    </div>

<div id="footer">&copy; 2020</div>
</body>
</html>