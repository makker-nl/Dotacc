--------------------------------------------------------
--  File created - maandag-juni-23-2014   
--------------------------------------------------------
REM INSERTING into XXX_FK_DEFINITIONS
delete from XXX_FK_DEFINITIONS;
SET DEFINE OFF;
-- Naar Personen 
Insert into XXX_FK_DEFINITIONS (FK_NAME,IND_EXCLUDE,IND_EXCLUDE_REFERING,FK_TYPE,LOOKUP_ATTR_NAME,IND_IGNORE_CONSTRUCTOR,IND_IGNORE_INS,IND_IGNORE_TO_XML) values ('BCM_LOGREGELS_LOG_FK','N','N','DETAIL','','N','N','N');
COMMIT;
