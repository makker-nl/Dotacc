CREATE OR REPLACE PACKAGE xxx_xml_gen authid current_user
IS
  /******************************************************************************
  Purpose         : Generation utilities based on XSLT.
  Usage           : From scripts or packages.
  (c) 2008-2014 Darwin-IT Professionals, Martien van den Akker
  Change History
  When        Who            What
  03-06-2012  MAkker         Initial Creation
  *******************************************************************************/
  --
  -- Generate a table definition xml document and transform using a template.
  -- Transform a document using a stylesheet
  FUNCTION generateOnTable(
      p_Table_Owner   IN VARCHAR2 ,
      p_Table_Name    IN VARCHAR2 ,
      p_Template_Name IN VARCHAR2)
    RETURN CLOB;
  --
  -- Generate an object based on the document name and template name.
  -- Both document as stylesheets are loaded from the xxx_xml_documents table
  FUNCTION generate_On_doc(
      p_doc_Name      IN VARCHAR2 ,
      p_Template_Name IN VARCHAR2)
    RETURN CLOB;
  --
  -- Replace entities with XML-entity encoding.
  FUNCTION replaceEntities(
      p_Doc IN VARCHAR2)
    RETURN VARCHAR2;
  --
  -- Execute a command.
  PROCEDURE EXECUTE(
      p_CMD IN VARCHAR2);
  --
  -- Execute a command.
  PROCEDURE EXECUTE(
      p_CMD IN CLOB);
END xxx_xml_gen;
/