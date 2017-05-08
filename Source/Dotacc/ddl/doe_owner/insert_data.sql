prompt PL/SQL Developer import file
prompt Created on Saturday, September 20, 2008 by makker
set feedback off
set define off
prompt Disabling triggers for DOE_ADDRESSES...
alter table DOE_ADDRESSES disable all triggers;
prompt Disabling triggers for DOE_ADDRESS_TYPES...
alter table DOE_ADDRESS_TYPES disable all triggers;
prompt Disabling triggers for DOE_CUSTOMERS...
alter table DOE_CUSTOMERS disable all triggers;
prompt Disabling triggers for DOE_ARRANGEMENTS...
alter table DOE_ARRANGEMENTS disable all triggers;
prompt Disabling triggers for DOE_FUNCTIONS...
alter table DOE_FUNCTIONS disable all triggers;
prompt Disabling triggers for DOE_EMPLOYEES...
alter table DOE_EMPLOYEES disable all triggers;
prompt Disabling triggers for DOE_INSTRUCTOR_AVAILABILITIES...
alter table DOE_INSTRUCTOR_AVAILABILITIES disable all triggers;
prompt Disabling triggers for DOE_MATERIALS...
alter table DOE_MATERIALS disable all triggers;
prompt Disabling triggers for DOE_MATERIAL_AVAILABILITIES...
alter table DOE_MATERIAL_AVAILABILITIES disable all triggers;
prompt Disabling triggers for DOE_ARRANGEMENT_LINES...
alter table DOE_ARRANGEMENT_LINES disable all triggers;
prompt Disabling triggers for DOE_ARRANGEMENT_TYPES...
alter table DOE_ARRANGEMENT_TYPES disable all triggers;
prompt Disabling triggers for DOE_PARTICIPANTS...
alter table DOE_PARTICIPANTS disable all triggers;
prompt Disabling triggers for DOE_PARTY_ADDRESSES...
alter table DOE_PARTY_ADDRESSES disable all triggers;
prompt Disabling foreign key constraints for DOE_ARRANGEMENTS...
alter table DOE_ARRANGEMENTS disable constraint DOE_ART_CMR_FK;
prompt Disabling foreign key constraints for DOE_EMPLOYEES...
alter table DOE_EMPLOYEES disable constraint DOE_EMP_FNC_FK;
prompt Disabling foreign key constraints for DOE_INSTRUCTOR_AVAILABILITIES...
alter table DOE_INSTRUCTOR_AVAILABILITIES disable constraint DOE_IAY_EMP_FK;
prompt Disabling foreign key constraints for DOE_MATERIAL_AVAILABILITIES...
alter table DOE_MATERIAL_AVAILABILITIES disable constraint DOE_MAY_MTL_FK;
prompt Disabling foreign key constraints for DOE_ARRANGEMENT_LINES...
alter table DOE_ARRANGEMENT_LINES disable constraint DOE_ARL_ART_FK;
alter table DOE_ARRANGEMENT_LINES disable constraint DOE_ARL_IAY_FK;
alter table DOE_ARRANGEMENT_LINES disable constraint DOE_ARL_MAY_FK;
prompt Disabling foreign key constraints for DOE_PARTICIPANTS...
alter table DOE_PARTICIPANTS disable constraint DOE_PTP_CMR_FK;
alter table DOE_PARTICIPANTS disable constraint DOE_PTP_PK;
prompt Disabling foreign key constraints for DOE_PARTY_ADDRESSES...
alter table DOE_PARTY_ADDRESSES disable constraint DOE_PAS_ADS_FK;
alter table DOE_PARTY_ADDRESSES disable constraint DOE_PAS_ATE_FK;
alter table DOE_PARTY_ADDRESSES disable constraint DOE_PAS_CMR_FK;
alter table DOE_PARTY_ADDRESSES disable constraint DOE_PAS_EMP_FK;
prompt Deleting DOE_PARTY_ADDRESSES...
delete from DOE_PARTY_ADDRESSES;
commit;
prompt Deleting DOE_PARTICIPANTS...
delete from DOE_PARTICIPANTS;
commit;
prompt Deleting DOE_ARRANGEMENT_TYPES...
delete from DOE_ARRANGEMENT_TYPES;
commit;
prompt Deleting DOE_ARRANGEMENT_LINES...
delete from DOE_ARRANGEMENT_LINES;
commit;
prompt Deleting DOE_MATERIAL_AVAILABILITIES...
delete from DOE_MATERIAL_AVAILABILITIES;
commit;
prompt Deleting DOE_MATERIALS...
delete from DOE_MATERIALS;
commit;
prompt Deleting DOE_INSTRUCTOR_AVAILABILITIES...
delete from DOE_INSTRUCTOR_AVAILABILITIES;
commit;
prompt Deleting DOE_EMPLOYEES...
delete from DOE_EMPLOYEES;
commit;
prompt Deleting DOE_FUNCTIONS...
delete from DOE_FUNCTIONS;
commit;
prompt Deleting DOE_ARRANGEMENTS...
delete from DOE_ARRANGEMENTS;
commit;
prompt Deleting DOE_CUSTOMERS...
delete from DOE_CUSTOMERS;
commit;
prompt Deleting DOE_ADDRESS_TYPES...
delete from DOE_ADDRESS_TYPES;
commit;
prompt Deleting DOE_ADDRESSES...
delete from DOE_ADDRESSES;
commit;
prompt Loading DOE_ADDRESSES...
insert into DOE_ADDRESSES (ID, ADRESS_LINE1, ADRESS_LINE2, ADRESS_LINE3, POSTAL_CODE, CITY, COUNTRY)
values (1, 'Maasstraat 19', null, null, '3812HS', 'Amersfoort', 'NETHERLANDS');
insert into DOE_ADDRESSES (ID, ADRESS_LINE1, ADRESS_LINE2, ADRESS_LINE3, POSTAL_CODE, CITY, COUNTRY)
values (2, 'Rocky Road 2', null, null, '20001 ', 'StoneHench', 'UNITED KINGDOM');
insert into DOE_ADDRESSES (ID, ADRESS_LINE1, ADRESS_LINE2, ADRESS_LINE3, POSTAL_CODE, CITY, COUNTRY)
values (3, 'Hofvijver 12', null, null, '2000XX', 'Den Haag', 'NETHERLANDS');
insert into DOE_ADDRESSES (ID, ADRESS_LINE1, ADRESS_LINE2, ADRESS_LINE3, POSTAL_CODE, CITY, COUNTRY)
values (4, 'Rijnzathe 6', null, null, '3140ZP', 'De Meern', 'NETHERLANDS');
insert into DOE_ADDRESSES (ID, ADRESS_LINE1, ADRESS_LINE2, ADRESS_LINE3, POSTAL_CODE, CITY, COUNTRY)
values (5, 'Erasmusstraat 312', null, null, '1234GK', 'Rotterdam', 'NETHERLANDS');
insert into DOE_ADDRESSES (ID, ADRESS_LINE1, ADRESS_LINE2, ADRESS_LINE3, POSTAL_CODE, CITY, COUNTRY)
values (6, 'Darwinplein 11', null, null, '4321PS', 'Amsterdam', 'NETHERLANDS');
insert into DOE_ADDRESSES (ID, ADRESS_LINE1, ADRESS_LINE2, ADRESS_LINE3, POSTAL_CODE, CITY, COUNTRY)
values (7, 'Newtonweg 41', null, null, '6543AB', 'Maasland', 'NETHERLANDS');
insert into DOE_ADDRESSES (ID, ADRESS_LINE1, ADRESS_LINE2, ADRESS_LINE3, POSTAL_CODE, CITY, COUNTRY)
values (8, 'Docklands 123', null, null, '123234', 'London', 'UNITED KINGDOM');
commit;
prompt 8 records loaded
prompt Loading DOE_ADDRESS_TYPES...
insert into DOE_ADDRESS_TYPES (ID, CODE, DESCRIPTION)
values (1, 'HOME', 'Home address');
insert into DOE_ADDRESS_TYPES (ID, CODE, DESCRIPTION)
values (2, 'WORK', 'Work address');
insert into DOE_ADDRESS_TYPES (ID, CODE, DESCRIPTION)
values (3, 'HOLIDAY', 'Address to reach when on holiday');
commit;
prompt 3 records loaded
prompt Loading DOE_CUSTOMERS...
prompt Table is empty
prompt Loading DOE_ARRANGEMENTSS...
prompt Table is empty
prompt Loading DOE_FUNCTIONS...
insert into DOE_FUNCTIONS (ID, CODE, DESCRIPTION, IND_INSTRUCTOR)
values (1, 'GUIDE', 'Survival Guide', 'Y');
insert into DOE_FUNCTIONS (ID, CODE, DESCRIPTION, IND_INSTRUCTOR)
values (2, 'PILOT', 'Helicopter/Plane pilot', 'N');
insert into DOE_FUNCTIONS (ID, CODE, DESCRIPTION, IND_INSTRUCTOR)
values (3, 'CLIMB', 'Mountain Climbing', 'Y');
insert into DOE_FUNCTIONS (ID, CODE, DESCRIPTION, IND_INSTRUCTOR)
values (4, 'ADMIN', 'Administration', 'N');
insert into DOE_FUNCTIONS (ID, CODE, DESCRIPTION, IND_INSTRUCTOR)
values (5, 'DRIVER', '4WD Driver', 'Y');
insert into DOE_FUNCTIONS (ID, CODE, DESCRIPTION, IND_INSTRUCTOR)
values (6, 'RAFT', 'Canoeing and rafting', 'Y');
insert into DOE_FUNCTIONS (ID, CODE, DESCRIPTION, IND_INSTRUCTOR)
values (7, 'GUIDE', 'Survival Guide', 'Y');
insert into DOE_FUNCTIONS (ID, CODE, DESCRIPTION, IND_INSTRUCTOR)
values (8, 'PILOT', 'Helicopter/Plane pilot', 'N');
insert into DOE_FUNCTIONS (ID, CODE, DESCRIPTION, IND_INSTRUCTOR)
values (9, 'CLIMB', 'Mountain Climbing', 'Y');
insert into DOE_FUNCTIONS (ID, CODE, DESCRIPTION, IND_INSTRUCTOR)
values (10, 'ADMIN', 'Administration', 'N');
insert into DOE_FUNCTIONS (ID, CODE, DESCRIPTION, IND_INSTRUCTOR)
values (11, 'DRIVER', '4WD Driver', 'Y');
insert into DOE_FUNCTIONS (ID, CODE, DESCRIPTION, IND_INSTRUCTOR)
values (12, 'RAFT', 'Canoeing and rafting', 'Y');
commit;
prompt 12 records loaded
prompt Loading DOE_EMPLOYEES...
insert into DOE_EMPLOYEES (ID, TITLE, FIRSTNAME, LAST_NAME, GENDER, BIRTH_DATE, FNC_ID)
values (7, 'Mr.', 'Ed', 'Bushes', 'M', to_date('20-01-1968', 'dd-mm-yyyy'), 1);
insert into DOE_EMPLOYEES (ID, TITLE, FIRSTNAME, LAST_NAME, GENDER, BIRTH_DATE, FNC_ID)
values (8, 'Mr.', 'M.', 'Outback', 'M', to_date('14-10-1961', 'dd-mm-yyyy'), 1);
insert into DOE_EMPLOYEES (ID, TITLE, FIRSTNAME, LAST_NAME, GENDER, BIRTH_DATE, FNC_ID)
values (9, 'Mr.', 'M.', 'Outback', 'M', to_date('14-10-1961', 'dd-mm-yyyy'), 2);
insert into DOE_EMPLOYEES (ID, TITLE, FIRSTNAME, LAST_NAME, GENDER, BIRTH_DATE, FNC_ID)
values (10, 'Ms.', 'Pat', 'Darwin', 'F', to_date('14-03-1980', 'dd-mm-yyyy'), 4);
insert into DOE_EMPLOYEES (ID, TITLE, FIRSTNAME, LAST_NAME, GENDER, BIRTH_DATE, FNC_ID)
values (11, 'Mr.', 'T.', 'Barakus', 'M', to_date('11-02-1970', 'dd-mm-yyyy'), 5);
insert into DOE_EMPLOYEES (ID, TITLE, FIRSTNAME, LAST_NAME, GENDER, BIRTH_DATE, FNC_ID)
values (12, 'Ms.', 'Debby', 'Waters', 'F', to_date('20-01-1982', 'dd-mm-yyyy'), 6);
insert into DOE_EMPLOYEES (ID, TITLE, FIRSTNAME, LAST_NAME, GENDER, BIRTH_DATE, FNC_ID)
values (13, 'Mr.', 'Wally', 'Waters', 'M', to_date('13-06-1963', 'dd-mm-yyyy'), 1);
commit;
prompt 7 records loaded
prompt Loading DOE_INSTRUCTOR_AVAILABILITIES...
insert into DOE_INSTRUCTOR_AVAILABILITIES (ID, START_DATE, END_DATE, EMP_ID, DAYLY_RATE)
values (7, to_date('01-01-2008', 'dd-mm-yyyy'), null, 7, 500);
insert into DOE_INSTRUCTOR_AVAILABILITIES (ID, START_DATE, END_DATE, EMP_ID, DAYLY_RATE)
values (8, to_date('01-01-2008', 'dd-mm-yyyy'), null, 8, 500);
insert into DOE_INSTRUCTOR_AVAILABILITIES (ID, START_DATE, END_DATE, EMP_ID, DAYLY_RATE)
values (9, to_date('01-01-2008', 'dd-mm-yyyy'), null, 9, 1000);
insert into DOE_INSTRUCTOR_AVAILABILITIES (ID, START_DATE, END_DATE, EMP_ID, DAYLY_RATE)
values (10, to_date('01-01-2007', 'dd-mm-yyyy'), null, 10, 400);
insert into DOE_INSTRUCTOR_AVAILABILITIES (ID, START_DATE, END_DATE, EMP_ID, DAYLY_RATE)
values (11, to_date('06-01-2008', 'dd-mm-yyyy'), null, 11, 1000);
insert into DOE_INSTRUCTOR_AVAILABILITIES (ID, START_DATE, END_DATE, EMP_ID, DAYLY_RATE)
values (12, to_date('01-01-2008', 'dd-mm-yyyy'), null, 12, 500);
insert into DOE_INSTRUCTOR_AVAILABILITIES (ID, START_DATE, END_DATE, EMP_ID, DAYLY_RATE)
values (13, to_date('01-01-2008', 'dd-mm-yyyy'), null, 13, 800);
commit;
prompt 7 records loaded
prompt Loading DOE_MATERIALS...
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (2, 'BIKE', 'Paradox Male', 25);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (3, 'BIKE', 'Paradox Male', 25);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (4, 'BIKE', 'Paradox Male', 25);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (5, 'BIKE', 'Paradox Male', 25);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (6, 'BIKE', 'Paradox Male', 25);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (7, 'BIKE', 'Paradox Male', 25);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (8, 'BIKE', 'Paradox Male', 25);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (9, 'BIKE', 'Paradox Female', 25);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (10, 'BIKE', 'Paradox Female', 25);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (11, 'BIKE', 'Paradox Female', 25);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (12, 'BIKE', 'Paradox Female', 25);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (13, 'BIKE', 'Paradox Female', 25);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (14, 'BIKE', 'Favorit Junior', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (15, 'BIKE', 'Favorit Junior', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (16, 'BIKE', 'Favorit Junior', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (17, 'BIKE', 'Favorit Junior', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (18, 'BIKE', 'Favorit Junior', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (19, 'BIKE', 'Favorit Junior', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (20, '4WD', 'Toyota Patrol', 450);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (21, '4WD', 'Toyota Patrol w/ Rooftop tent', 550);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (22, 'PLANE', 'Piper Cup 152', 1500);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (23, 'RAFT', '8 pers. Inflatable', 200);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (24, 'CANOE', '2 pers. Unsinkable', 40);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (25, 'CANOE', '2 pers. Unsinkable', 40);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (26, 'CANOE', '2 pers. Unsinkable', 40);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (27, 'CANOE', '2 pers. Unsinkable', 40);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (28, 'CANOE', '2 pers. Unsinkable', 40);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (29, 'CANOE', '2 pers. Unsinkable', 40);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (30, 'CANOE', '2 pers. Unsinkable', 40);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (31, 'CANOE', '2 pers. Unsinkable', 40);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (32, 'CANOE', '2 pers. Unsinkable', 40);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (33, 'CANOE', '1 pers. Kayak', 30);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (34, 'CANOE', '1 pers. Kayak', 30);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (35, 'CANOE', '1 pers. Kayak', 30);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (36, 'CANOE', '1 pers. Kayak', 30);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (37, 'CANOE', '1 pers. Kayak', 30);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (38, 'CANOE', '1 pers. Kayak', 30);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (39, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (40, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (41, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (42, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (43, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (44, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (45, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (46, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (47, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (48, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (49, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (50, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (51, 'HARNESS', 'Climbing harness and ropes', 15);
insert into DOE_MATERIALS (ID, CODE, DESCRIPTION, RATE)
values (52, 'BOAT', 'RIB 400HP', 900);
commit;
prompt 51 records loaded
prompt Loading DOE_MATERIAL_AVAILABILITIES...
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (2, to_date('01-01-2008', 'dd-mm-yyyy'), null, 2);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (3, to_date('01-01-2008', 'dd-mm-yyyy'), null, 3);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (4, to_date('01-01-2008', 'dd-mm-yyyy'), null, 4);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (5, to_date('01-01-2008', 'dd-mm-yyyy'), null, 5);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (6, to_date('01-01-2008', 'dd-mm-yyyy'), null, 6);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (7, to_date('01-01-2008', 'dd-mm-yyyy'), null, 7);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (8, to_date('01-01-2008', 'dd-mm-yyyy'), null, 8);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (9, to_date('01-01-2008', 'dd-mm-yyyy'), null, 9);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (10, to_date('01-01-2008', 'dd-mm-yyyy'), null, 10);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (11, to_date('01-01-2008', 'dd-mm-yyyy'), null, 11);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (12, to_date('01-01-2008', 'dd-mm-yyyy'), null, 12);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (13, to_date('01-01-2008', 'dd-mm-yyyy'), null, 13);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (14, to_date('01-01-2008', 'dd-mm-yyyy'), null, 14);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (15, to_date('01-01-2008', 'dd-mm-yyyy'), null, 15);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (16, to_date('01-01-2008', 'dd-mm-yyyy'), null, 16);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (17, to_date('01-01-2008', 'dd-mm-yyyy'), null, 17);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (18, to_date('01-01-2008', 'dd-mm-yyyy'), null, 18);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (19, to_date('01-01-2008', 'dd-mm-yyyy'), null, 19);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (20, to_date('01-06-2008', 'dd-mm-yyyy'), null, 20);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (21, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 21);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (22, to_date('01-03-2008', 'dd-mm-yyyy'), to_date('01-11-2008', 'dd-mm-yyyy'), 22);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (23, to_date('01-01-2008', 'dd-mm-yyyy'), null, 23);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (24, to_date('01-01-2008', 'dd-mm-yyyy'), null, 24);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (25, to_date('01-01-2008', 'dd-mm-yyyy'), null, 25);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (26, to_date('01-01-2008', 'dd-mm-yyyy'), null, 26);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (27, to_date('01-01-2008', 'dd-mm-yyyy'), null, 27);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (28, to_date('01-01-2008', 'dd-mm-yyyy'), null, 28);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (29, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 29);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (30, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 30);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (31, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 31);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (32, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 32);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (33, to_date('01-01-2008', 'dd-mm-yyyy'), null, 33);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (34, to_date('01-01-2008', 'dd-mm-yyyy'), null, 34);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (35, to_date('01-01-2008', 'dd-mm-yyyy'), null, 35);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (36, to_date('01-01-2008', 'dd-mm-yyyy'), null, 36);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (37, to_date('01-01-2008', 'dd-mm-yyyy'), null, 37);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (38, to_date('01-01-2008', 'dd-mm-yyyy'), null, 38);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (39, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 39);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (40, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 40);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (41, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 41);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (42, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 42);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (43, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 43);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (44, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 44);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (45, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 45);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (46, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 46);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (47, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 47);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (48, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 48);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (49, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 49);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (50, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 50);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (51, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('01-06-2008', 'dd-mm-yyyy'), 51);
insert into DOE_MATERIAL_AVAILABILITIES (ID, START_DATE, END_DATE, MTL_ID)
values (52, to_date('01-01-2008', 'dd-mm-yyyy'), null, 52);
commit;
prompt 51 records loaded
prompt Loading DOE_ARRANGEMENT_LINES...
prompt Table is empty
prompt Loading DOE_ARRANGEMENT_TYPES...
insert into DOE_ARRANGEMENT_TYPES (ID, NAME, DESCRIPTION)
values (1, 'Wildwater Adventure', null);
insert into DOE_ARRANGEMENT_TYPES (ID, NAME, DESCRIPTION)
values (2, 'Helicopter Safari', null);
insert into DOE_ARRANGEMENT_TYPES (ID, NAME, DESCRIPTION)
values (3, '4WD Safari', null);
insert into DOE_ARRANGEMENT_TYPES (ID, NAME, DESCRIPTION)
values (4, 'Moutain Biking Experience', null);
insert into DOE_ARRANGEMENT_TYPES (ID, NAME, DESCRIPTION)
values (5, 'Camelback Desert Exploration', null);
insert into DOE_ARRANGEMENT_TYPES (ID, NAME, DESCRIPTION)
values (6, 'Deep See fishing trip', null);
insert into DOE_ARRANGEMENT_TYPES (ID, NAME, DESCRIPTION)
values (7, 'Outback Trail (1 day)', null);
insert into DOE_ARRANGEMENT_TYPES (ID, NAME, DESCRIPTION)
values (8, 'Outback Trail (2 days)', null);
insert into DOE_ARRANGEMENT_TYPES (ID, NAME, DESCRIPTION)
values (9, 'Outback Trail (3 days)', null);
insert into DOE_ARRANGEMENT_TYPES (ID, NAME, DESCRIPTION)
values (10, 'Darwin to Adelaide Tour (5 days)', null);
insert into DOE_ARRANGEMENT_TYPES (ID, NAME, DESCRIPTION)
values (11, 'Custom', null);
commit;
prompt 11 records loaded
prompt Loading DOE_PARTICIPANTS...
prompt Table is empty
prompt Loading DOE_PARTY_ADDRESSES...
insert into DOE_PARTY_ADDRESSES (ID, START_DATE, END_DATE, CMR_ID, EMP_ID, ADS_ID, ATE_ID)
values (1, to_date('01-07-2007', 'dd-mm-yyyy'), null, null, 7, 1, 1);
insert into DOE_PARTY_ADDRESSES (ID, START_DATE, END_DATE, CMR_ID, EMP_ID, ADS_ID, ATE_ID)
values (2, to_date('01-01-2007', 'dd-mm-yyyy'), null, null, 8, 2, 1);
insert into DOE_PARTY_ADDRESSES (ID, START_DATE, END_DATE, CMR_ID, EMP_ID, ADS_ID, ATE_ID)
values (3, to_date('01-07-2006', 'dd-mm-yyyy'), null, null, 9, 3, 1);
insert into DOE_PARTY_ADDRESSES (ID, START_DATE, END_DATE, CMR_ID, EMP_ID, ADS_ID, ATE_ID)
values (4, to_date('01-01-2006', 'dd-mm-yyyy'), null, null, 10, 4, 1);
insert into DOE_PARTY_ADDRESSES (ID, START_DATE, END_DATE, CMR_ID, EMP_ID, ADS_ID, ATE_ID)
values (5, to_date('01-07-2005', 'dd-mm-yyyy'), null, null, 11, 5, 1);
insert into DOE_PARTY_ADDRESSES (ID, START_DATE, END_DATE, CMR_ID, EMP_ID, ADS_ID, ATE_ID)
values (6, to_date('01-01-2005', 'dd-mm-yyyy'), null, null, 12, 6, 2);
insert into DOE_PARTY_ADDRESSES (ID, START_DATE, END_DATE, CMR_ID, EMP_ID, ADS_ID, ATE_ID)
values (7, to_date('01-07-2004', 'dd-mm-yyyy'), null, null, 12, 7, 1);
commit;
prompt 7 records loaded
prompt Enabling foreign key constraints for DOE_ARRANGEMENTS...
alter table DOE_ARRANGEMENTS enable constraint DOE_ART_CMR_FK;
prompt Enabling foreign key constraints for DOE_EMPLOYEES...
alter table DOE_EMPLOYEES enable constraint DOE_EMP_FNC_FK;
prompt Enabling foreign key constraints for DOE_INSTRUCTOR_AVAILABILITIES...
alter table DOE_INSTRUCTOR_AVAILABILITIES enable constraint DOE_IAY_EMP_FK;
prompt Enabling foreign key constraints for DOE_MATERIAL_AVAILABILITIES...
alter table DOE_MATERIAL_AVAILABILITIES enable constraint DOE_MAY_MTL_FK;
prompt Enabling foreign key constraints for DOE_ARRANGEMENT_LINES...
alter table DOE_ARRANGEMENT_LINES enable constraint DOE_ARL_ART_FK;
alter table DOE_ARRANGEMENT_LINES enable constraint DOE_ARL_IAY_FK;
alter table DOE_ARRANGEMENT_LINES enable constraint DOE_ARL_MAY_FK;
prompt Enabling foreign key constraints for DOE_PARTICIPANTS...
alter table DOE_PARTICIPANTS enable constraint DOE_PTP_CMR_FK;
alter table DOE_PARTICIPANTS enable constraint DOE_PTP_PK;
prompt Enabling foreign key constraints for DOE_PARTY_ADDRESSES...
alter table DOE_PARTY_ADDRESSES enable constraint DOE_PAS_ADS_FK;
alter table DOE_PARTY_ADDRESSES enable constraint DOE_PAS_ATE_FK;
alter table DOE_PARTY_ADDRESSES enable constraint DOE_PAS_CMR_FK;
alter table DOE_PARTY_ADDRESSES enable constraint DOE_PAS_EMP_FK;
prompt Enabling triggers for DOE_ADDRESSES...
alter table DOE_ADDRESSES enable all triggers;
prompt Enabling triggers for DOE_ADDRESS_TYPES...
alter table DOE_ADDRESS_TYPES enable all triggers;
prompt Enabling triggers for DOE_CUSTOMERS...
alter table DOE_CUSTOMERS enable all triggers;
prompt Enabling triggers for DOE_ARRANGEMENTS...
alter table DOE_ARRANGEMENTS enable all triggers;
prompt Enabling triggers for DOE_FUNCTIONS...
alter table DOE_FUNCTIONS enable all triggers;
prompt Enabling triggers for DOE_EMPLOYEES...
alter table DOE_EMPLOYEES enable all triggers;
prompt Enabling triggers for DOE_INSTRUCTOR_AVAILABILITIES...
alter table DOE_INSTRUCTOR_AVAILABILITIES enable all triggers;
prompt Enabling triggers for DOE_MATERIALS...
alter table DOE_MATERIALS enable all triggers;
prompt Enabling triggers for DOE_MATERIAL_AVAILABILITIES...
alter table DOE_MATERIAL_AVAILABILITIES enable all triggers;
prompt Enabling triggers for DOE_ARRANGEMENT_LINES...
alter table DOE_ARRANGEMENT_LINES enable all triggers;
prompt Enabling triggers for DOE_ARRANGEMENT_TYPES...
alter table DOE_ARRANGEMENT_TYPES enable all triggers;
prompt Enabling triggers for DOE_PARTICIPANTS...
alter table DOE_PARTICIPANTS enable all triggers;
prompt Enabling triggers for DOE_PARTY_ADDRESSES...
alter table DOE_PARTY_ADDRESSES enable all triggers;
set feedback on
set define on
prompt Done.
