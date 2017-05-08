CREATE OR REPLACE PACKAGE body xxx_obj
IS
--
-- Delete all objects
procedure deleteAll
is
begin
  delete from xxx_objects;
end deleteAll;
  --
  -- Create a new document in xxx_objects
FUNCTION createNewObject(
    p_object_name VARCHAR2,
    p_object_type VARCHAR2)
  RETURN CLOB
IS
  l_clob CLOB;
BEGIN
  INSERT
  INTO XXX_OBJECTS
    (
      OBJECT_NAME,
      OBJECT_TYPE,
      SOURCE
    )
    VALUES
    (
      p_object_name,
      p_object_type,
      empty_clob()
    )
  RETURNING SOURCE
  INTO l_clob;
  RETURN l_clob;
END createNewObject;
--
-- Get an object  by name from the xml_objects table and create it if
-- createNew=true.
FUNCTION get
  (
    p_object_name VARCHAR2,
    p_object_type VARCHAR2,
    createNew     BOOLEAN
  )
  RETURN CLOB
IS
  l_object CLOB;
BEGIN
  IF createNew THEN
    remove(p_object_name, p_object_type);
    l_object := createNewObject(p_object_name, p_object_type);
  ELSE
    SELECT source INTO l_object FROM xxx_objects WHERE object_name = p_object_name AND object_type = p_object_type;
  END IF;
  RETURN l_object;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  RETURN NULL;
END get;
--
-- Get an XML document as a CLOB by name from the xml_documents table
FUNCTION getAsCLOB(
    p_object_name VARCHAR2,
    p_object_type VARCHAR2)
  RETURN CLOB
IS
BEGIN
  RETURN get(p_object_name, p_object_type , FALSE);
END;
--
-- Get an XML document as a VARCHAR2 by name from the xml_documents table
FUNCTION getAsText(
    p_object_name VARCHAR2,
    p_object_type VARCHAR2)
  RETURN VARCHAR2
IS
BEGIN
  RETURN dbms_lob.substr(getAsCLOB(p_object_name , p_object_type ));
END;
--
-- Save an XML document as a CLOB (parsing it first if necessary)
-- into the xml_documents table with a given document name.
PROCEDURE SAVE(
    p_object_name VARCHAR2,
    p_object_type VARCHAR2,
    p_source CLOB ,
    docommit BOOLEAN := TRUE)
IS
  l_clob CLOB;
BEGIN
  INSERT
  INTO XXX_OBJECTS
    (
      OBJECT_NAME,
      OBJECT_TYPE,
      SOURCE
    )
    VALUES
    (
      p_object_name,
      p_object_type,
      p_source
    );
  IF docommit THEN
    COMMIT;
  END IF;
END;
--
-- Remove an XML document by name from the xml_documents table
PROCEDURE remove(
    p_object_name VARCHAR2,
    p_object_type VARCHAR2,
    docommit      BOOLEAN := TRUE )
IS
BEGIN
  DELETE FROM xxx_objects WHERE object_name = p_object_name AND object_type = p_object_type;
  IF docommit THEN
    COMMIT;
  END IF;
END;
--
-- Test if a named documnt exists in the xml_documents table
FUNCTION docExists(
    p_object_name VARCHAR2,
    p_object_type VARCHAR2)
  RETURN BOOLEAN
IS
BEGIN
  RETURN getAsCLOB(p_object_name , p_object_type ) IS NOT NULL;
END;
--
-- Initialization 
BEGIN  
  NULL;
END xxx_obj;
/
