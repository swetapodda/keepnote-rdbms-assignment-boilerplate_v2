create table if not exists user(
user_id varchar(20) not null primary key,
user_name varchar(50) not null,
user_added_date DATETIME  not null default current_timestamp,
user_password varchar (50) not null,
user_mobile varchar (50)
);

CREATE TABLE if not exists NOTE(
			NOTE_ID INTEGER NOT NULL,
			NOTE_TITLE VARCHAR(100) NOT NULL,
			NOTE_CONTENT VARCHAR(200) NULL,
			NOTE_STATUS VARCHAR(20) NOT NULL,
			NOTE_CREATION_DATE DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
			PRIMARY KEY (NOTE_ID)
		) ;


CREATE TABLE if not exists CATEGORY(
			CATEGORY_ID INTEGER NOT NULL PRIMARY KEY,
			CATEGORY_NAME VARCHAR(30) NOT NULL,
			CATEGORY_DESCR VARCHAR(30),
			CATEGORY_CREATION_DATE DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
			CATEGORY_CREATOR VARCHAR(20) NOT NULL,
			FOREIGN KEY CATEGORY_CREATOR_FK(CATEGORY_CREATOR) REFERENCES user(USER_ID) ON
			DELETE CASCADE ON
			UPDATE CASCADE
		) ;
		
CREATE TABLE if not exists REMINDER (
			REMINDER_ID INTEGER NOT NULL PRIMARY KEY,
			REMINDER_NAME VARCHAR(50) NOT NULL,
			REMINDER_DESCR VARCHAR(100),
			REMINDER_TYPE VARCHAR(50) ,
			REMINDER_CREATION_DATE DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
			REMINDER_CREATOR VARCHAR(20) NOT NULL,
			FOREIGN KEY REMINDER_CREATOR_FK(REMINDER_CREATOR) REFERENCES user(USER_ID) 
			ON DELETE CASCADE 
			ON UPDATE CASCADE
		) ;
		

CREATE TABLE if not exists NOTECATEGORY (
			NOTECATEGORY_ID INTEGER NOT NULL PRIMARY KEY,
			NOTE_ID INTEGER NOT NULL,
			FOREIGN KEY CNOTE_ID_FK(NOTE_ID) REFERENCES NOTE(NOTE_ID) 
			ON DELETE CASCADE 
			ON UPDATE CASCADE,
			CATEGORY_ID INTEGER NOT NULL,
			FOREIGN KEY NCATEGORY_ID_FK(CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID) 
			ON DELETE CASCADE 
			ON UPDATE CASCADE
		) ;

CREATE TABLE if not exists NOTEREMINDER (
			NOTEREMINDER_ID INTEGER NOT NULL PRIMARY KEY,
			NOTE_ID INTEGER NOT NULL ,
			FOREIGN KEY RNOTE_ID_FK(NOTE_ID) REFERENCES NOTE(NOTE_ID)
			ON DELETE CASCADE
			ON UPDATE CASCADE,
			REMINDER_ID INTEGER NOT NULL ,
			FOREIGN KEY NREMINDER_ID_FK(REMINDER_ID) REFERENCES REMINDER(REMINDER_ID)
			ON DELETE CASCADE
			ON UPDATE CASCADE
		) ;

CREATE TABLE if not exists USERNOTE (
			USERNOTE_ID INTEGER NOT NULL PRIMARY KEY,
			USER_ID VARCHAR(20) NOT NULL ,
			FOREIGN KEY NUSER_ID_FK(USER_ID) REFERENCES user(USER_ID)
			ON DELETE CASCADE
			ON UPDATE CASCADE,
			NOTE_ID INTEGER NOT NULL ,
			FOREIGN KEY NNOTE_ID_FK(NOTE_ID) REFERENCES NOTE(NOTE_ID)
			ON DELETE CASCADE
			ON UPDATE CASCADE
		) ;


INSERT INTO user(USER_ID,USER_NAME,USER_PASSWORD,USER_MOBILE) VALUES('admin','Sweta','password','9882698767');
INSERT INTO NOTE(NOTE_ID,NOTE_TITLE, NOTE_CONTENT, NOTE_STATUS) VALUES(1,'MEETING WITH ARCHITECT','Discussion on New Requirement on JIRA Ticket','ACTIVE');
INSERT INTO CATEGORY(CATEGORY_ID,CATEGORY_NAME, CATEGORY_DESCR,CATEGORY_CREATOR) VALUES(1,'Business','Business Meeting','admin');
INSERT INTO REMINDER(REMINDER_ID,REMINDER_NAME, REMINDER_DESCR, REMINDER_TYPE,REMINDER_CREATOR) VALUES(1,'WebEx Meeting','webEx @12:00PM IST','Official','admin');
INSERT INTO NOTECATEGORY(NOTECATEGORY_ID,NOTE_ID, CATEGORY_ID) VALUES(1,1,1);
INSERT INTO NOTEREMINDER(NOTEREMINDER_ID,NOTE_ID, REMINDER_ID) VALUES(1,1,1);
INSERT INTO USERNOTE(USERNOTE_ID,USER_ID, NOTE_ID) VALUES(1,'admin',1);

--Fetch the row from User table based on Id and Password.

SELECT * FROM user WHERE USER_ID='admin' AND USER_PASSWORD= 'password';

--Fetch all the rows from Note table based on the field note_creation_date.

SELECT * FROM NOTE where note_creation_date is not null and date(note_creation_date)= '2020-07-14';

--Fetch all the Categories created after the particular Date.

SELECT * FROM CATEGORY WHERE DATE (CATEGORY_CREATION_DATE) > '2020-07-13';

--Fetch all the Note ID from UserNote table for a given User.

SELECT UN.NOTE_ID FROM USERNOTE AS UN ,USER  AS USR WHERE UN.USER_ID = USR.USER_ID and USR.USER_NAME = 'Sweta';

--Write Update query to modify particular Note for the given note Id.

UPDATE NOTE SET NOTE_TITLE = 'Weekly Status Meeting',NOTE_CONTENT='Sprint Planning Meeting',NOTE_STATUS = 'ACTIVE' WHERE NOTE_ID=1;

--Fetch all the Notes from the Note table by a particular User.

SELECT Note.NOTE_ID,Note.NOTE_TITLE, Note.NOTE_CONTENT, Note.NOTE_STATUS
 FROM NOTE AS Note, USERNOTE AS USRNOTE, user AS USR
 WHERE USRNOTE.USER_ID = USR.USER_ID AND Note.NOTE_ID= USRNOTE.NOTE_ID AND USR.USER_NAME = 'Sweta';

--Fetch all the Notes from the Note table for a particular Category.

SELECT Note.NOTE_ID,Note.NOTE_TITLE, Note.NOTE_CONTENT, Note.NOTE_STATUS 
FROM NOTE AS Note, CATEGORY AS Cat, NOTECATEGORY AS NoteCat 
WHERE Note.NOTE_ID=NoteCat.NOTE_ID AND NoteCat.CATEGORY_ID= Cat.CATEGORY_ID AND Cat.CATEGORY_NAME = 'Personal';

--Fetch all the reminder details for a given note id.

SELECT REM.* FROM REMINDER REM, NOTEREMINDER NREM WHERE REM.REMINDER_ID= NREM.REMINDER_ID AND NREM.NOTE_ID=1;

--Fetch the reminder details for a given reminder id.

SELECT * FROM REMINDER WHERE REMINDER_ID=1;

--Write a query to create a new Note from particular User (Use Note and UserNote tables - insert statement).
INSERT INTO NOTE(NOTE_ID,NOTE_TITLE, NOTE_CONTENT, NOTE_STATUS) VALUES(2,'IBM Training','FSD Training','ACTIVE');
INTO USERNOTE(USERNOTE_ID,USER_ID, NOTE_ID) VALUES(2,'admin',2);

--Write a query to create a new Note from particular User to particular Category(Use Note and NoteCategory tables - insert statement)
INSERT INTO NOTE(NOTE_ID,NOTE_TITLE, NOTE_CONTENT, NOTE_STATUS) VALUES(3,'KT Planning','KT Planning for the New resource','ACTIVE');
INSERT INTO CATEGORY(CATEGORY_ID,CATEGORY_NAME, CATEGORY_DESCR,CATEGORY_CREATOR) VALUES(2,'Official','Official Meeting','admin');
INSERT INTO NOTECATEGORY(NOTECATEGORY_ID,NOTE_ID, CATEGORY_ID) VALUES(2,3,2);

--Write a query to set a reminder for a particular note (Use Reminder and NoteReminder tables - insert statement)
INSERT INTO REMINDER (REMINDER_ID,REMINDER_NAME, REMINDER_DESCR, REMINDER_TYPE,REMINDER_CREATOR) VALUES(2,'Training','Training @ 10AM Thursday IST' ,'Personal','admin');
INSERT INTO NOTEREMINDER (NOTEREMINDER_ID,NOTE_ID, REMINDER_ID) VALUES(2,1,2);

--Write a query to delete particular Note added by a User(Note and UserNote tables - delete statement)

DELETE from NOTE where NOTE_ID=2;

--Write a query to delete particular Note from particular Category(Note and NoteCategory tables - delete statement)

DELETE from NOTE where NOTE_ID=2;

--Create a trigger to delete all matching records from UserNote, NoteReminder and NoteCategory table when :
--	1. A particular note is deleted from Note table (all the matching records from UserNote, NoteReminder and NoteCategory should be removed automatically) 

delimiter //
CREATE TRIGGER note_delete_trigger 
BEFORE DELETE on Note 
FOR EACH ROW 
Begin
DELETE FROM NOTECATEGORY WHERE NOTE_ID = OLD.NOTE_ID;
DELETE FROM USERNOTE WHERE NOTE_ID = OLD.NOTE_ID;
DELETE FROM NOTEREMINDER WHERE NOTE_ID = OLD.NOTE_ID;
end; //
delimiter ;

---2. A particular user is deleted from User table (all the matching notes should be removed automatically)

delimiter //
CREATE TRIGGER user_delete_trigger 
BEFORE DELETE on User 
FOR EACH ROW 
Begin
DELETE FROM CATEGORY WHERE CATEGORY_CREATOR = OLD.USER_ID;
DELETE from REMINDER where REMINDER_CREATOR = OLD.USER_ID;
DELETE from USERNOTE where USER_ID = OLD.USER_ID;
end; //
delimiter ;