CREATE OR REPLACE PACKAGE xxx_gen_objects
AS
  /******************************************************************************
  Purpose         : Generate Object Types
  Usage           : From scripts
  (c) 2008-2014 Darwin-IT Professionals, Martien van den Akker
  Change History
  When        Who            What
  16-06-2014  MAkker         Initial Creation
  13-10-2014  MAkker         Made generic, project independent.
  *******************************************************************************/
  subtype max_varchar2 IS   VARCHAR2(32767);
  subtype ident_type IS     VARCHAR2(30);
  subtype file_name IS      VARCHAR2(255);
  subtype dbl_ident_type IS VARCHAR2(61);
type t_table_List
IS
  TABLE OF ident_type;
  g_obj_type_tps CONSTANT ident_type := 'TYPE';
  g_obj_type_tpb CONSTANT ident_type := 'TYPE BODY';
  --
  g_xsl_language CONSTANT VARCHAR2(2)      := 'EN';
  g_xsl_CreateObjectType file_name         := 'CreateObjectTypeNL_2.0.xsl';
  g_xsl_CreateObjectTypeBody file_name     := 'CreateObjectTypeBodyNL_2.0.xsl';
  g_xsl_CreateTblObjectType file_name      := 'CreateObjectTable_1.0.xsl';
  g_xsl_CreateCollObjectType file_name     := 'CreateCollObjectTypeNL_2.0.xsl';
  g_xsl_CreateCollObjectTypeBody file_name := 'CreateCollObjectTypeBodyNL_2.0.xsl';
  --
  g_xsl_NL_CreateObjectType      CONSTANT file_name := 'CreateObjectTypeNL_2.0.xsl';
  g_xsl_NL_CreateObjectTypeBody  CONSTANT file_name := 'CreateObjectTypeBodyNL_2.0.xsl';
  g_xsl_NL_CreateTblObjectType   CONSTANT file_name := 'CreateObjectTable_1.0.xsl';
  g_xsl_NL_CreateCollObjType     CONSTANT file_name := 'CreateCollObjectTypeNL_2.0.xsl';
  g_xsl_NL_CreateCollObjTypeBody CONSTANT file_name := 'CreateCollObjectTypeBodyNL_2.0.xsl';
  --
  g_xsl_EN_CreateObjectType      CONSTANT file_name  := 'CreateObjectTypeEN_2.0.xsl';
  g_xsl_EN_CreateObjectTypeBody  CONSTANT file_name  := 'CreateObjectTypeBodyEN_2.0.xsl';
  g_xsl_EN_CreateTblObjectType   CONSTANT file_name  := 'CreateObjectTable_1.0.xsl';
  g_xsl_EN_CreateCollObjType     CONSTANT file_name  := 'CreateCollObjectTypeEN_2.0.xsl';
  g_xsl_EN_CreateCollObjTypeBody CONSTANT file_name  := 'CreateCollObjectTypeBodyEN_2.0.xsl';
  g_obj_type_script              CONSTANT ident_type := 'SCRIPT';
  g_CreateScript                 CONSTANT file_name  := 'CreateObjects.sql';
  g_DropScript                   CONSTANT file_name  := 'DropObjects.sql';
  --
  -- Query table definitions as an XMLType from the data dictionary.
  PROCEDURE generate_objects;
  --
  -- Generate Drop and Create Scripts
  PROCEDURE generate_scripts;
  --
  -- Drop Object-Type.
  PROCEDURE drop_object_type(
      p_object_name IN ident_type);
  --
  -- Drop  objects Script
  PROCEDURE drop_objects;
  --
  -- Create TableOf object for object_type
  PROCEDURE create_tableof_object(
      p_tableof_type IN ident_type,
      p_object_type  IN ident_type);
  --
  -- Create Objects
  PROCEDURE create_objects;
  --
  -- Rereate Objects
  PROCEDURE recreate_objects;
  --
END xxx_gen_objects;
/