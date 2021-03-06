# HIVE
Task tracker for SCRUM development

![иллюстрация к проекту](https://github.com/DmitryBelenov/hive/blob/master/src/main/webapp/resources/hive.jpg)

Трекер Hive - это свободно распространяемый веб-проект, который помогает решить
задачу организации работы команды программистов, тестировщиков, специалистов тех.
подержки. Может быть использован так же командами, не связанными с разработкой
ПО.

Основные возможности трекера:
1. Регистрация организации и сотрудников с подтверждением 
через email. Шифрование пароля хэш функцией SHA-256. 
2. Создание новых пользователей организации, назначение ролей.
3. Создание задач, назначение их на определенного сотрудника.
Изменение и отслеживание статуса задачи и этапа ее жизненного цикла.
Возможность комментировать задачу всем зарегистрированым пользователям.
Возможность исполнителю задачи переводить ее на других сотрудников.
4. Ведение архива устаревших задач, восстановление по необходимости.
5. Ведение журнала заявок от клиентов компании для технической поддержки.
Возможность создавать, редактировать, менять статус завяки.
6. Возможность изменения пароля пользователя, назначенного автоматически
при регистрации.
7. Хранение настроек системы во внешнем файле.

Размер проекта версии 1.0 около 2Мб.

Как установить:

Проект может быть использован как в локальных, так и глобальных сетях.
1. Скачать архив с проектом
https://github.com/DmitryBelenov/hive/blob/master/Hive1.0.rar
2. Установить postgreSQL в систему (если нет)
3. Скриптами из create_project_tables.sql создать бд, пользователя, наполнить бд таблицами.
Выполнять согласно номерам -- 1, -- 2 и т.д.
4. Установить Tomcat8,9. Разместить архив hive.war в каталог <ваш путь к tomcat>\webapps\

5. Разместить файл hive.properties в каталог C:\Users\\<имя пользователя>\Hive

Состав файла настроек (дополнить своими данными в местах с тегами):

hive.server.ip=<IP или hostname вашего сервера>

hive.server.port=<Порт, на котором стартуете сервер>

hive.http.type=<тип протокола http:// или https://>

параметры базы данных так же можно изменить на свои
(если при создании указать отличающиеся от тех, что в исходном скрипте)

6. Произвести deploy приложения (запустить tomcat)
