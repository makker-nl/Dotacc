CREATE TABLE HBC_ACCOMODATIONS
(
ID NUMBER NOT NULL,
TYPE VARCHAR2(20) NOT NULL,
NAME VARCHAR2(100) NOT NULL,
STARS NUMBER,
RATE_FROM NUMBER,
RATE_TO NUMBER,
NOTES VARCHAR2(4000)
)
;

CREATE TABLE HBC_ADRESSES
(
ID NUMBER NOT NULL,
ADDRESS_LINE1 VARCHAR2(40) NOT NULL,
ADDRESS_LINE2 VARCHAR2(40),
ADDRESS_LINE3 VARCHAR2(40),
POSTAL_CODE VARCHAR2(15),
PLACE VARCHAR2(40) NOT NULL,
COUNTRY VARCHAR2(50) NOT NULL,
AMN_ID NUMBER NOT NULL
)
;

CREATE TABLE HBC_PLACES
(
ID NUMBER NOT NULL,
CODE VARCHAR2(10),
NO_PERSONS NUMBER,
RATE NUMBER,
AMN_ID NUMBER NOT NULL
)
;

CREATE TABLE HBC_PLACE_AVAILABILITIES
(
ID NUMBER NOT NULL,
DATE_FROM DATE NOT NULL,
DATE_TO DATE,
PLC_ID NUMBER NOT NULL
)
;

CREATE TABLE HBC_CUSTOMERS
(
ID NUMBER NOT NULL,
NAME VARCHAR2(40) NOT NULL,
BIRTH_DATE DATE NOT NULL,
GENDER VARCHAR2(1) NOT NULL
)
;

CREATE TABLE HBC_PLACES_BOOKED
(
ID NUMBER NOT NULL,
DATE_FROM DATE NOT NULL,
DATE_TO DATE NOT NULL,
PLC_ID NUMBER NOT NULL,
CMR_ID NUMBER NOT NULL
)
;

ALTER TABLE HBC_ACCOMODATIONS
ADD CONSTRAINT HBC_AMN_PK PRIMARY KEY
(
ID
)
 ENABLE
;

ALTER TABLE HBC_ADRESSES
ADD CONSTRAINT HBC_ADS_PK PRIMARY KEY
(
ID
)
 ENABLE
;

ALTER TABLE HBC_PLACES
ADD CONSTRAINT HBC_PLC_PK PRIMARY KEY
(
ID
)
 ENABLE
;

ALTER TABLE HBC_PLACE_AVAILABILITIES
ADD CONSTRAINT HBC_PAY_PK PRIMARY KEY
(
ID
)
 ENABLE
;

ALTER TABLE HBC_CUSTOMERS
ADD CONSTRAINT HBC_CMR_PK PRIMARY KEY
(
ID
)
 ENABLE
;

ALTER TABLE HBC_ADRESSES
ADD CONSTRAINT HBC_ADS_AMN_FK FOREIGN KEY
(
AMN_ID
)
REFERENCES HBC_ACCOMODATIONS
(
ID
) ENABLE
;

ALTER TABLE HBC_PLACES
ADD CONSTRAINT HBC_PLC_AMN_FK FOREIGN KEY
(
AMN_ID
)
REFERENCES HBC_ACCOMODATIONS
(
ID
) ENABLE
;

ALTER TABLE HBC_PLACE_AVAILABILITIES
ADD CONSTRAINT HBC_PAY_PLC_FK FOREIGN KEY
(
PLC_ID
)
REFERENCES HBC_PLACES
(
ID
) ENABLE
;

ALTER TABLE HBC_PLACES_BOOKED
ADD CONSTRAINT HBC_PBD_PLC_FK FOREIGN KEY
(
PLC_ID
)
REFERENCES HBC_PLACES
(
ID
) ENABLE
;

ALTER TABLE HBC_PLACES_BOOKED
ADD CONSTRAINT HBC_PBD_CMR_FK FOREIGN KEY
(
CMR_ID
)
REFERENCES HBC_CUSTOMERS
(
ID
) ENABLE
;

ALTER TABLE HBC_PLACE_AVAILABILITIES
ADD CONSTRAINT HBC_PAY_CHK1 CHECK
(date_from<=date_to)
 ENABLE
;

ALTER TABLE HBC_CUSTOMERS
ADD CONSTRAINT HBC_CMR_CHK1 CHECK
(gender in ('M','F'))
 ENABLE
;

ALTER TABLE HBC_PLACES_BOOKED
ADD CONSTRAINT HBC_PBD_CHK1 CHECK
(date_from<=date_to)
 ENABLE
;

Prompt Create Trigers
@@hbc_owner_triggers.sql
Prompt Create Sequences
@@hbc_owner_sequences.sql
Prompt Insert Data
@@insert_data.sql