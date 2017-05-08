declare
  lStyleSheet CLOB;
  lTableDef clob;
  lObject Clob;
  l_object_name varchar2(100);
  l_object_type varchar2(100) := 'TypeBody';
  l_style_sheet varchar2(100) := 'CreateObjectTypeBody';
begin
  -- Call the function
  lStyleSheet := xxx_xmldoc.getAsClob(name => l_style_sheet);
  for r_doc in (select * from xxx_xml_documents where docname like 'SOS_%')
  loop
    lObject     := xxx_xml_gen.transform( pDocument   => r_doc.xmldoc
                                        , pStylesheet => lStyleSheet);
    l_object_name := r_doc.docname||'_TYPE';
    
    delete from xxx_objects where  object_name = l_object_name and object_type = l_object_type;
    
    insert into xxx_objects 
      (object_name, object_type, source)
    values
      (l_object_name , l_object_type, lObject);
    
  end loop;
end;
/