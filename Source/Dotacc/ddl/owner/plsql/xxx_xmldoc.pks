CREATE OR REPLACE PACKAGE xxx_xmldoc
IS
  /******************************************************************************
  Purpose         : Methods to get documents from or save documents into
  xxx_xml_documents.
  Usage           : From scripts or packages.
  (c) 2008-2014 Darwin-IT Professionals, Martien van den Akker
  Change History
  When        Who            What
  03-06-2012  MAkker         Initial Creation
  *******************************************************************************/
  --
  --
  -- Load a file from a directory into the xml document table.
  PROCEDURE LoadCLOB(
      file     VARCHAR2 ,
      name     VARCHAR2 := NULL ,
      dir      VARCHAR2 DEFAULT 'XMLFILES' ,
      doCommit BOOLEAN := TRUE);
  --
  --
  -- Save an XML document as a varchar2 (parsing it first if necessary)
  -- into the xml_documents table with a given document name.
  PROCEDURE SAVE(
      name     VARCHAR2 ,
      xmldoc   VARCHAR2 ,
      docommit BOOLEAN := TRUE);
  --
  --
  -- Save an XML document as a CLOB (parsing it first if necessary)
  -- into the xml_documents table with a given document name.
  PROCEDURE SAVE(
      name VARCHAR2 ,
      xmldoc CLOB ,
      docommit BOOLEAN := TRUE);
  --
  --
  -- Save an XML document as a BFILE (parsing it first if necessary)
  -- into the xml_documents table with a given document name.
  PROCEDURE SAVE(
      name VARCHAR2 ,
      xmldoc BFILE ,
      docommit BOOLEAN := TRUE);
  --
  --
  -- Save an XML document as a xmldomDOMDocument (parsing it first if necessary)
  -- into the xml_documents table with a given document name.
  PROCEDURE SAVE(
      name VARCHAR2 ,
      xmldoc dbms_xmldom.DOMDocument ,
      docommit BOOLEAN := TRUE);
  --
  --
  -- Get an XML document by name from the xml_documents table
  FUNCTION get(
      name VARCHAR2)
    RETURN dbms_xmldom.DOMDocument;
  --
  --
  -- Get an XML document as a CLOB by name from the xml_documents table
  FUNCTION getAsCLOB(
      name VARCHAR2)
    RETURN CLOB;
  --
  --
  -- Get an XML document as a VARCHAR2 by name from the xml_documents table
  FUNCTION getAsText(
      name VARCHAR2)
    RETURN VARCHAR2;
  --
  --
  -- Remove an XML document by name from the xml_documents table
  PROCEDURE remove(
      name     VARCHAR2,
      docommit BOOLEAN := TRUE);
  --
  --
  -- Test if a named documnt exists in the xml_documents table
  FUNCTION docExists(
      name VARCHAR2)
    RETURN BOOLEAN;
END xxx_xmldoc;