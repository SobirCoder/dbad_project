
use freedbtech_dbad;
delimiter //
create procedure proc_countries_save
(
	in i_country_id                      int(10) unsigned,
  in i_name                            varchar(250),
  in i_state                           varchar(1)    
)

begin
	if i_country_id is null then
		insert into countries(name, state)
		values (i_name, i_state);
	else
		update countries 
			set name = i_name,
					state = i_state
			where country_id = i_country_id;
	end if;
end//

delimiter ;


use freedbtech_dbad;
delimiter //
create procedure proc_get_countries
(
	in i_country_id int(10)
)
begin
	select * from countries t
	where (i_country_id is null or t.country_id = i_country_id);
end//

delimiter ;


/*-- region*/

use freedbtech_dbad;
delimiter //
create procedure proc_regions_save
(
	in i_region_id                       int(10),
  in i_name                            varchar(250),
  in i_country_id											 int(10),
  in i_state                           varchar(1)    
)

begin
	if i_region_id is null then
		insert into regions(name, country_id, state)
		values (i_name, i_country_id, i_state);
	else
		update regions 
			set name = i_name,
					country_id = i_country_id,
					state = i_state
			where region_id = i_region_id;
	end if;
end//

delimiter ;


use freedbtech_dbad;
delimiter //
create procedure proc_get_regions
(
	in i_region_id int(10)
)
begin
	select * from regions t
	where (i_region_id is null or t.region_id = i_region_id);
end//

delimiter ;


/*-- presons*/

use freedbtech_dbad;
delimiter //
create procedure proc_persons_save
(
	i_PERSON_ID                       int(10) ,
  i_FIRST_NAME                      varchar(250),
  i_LAST_NAME                       varchar(250),
  i_MIDDLE_NAME                     varchar(250),
  i_PASSPORT_NUMBER                 varchar(250),
  i_DATE_OF_BIRTH                   datetime,
  i_PLACE_OF_BIRTH                  int(10) ,
  i_GENDER                          varchar(1),
  i_REGION_ID                       int(10) ,
  i_ADDRESS                         varchar(250),
  i_PHONE                           varchar(250),
  i_EMAIL                           varchar(250)    
)
begin
	if i_PERSON_ID is null then
		insert into persons(first_name, last_name, middle_name, passport_number, 
												date_of_birth, place_of_birth, gender, region_id, address, 
												phone, email)
		values (i_FIRST_NAME, i_LAST_NAME, i_MIDDLE_NAME, i_PASSPORT_NUMBER, 
						i_DATE_OF_BIRTH, i_PLACE_OF_BIRTH, i_GENDER, i_REGION_ID, i_ADDRESS, i_PHONE, 
						i_EMAIL);
	else
		update persons 
			set FIRST_NAME      = i_FIRST_NAME,
					LAST_NAME       = i_LAST_NAME,
					MIDDLE_NAME     = i_MIDDLE_NAME,
					PASSPORT_NUMBER = i_PASSPORT_NUMBER,
					DATE_OF_BIRTH   = i_DATE_OF_BIRTH,
					PLACE_OF_BIRTH  = i_PLACE_OF_BIRTH,
					GENDER          = i_GENDER,
					REGION_ID       = i_REGION_ID,
					ADDRESS         = i_ADDRESS,
					PHONE           = i_PHONE,
					EMAIL           = i_EMAIL
			where person_id = i_person_id;
	end if;
end//

delimiter ;


use freedbtech_dbad;
delimiter //
create procedure proc_get_persons
(
	in i_person_id int(10)
)
begin
	select * from persons t
	where (i_person_id is null or t.person_id = i_person_id);
end//

delimiter ;


/*-- blood groups*/

use freedbtech_dbad;
delimiter //
create procedure proc_blood_groups_save
(
	in i_blood_group_id                  int(10),
  in i_name                            varchar(250)
)

begin
	if i_blood_group_id is null then
		insert into blood_groups(name)
		values (i_name);
	else
		update blood_groups 
			set name = i_name
			where blood_group_id = i_blood_group_id;
	end if;
end//

delimiter ;


use freedbtech_dbad;
delimiter //
create procedure proc_get_blood_groups
(
	in i_blood_group_id int(10)
)
begin
	select * from blood_groups t
	where (i_blood_group_id is null or t.blood_group_id = i_blood_group_id);
end//

delimiter ;


/*-- hospitals*/

use freedbtech_dbad;
delimiter //
create procedure proc_hospitals_save
(
	i_HOSPITAL_ID                     int(10),
	i_NAME                            varchar(250),
	i_REGION_ID                       int(10),
	i_ADDRESS                         varchar(250),
	i_PHONE                           varchar(250),
	i_FAX                             varchar(250),
	i_STATE                           varchar(1)      
)
begin
	if i_HOSPITAL_ID is null then
		insert into hospitals(NAME, REGION_ID, ADDRESS, PHONE, 
													FAX, STATE)
		values (i_name, i_REGION_ID ,i_ADDRESS, i_PHONE, i_FAX, i_STATE);
	else
		update hospitals 
			set name = i_name,
				  REGION_ID	= i_REGION_ID,
					ADDRESS  	= i_ADDRESS,
					PHONE    	= i_PHONE,
					FAX      	= i_FAX,
					STATE    	= i_STATE
			where hospital_id = i_hospital_id;
	end if;
end//

delimiter ;


use freedbtech_dbad;
delimiter //
create procedure proc_get_hospitals
(
	in i_hospital_id int(10)
)
begin
	select * from hospitals t
	where (i_hospital_id is null or t.hospital_id = i_hospital_id);
end//

delimiter ;


/*-- employees*/

use freedbtech_dbad;
delimiter //
create procedure proc_employees_save
(
	i_employee_id               		  int(10),
  i_PERSON_ID                       int(10),
	i_HOSPITAL_ID                     int(10),
	i_JOB_TITLE                       varchar(250),    
	i_START_DATE                      datetime,        
	i_END_DATE                        datetime,
	i_SALARY                          varchar(250),  
	i_STATE                           varchar(1)      
)
begin
	if i_employee_id is null then
		insert into employees(PERSON_ID, HOSPITAL_ID, JOB_TITLE, start_date,
													END_DATE, SALARY, STATE)
		values (i_PERSON_ID, i_HOSPITAL_ID, i_JOB_TITLE, i_START_DATE, 
						i_END_DATE, i_SALARY, i_STATE);
	else
		update employees 
			set PERSON_ID  	= i_PERSON_ID,
					HOSPITAL_ID	= i_HOSPITAL_ID,
					JOB_TITLE  	= i_JOB_TITLE,
					START_DATE 	= i_START_DATE,
					END_DATE   	= i_END_DATE,
					SALARY     	= i_SALARY,
					STATE      	= i_STATE
			where employee_id = i_employee_id;
	end if;
end//

delimiter ;


use freedbtech_dbad;
delimiter //
create procedure proc_get_employees
(
	in i_employee_id int(10)
)
begin
	select * from employees t
	where (i_employee_id is null or t.employee_id = i_employee_id);
end//

delimiter ;


/*-- PROCEDURE_TYPES*/

use freedbtech_dbad;
delimiter //
create procedure proc_procedure_types_save
(
	in i_procedure_type_id                  int(10),
  in i_name                            varchar(250)
)

begin
	if i_procedure_type_id is null then
		insert into procedure_types(name)
		values (i_name);
	else
		update procedure_types 
			set name = i_name
			where procedure_type_id = i_procedure_type_id;
	end if;
end//

delimiter ;


use freedbtech_dbad;
delimiter //
create procedure proc_get_procedure_types
(
	in i_procedure_type_id int(10)
)
begin
	select * from procedure_types t
	where (i_procedure_type_id is null or t.procedure_type_id = i_procedure_type_id);
end//

delimiter ;


/*-- procedures*/

use freedbtech_dbad;
delimiter //
create procedure proc_procedures_save
(
	i_PROCEDURE_ID                    int(10),
	i_PATIENT_ID                      int(10),
	i_HOSPITAL_ID                     int(10),
	i_PROCEDURE_TYPE_ID               int(10),
	i_START_TIME                      datetime(6),
	i_END_TIME                        datetime(6),
	i_STATUS                          varchar(1)      
)

begin
	if i_PROCEDURE_ID is null then
		insert into procedures(PATIENT_ID, HOSPITAL_ID, PROCEDURE_TYPE_ID, 
													 START_TIME, END_TIME, STATUS)
		values (i_PATIENT_ID,
						i_HOSPITAL_ID,
						i_PROCEDURE_TYPE_ID,
						i_START_TIME,
						i_END_TIME,
						i_STATUS);
	else
		update procedures 
			set PATIENT_ID   			= i_PATIENT_ID,
					HOSPITAL_ID      	= i_HOSPITAL_ID,
					PROCEDURE_TYPE_ID	= i_PROCEDURE_TYPE_ID,
					START_TIME       	= i_START_TIME,
					END_TIME         	= i_END_TIME,
					STATUS           	= i_STATUS
			where procedure_id = i_procedure_id;
	end if;
end//

delimiter ;


use freedbtech_dbad;
delimiter //
create procedure proc_get_procedures
(
	in i_procedure_id int(10)
)
begin
	select * from procedures t
	where (i_procedure_id is null or t.procedure_id = i_procedure_id);
end//

delimiter ;

/*-- PROCEDURE DOCTORS*/

use freedbtech_dbad;
delimiter //
create procedure proc_procedure_doctors_save
(
	i_PROCEDURE_ID                    int(10),
	i_DOCTOR_ID                       int(10),
	i_DOCTOR_ROLE                     varchar(250),    
	i_START_TIME                      datetime(6),
	i_END_TIME                        datetime(6),
	i_STATUS                          varchar(1)      
)
begin
	if i_DOCTOR_ID is null then
		insert into procedure_doctors(procedure_id, DOCTOR_ROLE, START_TIME, 
																	END_TIME, STATUS)
		values (i_procedure_id,
						i_DOCTOR_ROLE,
						i_START_TIME, 
						i_END_TIME,   
						i_STATUS);
	else
		update procedure_doctors 
			set DOCTOR_ROLE = i_DOCTOR_ROLE,
					START_TIME  = i_START_TIME,
					END_TIME    = i_END_TIME,
					STATUS      = i_STATUS
			where procedure_id = i_procedure_id
					  and doctor_id = i_doctor_id;
	end if;
end//

delimiter ;


use freedbtech_dbad;
delimiter //
create procedure proc_get_procedure_doctors
(
	in i_procedure_id int(10),
	in i_doctor_id int(10)
)
begin
	select * from procedure_doctors t
	where (i_procedure_id is null and i_doctor_id is null or t.procedure_id = i_procedure_id
					  									and t.doctor_id = i_doctor_id);
end// 

delimiter ;


/*-- PROCEDURE drawings*/

use freedbtech_dbad;
delimiter //
create procedure proc_blood_drawings_save
(
	i_DRAWING_ID                      int(10),
	i_PROCEDURE_ID                    int(10),
	i_BLOOD_GROUP_ID                  int(10),
	i_AMOUNT                          int(10),
	i_EXPIRY_DATE                     datetime,        
	i_STATUS                          varchar(1)         
)
begin
	if i_DRAWING_ID is null then
		insert into blood_drawings(PROCEDURE_ID, BLOOD_GROUP_ID, 
															 AMOUNT, EXPIRY_DATE, STATUS)
		values (i_PROCEDURE_ID,  
						i_BLOOD_GROUP_ID,
						i_AMOUNT,        
						i_EXPIRY_DATE,   
						i_STATUS);
	else
		update blood_drawings 
			set BLOOD_GROUP_ID = i_BLOOD_GROUP_ID,
					AMOUNT         = i_AMOUNT,
					EXPIRY_DATE    = i_EXPIRY_DATE,
					STATUS         = i_STATUS
			where drawing_id = i_DRAWING_ID
					  and procedure_id = i_procedure_id;
	end if;
end//

delimiter ;


use freedbtech_dbad;
delimiter //
create procedure proc_get_blood_drawings
(
	in i_DRAWING_ID int(10),
	in i_procedure_id int(10)
)
begin
	select * from blood_drawings t
	where (drawing_id is null and procedure_id is null or t.drawing_id = i_DRAWING_ID
					  								and t.procedure_id = i_procedure_id);
end//

delimiter ;


/*-- PROCEDURE drawings*/

use freedbtech_dbad;
delimiter //
create procedure proc_blood_donations_save
(
	i_DONATION_ID                     int(10),
	i_PROCEDURE_ID                    int(10),
	i_DRAWING_ID                      int(10)     
)
begin
	if i_DONATION_ID is null then
		insert into blood_donations(procedure_id, drawing_id)
		values (i_PROCEDURE_ID,  
						i_drawing_ID);
	else
		update blood_donations 
			set procedure_id = i_procedure_id,
					drawing_id = i_drawing_ID
			where donation_id = i_DONATION_ID;
	end if;
end//

delimiter ;


use freedbtech_dbad;
delimiter //
create procedure proc_get_blood_donations
(
	in i_donation_id int(10)
)
begin
	select * from blood_donations t
	where (i_donation_id is null or t.donation_id = i_donation_id);
end//

delimiter ;