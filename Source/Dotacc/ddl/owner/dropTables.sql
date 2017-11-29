set serveroutput on
set define off
declare 
  procedure pl(p_text in varchar2) is
  begin
    dbms_output.put_line(p_text);
  end;
  --
  procedure drop_table(p_table in varchar2)
  is
    cursor c_ddl (b_table_name in varchar2)
    is select 'DROP TABLE '||obj.object_name ddl
       from all_objects obj
       where obj.object_type = 'TABLE'
       and obj.object_name = b_table_name;
    r_ddl c_ddl%rowtype;
    l_found boolean;
  begin
    open c_ddl(b_table_name =>p_table);
    fetch c_ddl into r_ddl;
    l_found := c_ddl%found;
    close c_ddl;
    if l_found then
      pl('Drop table '||p_table);
      execute immediate r_ddl.ddl;
    else 
      pl('Table '||p_table||' does not exist');
    end if;
  end drop_table;
  --
  procedure drop_sequence(p_sequence in varchar2)
  is
    cursor c_ddl (b_sequence_name in varchar2)
    is select 'DROP SEQUENCE '||obj.object_name ddl
       from all_objects obj
       where obj.object_type = 'SEQUENCE'
       and obj.object_name = b_sequence_name;
    r_ddl c_ddl%rowtype;
    l_found boolean;
  begin
    open c_ddl(b_sequence_name =>p_sequence);
    fetch c_ddl into r_ddl;
    l_found := c_ddl%found;
    close c_ddl;
    if l_found then
      pl('Drop sequence '||p_sequence);
      execute immediate r_ddl.ddl;
    else 
      pl('Sequence '||p_sequence||' does not exist');
    end if;
  end;
begin
  drop_table('XXX_TABLES');
  drop_table('XXX_DERIVED_COLUMNS');
  drop_table('XXX_CUSTOM_METHODS');
  drop_table('XXX_FK_DEFINITIONS');
  drop_table('XXX_LOGS');
  drop_table('XXX_OBJECTS');
  drop_table('XXX_XML_DOCUMENTS');
  drop_sequence('XXX_LOG_ID_SEQ');
end;
/
--exit

