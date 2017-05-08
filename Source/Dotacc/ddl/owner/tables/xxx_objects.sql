-- Create table
create table XXX_OBJECTS
(
  OBJECT_NAME VARCHAR2(100) not null,
  OBJECT_TYPE VARCHAR2(30) not null,
  SOURCE      CLOB not null
);
ALTER TABLE XXX_OBJECTS ADD CONSTRAINT XXX_OBJ_PK PRIMARY KEY ( OBJECT_NAME, OBJECT_TYPE) ;