--------------------------------------------------------
--  File created - donderdag-juni-19-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table XXX_FK_DEFINITIONS
--------------------------------------------------------
  CREATE TABLE XXX_FK_DEFINITIONS
   (	FK_NAME VARCHAR2(30 CHAR), 
   IND_EXCLUDE VARCHAR2(1 CHAR) DEFAULT 'Y', 
	IND_EXCLUDE_REFERING VARCHAR2(1 CHAR) DEFAULT 'Y', 
	FK_TYPE VARCHAR2(20 CHAR),
  LOOKUP_ATTR_NAME VARCHAR2(30 CHAR),
   "IND_IGNORE_CONSTRUCTOR" VARCHAR2(1 CHAR) DEFAULT 'N',
  "IND_IGNORE_INS" VARCHAR2(1 CHAR) DEFAULT 'N',
	"IND_IGNORE_TO_XML" VARCHAR2(1 CHAR) DEFAULT 'N'
   ) ;
   
  COMMENT ON COLUMN "XXX_FK_DEFINITIONS"."IND_IGNORE_CONSTRUCTOR" IS 'Indicates if code in constructor should be ignored.';
  COMMENT ON COLUMN "XXX_FK_DEFINITIONS"."IND_IGNORE_INS" IS 'Indicates if code in ''ins''-method should be ignored.';
	COMMENT ON COLUMN "XXX_FK_DEFINITIONS"."IND_IGNORE_TO_XML" IS 'Indicates if code in ''to_xml()''-method should be ignored.';
--------------------------------------------------------
--  Constraints for Table XXX_FK_DEFINITIONS
--------------------------------------------------------

  ALTER TABLE XXX_FK_DEFINITIONS ADD CONSTRAINT XXX_FDN_CHK1 CHECK (FK_TYPE in ('DETAIL','LOOKUP')) ENABLE;
  ALTER TABLE XXX_FK_DEFINITIONS ADD CONSTRAINT XXX_FDN_CHK2 CHECK (IND_EXCLUDE in ('Y','N')) ENABLE;
  ALTER TABLE XXX_FK_DEFINITIONS ADD CONSTRAINT XXX_FDN_CHK3 CHECK (IND_EXCLUDE_REFERING in ('Y','N')) ENABLE;
  ALTER TABLE "XXX_FK_DEFINITIONS" ADD CONSTRAINT "XXX_FDN_CHK4" CHECK ("IND_IGNORE_CONSTRUCTOR" in ('Y','N')) ENABLE;
  ALTER TABLE "XXX_FK_DEFINITIONS" ADD CONSTRAINT "XXX_FDN_CHK5" CHECK ("IND_IGNORE_INS" in ('Y','N')) ENABLE;
  ALTER TABLE "XXX_FK_DEFINITIONS" ADD CONSTRAINT "XXX_FDN_CHK6" CHECK ("IND_IGNORE_TO_XML" in ('Y','N')) ENABLE;
  ALTER TABLE XXX_FK_DEFINITIONS MODIFY (FK_NAME NOT NULL ENABLE);
  ALTER TABLE XXX_FK_DEFINITIONS MODIFY (IND_EXCLUDE NOT NULL ENABLE);
  ALTER TABLE XXX_FK_DEFINITIONS MODIFY (IND_EXCLUDE_REFERING NOT NULL ENABLE);
