CREATE OR REPLACE package body xxx_table_definitions is
--
--
  function getTableNameShort( p_Table_Owner varchar2, p_Table_Name varchar2) 
  return varchar2
  is
    cursor c_tab(b_Table_Owner varchar2, b_Table_Name varchar2) 
    is select tab.table_owner
       ,      tab.table_name
       ,      tab.short_name
       from xxx_tables tab
       where tab.table_owner = b_Table_Owner 
       and   tab.table_name = p_Table_Name;
    r_tab c_tab%rowtype;
    l_table_name max_varchar2;
  begin
    l_table_name  := p_Table_Name;
    open c_tab(b_Table_Owner => p_Table_Owner, b_Table_Name => p_Table_Name);
    fetch c_tab into r_tab;
    close c_tab;
    if r_tab.short_name is not null then
      l_table_name := r_tab.short_name;
    elsif length(l_table_name) > g_max_length_tab_name then   
      l_table_name := substr(1,g_max_length_tab_name);     
    end if;
    return l_table_name;
  end getTableNameShort;
  --
  -- get type name for table
  function get_type_name(p_table_owner ident_type, p_table_name ident_type )
    return varchar2
  is
  begin
    return g_obj_type_prefix||xxx_table_definitions.getTableNameShort(p_table_owner, p_table_name)||g_obj_type_suffix;
  end get_type_name;  
  --
  -- get table_of type name for table_name
  function get_tbl_type_name(p_table_owner ident_type, p_table_name ident_type )
    return varchar2
  is
  begin
    return g_obj_tbl_prefix||xxx_table_definitions.getTableNameShort(p_table_owner, p_table_name)||g_obj_tbl_suffix;
  end get_tbl_type_name;
  --
  -- get collection type name for table
  function  get_coll_type_name(p_table_owner ident_type, p_table_name ident_type )
    return varchar2
  is
  begin
    return g_obj_coll_prefix||xxx_table_definitions.getTableNameShort(p_table_owner, p_table_name)||'_COLL';
  end get_coll_type_name;
  --
  -- Query the table columns as an XMLType from datadictionary.
  function getTabColumns( p_Owner     varchar2
                     , p_Table_Name varchar2) 
  return xmltype
  is
    cursor c_xml( b_Owner     varchar2
                , b_TableName varchar2)  
    is select xmlelement( "Columns"
                        , xmlagg(xmlelement( "Column"
                                           , xmlelement("ColName", col.column_name)
                                           , xmlelement("ColId", col.column_id)
                                           , case when substr(col.data_type, 1, 9) = 'TIMESTAMP' then xmlelement("DataType", 'TIMESTAMP') else xmlelement("DataType", col.data_type) end 
                                           , case when col.data_type in ('DATE', 'CLOB', 'BLOB', 'XMLTYPE') OR substr(col.data_type, 1, 9) = 'TIMESTAMP' then null else xmlelement("DataLength", col.data_length) end 
                                           , case when col.data_precision is null then null else xmlelement("DataPrecision", col.data_precision) end
                                           , case when col.data_scale is null OR substr(col.data_type, 1, 9) = 'TIMESTAMP'  then null else xmlelement("DataScale", col.data_scale) end
                                           )
                                )
                        ) xml
    from all_tab_columns col
    where col.owner      = b_Owner
    and   col.table_name = b_TableName
    order by col.column_id;
    --group by col.owner, col.table_name;
    r_xml c_xml%rowtype;
  begin
    open c_xml( b_Owner     => p_Owner
              , b_TableName => p_Table_Name);
    fetch c_xml into r_xml;
    if c_xml%notfound
    then
      raise no_data_found;
    end if;
    close c_xml;          
    return(r_xml.xml);
  exception
    when others then
      if c_xml%isopen then close c_xml; end if;
      raise;
  end getTabColumns;
  --
  -- Query the primary key columns as an XMLType from datadictionary.
  FUNCTION getPKColumns(
      p_Owner      VARCHAR2 ,
      p_Table_Name VARCHAR2)
    RETURN xmltype
  is
    cursor c_xml( b_Owner     varchar2
                , b_TableName varchar2)  
    is select cnt.owner
       ,      cnt.table_name
       ,      cnt.constraint_name
       ,      xmlelement
              ( "PrimaryKey"
              , xmlelement("PrimaryKeyName", cnt.constraint_name)
              , xmlelement
                ( "PrimaryKeyColumns"
                , xmlagg
                  ( xmlelement
                    ( "Column"            
                    , xmlelement("Name", cln.column_name)
                    , xmlelement("Position", cln.position)
                    , xmlelement("DataType", tcl.data_type)
                    , case when tcl.data_type in ('CLOB', 'BLOB', 'XMLTYPE')  then null else xmlelement("DataLength", tcl.data_length) end 
                    , case when tcl.data_precision is null then null else xmlelement("DataPrecision", tcl.data_precision) end
                    , case when tcl.data_scale is null then null else xmlelement("DataScale", tcl.data_scale) end
                    )
                  )
                )
              , ( select xmlelement
                         ( "ReferingForeignKeys"
                         , xmlagg
                           ( xmlelement
                             ( "ReferingForeignKey"
                                , xmlattributes
                                  ( nvl(fdn.IND_IGNORE_CONSTRUCTOR, 'N')  as "IgnoreConstructor"
                                  , nvl(fdn.IND_IGNORE_INS, 'N')  as "IgnoreIns"
                                  , nvl(fdn.IND_IGNORE_TO_XML, 'N')  as "IgnoreToXml"
                                  )
                             , xmlforest
                               ( conr.owner             as "Owner"
                               , conr.constraint_name   as "Name"
                               , conr.constraint_type   as "Type"
                               , conr.table_name        as "TableName"
                               , xxx_table_definitions.getTableNameShort( conr.owner, conr.table_name) as "TableShortName"
                               , xxx_table_definitions.get_type_name( conr.owner, conr.table_name) as "TypeName"
                               , xxx_table_definitions.get_tbl_type_name( conr.owner, conr.table_name) as "TableOfTypeName"
                               , xxx_table_definitions.get_coll_type_name( conr.owner, conr.table_name) as "CollectionTypeName"
                               , conr.r_constraint_name as "RefConstraintName"
                               , conr.r_owner as "RefConstraintOwner"
                               )
                             , xmlelement
                               ( "ConstraintColumns"
                               , xmlelement
                                 ( "ConstraintColumn"
                                 , xmlforest
                                   ( cnlr.column_name as "ColumnName"
                                   , cnlr.position as "Position"
                                   )
                                 )
                               )
                             )
                           ) 
                         ) xml_ref_fks
                  from all_constraints conr
                  join all_cons_columns cnlr 
                    on  cnlr.owner = conr.r_owner
                    and cnlr.constraint_name = conr.constraint_name
                  left outer join xxx_fk_definitions fdn on fdn.fk_name = conr.constraint_name 
                  where conr.r_owner = cnt.owner
                  and   conr.r_constraint_name = cnt.constraint_name
                  and   not exists(select * from xxx_fk_definitions fdn where fdn.fk_name = conr.constraint_name and (fdn.IND_EXCLUDE_REFERING = 'Y' or fdn.FK_TYPE='LOOKUP'))
                )
              ) xml
       from all_constraints cnt
       ,    all_cons_columns cln
       ,    all_tab_columns  tcl
       where cnt.constraint_type = 'P'
       and   cln.owner           = cnt.owner
       and   cln.table_name      = cnt.table_name
       and   cln.constraint_name = cnt.constraint_name
       and   tcl.table_name      = cln.table_name
       and   tcl.owner           = cln.owner
       and   tcl.column_name     = cln.column_name
       and   cnt.owner           = b_Owner
       and   cnt.table_name      = b_TableName
       group by cnt.owner, cnt.table_name, cnt.constraint_name;       
    r_xml c_xml%rowtype;
  begin
    open c_xml( b_Owner     => p_Owner
              , b_TableName => p_Table_Name);
    fetch c_xml into r_xml;
    if c_xml%notfound
    then
      raise no_data_found;
    end if;
    close c_xml;          
    return(r_xml.xml);
  exception
    when others then
      if c_xml%isopen then close c_xml; end if;
      raise;
  end getPKColumns;
  --
  -- Query the foreign keys as an XMLType from datadictionary.
  function getForeignKeys(
      p_Owner      VARCHAR2 ,
      p_Table_Name VARCHAR2) 
  return XMLType 
  is
    cursor c_xml( b_owner varchar2
                , b_table_name varchar2)
    is select xmlelement 
              ( "FkConstraints"
              , xmlagg
                ( xmlelement
                  ( "FkConstraint"
                   , xmlattributes
                    ( nvl(fdn.IND_IGNORE_CONSTRUCTOR, 'N')  as "IgnoreConstructor"
                    , nvl(fdn.IND_IGNORE_INS, 'N')  as "IgnoreIns"
                    , nvl(fdn.IND_IGNORE_TO_XML, 'N')  as "IgnoreToXml"
                    )
                  , xmlforest
                    ( con.owner             as "Owner"
                    , con.constraint_name   as "Name"
                    , con.constraint_type   as "Type"
                    , con.table_name        as "TableName"
                    , xxx_table_definitions.getTableNameShort( con.owner, con.table_name ) as "TableShortName"
                    , xxx_table_definitions.get_type_name( con.owner, con.table_name) as "TypeName"
                    , xxx_table_definitions.get_tbl_type_name( con.owner, con.table_name) as "TableOfTypeName"
                    , xxx_table_definitions.get_coll_type_name( con.owner, con.table_name) as "CollectionTypeName"
                    , nvl(fdn.fk_type, 'DETAIL') as "FkType"
                    )
                  , case when fdn.lookup_attr_name is null then null else xmlelement("LookupAttrName", fdn.lookup_attr_name) end 
                  , xmlelement
                    ( "ConstraintColumns"
                    , xmlelement
                      ( "ConstraintColumn"
                      , xmlforest
                        ( cnlr.column_name as "ColumnName"
                        , cnlr.position as "Position"
                        )
                      )
                    )
                  , ( select xmlelement 
                             ( "RefConstraint"
                             , xmlforest
                               ( conp.owner           as "Owner"
                               , conp.constraint_name as "Name"
                               , conp.constraint_type as "Type"
                               , conp.table_name      as "TableName"
                               , xxx_table_definitions.getTableNameShort(conp.owner, conp.table_name)as "TableShortName"
                               , xxx_table_definitions.get_type_name( conp.owner, conp.table_name) as "TypeName"
                               , xxx_table_definitions.get_tbl_type_name( conp.owner, conp.table_name) as "TableOfTypeName"
                               , xxx_table_definitions.get_coll_type_name( conp.owner, conp.table_name) as "CollectionTypeName"
                               )
                               , xmlelement
                                 ( "ConstraintColumns"
                                 , xmlelement
                                 ( "ConstraintColumn"
                                   , xmlforest
                                   ( cnlp.column_name as "ColumnName"
                                   , cnlp.position as "Position"
                                   )
                                 )
                               )
                             )
                      from all_constraints conp 
                      join all_cons_columns cnlp 
                        on  cnlp.owner = conp.owner
                        and cnlp.constraint_name = conp.constraint_name
                      where conp.owner = con.r_owner
                      and   conp.constraint_name = con.r_constraint_name
                    )
                  )
                )
              ) xml
       from all_constraints con
       join all_cons_columns cnlr
         on  cnlr.owner = con.owner
         and cnlr.constraint_name = con.constraint_name
       left outer join xxx_fk_definitions fdn on fdn.fk_name = con.constraint_name 
       where con.constraint_type = 'R'
       and nvl(fdn.IND_EXCLUDE, 'N') = 'N'
       and con.owner = b_owner
       and con.table_name = b_table_name;
    r_xml c_xml%rowtype;
  begin
    open c_xml( b_Owner      => p_Owner
              , b_Table_Name => p_Table_Name);
    fetch c_xml into r_xml;
    if c_xml%notfound
    then
      raise no_data_found;
    end if;
    close c_xml;          
    return(r_xml.xml);
  exception
    when others then
      if c_xml%isopen then close c_xml; end if;
      raise;
  end getForeignKeys;
  --
  -- Get derived columns of a table
  function getDerivedColumns( p_Owner      VARCHAR2 
                            , p_Table_Name VARCHAR2) 
  return XMLType 
  is
    cursor c_xml( b_owner varchar2
                , b_table_name varchar2)
    is select xmlelement
              ( "DerivedColumns"
              , xmlagg
                ( xmlelement
                  ( "DerivedColumn"
                  , xmlattributes
                    ( dcn.IND_IGNORE_CONSTRUCTOR  as "IgnoreConstructor"
                    , dcn.IND_IGNORE_INS  as "IgnoreIns"
                    , dcn.IND_IGNORE_TO_XML  as "IgnoreToXml"
                    )
                  , xmlforest
                    ( dcn.table_owner as "TableOwner"
                    , dcn.table_name  as "TableName"
                    , xxx_table_definitions.getTableNameShort(dcn.table_owner, dcn.table_name ) as "TableShortName"
                    , dcn.derived_column as "DerivedColumn"
                    , dcn.derivation_attribute as "DerivationAttribute"
                    , dcn.derivation_obj_type  as "DerivationObjectType"
                    , dcn.derivation_method  as "DerivationMethod"
                    , dcn. derivation_attribute_pk_col as "DerivationAttributePkCol"
                    )
                  )
                )
              ) xml
       from xxx_derived_columns dcn
       where table_owner = b_owner
       and   table_name  = b_table_name;
    r_xml c_xml%rowtype;
  begin
    open c_xml( b_Owner      => p_Owner
              , b_Table_Name => p_Table_Name);
    fetch c_xml into r_xml;
    if c_xml%notfound
    then
      raise no_data_found;
    end if;
    close c_xml;          
    return(r_xml.xml);
  exception
    when others then
      if c_xml%isopen then close c_xml; end if;
      raise;
  end getDerivedColumns;
  --
  -- Query table definitions as an XMLType from the data dictionary.
  function getTableDefAsXMLType( p_Table_Owner varchar2
                           , p_Table_Name varchar2) 
                           return XMLType is
    l_Result XMLType;
    cursor c_Tbl ( b_Table_Owner varchar2
                 , b_Table_Name varchar2)
    is select tbl.owner
       ,      tbl.table_name
       ,      xmlelement( "TableDefinition" 
                        , xmlelement("Name", tbl.table_name)
                        , xmlelement("ShortName", xxx_table_definitions.getTableNameShort( tbl.owner, tbl.table_name))
                        , xmlelement("TypeName", xxx_table_definitions.get_type_name( tbl.owner, tbl.table_name))
                        , xmlelement("TableOfTypeName", xxx_table_definitions.get_tbl_type_name( tbl.owner, tbl.table_name))
                        , xmlelement("CollectionTypeName", xxx_table_definitions.get_coll_type_name( tbl.owner, tbl.table_name))
                        , xxx_table_definitions.getTabColumns(tbl.owner, tbl.table_name)
                        , xxx_table_definitions.getPKColumns(tbl.owner, tbl.table_name)
                        , xxx_table_definitions.getForeignKeys(tbl.owner, tbl.table_name)
                        , xxx_table_definitions.getDerivedColumns(tbl.owner, tbl.table_name)
                        , xmlelement 
                          ( "CustomMethods"
                          , ( select xmlagg
                              ( xmlelement 
                                ( "CustomMethod"
                                  , xmlforest
                                  ( cmd.type_name as "typeName"
                                  , cmd.method_name as "methodName"
                                  , cmd.ind_static as "isStatic"
                                  , cmd.method_comment as "methodComment"
                                  , cmd.method_spec as "methodSpecification"
                                  , cmd.method_decl as "methodDeclaration"
                                  )
                                )
                              )
                              from xxx_custom_methods cmd where cmd.table_owner = tbl.owner and cmd.table_name = tbl.table_name
                            )
                          )
                        ) xml
       from all_tables tbl
       where tbl.owner      = b_Table_Owner
       and   tbl.table_name = b_Table_Name
       group by tbl.owner, tbl.table_name
    ;
    r_Tbl c_Tbl%RowType;
  begin
    open c_Tbl( b_Table_Owner => p_Table_Owner
              , b_Table_Name  => p_Table_Name);
    fetch c_Tbl into r_Tbl;
    if c_Tbl%found
    then
      l_Result := r_Tbl.xml;
    else
      l_Result := null;
    end if;
    return(l_Result);
  exception
    when others then
      if c_Tbl%isopen then close c_Tbl; end if;
      raise;
  end getTableDefAsXMLType;
 -- Query table definitions as an XML CLOB from the data dictionary.
  function getTableDefAsXML( p_Table_Owner varchar2
                           , p_Table_Name varchar2) 
                           return clob is
    l_xml xmltype;
    l_Result clob;
  begin
    l_xml := getTableDefAsXMLType( p_Table_Owner => p_Table_Owner
                                 , p_Table_Name => p_Table_Name ) ;
    if l_xml is not null then
      l_Result := '<?xml version="1.0"?>'||chr(10);
      dbms_lob.append( src_lob =>  l_xml.getClobVal
                     , dest_lob => l_Result);
    else
      l_Result := null;
    end if;
    return(l_Result);
  end getTableDefAsXML;
begin
  -- Initialization
  null;
end xxx_table_definitions;
/
