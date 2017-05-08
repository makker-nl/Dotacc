-- Create table
create table XXX_XML_DOCUMENTS
(
  DOCNAME   VARCHAR2(200) not null,
  XMLDOC    CLOB,
  TIMESTAMP DATE
);

alter table XXX_XML_DOCUMENTS
  add constraint XXX_XDC_PK primary key (DOCNAME)
  using index ;  
CREATE OR REPLACE TRIGGER XXX_XDC_BR
BEFORE INSERT OR UPDATE ON XXX_XML_DOCUMENTS
FOR EACH ROW
BEGIN
  :new.timestamp := SYSDATE;
END;
/
