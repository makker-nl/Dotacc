CREATE OR REPLACE PACKAGE xxx_table_definitions
IS
  /******************************************************************************
  Purpose         : Get table definitions in XML.
  Usage           : From scripts or packages.
  (c) 2008-2014 Darwin-IT Professionals, Martien van den Akker
  Change History
  When        Who            What
  03-06-2012  MAkker         Initial Creation
  13-10-2014  MAkker         Made generic, project independent. Also add referential
                             integrity, custom functions, derived attributes, etc.
  *******************************************************************************/
  subtype max_varchar2 IS   VARCHAR2(32767);
  subtype ident_type IS     VARCHAR2(30);
  g_max_length_tab_name number := 25;
  g_obj_type_prefix              CONSTANT ident_type := '';
  --g_obj_type_suffix              CONSTANT ident_type := '_TYPE';
  g_obj_type_suffix              CONSTANT ident_type := '_T';
  g_obj_tbl_prefix              CONSTANT ident_type := 'T';
  --g_obj_tbl_suffix              CONSTANT ident_type := '_TBL';
  g_obj_tbl_suffix              CONSTANT ident_type := '_TAB';
  g_obj_coll_prefix              CONSTANT ident_type := 'T';
  g_obj_coll_suffix              CONSTANT ident_type := '_COL';
  --
  -- Get short name of table
  function getTableNameShort( p_Table_Owner varchar2, p_Table_Name varchar2) 
  return varchar2;
  --
  --  get type name for table
  function get_type_name(p_table_owner ident_type, p_table_name ident_type )
    return varchar2;
  --
  -- get table_of type name for table_name
  function get_tbl_type_name(p_table_owner ident_type, p_table_name ident_type )
    return varchar2;
  --
  -- get collection type name for table
  function  get_coll_type_name(p_table_owner ident_type, p_table_name ident_type )
    return varchar2;
  --
  -- Query table definitions as an XMLType from the data dictionary.
  function getTableDefAsXMLType( p_Table_Owner varchar2
                           , p_Table_Name varchar2) 
                           return XMLType;
  --
  -- Query table definitions as an XML CLOB from the data dictionary.
  FUNCTION getTableDefAsXML(
      p_Table_Owner VARCHAR2 ,
      p_Table_Name  VARCHAR2)
    RETURN CLOB;
  --
  -- Query the table columns as an XMLType from datadictionary.
  FUNCTION getTabColumns(
      p_Owner      VARCHAR2 ,
      p_Table_Name VARCHAR2)
    RETURN xmltype;
  --
  -- Query the primary key columns as an XMLType from datadictionary.
  FUNCTION getPKColumns(
      p_Owner      VARCHAR2 ,
      p_Table_Name VARCHAR2)
    RETURN xmltype;
  --
  -- Query the foreign keys as an XMLType from datadictionary.
  function getForeignKeys(
      p_Owner      VARCHAR2 ,
      p_Table_Name VARCHAR2) 
  return XMLType;
 --
  -- Get derived columns of a table
  function getDerivedColumns( p_Owner      VARCHAR2 
                            , p_Table_Name VARCHAR2) 
  return XMLType;
END xxx_table_definitions;
/