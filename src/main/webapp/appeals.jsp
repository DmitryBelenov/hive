<%@ page import="java.util.*" %>
<%@ page import="ru.objects.appeals.Appeal" %>
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
        <form id="new_appeal" method="post" action="new_appeal" enctype="multipart/form-data">
            Содержание:<br><textarea rows="6" cols="110" name="appeal_content" id="appeal_content" maxlength="5000" style="resize: none"></textarea>
            <br>
            Комментарий:<br><textarea rows="2" cols="110" name="appeal_comment" id="appeal_comment" maxlength="1000" style="resize: none"></textarea>
            <br>
            Название организации:<br><input type="text" name="customer_org_name" id="customer_org_name" maxlength="255" style="text-align: center" size="33">
            <br>
            Имя заказчика:<br><input type="text" name="customer_name" id="customer_name" maxlength="255" style="text-align: center" size="33">
            <br>
            Почта заказчика:<br><input type="text" name="customer_mail" id="customer_mail" maxlength="255" style="text-align: center" size="33">
            <br><br>
            Исполнитель:<br><select size="1" name="executor" form="new_appeal" id="executor">
            <%
                Map<String, String> orgUsers = (Map<String, String>)request.getAttribute("org_users");
                if (orgUsers.size() > 0) {
                    for (String userId : orgUsers.keySet()){
            %>
            <option value="<%= userId%>"><%= orgUsers.get(userId)%></option>
            <%
                    }
                }%>
            </select>&nbsp;&nbsp;
            Уровень приоритета:&nbsp;<select size="1" name="priority_level" form="new_appeal" id="priority_level">
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
                    var org_name = document.getElementById("org_name").value;
                    var customer_name = document.getElementById("customer_name").value;
                    var customer_mail = document.getElementById("customer_mail").value;

                    if (appeal_content === "" || appeal_comment === "" || org_name === "" || customer_name === "" || customer_mail === "") {
                        alert("Поля формы заявки не могут быть пустыми");
                        return false;
                    } else {
                        return true;
                    }
                }
            </script>
        </form>

        <!-- appeals table -->
        <br>
        <fieldset class="appeals_list_block_style" style=" border-radius: 3px">
            <legend>Журнал заявок</legend>
        <div class="scroll_block_appeals">
            <table>
                <tbody>
                <tr>
                    <form method="post" action="open_appeal">
                        <%--<input type="hidden" name="" value=""/>--%>

                        <td align="center" width="50"><button class="float-left submit-button cool_button">open</button></td>
                    </form>
                </tr>
                </tbody>
            </table>
        </div>
        </fieldset>
     </div>
    </div>

<div id="footer">&copy; 2020</div>
</body>
</html>