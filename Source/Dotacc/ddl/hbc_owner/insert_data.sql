prompt PL/SQL Developer import file
prompt Created on Friday, September 19, 2008 by makker
set feedback off
set define off
prompt Disabling triggers for HBC_ACCOMODATIONS...
alter table HBC_ACCOMODATIONS disable all triggers;
prompt Disabling triggers for HBC_ADRESSES...
alter table HBC_ADRESSES disable all triggers;
prompt Disabling triggers for HBC_CUSTOMERS...
alter table HBC_CUSTOMERS disable all triggers;
prompt Disabling triggers for HBC_PLACES...
alter table HBC_PLACES disable all triggers;
prompt Disabling triggers for HBC_PLACES_BOOKED...
alter table HBC_PLACES_BOOKED disable all triggers;
prompt Disabling triggers for HBC_PLACE_AVAILABILITIES...
alter table HBC_PLACE_AVAILABILITIES disable all triggers;
prompt Disabling foreign key constraints for HBC_ADRESSES...
alter table HBC_ADRESSES disable constraint HBC_ADS_amn_FK;
prompt Disabling foreign key constraints for HBC_PLACES...
alter table HBC_PLACES disable constraint HBC_Plc_amn_FK;
prompt Disabling foreign key constraints for HBC_PLACES_BOOKED...
alter table HBC_PLACES_BOOKED disable constraint HBC_Pbd_plc_FK;
prompt Disabling foreign key constraints for HBC_PLACE_AVAILABILITIES...
alter table HBC_PLACE_AVAILABILITIES disable constraint HBC_Pay_plc_FK;
prompt Deleting HBC_PLACE_AVAILABILITIES...
delete from HBC_PLACE_AVAILABILITIES;
commit;
prompt Deleting HBC_PLACES_BOOKED...
delete from HBC_PLACES_BOOKED;
commit;
prompt Deleting HBC_PLACES...
delete from HBC_PLACES;
commit;
prompt Deleting HBC_CUSTOMERS...
delete from HBC_CUSTOMERS;
commit;
prompt Deleting HBC_ADRESSES...
delete from HBC_ADRESSES;
commit;
prompt Deleting HBC_ACCOMODATIONS...
delete from HBC_ACCOMODATIONS;
commit;
prompt Loading HBC_ACCOMODATIONS...
insert into HBC_ACCOMODATIONS (ID, TYPE, NAME, STARS, RATE_FROM, RATE_TO, NOTES)
values (1, 'Hotel', 'Bamurru Plains', 5, 898, 1345, 'Bamurru Plains provides an exclusive wildlife experience on the magnificent Mary River floodplains, just two and half hours from Darwin.');
insert into HBC_ACCOMODATIONS (ID, TYPE, NAME, STARS, RATE_FROM, RATE_TO, NOTES)
values (2, 'Camping', 'Corroboree Park Tavern', 2, 10, 80, 'The Corroboree Park Tavern is situated on the Arnhem Highway, just two hours drive from the World Heritage-listed Kakadu National Park. Set amongst 20 acres of parkland with motel rooms and a dormitory style bunkhouse.');
insert into HBC_ACCOMODATIONS (ID, TYPE, NAME, STARS, RATE_FROM, RATE_TO, NOTES)
values (3, 'Camping', 'Tumbling Waters Holiday Park', 2, 18, 110, 'Less than 40 minutes from Darwin lies a hidden tropical oasis as close to paradise as you are likely to find. Nestled amongst thousands of palms and beautiful tropical gardens, this unique park offers something for everybody.');
insert into HBC_ACCOMODATIONS (ID, TYPE, NAME, STARS, RATE_FROM, RATE_TO, NOTES)
values (4, 'Hotel', 'Carmor Plains Wildlife Reserve', 3, 175, 390, 'Carmor Plains Wildlife Reserve is 100,000 acres of coastal wetlands and forests, located 210 kilometres southeast of Darwin. The reserve is a photographer�s paradise where wildlife such as crocodiles and kangaroos.');
insert into HBC_ACCOMODATIONS (ID, TYPE, NAME, STARS, RATE_FROM, RATE_TO, NOTES)
values (5, 'Hotel', 'Bullo River Station', 4, 750, 750, 'If you�ve always wanted to stay on a working cattle station and experience Australia�s incredible Top End and Kimberley landscape, the iconic property of Bullo River Station provides the quintessential outback experience.');
commit;
prompt 5 records loaded
prompt Loading HBC_ADRESSES...
insert into HBC_ADRESSES (ID, ADDRESS_LINE1, ADDRESS_LINE2, ADDRESS_LINE3, POSTAL_CODE, PLACE, COUNTRY, AMN_ID)
values (1, 'MetropolePlaca 12', null, null, '10300', 'Bamurru', 'AUSTRAILIA', 1);
insert into HBC_ADRESSES (ID, ADDRESS_LINE1, ADDRESS_LINE2, ADDRESS_LINE3, POSTAL_CODE, PLACE, COUNTRY, AMN_ID)
values (2, 'Parkroad 21', null, null, '30501', 'Corroboree Park', 'AUSTRAILIA', 2);
insert into HBC_ADRESSES (ID, ADDRESS_LINE1, ADDRESS_LINE2, ADDRESS_LINE3, POSTAL_CODE, PLACE, COUNTRY, AMN_ID)
values (3, 'WaterHeight 43', null, null, '20134', 'Tumbling Creek', 'AUSTRAILIA', 3);
insert into HBC_ADRESSES (ID, ADDRESS_LINE1, ADDRESS_LINE2, ADDRESS_LINE3, POSTAL_CODE, PLACE, COUNTRY, AMN_ID)
values (4, 'Carmor Avenue 1', null, null, '12491', 'Carmor Plains', 'AUSTRAILIA', 4);
insert into HBC_ADRESSES (ID, ADDRESS_LINE1, ADDRESS_LINE2, ADDRESS_LINE3, POSTAL_CODE, PLACE, COUNTRY, AMN_ID)
values (5, 'RiverWild 2', null, null, '31333', 'BulloSprings', 'AUSTRAILIA', 5);
commit;
prompt 5 records loaded
prompt Loading HBC_CUSTOMERS...
prompt Table is empty
prompt Loading HBC_PLACES...
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (136, 2, 898, 1, '1');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (137, 2, 898, 1, '2');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (138, 2, 898, 1, '3');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (139, 2, 898, 1, '4');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (140, 2, 898, 1, '5');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (141, 2, 898, 1, '6');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (142, 2, 898, 1, '7');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (143, 2, 898, 1, '8');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (144, 2, 898, 1, '9');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (145, 2, 898, 1, '10');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (146, 2, 898, 1, '11');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (147, 2, 898, 1, '12');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (148, 2, 1125, 1, '101');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (149, 2, 1125, 1, '102');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (150, 2, 1125, 1, '103');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (151, 2, 1125, 1, '104');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (152, 2, 1125, 1, '105');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (153, 2, 1125, 1, '106');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (154, 2, 1125, 1, '107');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (155, 2, 1125, 1, '108');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (156, 2, 1125, 1, '109');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (157, 2, 1125, 1, '110');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (158, 2, 1125, 1, '111');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (159, 2, 1125, 1, '112');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (160, 2, 1125, 1, '113');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (161, 2, 1125, 1, '114');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (162, 2, 1125, 1, '201');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (163, 2, 1345, 1, '202');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (164, 2, 1345, 1, '203');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (165, 2, 1345, 1, '204');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (166, 2, 1345, 1, '205');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (167, 2, 1345, 1, '206');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (168, 2, 1345, 1, '207');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (169, 2, 1345, 1, '208');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (170, 2, 1345, 1, '209');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (171, 2, 1345, 1, '210');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (172, 2, 1345, 1, '211');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (173, 2, 1345, 1, '212');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (174, 2, 1345, 1, '213');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (175, 2, 1345, 1, '214');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (176, 2, 10, 2, '1');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (177, 2, 10, 2, '2');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (178, 2, 10, 2, '3');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (179, 2, 10, 2, '4');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (180, 2, 10, 2, '5');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (181, 2, 10, 2, '6');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (182, 2, 10, 2, '7');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (183, 2, 10, 2, '8');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (184, 2, 10, 2, '9');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (185, 2, 10, 2, '10');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (186, 4, 35, 2, '11');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (187, 4, 35, 2, '12');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (188, 4, 35, 2, '13');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (189, 4, 35, 2, '14');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (190, 4, 35, 2, '15');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (191, 4, 35, 2, '16');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (192, 4, 35, 2, '17');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (193, 4, 35, 2, '18');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (194, 4, 35, 2, '19');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (195, 4, 35, 2, '20');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (196, 8, 65, 2, '21');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (197, 8, 65, 2, '22');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (198, 8, 65, 2, '23');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (199, 8, 65, 2, '24');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (200, 8, 65, 2, '25');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (201, 8, 65, 2, '26');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (202, 8, 65, 2, '27');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (203, 8, 65, 2, '28');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (204, 8, 65, 2, '29');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (205, 8, 65, 2, '30');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (206, 10, 80, 2, '31');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (207, 10, 80, 2, '32');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (208, 10, 80, 2, '33');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (209, 10, 80, 2, '34');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (210, 10, 80, 2, '35');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (211, 10, 80, 2, '36');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (212, 10, 80, 2, '37');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (213, 10, 80, 2, '38');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (214, 10, 80, 2, '39');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (215, 10, 80, 2, '40');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (216, 2, 18, 3, '1');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (217, 2, 18, 3, '2');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (218, 2, 18, 3, '3');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (219, 2, 18, 3, '4');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (220, 2, 18, 3, '5');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (221, 2, 18, 3, '6');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (222, 2, 18, 3, '7');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (223, 2, 18, 3, '8');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (224, 2, 18, 3, '9');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (225, 2, 18, 3, '10');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (226, 4, 45, 3, '11');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (227, 4, 45, 3, '12');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (228, 4, 45, 3, '13');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (229, 4, 45, 3, '14');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (230, 4, 45, 3, '15');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (231, 4, 45, 3, '16');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (232, 4, 45, 3, '17');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (233, 4, 45, 3, '18');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (234, 4, 45, 3, '19');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (235, 4, 45, 3, '20');
commit;
prompt 100 records committed...
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (236, 4, 45, 3, '21');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (237, 4, 45, 3, '22');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (238, 4, 45, 3, '23');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (239, 4, 45, 3, '24');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (240, 4, 45, 3, '25');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (241, 4, 45, 3, '26');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (242, 8, 82, 3, '27');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (243, 8, 82, 3, '28');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (244, 8, 82, 3, '29');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (245, 8, 82, 3, '30');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (246, 8, 82, 3, '31');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (247, 8, 82, 3, '32');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (248, 8, 82, 3, '33');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (249, 8, 82, 3, '34');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (250, 8, 82, 3, '35');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (251, 8, 82, 3, '36');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (252, 8, 82, 3, '37');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (253, 8, 82, 3, '38');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (254, 8, 82, 3, '39');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (255, 8, 82, 3, '40');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (256, 8, 82, 3, '41');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (257, 8, 82, 3, '42');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (258, 8, 82, 3, '43');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (259, 12, 110, 3, '44');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (260, 12, 110, 3, '45');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (261, 12, 110, 3, '46');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (262, 12, 110, 3, '47');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (263, 12, 110, 3, '48');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (264, 12, 110, 3, '49');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (265, 12, 110, 3, '50');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (266, 12, 110, 3, '51');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (267, 12, 110, 3, '52');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (268, 12, 110, 3, '53');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (269, 2, 175, 4, '1');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (270, 2, 175, 4, '2');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (271, 2, 175, 4, '3');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (272, 2, 175, 4, '4');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (273, 2, 175, 4, '5');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (274, 2, 175, 4, '6');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (275, 2, 175, 4, '7');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (276, 2, 175, 4, '8');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (277, 2, 175, 4, '9');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (278, 2, 175, 4, '10');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (279, 2, 175, 4, '11');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (280, 2, 175, 4, '12');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (281, 2, 245, 4, '101');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (282, 2, 245, 4, '102');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (283, 2, 245, 4, '103');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (284, 2, 245, 4, '104');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (285, 2, 245, 4, '105');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (286, 2, 245, 4, '106');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (287, 2, 245, 4, '107');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (288, 2, 245, 4, '108');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (289, 2, 245, 4, '109');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (290, 2, 245, 4, '110');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (291, 2, 245, 4, '111');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (292, 2, 245, 4, '112');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (293, 2, 245, 4, '113');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (294, 2, 315, 4, '114');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (295, 2, 315, 4, '201');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (296, 2, 315, 4, '202');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (297, 2, 315, 4, '203');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (298, 2, 315, 4, '204');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (299, 2, 315, 4, '205');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (300, 2, 315, 4, '206');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (301, 2, 315, 4, '207');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (302, 2, 315, 4, '208');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (303, 2, 315, 4, '209');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (304, 2, 315, 4, '210');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (305, 2, 315, 4, '211');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (306, 2, 315, 4, '212');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (307, 2, 315, 4, '213');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (308, 2, 315, 4, '214');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (309, 2, 390, 4, '301');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (310, 2, 390, 4, '302');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (311, 2, 390, 4, '303');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (312, 2, 390, 4, '304');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (313, 2, 390, 4, '305');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (314, 2, 390, 4, '306');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (315, 2, 390, 4, '307');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (316, 2, 390, 4, '308');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (317, 2, 390, 4, '309');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (318, 2, 390, 4, '310');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (319, 2, 390, 4, '311');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (320, 2, 390, 4, '312');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (321, 2, 390, 4, '313');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (322, 2, 390, 4, '314');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (323, 2, 390, 4, '315');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (324, 2, 750, 5, '1');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (325, 2, 750, 5, '2');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (326, 2, 750, 5, '3');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (327, 2, 750, 5, '4');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (328, 2, 750, 5, '5');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (329, 2, 750, 5, '6');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (330, 2, 750, 5, '7');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (331, 2, 750, 5, '8');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (332, 2, 750, 5, '9');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (333, 2, 750, 5, '10');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (334, 2, 750, 5, '11');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (335, 2, 750, 5, '12');
commit;
prompt 200 records committed...
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (336, 2, 750, 5, '101');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (337, 2, 750, 5, '102');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (338, 2, 750, 5, '103');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (339, 2, 750, 5, '104');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (340, 2, 750, 5, '105');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (341, 2, 750, 5, '106');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (342, 2, 750, 5, '107');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (343, 2, 750, 5, '108');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (344, 2, 750, 5, '109');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (345, 2, 750, 5, '110');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (346, 2, 750, 5, '111');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (347, 2, 750, 5, '112');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (348, 2, 750, 5, '113');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (349, 2, 750, 5, '114');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (350, 2, 750, 5, '201');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (351, 2, 750, 5, '202');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (352, 2, 750, 5, '203');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (353, 2, 750, 5, '204');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (354, 2, 750, 5, '205');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (355, 2, 750, 5, '206');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (356, 2, 750, 5, '207');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (357, 2, 750, 5, '208');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (358, 2, 750, 5, '209');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (359, 2, 750, 5, '210');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (360, 2, 750, 5, '211');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (361, 2, 750, 5, '212');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (362, 2, 750, 5, '213');
insert into HBC_PLACES (ID, NO_PERSONS, RATE, AMN_ID, CODE)
values (363, 2, 750, 5, '214');
commit;
prompt 228 records loaded
prompt Loading HBC_PLACES_BOOKED...
prompt Table is empty
prompt Loading HBC_PLACE_AVAILABILITIES...
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (30, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 136);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (31, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 137);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (32, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 138);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (33, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 139);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (34, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 140);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (35, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 141);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (36, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 142);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (37, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 143);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (38, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 144);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (39, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 145);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (40, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 146);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (41, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 147);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (42, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 148);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (43, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 149);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (44, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 150);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (45, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 151);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (46, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 152);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (47, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 153);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (48, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 154);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (49, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 155);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (50, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 156);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (51, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 157);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (52, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 158);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (53, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 159);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (54, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 160);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (55, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 161);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (56, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 162);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (57, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 163);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (58, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 164);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (59, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 165);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (60, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 166);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (61, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 167);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (62, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 168);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (63, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 169);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (64, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 170);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (65, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 171);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (66, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 172);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (67, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 173);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (68, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 174);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (69, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 175);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (70, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 176);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (71, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 177);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (72, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 178);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (73, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 179);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (74, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 180);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (75, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 181);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (76, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 182);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (77, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 183);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (78, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 184);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (79, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 185);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (80, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 186);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (81, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 187);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (82, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 188);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (83, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 189);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (84, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 190);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (85, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 191);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (86, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 192);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (87, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 193);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (88, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 194);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (89, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 195);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (90, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 196);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (91, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 197);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (92, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 198);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (93, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 199);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (94, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 200);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (95, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 201);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (96, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 202);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (97, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 203);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (98, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 204);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (99, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 205);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (100, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 206);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (101, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 207);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (102, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 208);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (103, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 209);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (104, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 210);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (105, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 211);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (106, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 212);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (107, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 213);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (108, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 214);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (109, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 215);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (110, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 216);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (111, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 217);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (112, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 218);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (113, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 219);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (114, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 220);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (115, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 221);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (116, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 222);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (117, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 223);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (118, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 224);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (119, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 225);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (120, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 226);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (121, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 227);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (122, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 228);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (123, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 229);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (124, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 230);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (125, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 231);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (126, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 232);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (127, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 233);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (128, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 234);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (129, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 235);
commit;
prompt 100 records committed...
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (130, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 236);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (131, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 237);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (132, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 238);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (133, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 239);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (134, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 240);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (135, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 241);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (136, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 242);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (137, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 243);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (138, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 244);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (139, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 245);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (140, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 246);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (141, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 247);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (142, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 248);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (143, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 249);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (144, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 250);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (145, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 251);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (146, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 252);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (147, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 253);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (148, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 254);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (149, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 255);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (150, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 256);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (151, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 257);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (152, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 258);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (153, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 259);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (154, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 260);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (155, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 261);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (156, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 262);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (157, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 263);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (158, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 264);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (159, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 265);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (160, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 266);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (161, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 267);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (162, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 268);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (163, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 269);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (164, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 270);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (165, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 271);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (166, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 272);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (167, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 273);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (168, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 274);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (169, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 275);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (170, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 276);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (171, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 277);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (172, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 278);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (173, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 279);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (174, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 280);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (175, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 281);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (176, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 282);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (177, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 283);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (178, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 284);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (179, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 285);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (180, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 286);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (181, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 287);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (182, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 288);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (183, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 289);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (184, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 290);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (185, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 291);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (186, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 292);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (187, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 293);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (188, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 294);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (189, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 295);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (190, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 296);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (191, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 297);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (192, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 298);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (193, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 299);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (194, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 300);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (195, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 301);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (196, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 302);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (197, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 303);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (198, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 304);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (199, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 305);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (200, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 306);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (201, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 307);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (202, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 308);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (203, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 309);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (204, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 310);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (205, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 311);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (206, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 312);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (207, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 313);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (208, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 314);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (209, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 315);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (210, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 316);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (211, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 317);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (212, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 318);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (213, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 319);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (214, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 320);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (215, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 321);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (216, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 322);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (217, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 323);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (218, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 324);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (219, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 325);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (220, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 326);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (221, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 327);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (222, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 328);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (223, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 329);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (224, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 330);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (225, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 331);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (226, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 332);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (227, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 333);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (228, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 334);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (229, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 335);
commit;
prompt 200 records committed...
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (230, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 336);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (231, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 337);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (232, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 338);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (233, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 339);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (234, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 340);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (235, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 341);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (236, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 342);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (237, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 343);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (238, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 344);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (239, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 345);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (240, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 346);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (241, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 347);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (242, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 348);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (243, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 349);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (244, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 350);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (245, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 351);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (246, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 352);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (247, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 353);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (248, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 354);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (249, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 355);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (250, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 356);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (251, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 357);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (252, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 358);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (253, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 359);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (254, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 360);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (255, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 361);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (256, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 362);
insert into HBC_PLACE_AVAILABILITIES (ID, DATE_FROM, DATE_TO, PLC_ID)
values (257, to_date('01-01-2008', 'dd-mm-yyyy'), to_date('31-12-2008', 'dd-mm-yyyy'), 363);
commit;
prompt 228 records loaded
prompt Enabling foreign key constraints for HBC_ADRESSES...
alter table HBC_ADRESSES enable constraint HBC_ADS_amn_FK;
prompt Enabling foreign key constraints for HBC_PLACES...
alter table HBC_PLACES enable constraint HBC_Plc_amn_FK;
prompt Enabling foreign key constraints for HBC_PLACES_BOOKED...
alter table HBC_PLACES_BOOKED enable constraint HBC_Pbd_plc_FK;
prompt Enabling foreign key constraints for HBC_PLACE_AVAILABILITIES...
alter table HBC_PLACE_AVAILABILITIES enable constraint HBC_Pay_plc_FK;
prompt Enabling triggers for HBC_ACCOMODATIONS...
alter table HBC_ACCOMODATIONS enable all triggers;
prompt Enabling triggers for HBC_ADRESSES...
alter table HBC_ADRESSES enable all triggers;
prompt Enabling triggers for HBC_CUSTOMERS...
alter table HBC_CUSTOMERS enable all triggers;
prompt Enabling triggers for HBC_PLACES...
alter table HBC_PLACES enable all triggers;
prompt Enabling triggers for HBC_PLACES_BOOKED...
alter table HBC_PLACES_BOOKED enable all triggers;
prompt Enabling triggers for HBC_PLACE_AVAILABILITIES...
alter table HBC_PLACE_AVAILABILITIES enable all triggers;
set feedback on
set define on
prompt Done.
