CREATE OR REPLACE PACKAGE BODY xxx_gen_objects
AS
  g_drop_type_cmd max_varchar2 := 'drop type ${type_name}';
  e_obj_does_not_exist EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_obj_does_not_exist , -04043);
  e_compiled_with_errors EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_compiled_with_errors , -24344);
  --
  -- Generate drop type command
  FUNCTION generate_drop_type_cmd(
      p_object_name ident_type)
    RETURN max_varchar2
  IS
    l_cmd max_varchar2;
  BEGIN
    l_cmd := REPLACE(g_drop_type_cmd, '${type_name}',p_object_name);
    RETURN l_cmd ;
  END generate_drop_type_cmd;
--
-- check if table to be excluded for table-of and collection objects
  FUNCTION exclude_table_for_collobj(
      p_table_name IN ident_type)
    RETURN BOOLEAN
  IS
    CURSOR c_tab(b_table_name IN ident_type)
    IS
      SELECT TABLE_NAME,
        GENERATION_ORDER,
        IND_EXCLUDE_COLL
      FROM XXX_TABLES tab
      WHERE tab.table_name     = b_table_name
      AND tab.IND_EXCLUDE_COLL = 'Y';
    r_tab c_tab%rowtype;
    l_found BOOLEAN;
  BEGIN
    OPEN c_tab(b_table_name => p_table_name);
    FETCH c_tab INTO r_tab;
    l_found := c_tab%found;
    CLOSE c_tab;
    RETURN l_found;
  END exclude_table_for_collobj;
--
-- Drop Object-Type.
  PROCEDURE drop_object_type(
      p_object_name IN ident_type)
  IS
    l_cmd max_Varchar2;
  BEGIN
    l_cmd := generate_drop_type_cmd(p_object_name);
    XXX_LOG.PUT_LINE('Execute command: ['||l_cmd||']');
    xxx_xml_gen.execute(l_cmd);
    XXX_LOG.PUT_LINE(p_object_name||' dropped.');
  EXCEPTION
  WHEN e_obj_does_not_exist THEN
    XXX_LOG.PUT_LINE('Object '||p_object_name||' does not not exist.');
  END drop_object_type;
--
-- Generate Object-Types and save objects to xxx_objects.
  PROCEDURE generate_object(
      p_Table_Def CLOB ,
      p_table_name ident_type,
      p_object_name ident_type,
      p_object_type ident_type,
      p_template_name ident_type)
  AS
    l_Object_Def CLOB;
  BEGIN
    XXX_LOG.PUT_LINE('Generate object for table '||p_table_name||' with template '||p_template_name);
    l_Object_Def := xxx_xml_gen.generate_On_doc( p_doc_Name => p_table_name , p_Template_Name =>p_template_name );
    xxx_obj.remove(p_object_name => p_object_name, p_object_type => p_object_type);
    xxx_obj.save( p_object_name =>p_object_name, p_object_type => p_object_type , p_source => l_object_def);
  END generate_object;
--
-- get type name for table
  FUNCTION get_type_name(
      p_table_owner ident_type,
      p_table_name ident_type )
    RETURN VARCHAR2
  IS
  BEGIN
    RETURN xxx_table_definitions.get_type_name(p_table_owner, p_table_name);
  END get_type_name;
--
-- get table_of type name for table
  FUNCTION get_tbl_type_name(
      p_table_owner ident_type,
      p_table_name ident_type )
    RETURN VARCHAR2
  IS
  BEGIN
    RETURN xxx_table_definitions.get_tbl_type_name(p_table_owner, p_table_name);
  END get_tbl_type_name;
--
-- get collection type name for table
  FUNCTION get_coll_type_name(
      p_table_owner ident_type,
      p_table_name ident_type )
    RETURN VARCHAR2
  IS
  BEGIN
    RETURN xxx_table_definitions.get_coll_type_name(p_table_owner, p_table_name);
  END get_coll_type_name;
--
--  Append object def to script
  PROCEDURE create_type4table(
      p_object_name ident_type,
      p_object_type ident_type)
  IS
    l_Object_Def CLOB;
  BEGIN
    xxx_log.put_line('Create '||p_object_name||' '||p_object_type);
    l_Object_Def := xxx_obj.getAsCLOB( p_object_name => p_object_name, p_object_type =>p_object_type);
    xxx_xml_gen.execute(l_object_def);
  EXCEPTION
  WHEN e_compiled_with_errors THEN
    xxx_log.put_line(p_object_name||' '||p_object_type||' is aangemaakt met compilatie fout.');
  END create_type4table;
--
-- Create the type that is generated for table
  PROCEDURE create_types4Table(
      p_table_owner ident_type,
      p_table_name ident_type)
  IS
    l_object_name ident_type;
  BEGIN
    l_object_name :=get_type_name(p_table_owner, p_table_name);
    create_type4table( p_object_name =>l_object_name, p_object_type => g_obj_type_tps);
    create_type4table( p_object_name =>l_object_name, p_object_type => g_obj_type_tpb);
    -- Generate collection objects for not excluded tables
    IF NOT exclude_table_for_collobj (p_table_name=> p_table_name) THEN
      l_object_name :=get_tbl_type_name(p_table_owner, p_table_name);
      create_type4table( p_object_name =>l_object_name, p_object_type => g_obj_type_tps);
      l_object_name :=get_coll_type_name(p_table_owner, p_table_name);
      create_type4table( p_object_name =>l_object_name, p_object_type => g_obj_type_tps);
      create_type4table( p_object_name =>l_object_name, p_object_type => g_obj_type_tpb);
    END IF;
  END create_types4Table;
--
-- Generate Object-Types and save objects to xxx_objects.
  PROCEDURE generate_objects4Table(
      p_table_owner ident_type,
      p_table_name ident_type)
  AS
    l_object_name ident_type;
    l_Object_Def CLOB;
    l_Table_Def CLOB;
    l_table_name ident_type  := upper(p_table_name);
    l_table_owner ident_type := upper(p_table_owner);
  BEGIN
    xxx_log.put_line('Generate Table Def for '||l_table_name);
    l_Table_Def := xxx_table_definitions.getTableDefAsXML(p_table_owner => l_table_owner, p_table_name => l_table_name);
    xxx_log.put_line('Save Table Def for '||l_table_name);
    xxx_xmldoc.remove( l_table_name);
    xxx_xmldoc.save( name =>l_table_name, xmldoc => l_Table_Def);
    l_object_name :=get_type_name(p_table_owner, p_table_name);
    -- Generate 'Entity' object type
    generate_object( p_Table_Def => l_Table_Def, p_table_name => l_table_name, p_object_name => l_object_name , p_object_type =>g_obj_type_tps, p_template_name => g_xsl_CreateObjectType);
    generate_object( p_Table_Def => l_Table_Def, p_table_name => l_table_name, p_object_name=> l_object_name, p_object_type =>g_obj_type_tpb, p_template_name => g_xsl_CreateObjectTypeBody);
    -- Generate collection objects for not excluded tables
    IF NOT exclude_table_for_collobj (p_table_name=> p_table_name) THEN
      -- Generate Table object
      l_object_name := get_tbl_type_name(p_table_owner, p_table_name);
      generate_object( p_Table_Def => l_Table_Def, p_table_name => l_table_name, p_object_name=> l_object_name, p_object_type =>g_obj_type_tps, p_template_name => g_xsl_CreateTblObjectType);
      -- Generate Collection object
      l_object_name := get_coll_type_name(p_table_owner, p_table_name);
      generate_object( p_Table_Def => l_Table_Def, p_table_name => l_table_name, p_object_name=> l_object_name, p_object_type =>g_obj_type_tps, p_template_name => g_xsl_CreateCollObjectType);
      generate_object( p_Table_Def => l_Table_Def, p_table_name => l_table_name, p_object_name=> l_object_name, p_object_type =>g_obj_type_tpb, p_template_name => g_xsl_CreateCollObjectTypeBody);
    END IF;
  END generate_objects4Table;
--
-- append drop object statement to script
  PROCEDURE append_drop_object_to_script(
      p_script IN OUT CLOB,
      p_object_name ident_type)
  IS
    l_cmd max_varchar2;
  BEGIN
    --l_cmd := generate_drop_type_cmd(p_object_name => p_object_name)||';'||chr(10);
    l_cmd := 'drop_type('''|| p_object_name || ''');'||chr(10);
    dbms_lob.append(p_script,l_cmd);
  END append_drop_object_to_script ;
--
--  Append object def to script
  PROCEDURE append_obj_to_script(
      p_script IN OUT CLOB,
      p_object_name ident_type,
      p_object_type ident_type)
  IS
    l_Object_Def CLOB;
  BEGIN
    xxx_log.put_line('Append '||p_object_type||' '||p_object_name||chr(10));
    l_Object_Def := xxx_obj.getAsCLOB( p_object_name => p_object_name, p_object_type =>p_object_type);
    dbms_lob.append(p_script,'prompt Create '||p_object_type||' '||p_object_name||chr(10));
    dbms_lob.append(p_script,l_object_def);
    dbms_lob.append(p_script,chr(10)||'/'||chr(10));
  END append_obj_to_script;
--
-- Generate Object-Types and save objects to xxx_objects.
  PROCEDURE append_Table_objects_to_script(
      p_script IN OUT nocopy CLOB,
      p_table_owner ident_type,
      p_table_name ident_type)
  IS
    l_object_name ident_type;
  BEGIN
    -- Create objects
    l_object_name :=get_type_name(p_table_owner, p_table_name);
    append_obj_to_script(p_script =>p_script, p_object_name =>l_object_name , p_object_type => g_obj_type_tps);
    append_obj_to_script(p_script =>p_script, p_object_name =>l_object_name , p_object_type => g_obj_type_tpb);
    -- Generate collection objects for not excluded tables
    IF NOT exclude_table_for_collobj (p_table_name=> p_table_name) THEN
      l_object_name :=get_tbl_type_name(p_table_owner, p_table_name);
      append_obj_to_script(p_script =>p_script, p_object_name =>l_object_name , p_object_type => g_obj_type_tps);
      l_object_name :=get_coll_type_name(p_table_owner, p_table_name);
      append_obj_to_script(p_script =>p_script, p_object_name =>l_object_name , p_object_type => g_obj_type_tps);
      append_obj_to_script(p_script =>p_script, p_object_name =>l_object_name , p_object_type => g_obj_type_tpb);
    END IF;
  END append_Table_objects_to_script;
--
-- Append drop obj statements for table to script
  PROCEDURE append_drop_objs4Tbl_to_script(
      p_script IN OUT nocopy CLOB,
      p_table_owner ident_type,
      p_table_name ident_type)
  AS
  BEGIN
    -- Generate drop objects commands for not excluded tables
    IF NOT exclude_table_for_collobj (p_table_name=> p_table_name) THEN
      append_drop_object_to_script( p_script => p_script, p_object_name => get_coll_type_name(p_table_owner, p_table_name) );
      append_drop_object_to_script( p_script => p_script, p_object_name => get_tbl_type_name(p_table_owner, p_table_name) );
    END IF;
    append_drop_object_to_script( p_script => p_script, p_object_name => get_type_name(p_table_owner, p_table_name) );
  END append_drop_objs4Tbl_to_script;
--
--
  FUNCTION count_tables
    RETURN NUMBER
  IS
    l_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO l_count FROM xxx_tables;
    RETURN l_count;
  END count_tables;
--
-- Generate Drop Script
  PROCEDURE append_drop_script(
      p_script IN OUT nocopy CLOB)
  AS
    l_drop_type_proc max_varchar2 := q'{procedure drop_type(p_object_name varchar2)
as
e_obj_does_not_exist EXCEPTION;
PRAGMA EXCEPTION_INIT(e_obj_does_not_exist , -04043);
l_cmd varchar2(100) := 'drop type '||p_object_name;
BEGIN
dbms_output.PUT_LINE('Execute command: ['||l_cmd||']');
execute immediate l_cmd;
dbms_output.PUT_LINE(p_object_name||' dropped.');
EXCEPTION
WHEN e_obj_does_not_exist THEN
dbms_output.PUT_LINE('Object '||p_object_name||' does not not exist.');
END drop_type;}';
    l_msg VARCHAR2(4000);
    CURSOR c_tab
    IS
      SELECT TABLE_OWNER,
        TABLE_NAME,
        GENERATION_ORDER,
        IND_EXCLUDE_COLL
      FROM XXX_TABLES tab
      ORDER BY tab.generation_order DESC;
  BEGIN
    -- Drop types
    dbms_lob.append(p_script,'--'||chr(10)||'-- Drop Types'||chr(10));
    l_msg := 'Number of tables to drop types for: '|| count_tables;
    xxx_log.put_line(l_msg);
    dbms_lob.append(p_script,'prompt '||l_msg||';'||chr(10));
    dbms_lob.append(p_script,'declare'||chr(10));
    dbms_lob.append(p_script,l_drop_type_proc);
    dbms_lob.append(p_script,chr(10)||'begin'||chr(10));
    FOR r_tab IN c_tab
    LOOP
      append_drop_objs4Tbl_to_script( p_script => p_script, p_table_owner => r_tab.table_owner, p_table_name => r_tab.table_name );
    END LOOP;
    dbms_lob.append(p_script,'end;'||chr(10)||'/'||chr(10));
  END append_drop_script;
--
-- Generate Create Script
  PROCEDURE append_create_script(
      p_script IN OUT nocopy CLOB)
  AS
    l_table_name ident_type;
    l_msg VARCHAR2(4000);
    CURSOR c_tab
    IS
      SELECT TABLE_OWNER,
        TABLE_NAME,
        GENERATION_ORDER,
        IND_EXCLUDE_COLL
      FROM XXX_TABLES tab
      ORDER BY tab.generation_order ASC;
  BEGIN
    -- Drop types
    dbms_lob.append(p_script,'--'||chr(10)||'-- Create Types'||chr(10));
    l_msg := 'Number of tables to create types for: '|| count_tables;
    xxx_log.put_line(l_msg);
    dbms_lob.append(p_script,'prompt '||l_msg||';'||chr(10));
    FOR r_tab IN c_tab
    LOOP
      append_Table_objects_to_script(p_script => p_script, p_table_owner => r_tab.table_owner, p_table_name => r_tab.table_name );
    END LOOP;
  END append_create_script;
--
-- Generate drop and create Scripts
  PROCEDURE generate_scripts
  AS
    l_create_script CLOB;
    l_drop_script CLOB;
    l_object_name ident_type;
    l_table_name ident_type;
  BEGIN
    generate_objects;
    --
    -- Generate drop script
    dbms_lob.createtemporary(l_drop_script,true, DBMS_LOB.SESSION);
    append_drop_script(p_script => l_drop_script);
    --
    xxx_log.put_line('Save script '|| g_DropScript);
    xxx_obj.remove(p_object_name => g_DropScript, p_object_type => g_obj_type_script);
    xxx_obj.save( p_object_name =>g_DropScript, p_object_type => g_obj_type_script , p_source => l_drop_script);
    --
    -- Generate Create objects script
    dbms_lob.createtemporary(l_create_script,true, DBMS_LOB.SESSION);
    append_create_script(p_script => l_create_script);
    --
    xxx_log.put_line('Save script '|| g_CreateScript);
    xxx_obj.remove(p_object_name => g_CreateScript, p_object_type => g_obj_type_script);
    xxx_obj.save( p_object_name =>g_CreateScript, p_object_type => g_obj_type_script , p_source => l_create_script);
  END generate_scripts;
--
-- Generate Objects
  PROCEDURE generate_objects
  AS
    l_table_name ident_type;
    CURSOR c_tab
    IS
      SELECT TABLE_OWNER,
        TABLE_NAME,
        GENERATION_ORDER,
        IND_EXCLUDE_COLL
      FROM XXX_TABLES tab;
    l_msg VARCHAR2(4000);
  BEGIN
    --
    -- Delete all objects
    xxx_obj.deleteAll;
    l_msg := 'Number of tables to create types for: '|| count_tables;
    xxx_log.put_line(l_msg);
    FOR r_tab IN c_tab
    LOOP
      generate_objects4Table (p_table_owner => r_tab.table_owner, p_table_name => r_tab.table_name );
    END LOOP;
  END generate_objects;
--
-- Drop objects for tableScript
  PROCEDURE drop_objects4table(
      p_table_owner ident_type,
      p_table_name ident_Type)
  IS
  BEGIN
    -- Generate drop objects commands for not excluded tables
    IF NOT exclude_table_for_collobj (p_table_name=> p_table_name) THEN
      drop_object_type( p_object_name => get_coll_type_name(p_table_owner, p_table_name) );
      drop_object_type( p_object_name => get_tbl_type_name(p_table_owner, p_table_name) );
    END IF;
    drop_object_type( p_object_name => get_type_name(p_table_owner, p_table_name) );
  END drop_objects4table;
--
-- Drop ZMS objects Script
  PROCEDURE drop_objects
  AS
    l_msg VARCHAR2(4000);
    CURSOR c_tab
    IS
      SELECT TABLE_OWNER,
        TABLE_NAME,
        GENERATION_ORDER,
        IND_EXCLUDE_COLL
      FROM XXX_TABLES tab
      ORDER BY tab.generation_order DESC;
  BEGIN
    -- Drop types
    l_msg := 'Number of tables to drop types for: '|| count_tables;
    xxx_log.put_line(l_msg);
    FOR r_tab IN c_tab
    LOOP
      drop_objects4table( p_table_owner => r_tab.table_owner, p_table_name => r_tab.table_name );
    END LOOP;
  END drop_objects;
--
-- Create Objects
  PROCEDURE create_objects
  AS
    CURSOR c_tab
    IS
      SELECT TABLE_OWNER,
        TABLE_NAME,
        GENERATION_ORDER,
        IND_EXCLUDE_COLL
      FROM XXX_TABLES tab
      ORDER BY tab.generation_order ASC;
  BEGIN
    generate_objects;
    FOR r_tab IN c_tab
    LOOP
      create_types4Table (p_table_owner => r_tab.table_owner, p_table_name => r_tab.table_name );
    END LOOP;
  END create_objects;
--
-- Create TableOf object for object_type
  PROCEDURE create_tableof_object(
      p_tableof_type IN ident_type,
      p_object_type  IN ident_type)
  AS
  BEGIN
    dbms_output.put_line('Create Table of object '|| p_tableof_type||' for object type '||p_object_type);
    xxx_xml_gen.execute('Create or replace type '|| p_tableof_type||' as table of '||p_object_type);
  END create_tableof_object;
--
-- Rereate Objects
  PROCEDURE recreate_objects
  IS
  BEGIN
    drop_objects;
    create_objects;
  END recreate_objects;
--
--
BEGIN
  IF g_xsl_language                 = 'NL' THEN
    g_xsl_CreateObjectType         := g_xsl_NL_CreateObjectType;
    g_xsl_CreateObjectTypeBody     := g_xsl_NL_CreateObjectTypeBody;
    g_xsl_CreateTblObjectType      := g_xsl_NL_CreateTblObjectType;
    g_xsl_CreateCollObjectType     := g_xsl_NL_CreateCollObjType;
    g_xsl_CreateCollObjectTypeBody := g_xsl_NL_CreateCollObjTypeBody;
  ELSE
    IF g_xsl_language                 = 'EN' THEN
      g_xsl_CreateObjectType         := g_xsl_EN_CreateObjectType;
      g_xsl_CreateObjectTypeBody     := g_xsl_EN_CreateObjectTypeBody;
      g_xsl_CreateTblObjectType      := g_xsl_EN_CreateTblObjectType;
      g_xsl_CreateCollObjectType     := g_xsl_EN_CreateCollObjType;
      g_xsl_CreateCollObjectTypeBody := g_xsl_EN_CreateCollObjTypeBody;
    END IF;
  END IF;
END xxx_gen_objects;
/
