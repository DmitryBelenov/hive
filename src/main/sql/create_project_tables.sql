-- организации
CREATE TABLE organizations (
   org_name VARCHAR (255) not null,
   org_address VARCHAR (255) not null,
   org_email VARCHAR (255) not null,
   org_login VARCHAR (255) not null,
   org_password VARCHAR (255) not null,
   email_confirmed boolean,
   confirmation_uuid varchar(255) not null,
   reg_date timestamp,
   org_prefix VARCHAR (255)
);

-- пользователи организаций
CREATE TABLE org_users (
   org_uuid VARCHAR (255) not null,
   user_uuid VARCHAR (255) not null,
   first_name VARCHAR (255) not null,
   last_name VARCHAR (255) not null,
   user_role VARCHAR (50) not null,
   user_email VARCHAR (255) not null,
   user_login VARCHAR (255) not null,
   user_password VARCHAR (255) not null,
   user_confirmed boolean,
   reg_date timestamp,
   user_icon VARCHAR (10)
);

-- задачи
CREATE TABLE task (
   task_id VARCHAR (255) not null,
   creator_id VARCHAR (255),
   creator_org_id VARCHAR (255) not null,
   head_line VARCHAR (255) not null,
   description VARCHAR (5000) not null,
   project VARCHAR (255),
   dead_line timestamp not null,
   assign_id VARCHAR (255) not null,
   attachment_line VARCHAR (3000),
   create_date timestamp  not null,
   priority VARCHAR (100) not null
);

-- комментарии к задачам
CREATE TABLE task_comments (
   org_id VARCHAR (255) not null,
   owner_id VARCHAR (255) not null,
   task_id VARCHAR (255) not null,
   text_content VARCHAR (3000) not null,
   create_date timestamp
);

-- префиксы задач
CREATE TABLE task_prefix (
   org_uuid VARCHAR (255) not null,
   prefix VARCHAR (255) not null,
   create_date timestamp not null
);

-- заявки
CREATE TABLE appeals (
   appeal_id VARCHAR (255) not null,
   priority_level VARCHAR (5) not null,
   appeal_number VARCHAR (50) not null,
   create_date timestamp not null,
   appeal_content VARCHAR (5000) not null,
   sender_org_name VARCHAR (255) not null,
   sender_name VARCHAR (255),
   sender_mail VARCHAR (255) not null,
   appeal_state VARCHAR (255) not null,
   performer_id VARCHAR (255) not null,
   appeal_comment VARCHAR (1000),
   attachment_line VARCHAR (3000)
);

