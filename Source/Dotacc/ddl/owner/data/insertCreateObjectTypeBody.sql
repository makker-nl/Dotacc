set serveroutput on
set define off
declare
  l_xsl_name xxx_xml_documents.docname%type := 'CreateObjectTypeBody_1.2.xsl';
  l_xsl_content clob  := q'{<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" indent="no"/>
  <!-- Stylesheet to Generate an Oracle Object Type body from an XML Query on a table in the database
     Author: Martien van den Akker, Darwin-IT Professionals
     Version 1.1, juni 2014
-->
  <!-- Variables -->
  <!-- newLine -->
  <xsl:variable name="newLine" select="'&#10;'"/>
  <!-- newLine and a comma -->
  <xsl:variable name="newLineComma" select="concat($newLine,', ')"/>
  <!-- space -->
  <xsl:variable name="space" select="' '"/>
  <!-- Apostrophe  -->
  <xsl:variable name="apos" select='"&apos;"'/>
  <!-- table prefix length-->
  <xsl:variable name="tblPrefixLength" select="number(4)"/>
 <!-- Member Names -->
  <xsl:variable name="insertMemberName" select="'ins'"/>
  <xsl:variable name="updateMemberName" select="'upd'"/>
  <xsl:variable name="updateNotNulAttrsMemberName" select="'upd_not_null_attrs'"/>
  <xsl:variable name="deleteMemberName" select="'del'"/>
  <xsl:variable name="toXmlMemberName" select="'to_xml'"/>
  <!-- Quote -->
  <xsl:variable name="quote">
    <xsl:text disable-output-escaping="yes">"</xsl:text>
  </xsl:variable>
  <!-- Create type body -->
  <xsl:variable name="CreateTypeBody">
    <xsl:text disable-output-escaping="no">create or replace type body </xsl:text>
  </xsl:variable>
  <xsl:variable name="ObjectTypeBodyHeading">
    <xsl:text>is
  /* Member constructor, procedures and functions  */
</xsl:text>
  </xsl:variable>
  <xsl:variable name="CloseType" select="concat($newLine,'end;')"/>
  <xsl:variable name="ImplementationStart" select="concat('  is',$newLine,'  begin',$newLine)"/>
  <xsl:variable name="intolresult">
    <xsl:text>
                     )
      into l_result
    from dual;
</xsl:text>
  </xsl:variable>
  <!-- Insert Declaration> -->
  <xsl:variable name="InsertDecl">
    <xsl:text>
    insert
    into </xsl:text>
  </xsl:variable>
  <!-- Variable for insert values clause -->
  <xsl:variable name="InsertValues">
    <xsl:text>    )
    values
</xsl:text>
  </xsl:variable>
  <!-- Update Declaration> -->
  <xsl:variable name="UpdateDecl">
    <xsl:text>
    update </xsl:text>
  </xsl:variable>
  <!-- Delete Declaration> -->
  <xsl:variable name="DeleteDecl">
    <xsl:text>
    delete </xsl:text>
  </xsl:variable>
  <!-- Main Template -->
  <xsl:template match="/">
    <xsl:apply-templates select="/TableDefinition" mode="ObjectTypeBody"/>
  </xsl:template>
  <!-- Object Type Body -->
  <xsl:template name="ObjectTypeBody" match="/TableDefinition" mode="ObjectTypeBody">
    <xsl:variable name="typeName" > 
       <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="TypeName"/> 
       </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($CreateTypeBody,$typeName, $space, $ObjectTypeBodyHeading)"/>
    <xsl:call-template name="ParameterlessConstructor">
      <xsl:with-param name="memberName" select="$typeName"/>
    </xsl:call-template>
    <xsl:call-template name="PKConstructor">
      <xsl:with-param name="memberName" select="$typeName"/>
    </xsl:call-template>
    <xsl:call-template name="ProcedureIns"/>
    <xsl:call-template name="ProcedureUpd"/>
    <xsl:call-template name="ProcedureUpdNotNullAttrs"/>
    <xsl:call-template name="ProcedureDel"/>
    <xsl:call-template name="ProcedureDelCasc"/>
    <xsl:call-template name="FunctionToXml"/>
    <xsl:call-template name="CustomMethods">
      <xsl:with-param name="typeName" select="$typeName"/>
    </xsl:call-template>
    <xsl:value-of select="$CloseType"/>
  </xsl:template>
  <!-- Parameterless Constructor -->
  <xsl:template name="ParameterlessConstructor">
    <xsl:param name="memberName"/>
    <xsl:value-of select="concat('  --',$newLine,'  -- Parameterless constructor')"/>
    <xsl:value-of select="concat($newLine,'  constructor function ', $memberName,$newLine,'  return self as result',$newLine)"/>
    <xsl:value-of select="$ImplementationStart"/>
    <xsl:value-of select="concat('    -- Instantiate an empty object, to be filled later.',$newLine)"/>
    <xsl:value-of select="concat('    return;',$newLine)"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$memberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to build a Primary Key based constructor -->
  <xsl:template name="PKConstructor">
    <xsl:param name="memberName"/>
    <xsl:call-template name="PKConstructorDecl">
      <xsl:with-param name="memberName" select="$memberName"/>
    </xsl:call-template>
    <xsl:value-of select="$ImplementationStart"/>
    <xsl:call-template name="SelectInto"/>
    <!-- Call constructors of Derivation Attributes -->
    <xsl:apply-templates select="DerivedColumns/DerivedColumn" mode="ConstructDerivationAttributes"/>
    <!-- Call constructors of FK Lookup Attributes -->
    <xsl:apply-templates select="FkConstraints/FkConstraint[FkType='LOOKUP']" mode="ConstructFKAttributes"/>
    <!-- Call constructors of FK Collection Attributes -->
    <xsl:apply-templates select="PrimaryKey/ReferingForeignKeys/ReferingForeignKey" mode="ConstructRefFKAttributes"/>
    <xsl:value-of select="concat($newLine,'    return;',$newLine)"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$memberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Primary Key based Constructor Declaration -->
  <xsl:template name="PKConstructorDecl">
    <xsl:param name="memberName"/>
    <xsl:value-of select="concat('  --',$newLine,'  -- Primary Key based Constructor',$newLine)"/>
    <xsl:value-of select="concat('  constructor function ',$memberName)"/>
    <xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[1]" mode="PKConstructorParametersFirst"/>
    <xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[position()>1]" mode="PKConstructorParametersRest"/>
    <xsl:value-of select="concat(')',$newLine,'  return self as result',$newLine)"/>
  </xsl:template>
  <!-- First parameter of the parameter list (starts with a opening bracket) -->
  <xsl:template name="PKConstructorParametersFirst" match="PrimaryKey/PrimaryKeyColumns/Column"
                mode="PKConstructorParametersFirst">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('( p_',Name, ' ', DataType)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Rest of the parameters of the parameter list (parameters start with comma, list ends with closing bracket) -->
  <xsl:template name="PKConstructorParametersRest" match="PrimaryKey/PrimaryKeyColumns/Column"
                mode="PKConstructorParametersRest">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat(', p_',Name, ' ', DataType)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Select into part of constructor -->
  <xsl:template name="SelectInto">
    <xsl:apply-templates select="Columns/Column[1]" mode="SelectColumnFirst"/>
    <xsl:apply-templates select="Columns/Column[position()>1]" mode="SelectColumnRest"/>
    <xsl:apply-templates select="Columns/Column[1]" mode="IntoColumnFirst"/>
    <xsl:apply-templates select="Columns/Column[position()>1]" mode="IntoColumnRest"/>
    <xsl:call-template name="From"/>
    <xsl:call-template name="PkWhere"/>
  </xsl:template>
  <!-- Select columns, first column with select statement -->
  <xsl:template name="SelectColumnFirst" match="Columns/Column" mode="SelectColumnFirst">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('    select ', ColName)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Select columns, rest of columns with comma's  -->
  <xsl:template name="SelectColumnRest" match="Columns/Column" mode="SelectColumnRest">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'    ,      ',ColName)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Into variables clause, first column, with into clause -->
  <xsl:template name="IntoColumnFirst" match="Columns/Column" mode="IntoColumnFirst">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine, '    into   self.', ColName)"/>
    </xsl:call-template>  
  </xsl:template>
  <!-- Into variables clause, rest of columns column, with comma's -->
  <xsl:template name="IntoColumnRest" match="Columns/Column" mode="IntoColumnRest">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine, '    ,      self.',ColName)"/>
    </xsl:call-template>  
  </xsl:template>
  <!-- From clause -->
  <xsl:template name="From">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine, '    from ', Name)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- where clause -->
  <xsl:template name="PkWhere">
    <xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[1]" mode="PkWhereClauseFirst"/>
    <xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[position()>1]" mode="PkWhereClauseRest"/>
    <xsl:value-of select="';'"/>
  </xsl:template>
  <xsl:template name="PkWhereClauseFirst" match="PrimaryKey/PrimaryKeyColumns/Column" mode="PkWhereClauseFirst">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine, '    where ', Name, ' = p_', Name)"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="PkWhereClauseRest" match="PrimaryKey/PrimaryKeyColumns/Column" mode="PkWhereClauseRest">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine, '    and   ', Name, ' = p_', Name)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Construct  Derivation Attributes: attributes to derive table-column-attributes -->
  <xsl:template name="ConstructDerivationAttributes" match="DerivedColumn" mode="ConstructDerivationAttributes">
    <xsl:variable name="derivedColumn" select="./DerivedColumn/text()"/>
    <xsl:variable name="derivationAttribute" select="./DerivationAttribute/text()"/>
    <xsl:variable name="derivationAttributeType" select="./DerivationObjectType/text()"/>
    <xsl:variable name="ignoreConstructor" select="@IgnoreConstructor"/>
    <xsl:if test="$ignoreConstructor='N' or string-length($ignoreConstructor) = 0">
      <xsl:value-of select="concat($newLine,'    -- Construct derivation attribute ' , $derivationAttribute)"/>
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="concat($newLine,'    ',$derivationAttribute, ' := ' , $derivationAttributeType,'( self.', $derivedColumn ,');')"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- Generate Lookup FK Attributes -->
  <xsl:template name="ConstructFKAttributes" match="FkConstraint" mode="ConstructFKAttributes">
    <xsl:variable name="tableShortName" select="./RefConstraint/TableShortName/text()"/>
    <xsl:variable name="attribute" select="LookupAttrName"/>
    <xsl:variable name="attributeType" select="./RefConstraint/TypeName/text()"/>
    <xsl:value-of select="concat($newLine,'    -- Call Constructor Lookup object ', $attribute,' for FK ',Name,$newLine)"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[1]" mode="FirstFKAttributeIfNotNullParameter"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[position()>1]"
                         mode="RestFKAttributeIfNotNullParameters"/>
    <xsl:value-of select="concat($newLine,'    then',$newLine)"/>
    <xsl:value-of select="concat('      ',$attribute, ' := ' , $attributeType)"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[1]" mode="FirstFKAttributeConstructorParameter"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[position()>1]"
                         mode="RestFKAttributeConstructorParameters"/>
    <xsl:value-of select="');'"/>
    <xsl:value-of select="concat($newLine,'    end if;')"/>
  </xsl:template>
  <!-- Generate First If FK Attribute Constructor parameter is not null-->
  <xsl:template name="FirstFKAttributeIfNotNullParameter" match="ConstraintColumn"
                mode="FirstFKAttributeIfNotNullParameter">
    <xsl:variable name="fkColumnName" select="ColumnName"/>
    <xsl:variable name="fkColumnPos" select="Position"/>
    <xsl:variable name="pkColumnName"
                  select="../../RefConstraint/ConstraintColumns/ConstraintColumn[Position=$fkColumnPos]/ColumnName"/>
    <xsl:value-of select="concat('    if self.',$fkColumnName, ' is not null')"/>
  </xsl:template>
  <!-- Generate First If FK Attribute Constructor parameter is not null-->
  <xsl:template name="RestFKAttributeIfNotNullParameters" match="ConstraintColumn"
                mode="RestFKAttributeIfNotNullParameters">
    <xsl:variable name="fkColumnName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="ColumnName" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="fkColumnPos" select="Position"/>
    <xsl:variable name="pkColumnName"
                  select="../../RefConstraint/ConstraintColumns/ConstraintColumn[Position=$fkColumnPos]/ColumnName"/>
    <xsl:value-of select="concat($newLine,'    or self.',$fkColumnName, ' is not null')"/>
  </xsl:template>
  <!-- Generate First of Lookup FK Attribute Constructor parameter -->
  <xsl:template name="FirstFKAttributeConstructorParameter" match="ConstraintColumn"
                mode="FirstFKAttributeConstructorParameter">
    <xsl:variable name="fkColumnName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="ColumnName" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="fkColumnPos" select="Position"/>
    <xsl:variable name="pkColumnName"
                  select="../../RefConstraint/ConstraintColumns/ConstraintColumn[Position=$fkColumnPos]/ColumnName"/>
    <xsl:value-of select="concat($newLine,'      ( p_',$pkColumnName,' => self.',$fkColumnName)"/>
  </xsl:template>
  <!-- Generate Rest of Lookup FK Attribute Constructor parameter -->
  <xsl:template name="RestFKAttributeConstructorParameters" match="ConstraintColumn"
                mode="RestFKAttributeConstructorParameters">
     <xsl:variable name="fkColumnName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="ColumnName" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="fkColumnPos" select="Position"/>
    <xsl:variable name="pkColumnName"
                  select="../../RefConstraint/ConstraintColumns/ConstraintColumn[Position=$fkColumnPos]/ColumnName"/>
    <xsl:value-of select="concat($newLine,'      , p_',$pkColumnName,' => self.',$fkColumnName)"/>
  </xsl:template>
  <!-- Generate Refering FK Attributes -->
  <xsl:template name="ConstructRefFKAttributes" match="ReferingForeignKey" mode="ConstructRefFKAttributes">
    <xsl:variable name="tableName" select="./TableName/text()"/>
    <xsl:variable name="tableShortName" select="./TableShortName/text()"/>
    <xsl:variable name="collAttribute" select="substring($tableName, $tblPrefixLength+1)"/>
    <xsl:variable name="collAttributeType" select="./CollectionTypeName/text()"/> 
    <xsl:value-of select="concat($newLine,'    -- Call Constructor Collection object ', $collAttribute,' for FK ',Name,$newLine)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('    ',$collAttribute, ' := ' , $collAttributeType)"/>
    </xsl:call-template>  
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[1]" mode="FirstRefFKAttributeConstructorParameter"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[position()>1]"
                         mode="RestRefFKAttributeConstructorParameters"/>
    <xsl:value-of select="');'"/>
  </xsl:template>
  <!-- Generate First of Refering  FK Attribute Constructor parameter -->
  <xsl:template name="FirstRefFKAttributeConstructorParameter" match="ConstraintColumn"
                mode="FirstRefFKAttributeConstructorParameter">
    <xsl:variable name="consColumnName" select="ColumnName"/>
    <xsl:variable name="consColumnPos" select="Position"/>
    <xsl:variable name="pkColumnName" select="../../../../PrimaryKeyColumns/Column[Position=$consColumnPos]/Name"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'      ( p_',$consColumnName,' => p_',$pkColumnName)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Generate Rest of Refering FK Attribute Constructor parameter -->
  <xsl:template name="RestRefFKAttributeConstructorParameters" match="ConstraintColumn"
                mode="RestRefFKAttributeConstructorParameters">
    <xsl:variable name="consColumnName" select="ColumnName"/>
    <xsl:variable name="consColumnPos" select="Position"/>
    <xsl:variable name="pkColumnName" select="../../../../PrimaryKeyColumns/Column[Position=$consColumnPos]/Name"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'      , p_',$consColumnName,' => p_',$pkColumnName)"/>
    </xsl:call-template>
    <!--<xsl:value-of select="concat($newLine,'      ,','p_',$pkColumnName)"/> -->
  </xsl:template>
}';
l_xsl_content_b clob := q'{  <!-- Template to build an Insert Member Procedure -->
  <xsl:template name="ProcedureIns">
    <xsl:value-of select="concat('  --',$newLine,'  -- Perform Insert on object and sub-types.',$newLine)"/>
    <xsl:value-of select="concat('  member procedure ', $insertMemberName, $newLine,'  is',$newLine,'  begin')"/>
    <!-- Call select methods of Derivation Attributes -->
    <xsl:apply-templates select="DerivedColumns/DerivedColumn" mode="SelectDerivationAttributes"/>
    <!-- Call insert of Lookup FK Attributes -->
    <xsl:apply-templates select="FkConstraints/FkConstraint[FkType='LOOKUP']" mode="CallFKAttributesIns"/>
    <xsl:call-template name="InsertIntoStmt">
      <xsl:with-param name="tableName">
        <xsl:call-template name="toLowerCase">
          <xsl:with-param name="text"  select="Name"/>
        </xsl:call-template>
      </xsl:with-param> 
    </xsl:call-template>
    <!-- Call insert of Refering FK Attributes -->
    <xsl:apply-templates select="PrimaryKey/ReferingForeignKeys/ReferingForeignKey" mode="CallRefFKAttributesIns"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$insertMemberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Perform Select method of Derivation Attributes: attributes to derive table-column-attributes -->
  <xsl:template name="SelectDerivationAttributes" match="DerivedColumn" mode="SelectDerivationAttributes">
    <xsl:variable name="ignoreIns" select="@IgnoreIns"/>
    <xsl:if test="$ignoreIns='N' or string-length($ignoreIns) = 0">
      <xsl:variable name="derivedColumn" select="./DerivedColumn/text()"/>
      <xsl:variable name="derivationAttribute" select="./DerivationAttribute/text()"/>
      <xsl:variable name="derivationAttributeType" select="./DerivationObjectType/text()"/>
      <xsl:variable name="derivationMethod" select="./DerivationMethod/text()"/>
      <xsl:variable name="derivationAttributePkCol" select="./DerivationAttributePkCol/text()"/>
      <xsl:value-of select="concat($newLine,'    -- Perform select method of derivation attribute ' , $derivationAttribute)"/>
      <xsl:value-of select="concat($newLine,'    if ',$derivationAttribute, ' is not null then')"/>
      <xsl:value-of select="concat($newLine,'      ',$derivationAttribute, '.' , $derivationMethod,';')"/>
      <xsl:value-of select="concat($newLine,'      -- Assign pk of ' , $derivationAttribute, ' to derived attribute')"/>
      <xsl:value-of select="concat($newLine,'      self.',$derivedColumn, ' := ' , $derivationAttribute,'.',$derivationAttributePkCol,';')"/>
      <xsl:value-of select="concat($newLine,'    end if;')"/>
    </xsl:if>
  </xsl:template>
  <!-- Call ins of Lookup FK Attributes -->
 <xsl:template name="CallFKAttributesIns" match="FkConstraint" mode="CallFKAttributesIns">
    <xsl:variable name="ignoreIns" select="@IgnoreIns"/>
    <xsl:if test="$ignoreIns='N' or string-length($ignoreIns) = 0">
      <xsl:variable name="attribute" >
        <xsl:call-template name="toLowerCase">
          <xsl:with-param name="text" select="LookupAttrName"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="concat($newLine,'    -- ',$cmtCallFKAttributesInsA, $attribute,' for FK ',Name)"/> 
      <xsl:value-of select="concat($newLine,'    if self.', $attribute,' is not null then',$newLine)"/>
      <xsl:value-of select="concat('      ',$attribute, '.ins;')"/>
      <xsl:value-of select="concat($newLine,'      -- ',$cmtCallFKAttributesInsB)"/>
      <!-- Assign FK Attributes -->
      <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[1]" mode="InsertFKAttributesAssign"/>
      <xsl:value-of select="concat($newLine,'    end if;')"/>
    </xsl:if>
  </xsl:template>
  <!-- Generate First of Lookup FK Attribute Constructor parameter -->
  <xsl:template name="InsertFKAttributesAssign" match="ConstraintColumn" mode="InsertFKAttributesAssign">
    <xsl:variable name="attribute" select="../../LookupAttrName"/>
    <xsl:variable name="fkColumnName" select="ColumnName"/>
    <xsl:variable name="fkColumnPos" select="Position"/>
    <xsl:variable name="pkColumnName"
                  select="../../RefConstraint/ConstraintColumns/ConstraintColumn[Position=$fkColumnPos]/ColumnName"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'      self.',$fkColumnName,' := ',$attribute,'.',$pkColumnName,';')"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Call ins of Refering FK Attributes -->
  <xsl:template name="CallRefFKAttributesIns" match="ReferingForeignKey" mode="CallRefFKAttributesIns">
    <xsl:variable name="ignoreIns" select="@IgnoreIns"/>
    <xsl:if test="$ignoreIns='N' or string-length($ignoreIns) = 0">
      <xsl:variable name="constraintName">
        <xsl:call-template name="toLowerCase">
          <xsl:with-param name="text" select="./Name/text()"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="tableName">
        <xsl:call-template name="toLowerCase">
          <xsl:with-param name="text" select="./TableName/text()"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="collAttribute">
        <xsl:call-template name="toLowerCase">
          <xsl:with-param name="text" select="substring($tableName, $tblPrefixLength+1)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="setMemberName" select="concat('set_', $constraintName)"/>
      <xsl:value-of select="concat('    -- Call ins method of Collection object ', $collAttribute,' for FK ',Name,$newLine)"/>
      <xsl:value-of select="concat('    if ',$collAttribute, ' is not null then',$newLine)"/>
      <xsl:value-of select="concat('      ',$collAttribute, '.',$setMemberName)"/>
      <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[1]" mode="FirstSetRefFKParameter"/>
      <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[position()>1]" mode="RestSetRefFKParameters"/>
      <xsl:value-of select="concat(');', $newLine)"/>
      <xsl:value-of select="concat('      ',$collAttribute, '.ins;',$newLine)"/>
      <xsl:value-of select="concat('    end if;',$newLine)"/>
    </xsl:if>
  </xsl:template>
  <!-- Template to do the first parameter of setRefFKParameter -->
  <xsl:template name="FirstSetRefFKParameter" match="ConstraintColumn" mode="FirstSetRefFKParameter">
    <xsl:variable name="constraintColPos" select="Position"/>
    <xsl:variable name="attributeName"
                  select="/TableDefinition/PrimaryKey/PrimaryKeyColumns/Column[Position=$constraintColPos]/Name/text()"/>
    <xsl:variable name="constraintColName" select="ColumnName"/>
    <xsl:variable name="parameter" select="concat('p_', $constraintColName)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine, '        ( ', $parameter,' => self.', $attributeName)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to do the rest of parameters  of setRefFKParameter -->
  <xsl:template name="RestSetRefFKParameters" match="ConstraintColumns/ConstraintColumn" mode="RestSetRefFKParameters">
    <xsl:variable name="constraintColPos" select="Position"/>
    <xsl:variable name="attributeName"
                  select="/TableDefinition/PrimaryKey/PrimaryKeyColumns/Column[Position=$constraintColPos]/Name/text()"/>
    <xsl:variable name="constraintColName" select="ColumnName"/>
    <xsl:variable name="parameter" select="concat('p_', $constraintColName)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine, '        , ', $parameter,' => self.', $attributeName)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Insert into part of Member Procedure Insert-->
  <xsl:template name="InsertIntoStmt">
    <xsl:param name="tableName"/>
    <xsl:value-of select="concat($newLine,'    -- Insert into ', $tableName)"/>
    <xsl:value-of select="concat($InsertDecl, $tableName,$newLine)"/>
    <xsl:apply-templates select="Columns/Column[1]" mode="InsertColumnFirst"/>
    <xsl:apply-templates select="Columns/Column[position()>1]" mode="InsertColumnRest"/>
    <xsl:value-of select="$InsertValues"/>
    <xsl:apply-templates select="Columns/Column[1]" mode="InsertValuesColumnFirst"/>
    <xsl:apply-templates select="Columns/Column[position()>1]" mode="InsertValuesColumnRest"/>
    <xsl:call-template name="InsertReturning"/>
    <xsl:call-template name="InsertReturningInto"/>
  </xsl:template>
  <!-- Insert columns, first column prefixed with (-->
  <xsl:template name="InsertColumnFirst" match="Columns/Column" mode="InsertColumnFirst">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('    ( ', ColName, $newLine)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Insert rest columns, prefixed with comma-->
  <xsl:template name="InsertColumnRest" match="Columns/Column" mode="InsertColumnRest">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('    , ', ColName, $newLine)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Insert Into values clause, first column with (-->
  <xsl:template name="InsertValuesColumnFirst" match="Columns/Column" mode="InsertValuesColumnFirst">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('    ( self.', ColName, $newLine)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Insert Into values clause, Rest of columns with ,-->
  <xsl:template name="InsertValuesColumnRest" match="Columns/Column" mode="InsertValuesColumnRest">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('    , self.', ColName, $newLine)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Insert Returning clause -->
  <xsl:template name="InsertReturning">
    <xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[1]" mode="InsertReturningClauseFirst"/>
    <xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[position()>1]" mode="InsertReturningClauseRest"/>
    <xsl:value-of select="$newLine"/>
  </xsl:template>
  <!-- Insert Returning clause, first column with returning clause -->
  <xsl:template name="InsertReturningClauseFirst" match="PrimaryKey/PrimaryKeyColumns/Column"
                mode="InsertReturningClauseFirst">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('    ) returning ', Name)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Insert Returning clause, rest column comma-->
  <xsl:template name="InsertReturningClauseRest" match="PrimaryKey/PrimaryKeyColumns/Column"
                mode="InsertReturningClauseRest">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat(', ', Name)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Insert Returning Into clause -->
  <xsl:template name="InsertReturningInto">
    <xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[1]" mode="InsertReturningIntoClauseFirst"/>
    <xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[position()>1]"
                         mode="InsertIntoReturningClauseRest"/>
    <xsl:value-of select="concat(';',$newLine)"/>
  </xsl:template>
  <!-- Insert Returning clause, first column with into clause -->
  <xsl:template name="InsertReturningIntoClauseFirst" match="PrimaryKey/PrimaryKeyColumns/Column"
                mode="InsertReturningIntoClauseFirst">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('      into self.', Name)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Insert Returning clause, rest column comma-->
  <xsl:template name="InsertIntoReturningClauseRest" match="PrimaryKey/PrimaryKeyColumns/Column"
                mode="InsertIntoReturningClauseRest">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat(', self.', Name)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to build an Update Member Procedure -->
  <xsl:template name="ProcedureUpd">
    
    <xsl:value-of select="concat('  --',$newLine,'  -- Perform an Update on object.',$newLine)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('  member procedure ', $updateMemberName, $newLine,'  is',$newLine,'  begin')"/>
    </xsl:call-template>
    <xsl:call-template name="UpdateStmt"/>
    <xsl:value-of select="$newLine"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$updateMemberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Update statement, where-clause based on PK -->
  <xsl:template name="UpdateStmt">
    <xsl:value-of select="concat($newLine,'    -- Update ', Name)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($UpdateDecl, Name)"/>
    </xsl:call-template>
    <xsl:apply-templates select="Columns/Column[1]" mode="UpdateColumnFirst"/>
    <xsl:apply-templates select="Columns/Column[position()>1]" mode="UpdateColumnRest"/>
    <xsl:call-template name="UpdatePkWhere"/>
  </xsl:template>
  <!-- Update columns, first column prefixed with set -->
  <xsl:template name="UpdateColumnFirst" match="Columns/Column" mode="UpdateColumnFirst">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'    set ', ColName, ' = self.', ColName)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Update rest columns, prefixed with comma-->
  <xsl:template name="UpdateColumnRest" match="Columns/Column" mode="UpdateColumnRest">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'    , ', ColName, ' = self.', ColName)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to build an Update Not Null Attrs Member Procedure -->
  <xsl:template name="ProcedureUpdNotNullAttrs">
    <xsl:value-of select="concat('  --',$newLine,'  -- Perform an Update on object, update columns only when attribute is not null.',$newLine)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('  member procedure ', $updateNotNulAttrsMemberName, $newLine,'  is',$newLine,'  begin')"/>
    </xsl:call-template>
    <xsl:call-template name="UpdateNotNullAttrsStmt"/>
    <xsl:value-of select="$newLine"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$updateNotNulAttrsMemberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Update statement with where-clause based on PK, columns are set only when attributes are not null -->
  <xsl:template name="UpdateNotNullAttrsStmt">
    <xsl:value-of select="concat($newLine,'    -- Update ', Name)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($UpdateDecl, Name)"/>
    </xsl:call-template>
    <xsl:apply-templates select="Columns/Column[1]" mode="UpdateNotNullAttrsFirst"/>
    <xsl:apply-templates select="Columns/Column[position()>1]" mode="UpdateNotNullAttrsRest"/>
    <xsl:call-template name="UpdatePkWhere"/>
  </xsl:template>
  <!-- Update Not Null Attributes columns, first column prefixed with set -->
  <xsl:template name="UpdateNotNullAttrsFirst" match="Columns/Column" mode="UpdateNotNullAttrsFirst">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'    set ', ColName, ' = ( case when (self.',ColName,' is not null ) then self.',ColName,' else ',ColName,' end)')"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Update  Not Null Attributes, rest columns, prefixed with comma-->
  <xsl:template name="UpdateNotNullAttrsRest" match="Columns/Column" mode="UpdateNotNullAttrsRest">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'    , ', ColName, ' = ( case when (self.',ColName,' is not null ) then self.',ColName,' else ',ColName,' end)')"/>
    </xsl:call-template>
  </xsl:template>
  <!-- where clause for update-->
  <xsl:template name="UpdatePkWhere">
    <xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[1]" mode="UpdatePkWhereClauseFirst"/>
    <xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[position()>1]" mode="UpdatePkWhereClauseRest"/>
    <xsl:value-of select="';'"/>
  </xsl:template>
  <xsl:template name="UpdatePkWhereClauseFirst" match="PrimaryKey/PrimaryKeyColumns/Column"
                mode="UpdatePkWhereClauseFirst">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine, '    where ', Name, ' = self.', Name)"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="UpdatePkWhereClauseRest" match="PrimaryKey/PrimaryKeyColumns/Column"
                mode="UpdatePkWhereClauseRest">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine, '    and   ', Name, ' = self.', Name)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to build an Delete Member Procedure -->
  <xsl:template name="ProcedureDel">
    <xsl:value-of select="concat('  --',$newLine,'  -- Perform a Delete on object.',$newLine)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('  member procedure ', $deleteMemberName, $newLine,'  is',$newLine,'  begin')"/>
    </xsl:call-template>
    <xsl:call-template name="DeleteStmt"/> 
    <xsl:value-of select="$newLine"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$deleteMemberName"/>
    </xsl:call-template>
  </xsl:template>
 <!-- Delete statement, where-clause based on PK -->
  <xsl:template name="DeleteStmt">
    <xsl:value-of select="concat($newLine,'    -- Delete ', Name)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($DeleteDecl, Name)"/>
    </xsl:call-template>
    <xsl:call-template name="UpdatePkWhere"/>
  </xsl:template>
  <!-- Template to build an Cascading Delete Member Procedure -->
  <xsl:template name="ProcedureDelCasc">
    <xsl:variable name="memberName" select="'del_casc'"/>
    <xsl:value-of select="concat('  --',$newLine,'  -- Perform a Cascading Delete on object.',$newLine)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('  member procedure ', $memberName, $newLine,'  is',$newLine,'  begin')"/>
    </xsl:call-template>
    <!-- Call del_casc of Collection Attributes Refering FK  -->
    <xsl:apply-templates select="PrimaryKey/ReferingForeignKeys/ReferingForeignKey" mode="CallRefFKAttributesDelCasc"/>
    <!-- Generate call to object's own del method -->
    <xsl:value-of select="concat($newLine, concat('    -- Call the object',$apos,'s own del method.'))"/>
    <xsl:value-of select="concat($newLine, '    self.del;')"/>
    <!-- Call del_casc of Lookup FK Attributes -->
    <xsl:apply-templates select="FkConstraints/FkConstraint[FkType='LOOKUP']" mode="CallFKAttributesDelCasc"/>
    <xsl:value-of select="$newLine"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$memberName"/>
    </xsl:call-template>
  </xsl:template>
   <!-- Call del_casc of Refering FK Attributes -->
  <xsl:template name="CallRefFKAttributesDelCasc" match="ReferingForeignKey" mode="CallRefFKAttributesDelCasc">
    <xsl:variable name="ignoreIns" select="@IgnoreIns"/>
    <xsl:if test="$ignoreIns='N' or string-length($ignoreIns) = 0">
      <xsl:variable name="constraintName" select="./Name/text()"/>
      <xsl:variable name="tableName" select="./TableName/text()"/>
      <xsl:variable name="collAttribute" select="substring($tableName, $tblPrefixLength+1)"/>
      <xsl:variable name="setMemberName" select="concat('set_', $constraintName)"/>
      <xsl:value-of select="concat($newLine,'    -- Call del_casc method of Collection object ', $collAttribute,' for FK ',Name)"/>
      <xsl:value-of select="concat($newLine,'    if ',$collAttribute, ' is not null then')"/>
      <xsl:value-of select="concat($newLine,'      ',$collAttribute, '.del_casc;')"/>
      <xsl:value-of select="concat($newLine,'    end if;')"/>
    </xsl:if>
  </xsl:template>
  <!-- Call del_casc of Lookup FK Attributes -->
  <xsl:template name="CallFKAttributesDelCasc" match="FkConstraint" mode="CallFKAttributesDelCasc">
    <xsl:variable name="attribute" select="LookupAttrName"/>
    <xsl:value-of select="concat($newLine,'    -- Call del_casc method of LookUp object ', $attribute,' for FK ',Name)"/>
    <xsl:value-of select="concat($newLine,'    if self.', $attribute,' is not null then')"/>
    <xsl:value-of select="concat($newLine,'      ',$attribute, '.del_casc;')"/>
    <xsl:value-of select="concat($newLine,'    end if;')"/>
  </xsl:template>
  <!-- Template to build a ToXML Member Function-->
  <xsl:template name="FunctionToXml">
    <xsl:value-of select="concat('  --',$newLine,'  -- ',$toXmlMemberName,' Method, to get the attributes as an XMLType, including those of subtypes.',$newLine)"/>
    <xsl:value-of select="concat('  member function ', $toXmlMemberName,$newLine)"/>
    <xsl:value-of select="concat('  return sys.xmltype', $newLine)"/>
    <xsl:value-of select="concat('  is', $newLine,'    l_result sys.xmltype;', $newLine)"/>
    <xsl:value-of select="concat('  begin', $newLine)"/>
    <xsl:call-template name="SelectIntoXML"/>
    <xsl:value-of select="concat('    return l_result;',$newLine)"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$toXmlMemberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Select Object Type attributes Into XMLType -->
  <xsl:template name="SelectIntoXML">
    <xsl:call-template name="SelectXMLName"/>
    <xsl:apply-templates select="Columns/Column" mode="SelectXMLColumn"/>
    <!-- Call to_xml of Derivation Attributes -->
    <xsl:apply-templates select="DerivedColumns/DerivedColumn" mode="CallDerivationAttributesToXml"/>
    <!-- Call to_xml of Lookup FK Attributes -->
    <xsl:apply-templates select="FkConstraints/FkConstraint[FkType='LOOKUP']" mode="CallFKAttributesToXml"/>
    <!-- Call to_xml of Refering FK Attributes -->
    <xsl:apply-templates select="PrimaryKey/ReferingForeignKeys/ReferingForeignKey" mode="CallRefFKAttributesToXml"/>
    <xsl:value-of select="$intolresult"/>
  </xsl:template>
  <!-- Select Object Type: Select clause -->
  <xsl:template name="SelectXMLName">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('    select xmlelement( ',$quote, Name,$quote)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Select Object Type: Columns -->
  <xsl:template name="SelectXmlColumnFirst" match="Columns/Column" mode="SelectXMLColumn">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'                     , xmlelement(',$quote,ColName,$quote,', ',ColName, ')')"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Call to_xml of Derivation Attributes -->
  <xsl:template name="CallDerivationAttributesToXml" match="DerivedColumn" mode="CallDerivationAttributesToXml">
    <xsl:variable name="derivedColumn" select="./DerivedColumn/text()"/>
    <xsl:variable name="derivationAttribute">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="./DerivationAttribute/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="derivationAttributeType">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="./DerivationObjectType/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="ignoreToXml" select="@IgnoreToXml"/>
    <xsl:if test="$ignoreToXml='N' or string-length($ignoreToXml) = 0">
      <xsl:value-of select="concat($newLine,'                     -- Call to_xml methof of derivation attribute ' , $derivationAttribute)"/>
      <xsl:value-of select="concat($newLine,'                     , ',$derivationAttribute, '.to_xml()')"/>
    </xsl:if>
  </xsl:template>
  <!-- Call to_xml of Lookup FK Attributes -->
  <xsl:template name="CallFKAttributesToXml" match="FkConstraint" mode="CallFKAttributesToXml">
    <xsl:variable name="attribute">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="LookupAttrName"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($newLine,'                     -- Call to_xml method of Lookup object ', $attribute,' for FK ',Name)"/>
    <xsl:value-of select="concat($newLine,'                     , ',$attribute, '.to_xml()')"/>
  </xsl:template>
  <!-- Call to_xml of Refering FK Attributes -->
  <xsl:template name="CallRefFKAttributesToXml" match="ReferingForeignKey" mode="CallRefFKAttributesToXml">
    <xsl:variable name="tableName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="./TableName/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="collAttribute" select="substring($tableName, $tblPrefixLength+1)"/>
    <xsl:value-of select="concat($newLine,'                     -- Call to_xml method of Collection object ', $collAttribute,' for FK ',Name)"/>
    <xsl:value-of select="concat($newLine,'                     , ',$collAttribute, '.to_xml()')"/>
  </xsl:template>
  <!-- Member End Body -->
  <xsl:template name="MemberEndBody">
    <xsl:param name="memberName"/>
    <xsl:variable name="MemberEndBody" select="concat('  end ', $memberName,';', $newLine)"/>
    <xsl:value-of select="$MemberEndBody"/>
  </xsl:template>
  <!-- Generate the Custom Methods -->
  <xsl:template name="CustomMethods">
    <xsl:param name="typeName" />
    <xsl:value-of select="concat('  --', $newLine,'  -- Custom Methods for ', $typeName, $newLine,'  --')" />
    <xsl:apply-templates select="CustomMethods/CustomMethod[typeName=$typeName]" />
  </xsl:template>
    <!-- Generate a Custom Method -->
  <xsl:template name="CustomMethod" match="CustomMethods/CustomMethod" >
    <xsl:value-of select="concat($newLine,'  ', methodComment)"/>
    <xsl:value-of select="concat($newLine,'  member ' , methodDeclaration, $newLine)"/>
  </xsl:template>
  <!-- to LowerCase -->
  <xsl:template name="toLowerCase"  >
    <xsl:param name="text" />
    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ'" />
    <xsl:value-of select="translate($text, $uppercase, $smallcase)" />
  </xsl:template>
</xsl:stylesheet>}';

begin
  dbms_lob.append(l_xsl_content, l_xsl_content_b);
  dbms_output.put_line('Save '||l_xsl_name);
  xxx_xmldoc.save( name   => l_xsl_name
                 , xmldoc => l_xsl_content);
end;