<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" indent="no"/>
  <!-- Stylesheet to Generate an Oracle 'Table of' Object Type from an XML Query on a table in the database
     Author: Martien van den Akker, Darwin-IT Professionals
     Version 2.0, februari 2016
-->
  <!-- Variables -->
  <!-- newLine -->
  <xsl:variable name="newLine" select="'&#10;'"/>
    <!--<xsl:text>
</xsl:text>
  </xsl:variable> -->
  <!-- newLine and a comma -->
  <xsl:variable name="newLineComma" select="concat($newLine,', ')"/>
  <!-- simple space -->
  <xsl:variable name="space" select="' '"/>
  <!-- table prefix length-->
  <xsl:variable name="tblPrefixLength" select="number(4)"/>
  <!-- Member Names -->
  <xsl:variable name="insertMemberName" select="'ins'"/>
  <xsl:variable name="updateMemberName" select="'upd'"/>
  <xsl:variable name="updateNotNulAttrsMemberName" select="'upd_not_null_attrs'"/>
  <xsl:variable name="deleteMemberName" select="'del'"/>
  <xsl:variable name="deleteCascMemberName" select="'del_casc'"/>
  <xsl:variable name="toXmlMemberName" select="'to_xml'"/>
  <!-- Comments EN 
  <xsl:variable name="cmtHeading" select="'Member constructors, procedures and functions'"/>
  <xsl:variable name="cmtParameterLessConstructor" select="'Parameterless constructor'"/>
  <xsl:variable name="cmtParameterLessConstructorImpl" select="'Instantiate an empty object, to be filled later.'"/>  
  <xsl:variable name="cmtCreateConstructorsImplA" select="'Constructor for FK Constraint '"/>
  <xsl:variable name="cmtSelectDerivationAttributesImplA" select="'Construct derivation attribute '"/>
  <xsl:variable name="cmtSelectDerivationAttributesImplB" select="'Ignore construction of derivation attribute '"/>
  <xsl:variable name="cmtSelectFKAttributesImplA" select="'Construct Lookup attribute based on foreinkey to '"/>
  <xsl:variable name="cmtSelectRefFKAttributesImplA" select="'Construct Collection attribute based on foreinkey to '"/>
  <xsl:variable name="cmtSetFKColMethodA" select="'Method to set columns for FK Constraint '"/>
  <xsl:variable name="cmtSetFKColMethodB" select="' on all members of collection.'"/>
  <xsl:variable name="cmtInsertMethod" select="'Perform Insert of the collection data'"/>
  <xsl:variable name="cmtDeleteMethod" select="'Perform Delete of the collection data'"/>
  <xsl:variable name="cmtDeleteCascMethod" select="'Perform a Cascading Delete of the collection data'"/>
  <xsl:variable name="cmtAddTypeMethodA" select="'Add '"/>
  <xsl:variable name="cmtAddTypeMethodB" select="' to '"/>
  <xsl:variable name="cmtToXMLMethod" select="'Return the collection content as XML'"/>
  <xsl:variable name="cmtAddTypeImplA" select="'Initialize table when not constructed yet.'"/>
   -->
  <!-- Comments NL -->
  <xsl:variable name="cmtHeading" select="'Member constructors, procedures en functies'"/>
  <xsl:variable name="cmtParameterLessConstructor" select="'Parameterloze constructor'"/>
  <xsl:variable name="cmtParameterLessConstructorImpl" select="'Instantieer een leeg object, om naderhand te vullen.'"/>
  <xsl:variable name="cmtCreateConstructorsImplA" select="'Constructor voor FK Constraint '"/>
  <xsl:variable name="cmtSelectDerivationAttributesImplA" select="'Construeer afgeleid attribuut '"/>  
  <xsl:variable name="cmtSelectDerivationAttributesImplB" select="'Negeer constructie van afgeleid attribuut '"/>  
  <xsl:variable name="cmtSelectFKAttributesImplA" select="'Construeer Lookup attribuut gebaseerd op foreinkey naar '"/>
  <xsl:variable name="cmtSelectRefFKAttributesImplA" select="'Construeer Collection attribuut gebaseerd op foreinkey naar '"/>
  <xsl:variable name="cmtSetFKColMethodA" select="'Methode voor het zetten van kolommen voor FK Constraint '"/>
  <xsl:variable name="cmtSetFKColMethodB" select="' op alle voorkomens in de collectie.'"/>
  <xsl:variable name="cmtInsertMethod" select="'Voer een Insert uit op de collectie data.'"/>
  <xsl:variable name="cmtDeleteMethod" select="'Voer een Delete uit op de collectie data.'"/>
  <xsl:variable name="cmtDeleteCascMethod" select="'Voer een a Cascading Delete uit op de collectie data.'"/>
  <xsl:variable name="cmtAddTypeMethodA" select="'Voeg '"/>
  <xsl:variable name="cmtAddTypeMethodB" select="' toe aan '"/>
  <xsl:variable name="cmtToXMLMethod" select="'Retourneer de collectie inhoud als XML.'"/>
  <xsl:variable name="cmtAddTypeImplA" select="'Initialiseer tabel wanneer deze nog niet is constructeerd.'"/>
  <!-- Create Object type body Declaration -->
  <xsl:variable name="createTypeBodyDecl">
    <xsl:text disable-output-escaping="no">create or replace type body </xsl:text>
  </xsl:variable>
  <!-- Constructor Function declaration -->
  <xsl:variable name="constuctorDecl" select="'  constructor function '"/>
  <!-- Constructor Function declaration closure -->
  <xsl:variable name="constuctorDeclClosure"
                select="concat(')', $newLine, '  return self as result', $newLine, '  as', $newLine)"/>
  <!-- Constructor begin body-->
  <xsl:variable name="constuctorBeginBody" select="concat('  begin', $newLine)"/>
  <!-- Close the Type -->
  <xsl:variable name="closeType" select="'end;'"/>
  <!-- Member procedure declaration -->
  <xsl:variable name="memberProc" select="'  member procedure '"/>
  <!-- Member procedure declaration closure -->
  <xsl:variable name="memberProcClosure" select="concat( $newLine, '  as', $newLine)"/>
  <!-- Member function declaration -->
  <xsl:variable name="memberFuncDecl" select="'  member function '"/>
  <!-- Member function declaration closure -->
  <xsl:variable name="memberFuncReturn" select="concat( $newLine, '  return ')"/>
  <!-- Member function declaration closure -->
  <xsl:variable name="memberFuncDeclClosure" select="concat( $newLine, '  as', $newLine)"/>
  <!-- Member begin body-->
  <xsl:variable name="memberBeginBody" select="concat('  begin', $newLine)"/>
  <!-- Object Heading -->
  <xsl:variable name="objectTypeHeading" select="concat('is',$newLine, '/* ',$cmtHeading,' */',$newLine)"/>
  <!-- Select Cast Multi set clause -->
  <xsl:variable name="SelectCastMS"
                select="concat('select cast',$newLine,'           ( multiset', $newLine, '             ( ')"/>
  <!-- Select clause -->
  <xsl:variable name="Select" select="'select '"/>
  <!-- From clause -->
  <xsl:variable name="From" select="'from   '"/>
  <!-- From dual clause -->
  <xsl:variable name="FromDual" select="'from dual'"/>
  <!-- Return clause -->
  <xsl:variable name="Return" select="'return '"/>
  <!-- Where clause -->
  <xsl:variable name="Where" select="'where  '"/>
  <!-- as part of CastMultiset -->
  <xsl:variable name="CastMSAs" select="') AS '"/>
  <!-- Where clause -->
  <xsl:variable name="Into" select="'into  '"/>
  <!-- Self Prefix -->
  <xsl:variable name="SelfPfx" select="'self.'"/>
  <!-- Main template -->
  <xsl:template match="/">
    <xsl:apply-templates select="/TableDefinition/FkConstraints" mode="ObjectColl"/>
    <xsl:apply-templates select="/TableDefinition" mode="CustomMethods"/>
    <xsl:value-of select="$closeType"/>
  </xsl:template>
  <!-- Template to create the object type Body -->
  <xsl:template name="ObjectType" match="/TableDefinition/FkConstraints" mode="ObjectColl">
    <xsl:variable name="tableName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text"  select="FkConstraint[1]/TableName/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="tableShortName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="FkConstraint[1]/TableShortName/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="typeName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="FkConstraint[1]/CollectionTypeName/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="tableOfTypeName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="FkConstraint[1]/TableOfTypeName/text()"/> 
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="tableOfElementTypeName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="FkConstraint[1]/TypeName/text()"/> 
      </xsl:call-template>
    </xsl:variable>  
    <xsl:call-template name="CreateType">
      <xsl:with-param name="typeName" select="$typeName"/>
    </xsl:call-template>
    <!-- Generate a parameterless Constructor -->
    <xsl:call-template name="ParameterlessConstructor">
      <xsl:with-param name="memberName" select="$typeName"/>
    </xsl:call-template>
    <!-- Generate a Foreign Key based Constructors -->
    <xsl:apply-templates select="FkConstraint[FkType='DETAIL']" mode="CreateConstructors"/>
    <!-- Generate Set methods for Foreign Keys -->
    <xsl:apply-templates select="FkConstraint[FkType='DETAIL']" mode="SetFKColDecl"/>
    <!-- Generate insert method -->
    <xsl:call-template name="InsertDecl"/>
    <!-- Generate delete method -->
    <xsl:call-template name="DeleteDecl"/>
    <!-- Generate Cascading delete method -->
    <xsl:call-template name="DeleteCascDecl"/>
    <!-- Generate Add method for single objecs -->
    <xsl:call-template name="AddTypeDecl">
      <xsl:with-param name="tableName" select="$tableName"/>
      <!--<xsl:with-param name="tableShortName" select="$tableShortName"/>-->
      <xsl:with-param name="tableOfElementTypeName" select="$tableOfElementTypeName"/>
      <xsl:with-param name="tableOfTypeName" select="$tableOfTypeName"/>
    </xsl:call-template>
    <!-- Generate Add method for table of objecs -->
    <xsl:call-template name="AddTblDecl">
      <xsl:with-param name="tableName" select="$tableName"/>
      <!--<xsl:with-param name="tableShortName" select="$tableShortName"/> -->
      <xsl:with-param name="tableOfTypeName" select="$tableOfTypeName"/>
    </xsl:call-template>
    <!-- Generate To_xml method -->
    <xsl:call-template name="ToXMLDecl">
      <xsl:with-param name="tableName" select="$tableName"/>
      <!--<xsl:with-param name="tableShortName" select="$tableShortName"/> -->
      <xsl:with-param name="typeName" select="$typeName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to do the create type declaration -->
  <xsl:template name="CreateType">
    <xsl:param name="typeName"/>
    <xsl:value-of select="concat($createTypeBodyDecl, $typeName, $space, $objectTypeHeading )"/>
  </xsl:template>
  <!-- Parameterless Constructor -->
  <xsl:template name="ParameterlessConstructor">
    <xsl:param name="memberName"/>
    <xsl:value-of select="concat('  --',$newLine,'  -- ',$cmtParameterLessConstructor)"/>
    <xsl:value-of select="concat($newLine,'  constructor function ', $memberName,$newLine,'  return self as result',$newLine)"/>
    <xsl:value-of select="concat('  is',$newLine,'  begin',$newLine)"/>
    <xsl:value-of select="concat('    -- ',$cmtParameterLessConstructorImpl,$newLine)"/>
    <xsl:value-of select="concat('    return;',$newLine)"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$memberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to create a constructor -->
  <xsl:template name="CreateConstructors" match="FkConstraint" mode="CreateConstructors">
    <xsl:variable name="tableName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="./TableName/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="tableShortName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="./TableShortName/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="typeName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="./CollectionTypeName/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="constraintName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text"  select="./Name/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="tableAttribute">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="substring($tableName, $tblPrefixLength+1)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="tableAttributeType">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text"  select="./TableOfTypeName/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('--', $newLine, '-- ',$cmtCreateConstructorsImplA,$constraintName,$newLine)"/>
    <xsl:value-of select="concat($constuctorDecl, $typeName)"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[1]" mode="FirstConstructorparameter"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[position()>1]" mode="NextConstructorparameters"/>
    <xsl:value-of select="$constuctorDeclClosure"/>
    <xsl:value-of select="$constuctorBeginBody"/>
    <xsl:value-of select="concat('    ',$SelectCastMS,$Select)"/>
    <xsl:apply-templates select="/TableDefinition/Columns/Column[1]" mode="FirstSelectColumn"/>
    <xsl:apply-templates select="/TableDefinition/Columns/Column[position()>1]" mode="RestSelectColumns"/>
    <xsl:apply-templates select="/TableDefinition/DerivedColumns/DerivedColumn" mode="SelectDerivationAttributes"/>
    <xsl:apply-templates select="/TableDefinition/FkConstraints/FkConstraint[FkType='LOOKUP']"
                         mode="SelectFKAttributes"/>
    <xsl:apply-templates select="/TableDefinition/PrimaryKey/ReferingForeignKeys/ReferingForeignKey"
                         mode="SelectRefFKAttributes"/>
    <xsl:value-of select="concat($newLine,'               ',$From, $tableName)"/>
    <xsl:value-of select="concat($newLine,'               ',$Where)"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[1]" mode="FirstSelectWhereCondition"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[position()>1]" mode="RestSelectWhereConditions"/>
    <xsl:value-of select="concat($newLine,'             ',$CastMSAs, $tableAttributeType, $newLine,'           )')"/>
    <xsl:value-of select="concat($newLine,'    ',$Into, $SelfPfx, $tableAttribute)"/>
    <xsl:value-of select="concat($newLine,'    ',$FromDual, ';')"/>
    <xsl:value-of select="concat($newLine,'    ',$Return, ';',$newLine)"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$typeName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to do the first constructor parameter -->
  <xsl:template name="FirstConstructorparameter" match="ConstraintColumns/ConstraintColumn"
                mode="FirstConstructorparameter">
    <xsl:variable name="constraintColName" select="ColumnName"/>
    <xsl:variable name="parameter">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="concat('p_', $constraintColName)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($newLine, '                       ( ', $parameter)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text"  select="concat($space, /TableDefinition/Columns/Column[ColName/text()=$constraintColName]/DataType/text())"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to do the first constructor parameter -->
  <xsl:template name="NextConstructorparameters" match="ConstraintColumns/ConstraintColumn"
                mode="NextConstructorparameters">
    <xsl:variable name="constraintColName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="ColumnName"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="parameter">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="concat('p_', $constraintColName)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($newLine, '                       , ', $parameter)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($space, /TableDefinition/Columns/Column[ColName/text()=$constraintColName]/DataType/text())"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to do the first select column -->
  <xsl:template name="FirstSelectColumn" match="/TableDefinition/Columns/Column" mode="FirstSelectColumn">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="ColName/text()"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to do the rest of select columns-->
  <xsl:template name="RestSelectColumns" match="/TableDefinition/Columns/Column" mode="RestSelectColumns">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'               ,      ', ColName/text())"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Generate Select of Derivation Attributes: attributes  -->
  <xsl:template name="SelectDerivationAttributes" match="DerivedColumn" mode="SelectDerivationAttributes">
    <xsl:variable name="derivedColumn">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="./DerivedColumn/text()"/>
      </xsl:call-template>
    </xsl:variable>
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
    <xsl:variable name="derivationAttributePkCol">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="./DerivationAttributePkCol/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="ignoreConstructor" select="@IgnoreConstructor"/>
    <xsl:choose>
      <xsl:when test="$ignoreConstructor='N' or string-length($ignoreConstructor) = 0">
        <xsl:value-of select="concat($newLine,'                      -- ',$cmtSelectDerivationAttributesImplA, $derivationAttribute)"/>
        <xsl:value-of select="concat($newLine,'               ,      ', $derivationAttributeType,'( p_', $derivationAttributePkCol, ' => ', $derivedColumn ,')')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($newLine,'                      -- ',$cmtSelectDerivationAttributesImplB, $derivationAttribute)"/>
        <xsl:value-of select="concat($newLine,'               ,      null ')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- Generate Select of LookUp FK Attributes -->
  <xsl:template name="SelectFKAttributes" match="FkConstraint" mode="SelectFKAttributes">
    <xsl:variable name="tableName" select="./RefConstraint/TableName/text()"/>
    <xsl:variable name="tableShortName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="./RefConstraint/TableShortName/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="attribute">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="LookupAttrName"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="attributeType">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="./RefConstraint/TypeName/text()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($newLine,'                      -- ',$cmtSelectFKAttributesImplA, $tableName)"/>
    <xsl:value-of select="concat($newLine,'               ,      ',$attributeType)"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[1]"
                         mode="FirstSelectFKAttributeConstructorParameter"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[position()>1]"
                         mode="RestSelectFKAttributeConstructorParameters"/>
    <xsl:value-of select="' )'"/>
  </xsl:template>
  <!-- Generate First of Lookup FK Attribute Constructor parameter -->
  <xsl:template name="FirstSelectFKAttributeConstructorParameter" match="ConstraintColumn"
                mode="FirstSelectFKAttributeConstructorParameter">
    <xsl:variable name="fkColumnName" select="ColumnName"/>
    <xsl:variable name="fkColumnPos" select="Position"/>
    <xsl:variable name="pkColumnName"
                  select="../../RefConstraint/ConstraintColumns/ConstraintColumn[Position=$fkColumnPos]/ColumnName"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'                      ( p_',$pkColumnName,' => ',$fkColumnName)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Generate Rest of Lookup FK Attribute Constructor parameter -->
  <xsl:template name="RestSelectFKAttributeConstructorParameters" match="ConstraintColumn"
                mode="RestSelectFKAttributeConstructorParameters">
    <xsl:variable name="fkColumnName" select="ColumnName"/>
    <xsl:variable name="fkColumnPos" select="Position"/>
    <xsl:variable name="pkColumnName"
                  select="../../RefConstraint/ConstraintColumns/ConstraintColumn[Position=$fkColumnPos]/ColumnName"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'                      , p_',$pkColumnName,' => ',$fkColumnName)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Generate Refering FK Attributes -->
  <xsl:template name="SelectRefFKAttributes" match="ReferingForeignKey" mode="SelectRefFKAttributes">
    <xsl:variable name="tableName" select="./TableName/text()"/>
    <xsl:variable name="tableShortName" select="./TableShortName/text()"/>
    <xsl:variable name="collAttribute" select="substring($tableName, $tblPrefixLength+1)"/>
    <!--<xsl:variable name="collAttributeType" select="concat($tableShortName, $collObjectSuffix)"/>-->
    <xsl:variable name="collAttributeType" select="./CollectionTypeName/text()"/>
    <xsl:value-of select="concat($newLine,'                      -- ',$cmtSelectRefFKAttributesImplA , $tableName)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'               ,      ' , $collAttributeType)"/>
    </xsl:call-template>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[1]"
                         mode="FirstSelectRefFKAttributeConstructorParameter"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[position()>1]"
                         mode="RestSelectRefFKAttributeConstructorParameters"/>
    <xsl:value-of select="' )'"/>
  </xsl:template>
  <!-- Generate First of Refering  FK Attribute Constructor parameter -->
  <xsl:template name="FirstSelectRefFKAttributeConstructorParameter" match="ConstraintColumn"
                mode="FirstSelectRefFKAttributeConstructorParameter">
    <xsl:variable name="consColumnName" select="ColumnName"/>
    <xsl:variable name="consColumnPos" select="Position"/>
    <xsl:variable name="pkColumnName" select="../../../../PrimaryKeyColumns/Column[Position=$consColumnPos]/Name"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'                      ( p_',$consColumnName,' => ',$pkColumnName)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Generate Rest of Refering FK Attribute Constructor parameter -->
  <xsl:template name="RestSelectRefFKAttributeConstructorParameters" match="ConstraintColumn"
                mode="RestSelectRefFKAttributeConstructorParameters">
    <xsl:variable name="consColumnName" select="ColumnName"/>
    <xsl:variable name="consColumnPos" select="Position"/>
    <xsl:variable name="pkColumnName" select="../../../../PrimaryKeyColumns/Column[Position=$consColumnPos]/Name"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine,'                      , p_',$consColumnName,' => ',$pkColumnName)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to do the first where condition-->
  <xsl:template name="FirstSelectWhereCondition" match="ConstraintColumns/ConstraintColumn"
                mode="FirstSelectWhereCondition">
    <xsl:variable name="constraintColName" select="ColumnName"/>
    <xsl:variable name="parameter" select="concat('p_', $constraintColName)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($constraintColName, ' = ',$parameter)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to do the first where condition-->
  <xsl:template name="RestSelectWhereConditions" match="ConstraintColumns/ConstraintColumn"
                mode="RestSelectWhereConditions">
    <xsl:variable name="constraintColName" select="ColumnName"/>
    <xsl:variable name="parameter" select="concat('p_', $constraintColName)"/>
    <xsl:value-of select="concat($newLine,'               and    ',$constraintColName, ' = ',$parameter)"/>
  </xsl:template>
  <!-- Methods to set the FK Columns on all members of the collection -->
  <xsl:template name="SetFKColDecl" match="FkConstraint" mode="SetFKColDecl">
    <xsl:variable name="tableName" select="./TableName/text()"/>
    <xsl:variable name="tableAttribute">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="substring($tableName, $tblPrefixLength+1)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="constraintName" select="./Name/text()"/>
    <xsl:variable name="memberName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="concat('set_', $constraintName)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('--', $newLine, '-- ',$cmtSetFKColMethodA,$constraintName,$cmtSetFKColMethodB,$newLine)"/>
    <xsl:value-of select="concat($memberProc, $memberName )"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[1]" mode="FirstConstructorparameter"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[position()>1]" mode="NextConstructorparameters"/>
    <xsl:value-of select="concat(')', $memberProcClosure)"/>
    <xsl:value-of select="$memberBeginBody"/>
    <xsl:value-of select="concat('    if ',$SelfPfx,$tableAttribute,' is not null and ',$SelfPfx,$tableAttribute,'.count > 0 then', $newLine)"/>
    <xsl:value-of select="concat('      for l_idx in ',$SelfPfx,$tableAttribute,'.first..',$SelfPfx,$tableAttribute,'.last', $newLine)"/>
    <xsl:value-of select="concat('      loop', $newLine)"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn" mode="AssignCollMemberAttributeWithFKCol"/>
    <xsl:value-of select="concat('      end loop;', $newLine)"/>
    <xsl:value-of select="concat('    end if;', $newLine)"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$memberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Assign collection member type attribute with constraint column -->
  <xsl:template name="AssignCollMemberAttributeWithFKCol" match="ConstraintColumns/ConstraintColumn"
                mode="AssignCollMemberAttributeWithFKCol">
    <xsl:variable name="constraintColName" select="ColumnName"/>
    <xsl:variable name="parameter" select="concat('p_', $constraintColName)"/>
    <xsl:variable name="tableName" select="../../TableName/text()"/>
    <xsl:variable name="tableAttribute" select="substring($tableName, $tblPrefixLength+1)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('        ',$SelfPfx,$tableAttribute,'(l_idx).',$constraintColName,' := ',$parameter,';', $newLine)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- insert Method -->
  <xsl:template name="InsertDecl">
    <xsl:variable name="tableName" select="FkConstraint[1]/TableName/text()"/>
    <xsl:variable name="tableAttribute">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text"  select="substring($tableName, $tblPrefixLength+1)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('--', $newLine, '-- ',$cmtInsertMethod, $newLine)"/>
    <xsl:value-of select="concat($memberProc, $insertMemberName, $memberProcClosure)"/>
    <xsl:value-of select="$memberBeginBody"/>
    <xsl:value-of select="concat('    if ',$SelfPfx,$tableAttribute,' is not null and ',$SelfPfx,$tableAttribute,'.count > 0 then', $newLine)"/>
    <xsl:value-of select="concat('      for l_idx in ', $SelfPfx, $tableAttribute, '.first..', $SelfPfx, $tableAttribute, '.last', $newLine)"/>
    <xsl:value-of select="concat('      loop',$newLine)"/>
    <xsl:value-of select="concat('        ', $SelfPfx, $tableAttribute, '(l_idx).',$insertMemberName,';', $newLine)"/>
    <xsl:value-of select="concat('      end loop;', $newLine)"/>
    <xsl:value-of select="concat('    end if;', $newLine)"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$insertMemberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- delete Method -->
  <xsl:template name="DeleteDecl">
    <xsl:variable name="tableName" select="FkConstraint[1]/TableName/text()"/>
    <xsl:variable name="tableAttribute">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text"  select="substring($tableName, $tblPrefixLength+1)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('--', $newLine, '-- ',$cmtDeleteMethod, $newLine)"/>
    <xsl:value-of select="concat($memberProc, $deleteMemberName, $memberProcClosure)"/>
    <xsl:value-of select="$memberBeginBody"/>
    <xsl:value-of select="concat('    if ',$SelfPfx,$tableAttribute,' is not null and ',$SelfPfx,$tableAttribute,'.count > 0 then', $newLine)"/>
    <xsl:value-of select="concat('      for l_idx in ', $SelfPfx, $tableAttribute, '.first..', $SelfPfx, $tableAttribute, '.last', $newLine)"/>
    <xsl:value-of select="concat('      loop',$newLine)"/>
    <xsl:value-of select="concat('        ', $SelfPfx, $tableAttribute, '(l_idx).',$deleteMemberName,';', $newLine)"/>
    <xsl:value-of select="concat('      end loop;', $newLine)"/>
    <xsl:value-of select="concat('    end if;', $newLine)"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$deleteMemberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Cascading Delete Method -->
  <xsl:template name="DeleteCascDecl">
    <xsl:variable name="tableName" select="FkConstraint[1]/TableName/text()"/>
    <xsl:variable name="tableAttribute">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text"  select="substring($tableName, $tblPrefixLength+1)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('--', $newLine, '-- ',$cmtDeleteCascMethod, $newLine)"/>
    <xsl:value-of select="concat($memberProc, $deleteCascMemberName, $memberProcClosure)"/>
    <xsl:value-of select="$memberBeginBody"/>
    <xsl:value-of select="concat('    if ',$SelfPfx,$tableAttribute,' is not null and ',$SelfPfx,$tableAttribute,'.count > 0 then', $newLine)"/>
    <xsl:value-of select="concat('      for l_idx in ', $SelfPfx, $tableAttribute, '.first..', $SelfPfx, $tableAttribute, '.last', $newLine)"/>
    <xsl:value-of select="concat('      loop',$newLine)"/>
    <xsl:value-of select="concat('        ', $SelfPfx, $tableAttribute, '(l_idx).',$deleteCascMemberName,';', $newLine)"/>
    <xsl:value-of select="concat('      end loop;', $newLine)"/>
    <xsl:value-of select="concat('    end if;', $newLine)"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$deleteCascMemberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Add type Method -->
  <xsl:template name="AddTypeDecl">
    <xsl:param name="tableName"/>
    <!--<xsl:param name="tableShortName"/> -->
    <xsl:param name="tableOfElementTypeName" />
    <xsl:param name="tableOfTypeName" />
    <xsl:variable name="memberName" select="concat('add_', substring($tableName, $tblPrefixLength+1))"/>
    <xsl:variable name="tableAttribute" select="substring($tableName, $tblPrefixLength+1)"/>
    <!--<xsl:variable name="tableAttributeType" select="concat($tableShortName, $tblObjectSuffix)"/> -->
    <xsl:variable name="tableAttributeType" select="$tableOfTypeName"/>
    <xsl:variable name="parameter" select="concat('p_', substring($tableName, $tblPrefixLength+1))"/>
    <!--<xsl:variable name="parameterType" select="concat($tableShortName, $objectSuffix)"/>-->
    <xsl:variable name="parameterType" select="$tableOfElementTypeName"/>    
    <xsl:value-of select="concat('--', $newLine, '-- ',$cmtAddTypeMethodA,$parameterType,$cmtAddTypeMethodB, $tableAttribute,$newLine)"/>
    <xsl:value-of select="concat($memberProc, $memberName,'(',$parameter,$space, $parameterType,')',$memberProcClosure)"/>
    <xsl:value-of select="$memberBeginBody"/>
    <xsl:value-of select="concat('    -- ',$cmtAddTypeImplA,$newLine)"/>
    <xsl:value-of select="concat('    if ', $SelfPfx, $tableAttribute , ' is null then',$newLine)"/>
    <xsl:value-of select="concat('      ', $SelfPfx, $tableAttribute , ' := ', $tableAttributeType,'();' ,$newLine)"/>
    <xsl:value-of select="concat('    end if;',$newLine)"/>
    <xsl:value-of select="concat('    ', $SelfPfx, $tableAttribute , '.extend;' ,$newLine)"/>
    <xsl:value-of select="concat('    ', $SelfPfx, $tableAttribute , '(', $SelfPfx, $tableAttribute,'.count) := ', $parameter,';',$newLine)"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$memberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Add type Method -->
  <xsl:template name="AddTblDecl">
    <xsl:param name="tableName"/>
    <!--<xsl:param name="tableShortName"/> -->
    <xsl:param name="tableOfTypeName" />
    <xsl:variable name="memberName" select="concat('add_', substring($tableName, $tblPrefixLength+1))"/>
    <xsl:variable name="tableAttribute" select="substring($tableName, $tblPrefixLength+1)"/>
    <!--<xsl:variable name="tableAttributeType" select="concat($tableShortName, $tblObjectSuffix)"/> -->
    <xsl:variable name="tableAttributeType" select="$tableOfTypeName"/>
    <xsl:variable name="parameter" select="concat('p_', substring($tableName, $tblPrefixLength+1),'_tbl')"/>
    <!--<xsl:variable name="parameterType" select="concat($tableShortName, $tblObjectSuffix)"/>  -->
    <xsl:variable name="parameterType" select="$tableOfTypeName"/> 
    <xsl:value-of select="concat('--', $newLine, '-- ',$cmtAddTypeMethodA,$parameterType,$cmtAddTypeMethodB, $tableAttribute,$newLine)"/>
    <xsl:value-of select="concat($memberProc, $memberName,'(',$parameter,$space, $parameterType,')',$memberProcClosure)"/>
    <xsl:value-of select="$memberBeginBody"/>
    <xsl:value-of select="concat('    if ', $parameter , ' is not null and ', $parameter , '.count > 0 then',$newLine)"/>
    <xsl:value-of select="concat('      for l_idx in ', $parameter , '.first..', $parameter , '.last',$newLine)"/>
    <xsl:value-of select="concat('        loop',$newLine)"/>
    <xsl:value-of select="concat('          ',$memberName,'(',$parameter,'(l_idx));',$newLine)"/>
    <xsl:value-of select="concat('        end loop;',$newLine)"/>
    <xsl:value-of select="concat('    end if;',$newLine)"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$memberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- To XML Method -->
  <xsl:template name="ToXMLDecl">
    <xsl:param name="tableName"/>
    <!--<xsl:param name="tableShortName"/> -->
    <xsl:param name="typeName"/>     
    <xsl:variable name="memberName" select="'to_xml'"/>
    <xsl:variable name="tableAttribute" select="substring($tableName, $tblPrefixLength+1)"/>
    <!--<xsl:variable name="typeName" select="concat($tableShortName, $collObjectSuffix)"/>  -->
    <xsl:value-of select="concat('--', $newLine, '-- ',$cmtToXMLMethod,$newLine)"/>
    <xsl:value-of select="concat($memberFuncDecl,$memberName ,$space, $memberFuncReturn, 'sys.xmltype', $memberFuncDeclClosure)"/>
    <xsl:value-of select="concat('    l_xml xmltype;',$newLine)"/>
    <xsl:value-of select="$memberBeginBody"/>
    <xsl:value-of select="concat('    select xmlelement',$newLine)"/>
    <xsl:value-of select="concat('           ( &quot;',$typeName,'&quot;', $newLine)"/>
    <xsl:value-of select="concat('           , xmlagg(tbl.to_xml())', $newLine)"/>
    <xsl:value-of select="concat('           )', $newLine)"/>
    <xsl:value-of select="concat('    into l_xml', $newLine)"/>
    <xsl:value-of select="concat('    from table(', $SelfPfx, $tableAttribute, ') tbl; ', $newLine)"/>
    <xsl:value-of select="concat('    return l_xml;', $newLine)"/>
    <xsl:call-template name="MemberEndBody">
      <xsl:with-param name="memberName" select="$memberName"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Member End Body -->
  <xsl:template name="MemberEndBody">
    <xsl:param name="memberName"/>
    <xsl:variable name="MemberEndBody" select="concat('  end ', $memberName,';', $newLine)"/>
    <xsl:value-of select="$MemberEndBody"/>
  </xsl:template>
  <!-- Generate the Custom Methods -->
  <xsl:template name="CustomMethods" match="/TableDefinition" mode="CustomMethods">
    <!--<xsl:variable name="typeName" select="concat(ShortName, $collObjectSuffix)"/> -->
    <xsl:variable name="typeName" select="CollectionTypeName/text()"/> 
    <xsl:if test="count(CustomMethods/CustomMethod[typeName=$typeName])>0">
      <xsl:value-of select="concat('  --', $newLine,'  -- Custom Methods for ', $typeName,$newLine,'  --', $newLine)" />
    </xsl:if>
    <xsl:apply-templates select="CustomMethods/CustomMethod[typeName=$typeName]" mode="CustomMethod" />
  </xsl:template>
    <!-- Generate a Custom Method -->
  <xsl:template name="CustomMethod" match="CustomMethods/CustomMethod"  mode="CustomMethod">
    <xsl:value-of select="concat('  ', methodComment,$newLine)"/>
    <xsl:value-of select="concat('  member ' , methodDeclaration,$newLine)"/>
  </xsl:template>
  <!-- to LowerCase -->
  <xsl:template name="toLowerCase"  >
    <xsl:param name="text" />
    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ'" />
    <xsl:value-of select="translate($text, $uppercase, $smallcase)" />
  </xsl:template>
</xsl:stylesheet>