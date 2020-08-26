create table students_info_bak (
school_id varchar(25) not null default '',
student_id varchar(50) not null default '',
exam_id varchar(10) not null,
exam_status char(1) default '0',
count tinyint(3) default 0,
version tinyint(2) default 1,
exam_password varchar(50) default '',
reassign_status char(1) default '0');

create table cescores_bak( 
     school_id     varchar(50) not null default '',
     user_id       varchar(30) not null default '', 
     course_id     varchar(5) not null default '', 
     category_id   varchar(5) not null default '', 
     work_id       varchar(8) not null default '', 
     submit_date   date, 
     marks_secured float(3), 
     total_marks   int(3), 
     status        char(1)     
)TYPE=MyISAM;  

create table exam_tbl_bak(
	school_id       varchar(50) not null default '',
	course_id	varchar(5) not null default '',
	teacher_id	varchar(25) not null default '',
	exam_id		varchar(8)  default '',
	exam_type	varchar(5) not null default '',
	exam_name	varchar(50) not null default '',
	instructions    varchar(150) default '',
	create_date	date not null default '0000-00-00',	
	from_date	date not null default '0000-00-00',
	to_date		date not null default '0000-00-00',
	from_time       time default '00:00:00',
	to_time         time default '00:00:00',
	dur_hrs		tinyint unsigned default 0,	
	dur_min         tinyint default 0,	
	type_wise       char(1) default '0',
	random_wise     char(1) default '0',
	versions        tinyint unsigned default '1',	
	mul_attempts    tinyint default '0',
	ques_list	text default '',
	short_type      char(1) default '0',
	status		char(1) default '0',
	no_of_groups	tinyint default '0',
	group_status	char(1) default '0',
	password	char(1) default '',
	grading char(1) not null default 0
)TYPE=MyISAM;