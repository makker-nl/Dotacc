declare
  lStyleSheet CLOB;
  lTableDef clob;
  lObject Clob;
begin
  for r_tab in (select table_name from user_tables tab)
  loop
  lTableDef := xxx_table_definitions.gettabledefasxml(ptableowner => upper('SOS'),
                                                    ptablename => upper(r_tab.table_name));
  delete from xxx_xml_documents where docname = r_tab.table_name;
  insert into xxx_xml_documents
    (docname, xmldoc)
  values
    (r_tab.table_name, lTableDef);
  
  end loop;
end;
/
