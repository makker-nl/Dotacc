--------------------------------------------------------
--  File created - Thursday-October-09-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table XXX_TABLES
--------------------------------------------------------

  CREATE TABLE "XXX_TABLES" 
   (	"TABLE_OWNER" VARCHAR2(30 BYTE), 
	"TABLE_NAME" VARCHAR2(30 BYTE), 
  "SHORT_NAME" VARCHAR2(30 BYTE),
	"GENERATION_ORDER" NUMBER(4,0), 
	"IND_EXCLUDE_COLL" VARCHAR2(1 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING;
--------------------------------------------------------
--  DDL for Index XXX_TAB_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "XXX_TAB_PK" ON "XXX_TABLES" ("TABLE_OWNER", "TABLE_NAME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index XXX_TAB_UK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "XXX_TAB_UK1" ON "XXX_TABLES" ("GENERATION_ORDER") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  Constraints for Table XXX_TABLES
--------------------------------------------------------

  ALTER TABLE "XXX_TABLES" ADD CONSTRAINT "XXX_TAB_PK" PRIMARY KEY ("TABLE_OWNER", "TABLE_NAME")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  ENABLE;
  ALTER TABLE "XXX_TABLES" ADD CONSTRAINT "XXX_TAB_CHK1" CHECK (IND_EXCLUDE_COLL IN ('Y', 'N')) ENABLE;
  ALTER TABLE "XXX_TABLES" MODIFY ("IND_EXCLUDE_COLL" NOT NULL ENABLE);
  ALTER TABLE "XXX_TABLES" MODIFY ("TABLE_NAME" NOT NULL ENABLE);
  ALTER TABLE "XXX_TABLES" MODIFY ("TABLE_OWNER" NOT NULL ENABLE);
  ALTER TABLE "XXX_TABLES" MODIFY ("GENERATION_ORDER" NOT NULL ENABLE);
  ALTER TABLE "XXX_TABLES" ADD CONSTRAINT "XXX_TAB_UK1" UNIQUE ("GENERATION_ORDER")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  ENABLE;
