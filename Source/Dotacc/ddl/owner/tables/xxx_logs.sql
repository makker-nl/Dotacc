--------------------------------------------------------
--  File created - donderdag-augustus-21-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table XXX_LOGS
--------------------------------------------------------
  CREATE TABLE "XXX_LOGS" 
   (	"ID" NUMBER(10,0), 
   "MODULE" VARCHAR2(200 CHAR), 
	"TEXT" VARCHAR2(4000 CHAR), 
	"PARAMETER1" VARCHAR2(4000 CHAR), 
	"PARAMETER2" VARCHAR2(4000 CHAR), 
	"PARAMETER3" VARCHAR2(4000 CHAR), 
	"PARAMETER4" VARCHAR2(4000 CHAR), 
	"PARAMETER5" VARCHAR2(4000 CHAR),
	"PARAMETER_CLOB"        CLOB 
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING;
--------------------------------------------------------
--  DDL for Index XXX_LOG_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "XXX_LOG_PK" ON "XXX_LOGS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 ;
--------------------------------------------------------
--  Constraints for Table XXX_LOGS
--------------------------------------------------------

  ALTER TABLE "XXX_LOGS" ADD CONSTRAINT "XXX_LOG_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  ENABLE;
  ALTER TABLE "XXX_LOGS" MODIFY ("TEXT" NOT NULL ENABLE);
  ALTER TABLE "XXX_LOGS" MODIFY ("MODULE" NOT NULL ENABLE);
  ALTER TABLE "XXX_LOGS" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  DDL for Trigger XXX_LOG_BRI
--------------------------------------------------------
CREATE OR REPLACE TRIGGER "XXX_LOG_BRI" 
before insert on xxx_logs 
for each row 
begin
  if :new.id is null then
    select xxx_log_id_seq.nextval
    into :new.id
    from dual;
  end if;
end;
/
ALTER TRIGGER "XXX_LOG_BRI" ENABLE;
