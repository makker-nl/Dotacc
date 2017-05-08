--------------------------------------------------------
--  File created - Thursday-October-09-2014   
--------------------------------------------------------
REM DELETING into XXX_TABLES
delete XXX_TABLES;
REM INSERTING into XXX_TABLES
SET DEFINE OFF;
Insert into XXX_TABLES (TABLE_OWNER,TABLE_NAME,SHORT_NAME, GENERATION_ORDER,IND_EXCLUDE_COLL) values ('APPL_GENERIEK','BCM_LOG','BCMLOG',2,'Y');
Insert into XXX_TABLES (TABLE_OWNER,TABLE_NAME,SHORT_NAME, GENERATION_ORDER,IND_EXCLUDE_COLL) values ('APPL_GENERIEK','BCM_LOG_REGELS','BCMLOGREGELS',1,'N');
commit;
exit
--ZMS_NIET_NATRLK_PERSONEN