-- --------------------------------------------------------------------------------------------------
-- countries
-- --------------------------------------------------------------------------------------------------
create table countries(
  country_id                      int(10) unsigned    not null auto_increment,
  name                            varchar(250)        not null,
  state                           varchar(1)          not null comment '(a)ctive, (p)assive - default active',
  constraint countries_pk primary key (country_id),
  constraint countries_u1 unique (name)
);

alter table countries add constraint countries_c1 check (state in ('a', 'p'));
alter table countries comment 'list of reference countries in the system';

-- --------------------------------------------------------------------------------------------------
-- regions
-- --------------------------------------------------------------------------------------------------
create table regions(
  region_id                       int(10) unsigned    not null auto_increment,
  name                            varchar(250)        not null,
  country_id                      int(10) unsigned    not null,
  state                           varchar(1)          not null comment '(a)ctive, (p)assive - default active',
  constraint regions_pk primary key (region_id),
  constraint regions_u1 unique (name),
  constraint regions_f1 foreign key (country_id) references countries(country_id) on delete cascade
);

alter table regions add constraint regions_c1 check (state in ('a', 'p'));
alter table regions comment 'list of reference regions in the system';

-- --------------------------------------------------------------------------------------------------
-- persons
-- --------------------------------------------------------------------------------------------------
create table persons(
  person_id                       int(10) unsigned    not null auto_increment,
  first_name                      varchar(250)        not null,
  last_name                       varchar(250)        not null,
  middle_name                     varchar(250),
  passport_number                 varchar(250)        not null,
  date_of_birth                   datetime            not null,
  place_of_birth                  int(10) unsigned    not null,
  gender                          varchar(1)          not null comment '(m)ale, (f)emale',
  region_id                       int(10) unsigned    not null,
  address                         varchar(250)        not null,
  phone                           varchar(250),
  email                           varchar(250),
  constraint persons_pk primary key (person_id),
  constraint persons_u1 unique (first_name, last_name, middle_name),
  constraint persons_u2 unique (passport_number),
  constraint persons_f1 foreign key (place_of_birth) references regions(region_id),
  constraint persons_f2 foreign key (region_id) references regions(region_id)
);

alter table persons add constraint persons_c1 check (gender in ('m', 'f'));
alter table persons comment 'list of reference persons in the system';

-- --------------------------------------------------------------------------------------------------
-- blood groups
-- --------------------------------------------------------------------------------------------------
create table blood_groups(
  blood_group_id                  int(10) unsigned    not null auto_increment,
  name                            varchar(250)        not null,
  constraint blood_groups_pk primary key (blood_group_id),
  constraint blood_groups_u1 unique (name)
);

alter table blood_groups comment 'list of reference blood groups in the system';

-- --------------------------------------------------------------------------------------------------
-- hospitals
-- --------------------------------------------------------------------------------------------------
create table hospitals(
  hospital_id                     int(10) unsigned    not null auto_increment,
  name                            varchar(250)        not null,
  region_id                       int(10) unsigned    not null,
  address                         varchar(250)        not null,
  phone                           varchar(250),
  fax                             varchar(250),
  state                           varchar(1)          not null comment '(a)ctive, (p)assive - default active',
  constraint hospitals_pk primary key (hospital_id),
  constraint hospitals_u1 unique (name),
  constraint hospitals_f1 foreign key (region_id) references regions(region_id)
);

alter table hospitals add constraint hospitals_c1 check (state in ('a', 'p'));
alter table hospitals comment 'list of reference hospitals in the system';

-- --------------------------------------------------------------------------------------------------
-- employees
-- --------------------------------------------------------------------------------------------------
create table employees(
  employee_id                     int(10) unsigned    not null auto_increment,
  person_id                       int(10) unsigned    not null,
  hospital_id                     int(10) unsigned    not null,
  job_title                       varchar(250)        not null,
  start_date                      datetime            not null,
  end_date                        datetime,
  salary                          varchar(250)        not null,
  state                           varchar(1)          not null comment '(a)ctive, (p)assive - default active',
  constraint employees_pk primary key (employee_id),
  constraint employees_f1 foreign key (person_id) references persons(person_id),
  constraint employees_f2 foreign key (hospital_id) references hospitals(hospital_id)
);

alter table employees add constraint employees_c1 check (end_date is null or start_date < end_date);
alter table employees add constraint employees_c2 check (state in ('a', 'p'));
alter table employees comment 'list of reference hospital employees in the system';

-- --------------------------------------------------------------------------------------------------
-- procedure types - 
-- --------------------------------------------------------------------------------------------------
create table procedure_types(
  procedure_type_id               int(10) unsigned    not null auto_increment,
  name                            varchar(250)        not null,
  constraint procedure_types_pk primary key (procedure_type_id),
  constraint procedure_types_u1 unique (name)
);

alter table procedure_types comment 'list of reference procedure types in the system';

-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
create table procedures(
  procedure_id                    int(10) unsigned    not null auto_increment,
  patient_id                      int(10) unsigned    not null,
  hospital_id                     int(10) unsigned    not null,
  procedure_type_id               int(10) unsigned    not null,
  start_time                      datetime(6),
  end_time                        datetime(6),
  status                          varchar(1)          not null comment '(w)aiting, (s)cheduled, on (g)oing, (p)aused, (f)inished',
  constraint procedures_pk primary key (procedure_id),
  constraint procedures_f1 foreign key (patient_id) references persons(person_id),
  constraint procedures_f2 foreign key (hospital_id) references hospitals(hospital_id),
  constraint procedures_f3 foreign key (procedure_type_id) references procedure_types(procedure_type_id)
);

alter table procedures add constraint procedures_c1 check (start_time is null or end_time is null or start_time < end_time);
alter table procedures add constraint procedures_c2 check (status in ('w', 's', 'g', 'p', 'f'));
alter table procedures add constraint procedures_c3 check (start_time is null and status in ('w', 's') or start_time is not null);
alter table procedures add constraint procedures_c4 check (end_time is null and status in ('w', 's', 'g', 'p') or end_time is not null);
alter table procedures comment 'list of curing procedures in the hospital';

-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
create table procedure_doctors(
  procedure_id                    int(10) unsigned    not null,
  doctor_id                       int(10) unsigned    not null,
  doctor_role                     varchar(250)        not null,
  start_time                      datetime(6),
  end_time                        datetime(6),
  status                          varchar(1)          not null comment '(w)aiting, (s)cheduled, on (g)oing, (p)aused, (f)inished',
  constraint procedure_doctors_pk primary key (procedure_id, doctor_id),
  constraint procedure_doctors_f1 foreign key (procedure_id) references procedures(procedure_id),
  constraint procedure_doctors_f2 foreign key (doctor_id) references employees(employee_id)
);

alter table procedure_doctors add constraint procedure_doctors_c1 check (start_time is null or end_time is null or start_time < end_time);
alter table procedure_doctors add constraint procedure_doctors_c2 check (status in ('w', 's', 'g', 'p', 'f'));
alter table procedure_doctors add constraint procedure_doctors_c3 check (start_time is null and status in ('w', 's') or start_time is not null);
alter table procedure_doctors add constraint procedure_doctors_c4 check (end_time is null and status in ('w', 's', 'g', 'p') or end_time is not null);
alter table procedure_doctors comment 'list of curing procedures in the hospital';

-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
create table blood_drawings(
  drawing_id                      int(10) unsigned    not null auto_increment,
  procedure_id                    int(10) unsigned    not null,
  blood_group_id                  int(10) unsigned    not null,
  amount                          int(10) unsigned    not null,
  expiry_date                     datetime            not null,
  status                          varchar(1)          not null comment '(a)vailable, (n)not available, (d)onated, (e)xpired',
  constraint blood_drawings_pk primary key (drawing_id),
  constraint blood_drawings_f1 foreign key (procedure_id) references procedures(procedure_id),
  constraint blood_drawings_f2 foreign key (blood_group_id) references blood_groups(blood_group_id)
);

alter table blood_drawings add constraint blood_drawings_c1 check (status in ('a', 'n', 'd', 'e'));
alter table blood_drawings comment 'blood bank of the hospital';

-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
create table blood_donations(
  donation_id                     int(10) unsigned    not null auto_increment,
  procedure_id                    int(10) unsigned    not null,
  drawing_id                      int(10) unsigned    not null,
  constraint blood_donations_pk primary key (donation_id),
  constraint blood_donations_f1 foreign key (procedure_id) references procedures(procedure_id),
  constraint blood_donations_f2 foreign key (drawing_id) references blood_drawings(drawing_id)
);

alter table blood_drawings comment 'blood donations of the hospital';