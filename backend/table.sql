create table COUNTRIES(
  COUNTRY_ID                      int(10) unsigned    not null auto_increment,
  NAME                            varchar(250)        not null,
  STATE                           varchar(1)          not null comment '(A)ctive, (P)assive - default Active',
  constraint COUNTRIES_PK primary key (COUNTRY_ID),
  constraint COUNTRIES_U1 unique (NAME)
);

alter table COUNTRIES add constraint COUNTRIES_C1 check (STATE in ('A', 'P'));
alter table COUNTRIES comment 'list of reference countries in the system';


create table REGIONS(
  REGION_ID                       int(10) unsigned    not null auto_increment,
  NAME                            varchar(250)        not null,
  COUNTRY_ID                      int(10) unsigned    not null,
  STATE                           varchar(1)          not null comment '(A)ctive, (P)assive - default Active',
  constraint REGIONS_PK primary key (REGION_ID),
  constraint REGIONS_U1 unique (NAME),
  constraint REGIONS_F1 foreign key (COUNTRY_ID) references COUNTRIES(COUNTRY_ID) on delete cascade
);

alter table REGIONS add constraint REGIONS_C1 check (STATE in ('A', 'P'));
alter table REGIONS comment 'list of reference regions in the system';


create table PERSONS(
  PERSON_ID                       int(10) unsigned    not null auto_increment,
  FIRST_NAME                      varchar(250)        not null,
  LAST_NAME                       varchar(250)        not null,
  MIDDLE_NAME                     varchar(250),
  PASSPORT_NUMBER                 varchar(250)        not null,
  DATE_OF_BIRTH                   datetime            not null,
  PLACE_OF_BIRTH_ID               int(10) unsigned    not null,
  GENDER                          varchar(1)          not null comment '(M)ale, (F)emale',
  REGION_ID                       int(10) unsigned    not null,
  ADDRESS                         varchar(250)        not null,
  PHONE                           varchar(250),
  EMAIL                           varchar(250),
  constraint PERSONS_PK primary key (PERSON_ID),
  constraint PERSONS_U1 unique (FIRST_NAME, LAST_NAME, MIDDLE_NAME),
  constraint PERSONS_U2 unique (PASSPORT_NUMBER),
  constraint PERSONS_F1 foreign key (PLACE_OF_BIRTH_ID) references REGIONS(REGION_ID),
  constraint PERSONS_F2 foreign key (REGION_ID) references REGIONS(REGION_ID)
);

alter table PERSONS add constraint PERSONS_C1 check (GENDER in ('M', 'F'));
alter table PERSONS comment 'list of reference persons in the system';


create table BLOOD_GROUPS(
  BLOOD_GROUP_ID                  int(10) unsigned    not null auto_increment,
  NAME                            varchar(250)        not null,
  constraint BLOOD_GROUPS_PK primary key (BLOOD_GROUP_ID),
  constraint BLOOD_GROUPS_U1 unique (NAME)
);

alter table BLOOD_GROUPS comment 'list of reference blood groups in the system';


create table HOSPITALS(
  HOSPITAL_ID                     int(10) unsigned    not null auto_increment,
  NAME                            varchar(250)        not null,
  REGION_ID                       int(10) unsigned    not null,
  ADDRESS                         varchar(250)        not null,
  PHONE                           varchar(250),
  FAX                             varchar(250),
  STATE                           varchar(1)          not null comment '(A)ctive, (P)assive - default Active',
  constraint HOSPITALS_PK primary key (HOSPITAL_ID),
  constraint HOSPITALS_U1 unique (NAME),
  constraint HOSPITALS_F1 foreign key (REGION_ID) references REGIONS(REGION_ID)
);

alter table HOSPITALS add constraint HOSPITALS_C1 check (STATE in ('A', 'P'));
alter table HOSPITALS comment 'list of reference hospitals in the system';


create table EMPLOYEES(
  EMPLOYEE_ID                     int(10) unsigned    not null auto_increment,
  PERSON_ID                       int(10) unsigned    not null,
  HOSPITAL_ID                     int(10) unsigned    not null,
  JOB_TITLE                       varchar(250)        not null,
  START_DATE                      datetime            not null,
  END_DATE                        datetime,
  SALARY                          varchar(250)        not null,
  STATE                           varchar(1)          not null comment '(A)ctive, (P)assive - default Active',
  constraint EMPLOYEES_PK primary key (EMPLOYEE_ID),
  constraint EMPLOYEES_F1 foreign key (PERSON_ID) references PERSONS(PERSON_ID),
  constraint EMPLOYEES_F2 foreign key (HOSPITAL_ID) references HOSPITALS(HOSPITAL_ID)
);

alter table EMPLOYEES add constraint EMPLOYEES_C1 check (END_DATE is null or START_DATE < END_DATE);
alter table EMPLOYEES add constraint EMPLOYEES_C2 check (STATE in ('A', 'P'));
alter table EMPLOYEES comment 'list of reference hospital employees in the system';


create table PROCEDURE_TYPES(
  PROCEDURE_TYPE_ID               int(10) unsigned    not null auto_increment,
  NAME                            varchar(250)        not null,
  constraint PROCEDURE_TYPES_PK primary key (PROCEDURE_TYPE_ID),
  constraint PROCEDURE_TYPES_U1 unique (NAME)
);

alter table PROCEDURE_TYPES comment 'list of reference procedure types in the system';


create table PROCEDURES(
  PROCEDURE_ID                   int(10) unsigned     not null auto_increment,
  PATIENT_ID                      int(10) unsigned    not null,
  HOSPITAL_ID                     int(10) unsigned    not null,
  PROCEDURE_TYPE_ID               int(10) unsigned    not null,
  START_TIME                      datetime(6),
  END_TIME                        datetime(6),
  STATUS                          varchar(1)          not null comment '(W)aiting, (S)cheduled, on (G)oing, (P)aused, (F)inished',
  constraint PROCEDURES_PK primary key (PROCEDURE_ID),
  constraint PROCEDURES_F1 foreign key (PATIENT_ID) references PERSONS(PERSON_ID),
  constraint PROCEDURES_F2 foreign key (HOSPITAL_ID) references HOSPITALS(HOSPITAL_ID),
  constraint PROCEDURES_F3 foreign key (PROCEDURE_TYPE_ID) references PROCEDURE_TYPES(PROCEDURE_TYPE_ID)
);

alter table PROCEDURES add constraint PROCEDURES_C1 check (START_TIME is null or END_TIME is null or START_TIME < END_TIME);
alter table PROCEDURES add constraint PROCEDURES_C2 check (STATUS in ('W', 'S', 'G', 'P', 'F'));
alter table PROCEDURES add constraint PROCEDURES_C3 check (START_TIME is null and STATUS in ('W', 'S') or START_TIME is not null);
alter table PROCEDURES add constraint PROCEDURES_C4 check (END_TIME is null and STATUS in ('W', 'S', 'G', 'P') or END_TIME is not null);
alter table PROCEDURES comment 'list of curing procedures in the hospital';


create table PROCEDURE_DOCTORS(
  PROCEDURE_ID                    int(10) unsigned    not null,
  DOCTOR_ID                       int(10) unsigned    not null auto_increment,
  DOCTOR_ROLE                     varchar(250)        not null,
  START_TIME                      datetime(6),
  END_TIME                        datetime(6),
  STATUS                          varchar(1)          not null comment '(W)aiting, (S)cheduled, on (G)oing, (P)aused, (F)inished',
  constraint PROCEDURE_DOCTORS_PK primary key (PROCEDURE_ID, DOCTOR_ID),
  constraint PROCEDURE_DOCTORS_F1 foreign key (PROCEDURE_ID) references PROCEDURES(PROCEDURE_ID),
  constraint PROCEDURE_DOCTORS_F2 foreign key (DOCTOR_ID) references EMPLOYEES(EMPLOYEE_ID)
);

alter table PROCEDURE_DOCTORS add constraint PROCEDURE_DOCTORS_C1 check (START_TIME is null or END_TIME is null or START_TIME < END_TIME);
alter table PROCEDURE_DOCTORS add constraint PROCEDURE_DOCTORS_C2 check (STATUS in ('W', 'S', 'G', 'P', 'F'));
alter table PROCEDURE_DOCTORS add constraint PROCEDURE_DOCTORS_C3 check (START_TIME is null and STATUS in ('W', 'S') or START_TIME is not null);
alter table PROCEDURE_DOCTORS add constraint PROCEDURE_DOCTORS_C4 check (END_TIME is null and STATUS in ('W', 'S', 'G', 'P') or END_TIME is not null);
alter table PROCEDURE_DOCTORS comment 'list of curing procedures in the hospital';


create table BLOOD_DRAWINGS(
  DRAWING_ID                      int(10) unsigned    not null auto_increment,
  PROCEDURE_ID                    int(10) unsigned    not null,
  BLOOD_GROUP_ID                  int(10) unsigned    not null,
  AMOUNT                          int(10) unsigned    not null,
  EXPIRY_DATE                     datetime            not null,
  STATUS                          varchar(1)          not null comment '(A)vailable, (N)not available, (D)onated, (E)xpired',
  constraint BLOOD_DRAWINGS_PK primary key (DRAWING_ID),
  constraint BLOOD_DRAWINGS_F1 foreign key (PROCEDURE_ID) references PROCEDURES(PROCEDURE_ID),
  constraint BLOOD_DRAWINGS_F2 foreign key (BLOOD_GROUP_ID) references BLOOD_GROUPS(BLOOD_GROUP_ID)
);

alter table BLOOD_DRAWINGS add constraint BLOOD_DRAWINGS_C1 check (STATUS in ('A', 'N', 'D', 'E'));
alter table BLOOD_DRAWINGS comment 'blood bank of the hospital';


create table BLOOD_DONATIONS(
  DONATION_ID                     int(10) unsigned    not null auto_increment,
  PROCEDURE_ID                    int(10) unsigned    not null,
  DRAWING_ID                      int(10) unsigned    not null,
  constraint BLOOD_DONATIONS_PK primary key (DONATION_ID),
  constraint BLOOD_DONATIONS_F1 foreign key (PROCEDURE_ID) references PROCEDURES(PROCEDURE_ID),
  constraint BLOOD_DONATIONS_F2 foreign key (DRAWING_ID) references BLOOD_DRAWINGS(DRAWING_ID)
);

alter table BLOOD_DONATIONS comment 'blood donations of the hospital';