CREATE TABLE USER (
user_id VARCHAR(20) AUTO_INCREMENT PRIMARY KEY,
user_name VARCHAR(60) NOT NULL,
user_added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
user_password VARCHAR(60) NOT NULL,
user_mobile  VARCHAR(60)
);
​
CREATE TABLE NOTE (
note_id BIGINT(15) AUTO_INCREMENT PRIMARY KEY,
note_title VARCHAR(60) NOT NULL,
note_content VARCHAR(255) ,
note_status VARCHAR(10) NOT NULL,
note_creation_date  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
​
CREATE TABLE CATEGORY  (
category_id BIGINT(15) AUTO_INCREMENT PRIMARY KEY,
category_name VARCHAR(60) NOT NULL,
category_descr VARCHAR(255) ,
category_creation_date  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
category_creator VARCHAR(20) NOT NULL,
CONSTRAINT FK_CAT_USERID
    FOREIGN KEY (category_creator) 
        REFERENCES USER(user_id)
);
​
CREATE TABLE REMINDER  (
reminder_id BIGINT(15) AUTO_INCREMENT PRIMARY KEY,
reminder_name VARCHAR(60) NOT NULL,
reminder_descr VARCHAR(255) ,
reminder_type VARCHAR(20) NOT NULL,
reminder_creation_date  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
reminder_creator VARCHAR(20) NOT NULL,
CONSTRAINT FK_REM_USERID
    FOREIGN KEY (reminder_creator) 
        REFERENCES USER(user_id)
);
 
CREATE TABLE NOTECATEGORY  (
notecategory_id BIGINT(15) AUTO_INCREMENT PRIMARY KEY,
note_id BIGINT(15),
category_id BIGINT(15),
CONSTRAINT FK_NC_NOTEID
    FOREIGN KEY (note_id) 
        REFERENCES NOTE(note_id),
CONSTRAINT FK_NC_CATID
    FOREIGN KEY (category_id) 
        REFERENCES CATEGORY(category_id)
);
​
CREATE TABLE NOTEREMINDER  (
notereminder_id BIGINT(15) AUTO_INCREMENT PRIMARY KEY,
note_id BIGINT(15),
reminder_id BIGINT(15),
CONSTRAINT FK_NR_NOTEID
    FOREIGN KEY (note_id) 
        REFERENCES NOTE(note_id),
CONSTRAINT FK_NR_REMID
    FOREIGN KEY (reminder_id) 
        REFERENCES REMINDER(reminder_id)
);
​
CREATE TABLE USERNOTE  (
usernote_id INT(15) NOT NULL PRIMARY KEY,
note_id INT(15),
user_id VARHCAR(20) NOT NULL,
CONSTRAINT FK_UN_NOTEID
    FOREIGN KEY (note_id) 
        REFERENCES NOTE(note_id)
CONSTRAINT FK_UN_USERID
    FOREIGN KEY (user_id) 
        REFERENCES USER(user_id)
);
​
​
 
INSERT INTO USER (`user_id`, `user_name`, `user_added_date`, `user_password`, `user_mobile`) values ('User_1', 'admin', '2020-07-10', 'password', '9988776655');
INSERT INTO USER (`user_id`, `user_name`, `user_added_date`, `user_password`, `user_mobile`) values ('User_2', 'root', '2020-07-10', 'root123', '884466334422');
​
INSERT INTO CATEGORY (`category_id`, `category_name`, `category_descr`, `category_creation_date`, `category_creator`) VALUES (1, 'Information', 'Informative Text', '2010-01-03', 'User_1');
INSERT INTO CATEGORY (`category_id`, `category_name`, `category_descr`, `category_creation_date`, `category_creator`) VALUES (2, 'Contact Details', 'User contact details', '2012-06-21', 'User_2');
INSERT INTO CATEGORY (`category_id`, `category_name`, `category_descr`, `category_creation_date`, `category_creator`) VALUES (3, 'Complaints', 'Complaint number or Disputes', '2014-05-05', 'User_1');
INSERT INTO CATEGORY (`category_id`, `category_name`, `category_descr`, `category_creation_date`, `category_creator`) VALUES (4, 'Request', 'Service request number', '2015-09-28', 'User_2');
​
INSERT INTO REMINDER (`reminder_id`, `reminder_name`, `reminder_descr`, `reminder_type`, `reminder_creation_date`, `reminder_creator`) VALUES (1, 'Alarm', 'Alarm Reminder', 'Daily', '2010-04-24', 'User_1');
INSERT INTO REMINDER (`reminder_id`, `reminder_name`, `reminder_descr`, `reminder_type`, `reminder_creation_date`, `reminder_creator`) VALUES (2, 'To-Do', 'To-Do Lisy', 'One-Time', '2010-04-24', 'User_1');
INSERT INTO REMINDER (`reminder_id`, `reminder_name`, `reminder_descr`, `reminder_type`, `reminder_creation_date`, `reminder_creator`) VALUES (3, 'Birthday', 'Birthday Reminder', 'Yearly', '2010-04-24', 'User_2');
INSERT INTO REMINDER (`reminder_id`, `reminder_name`, `reminder_descr`, `reminder_type`, `reminder_creation_date`, `reminder_creator`) VALUES (4, 'Anniversary', 'Anniversary Reminder', 'Yearly', '2010-04-24', 'User_2');
​
INSERT INTO NOTE (`note_id`, `note_title`, `note_content`, `note_status`, `note_creation_date`) VALUES (1, 'Note1', 'Note1-content', 'Inprogress', '2007-02-03');
INSERT INTO NOTE (`note_id`, `note_title`, `note_content`, `note_status`, `note_creation_date`) VALUES (2, 'Note2', 'Note2-content', 'InActive', '2007-01-31');
INSERT INTO NOTE (`note_id`, `note_title`, `note_content`, `note_status`, `note_creation_date`) VALUES (3, 'Note3', 'Note3-content', 'Active', '2007-02-02');
INSERT INTO NOTE (`note_id`, `note_title`, `note_content`, `note_status`, `note_creation_date`) VALUES (4, 'Note4', 'Note4-content', 'Completed', '2007-03-06');
​
INSERT INTO USERNOTE (`note_id`, `user_id`) VALUES (1, 'User_1');
INSERT INTO USERNOTE (`note_id`, `user_id`) VALUES (3, 'User_1');
INSERT INTO USERNOTE (`note_id`, `user_id`) VALUES (2, 'User_2');
INSERT INTO USERNOTE (`note_id`, `user_id`) VALUES (4, 'User_2');
​
INSERT INTO NOTEREMINDER (`note_id`, `reminder_id`) VALUES (1, 1);
INSERT INTO NOTEREMINDER (`note_id`, `reminder_id`) VALUES (2, 2);
INSERT INTO NOTEREMINDER (`note_id`, `reminder_id`) VALUES (3, 3);
INSERT INTO NOTEREMINDER (`note_id`, `reminder_id`) VALUES (4, 4);
​
INSERT INTO NOTECATEGORY (`note_id`, `category_id`) VALUES (1, 1);
INSERT INTO NOTECATEGORY (`note_id`, `category_id`) VALUES (2, 2);
INSERT INTO NOTECATEGORY (`note_id`, `category_id`) VALUES (3, 3);
INSERT INTO NOTECATEGORY (`note_id`, `category_id`) VALUES (4, 4);
​
SELECT * FROM USER WHERE USER_NAME = 'admin' AND USER_PASSWORD = 'password';
SELECT * FROM USER WHERE USER_NAME = 'root' AND USER_PASSWORD = 'root123';
​
SELECT * FROM NOTE WHERE NOTE_CREATION_DATE = '2007-02-03';
​
SELECT * FROM CATEGORY WHERE CATEGORY_CREATION_DATE > '2013-02-03';
​
SELECT NOTE_ID FROM USERNOTE WHERE USER_ID = 2;
​
UPDATE NOTE SET NOTE_TITLE = 'Note_Upd' WHERE NOTE_ID = 2;
​
SELECT NOTE.* FROM NOTE INNER JOIN USERNOTE ON NOTE.NOTE_ID = USERNOTE.NOTE_ID WHERE USERNOTE.USER_ID = 2;
​
SELECT NOTE.* FROM NOTE INNER JOIN NOTECATEGORY ON NOTE.NOTE_ID = NOTECATEGORY.NOTE_ID WHERE NOTECATEGORY.CATEGORY_ID = 3;
​
SELECT REMINDER.* FROM REMINDER INNER JOIN NOTEREMINDER ON REMINDER.REMINDER_ID = NOTEREMINDER.REMINDER_ID WHERE NOTEREMINDER.NOTE_ID = 3;
​
SELECT * FROM REMINDER WHERE REMINDER_ID = 4;
​
# Write a query to create a new Note from particular User (Use Note and UserNote tables - insert statement).
INSERT INTO NOTE(`note_title`,`note_content`,`note_status`,`note_creation_date`)  values( "Note5", "note5-content", "Progress", "2010-08-26");
INSERT INTO NOTECATEGORY (`note_id`, `category_id`) VALUES (last_insert_id(), 1);
​
# Write a query to create a new Note from particular User to particular Category(Use Note and NoteCategory tables - insert statement)
INSERT INTO NOTE(`note_title`,`note_content`,`note_status`,`note_creation_date`)  values( "Note6", "note6-content", "Active", "2011-08-26");
INSERT INTO NOTECATEGORY (`note_id`, `category_id`) VALUES (last_insert_id(), 3);
​
# Write a query to set a reminder for a particular note (Use Reminder and NoteReminder tables - insert statement)
INSERT INTO REMINDER (`reminder_name`,`reminder_descr`,`reminder_type`,`reminder_creation_date`,`reminder_creator`)  values("Shpping List", "Shopping list Items", "OneTime", "2010-07-20", 1);
INSERT INTO NOTEREMINDER (`note_id`,`reminder_id`) values(4,last_insert_id());
​
# Write a query to delete particular Note added by a User(Note and UserNote tables - delete statement)
DELETE FROM USERNOTE WHERE USER_ID = 2 AND NOTE_ID = (SELECT NOTE_ID FROM NOTE WHERE NOTE_TITLE = 'Note_Upd');
​
# Write a query to delete particular Note from particular Category(Note and NoteCategory tables - delete statement)
DELETE FROM NOTECATEGORY WHERE CATEGORY_ID = 2 AND NOTE_ID = (SELECT NOTE_ID FROM NOTE WHERE NOTE_TITLE = 'Note_Upd');
​
# Create a trigger to delete all matching records from UserNote, NoteReminder and NoteCategory table when :
#  1. A particular note is deleted from Note table (all the matching records from UserNote, NoteReminder and NoteCategory should be removed automatically)
DELIMITER //
CREATE TRIGGER ON_NOTE_DELETE BEFORE DELETE ON NOTE
    FOR EACH ROW 
    BEGIN 
		DELETE FROM USERNOTE WHERE NOTE_ID = OLD.NOTE_ID;
        DELETE FROM NOTEREMINDER WHERE NOTE_ID = OLD.NOTE_ID;
        DELETE FROM NOTECATEGORY WHERE NOTE_ID = OLD.NOTE_ID;
	END; //
DELIMITER ;
​
SELECT * FROM USERNOTE;  # 1,3, 4 => 1 ROW
SELECT * FROM NOTEREMINDER;  # 1,2,3,4,5 => 1 ROW
SELECT * FROM NOTECATEGORY;  # 1,3,4,5,6 => 1 ROW
​
DELETE FROM NOTE WHERE NOTE_ID = 3;
​
#  2. A particular user is deleted from User table (all the matching notes should be removed automatically)
DELIMITER //
CREATE TRIGGER ON_CAT_DELETE BEFORE DELETE ON CATEGORY
    FOR EACH ROW 
    BEGIN 
		DELETE FROM NOTECATEGORY WHERE CATEGORY_ID = OLD.CATEGORY_ID;
	END; //
    
CREATE TRIGGER ON_REM_DELETE BEFORE DELETE ON REMINDER
    FOR EACH ROW 
    BEGIN 
		DELETE FROM NOTEREMINDER WHERE REMINDER_ID = OLD.REMINDER_ID;
	END; //
    
CREATE TRIGGER ON_USER_DELETE BEFORE DELETE ON USER
    FOR EACH ROW 
    BEGIN 
		DELETE FROM CATEGORY WHERE CATEGORY_CREATOR = OLD.USER_ID;
        DELETE FROM REMINDER WHERE REMINDER_CREATOR = OLD.USER_ID;
		DELETE FROM USERNOTE WHERE USER_ID = OLD.USER_ID;
	END; //
DELIMITER ;
​
SELECT * FROM CATEGORY;  # 1,2,3,4 => 1&3 ROW
SELECT * FROM REMINDER;  # 1,2,3,4,5 => 1,2&5 ROW
SELECT * FROM USERNOTE;  # 1,2 => 1 ROW
​
DELETE FROM USER WHERE USER_ID = 1;
