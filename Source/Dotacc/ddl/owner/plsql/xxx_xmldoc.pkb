CREATE OR REPLACE PACKAGE body xxx_xmldoc
IS
--
--
-- Create a new document in XMLDoc
FUNCTION createNewXMLDoc(
    name VARCHAR2)
  RETURN CLOB
IS
  c CLOB;
BEGIN
  INSERT INTO xxx_xml_documents
    (docname, xmldoc
    ) VALUES
    (name, empty_clob()
    ) RETURNING xmldoc INTO c;
  RETURN c;
END createNewXMLDoc;
--
--
-- Get an XML document by name from the xml_documents table and create it if
-- createNew=true.
FUNCTION get
  (
    name      VARCHAR2,
    createNew BOOLEAN
  )
  RETURN CLOB
IS
  l_xmldoc CLOB;
BEGIN
  IF createNew THEN
    remove(name);
    l_xmldoc := createNewXMLDoc(name);
  ELSE
    SELECT xmldoc INTO l_xmldoc FROM xxx_xml_documents WHERE docname = name;
  END IF;
  RETURN l_xmldoc;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  RETURN NULL;
END get;
--
--
-- Get an XML document as a CLOB by name from the xml_documents table
FUNCTION getAsCLOB(
    name VARCHAR2)
  RETURN CLOB
IS
BEGIN
  RETURN get(name, FALSE);
END;
--
--
-- Get an XML document as a VARCHAR2 by name from the xml_documents table
FUNCTION getAsText(
    name VARCHAR2)
  RETURN VARCHAR2
IS
BEGIN
  RETURN dbms_lob.substr(getAsCLOB(name));
END;
--
--
-- Get an XML document by name from the xml_documents table
FUNCTION get(
    name VARCHAR2)
  RETURN dbms_xmldom.DOMDocument
IS
BEGIN
  RETURN xxx_xml.parse(getAsCLOB(name));
END;
--
--
-- Save an XML document as a varchar2 (parsing it first if necessary)
-- into the xml_documents table with a given document name.
PROCEDURE SAVE(
    name     VARCHAR2 ,
    xmldoc   VARCHAR2 ,
    docommit BOOLEAN := TRUE)
IS
  c CLOB := get( name => name , createNew => TRUE);
  doc xmldom.DOMDocument;
BEGIN
  doc := xxx_xml.parse(xmldoc);
  dbms_xmldom.writeToClob(doc, c);
  xxx_xml.free_Document(doc);
  IF docommit THEN
    COMMIT;
  END IF;
EXCEPTION
WHEN OTHERS THEN
  xxx_xml.free_Document(doc);
  RAISE;
END;
--
--
-- Save an XML document as a CLOB (parsing it first if necessary)
-- into the xml_documents table with a given document name.
PROCEDURE SAVE(
    name VARCHAR2 ,
    xmldoc CLOB ,
    docommit BOOLEAN := TRUE)
IS
  c CLOB := get( name => name , createNew => TRUE);
  doc xmldom.DOMDocument;
BEGIN
  doc := xxx_xml.parse(xmldoc);
  dbms_xmldom.writeToClob(doc, c);
  xxx_xml.free_Document(doc);
  IF docommit THEN
    COMMIT;
  END IF;
EXCEPTION
WHEN OTHERS THEN
  xxx_xml.free_Document(doc);
  RAISE;
END;
--
--
-- Save an XML document as a BFILE (parsing it first if necessary)
-- into the xml_documents table with a given document name.
PROCEDURE SAVE(
    name VARCHAR2 ,
    xmldoc BFILE ,
    docommit BOOLEAN := TRUE)
IS
  c CLOB := get( name => name , createNew => TRUE);
  doc xmldom.DOMDocument;
BEGIN
  doc := xxx_xml.parse(xmldoc);
  dbms_xmldom.writeToClob(doc, c);
  xxx_xml.free_Document(doc);
  IF docommit THEN
    COMMIT;
  END IF;
EXCEPTION
WHEN OTHERS THEN
  xxx_xml.free_Document(doc);
  RAISE;
END;
--
--
-- Save an XML document as a xmldomDOMDocument (parsing it first if necessary)
-- into the xml_documents table with a given document name.
PROCEDURE SAVE(
    name VARCHAR2 ,
    xmldoc dbms_xmldom.DOMDocument ,
    docommit BOOLEAN := TRUE)
IS
  c CLOB := get( name => name , createNew => TRUE);
BEGIN
  xmldom.writeToClob(xmldoc, c);
  IF docommit THEN
    COMMIT;
  END IF;
END;
--
--
-- Load a file from a directory into the xml document table.
PROCEDURE LoadCLOB(
    file     VARCHAR2 ,
    name     VARCHAR2 := NULL ,
    dir      VARCHAR2 DEFAULT 'XMLFILES' ,
    doCommit BOOLEAN := TRUE)
IS
  lBFILE BFILE;
  lCLOB CLOB;
  lDocName VARCHAR2(200) := NVL(name, file);
BEGIN
  -- (1) Remove if exist
  BEGIN
    remove(name => lDocName);
  EXCEPTION
  WHEN no_data_found THEN
    NULL;
  END;
  -- (2) Get a BFILE handle to the external file
  lBFILE := BFileName(dir, file);
  -- (3) Insert with empty clob
  INSERT
  INTO xxx_xml_documents
    (
      docname,
      xmldoc
    )
    VALUES
    (
      name,
      empty_clob()
    )
  RETURNING xmldoc
  INTO lCLOB;
  -- (4) Load File
  dbms_lob. fileOpen(lBFILE);
  dbms_lob.loadFromFile(dest_lob => lCLOB, src_lob => lBFILE, amount => dbms_lob.getLength(lBFILE));
  dbms_lob.fileClose(lBFILE);
  -- (5) Do commit
  IF docommit THEN
    COMMIT;
  END IF;
END;
--
--
-- Remove an XML document by name from the xml_documents table
PROCEDURE remove
  (
    name     VARCHAR2,
    docommit BOOLEAN := TRUE
  )
IS
BEGIN
  DELETE FROM xxx_xml_documents WHERE docname = name;
  IF docommit THEN
    COMMIT;
  END IF;
END;
--
--
-- Test if a named documnt exists in the xml_documents table
FUNCTION docExists(
    name VARCHAR2)
  RETURN BOOLEAN
IS
BEGIN
  RETURN getAsCLOB(name) IS NOT NULL;
END;
--
--
BEGIN
  -- Initialization
  NULL;
END xxx_xmldoc;

