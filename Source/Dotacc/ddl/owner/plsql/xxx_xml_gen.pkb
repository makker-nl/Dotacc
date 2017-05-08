CREATE OR REPLACE PACKAGE body xxx_xml_gen
IS
  --
  -- Generate a table definition xml document and transform using a template.
  -- Transform a document using a stylesheet
FUNCTION generateOnTable(
    p_Table_Owner   IN VARCHAR2 ,
    p_Table_Name    IN VARCHAR2 ,
    p_Template_Name IN VARCHAR2)
  RETURN CLOB
IS
  l_StyleSheet CLOB;
  l_TableDef CLOB;
  l_Object CLOB;
BEGIN
  l_StyleSheet := xxx_xmldoc.getAsClob(name => p_Template_Name);
  l_TableDef   := xxx_table_definitions.getTableDefAsXML( p_Table_Owner => upper(p_Table_Owner) , p_Table_Name => upper(p_Table_Name));
  l_Object     := xxx_xslt.transformToCLOB( p_xml => l_TableDef, p_stylesheet => l_Stylesheet);
  RETURN l_Object;
END generateOnTable;
--
-- Generate an object based on the document name and template name.
-- Both document as stylesheets are loaded from the xxx_xml_documents table
--
FUNCTION generate_On_doc(
    p_doc_Name      IN VARCHAR2 ,
    p_Template_Name IN VARCHAR2)
  RETURN CLOB
IS
  l_Stylesheet CLOB;
  l_doc CLOB;
  l_Object CLOB;
  l_xmltype XMLTYPE;
  l_xmldomdoc dbms_xmldom.DOMDocument;
  l_temp_result CLOB;
BEGIN
  l_Stylesheet := xxx_xmldoc.getAsClob(name => p_Template_Name);
  l_doc        := xxx_xmldoc.getAsClob(name => p_doc_Name);
  l_Object     := xxx_xslt.transformToCLOB( p_xml => l_doc, p_stylesheet => l_Stylesheet);
  RETURN l_Object;
END;
--
-- Replace entities with XML-entity encoding.
FUNCTION replaceEntities(
    p_Doc IN VARCHAR2)
  RETURN VARCHAR2
IS
  l_Doc VARCHAR2(32767);
BEGIN
  l_Doc := REPLACE(srcstr => p_Doc, oldsub => '&QUOT;', newsub => '"');
  l_Doc := REPLACE(srcstr => l_Doc, oldsub => '&APOS;', newsub => '''');
  l_Doc := REPLACE(srcstr => l_Doc, oldsub => '&GT;' , newsub => '>');
  RETURN l_Doc;
END;
--
-- Execute a command.
PROCEDURE EXECUTE(
    p_CMD IN VARCHAR2)
IS
  l_Cmd VARCHAR2(32767);
BEGIN
  l_Cmd := replaceEntities(p_CMD);
  EXECUTE immediate l_Cmd;
END;
--
-- Execute a command.
PROCEDURE EXECUTE(
    p_CMD IN CLOB)
IS
BEGIN
  EXECUTE(p_CMD => dbms_lob.substr(lob_loc => p_CMD, amount => dbms_lob.getlength(p_CMD)));
END;
BEGIN
  -- Initialization
  NULL;
END xxx_xml_gen;
/
