CREATE OR REPLACE PACKAGE xxx_obj
IS
  /******************************************************************************
  Purpose         : Methods to get documents from or save documents into
  xxx_objects.
  Usage           : From scripts or packages.
  (c) 2008-2014 Darwin-IT Professionals, Martien van den Akker
  Change History
  When        Who            What
  03-06-2012  MAkker         Initial Creation
  *******************************************************************************/
  --
  -- Delete all objects
  PROCEDURE deleteAll;
  --
  -- Save an XML document as a CLOB (parsing it first if necessary)
  -- into the xml_documents table with a given document name.
  PROCEDURE SAVE(
      p_object_name VARCHAR2,
      p_object_type VARCHAR2,
      p_source CLOB ,
      docommit BOOLEAN := TRUE);
  --
  -- Get an object  by name from the xml_objects table and create it if
  -- createNew=true.
  FUNCTION get(
      p_object_name VARCHAR2,
      p_object_type VARCHAR2,
      createNew     BOOLEAN )
    RETURN CLOB;
  --
  -- Get an XML document as a CLOB by name from the xml_documents table
  FUNCTION getAsCLOB(
      p_object_name VARCHAR2,
      p_object_type VARCHAR2)
    RETURN CLOB;
  --
  -- Get an XML document as a VARCHAR2 by name from the xml_documents table
  FUNCTION getAsText(
      p_object_name VARCHAR2,
      p_object_type VARCHAR2)
    RETURN VARCHAR2;
  --
  -- Remove an XML document by name from the xml_documents table
  PROCEDURE remove(
      p_object_name VARCHAR2,
      p_object_type VARCHAR2,
      docommit      BOOLEAN := TRUE);
  --
  -- Test if a named documnt exists in the xml_documents table
  FUNCTION docExists(
      p_object_name VARCHAR2,
      p_object_type VARCHAR2)
    RETURN BOOLEAN;
--
END xxx_obj;