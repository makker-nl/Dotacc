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
  <!-- space -->
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
  <!-- Create Object type Declaration -->
  <xsl:variable name="createTypeDecl">
    <xsl:text disable-output-escaping="no">create or replace type </xsl:text>
  </xsl:variable>
  <!-- Constructor Function declaration -->
  <xsl:variable name="constuctorDecl" select="'constructor function '"/>
  <!-- Constructor Function declaration closure -->
  <xsl:variable name="constuctorDeclClosure" select="concat(')', $newLine, '  return self as result')"/>
  <!-- Close the Type -->
  <xsl:variable name="closeType" select="concat($newLine,');')"/>
  <xsl:variable name="author" select="'Martien van den Akker, Darwin-IT Professionals'"/>
  <xsl:variable name="creationDate" select="'24/02/2016 12:00:00 PM'"/>
  <!-- Comments EN 
  <xsl:variable name="cmtPurpose" select="'Table to Object Mapping'"/>
  <xsl:variable name="cmtAttrs" select="'Attributes'"/>
  <xsl:variable name="cmtParameterLessConstructor" select="'Parameterless constructor'"/>
  <xsl:variable name="cmtFKBasedConstructor" select="'Constructor for FK Constraint '"/>
  <xsl:variable name="cmtSetFKColMethodA" select="'Method to set columns for FK Constraint '"/>
  <xsl:variable name="cmtSetFKColMethodB" select="' on all members of collection.'"/>
  <xsl:variable name="cmtInsertMethod" select="'Perform Insert of the collection data'"/>
  <xsl:variable name="cmtDeleteMethod" select="'Perform Delete of the collection data'"/>
  <xsl:variable name="cmtDeleteCascMethod" select="'Perform a Cascading Delete of the collection data'"/>
  <xsl:variable name="cmtAddTypeMethodA" select="'Add '"/>
  <xsl:variable name="cmtAddTypeMethodB" select="' to '"/>
  <xsl:variable name="cmtToXMLMethod" select="'Return the collection content as XML'"/>
  -->
  <!-- Comments NL -->
  <xsl:variable name="cmtPurpose" select="'Tabel naar Object Mapping'"/>
  <xsl:variable name="cmtAttrs" select="'Attributen'"/>
  <xsl:variable name="cmtParameterLessConstructor" select="'Parameterloze constructor'"/>
  <xsl:variable name="cmtFKBasedConstructor" select="'Constructor voor FK Constraint '"/>
  <xsl:variable name="cmtSetFKColMethodA" select="'Methode voor het zetten van kolommen voor FK Constraint '"/>
  <xsl:variable name="cmtSetFKColMethodB" select="' op alle voorkomens in de collectie.'"/>
  <xsl:variable name="cmtInsertMethod" select="'Voer een Insert uit op de collectie data.'"/>
  <xsl:variable name="cmtDeleteMethod" select="'Voer een Delete uit op de collectie data.'"/>
  <xsl:variable name="cmtDeleteCascMethod" select="'Voer een a Cascading Delete uit op de collectie data.'"/>
  <xsl:variable name="cmtAddTypeMethodA" select="'Voeg '"/>
  <xsl:variable name="cmtAddTypeMethodB" select="' toe aan '"/>
  <xsl:variable name="cmtToXMLMethod" select="'Retourneer de collectie inhoud als XML.'"/>
  <!-- Object Heading -->
  <xsl:variable name="objectTypeHeading"
  select="concat(' as object',$newLine,'(',$newLine,'  -- Author  : ',$author, $newLine,'  -- Created : ',$creationDate,$newLine,'  -- Purpose : ',$cmtPurpose,$newLine,$newLine,'  -- ',$cmtAttrs, $newLine)"/>
  <xsl:variable name="memberProcDecl" select="'member procedure '"/>
  <!-- Member function declaration -->
  <xsl:variable name="memberFuncDecl" select="'member function '"/>
  <!-- Main template -->
  <xsl:template match="/">
    <xsl:apply-templates select="/TableDefinition/FkConstraints" mode="ObjectColl"/>
    <xsl:apply-templates select="/TableDefinition" mode="CustomMethods"/>
    <xsl:value-of select="$closeType"/>
  </xsl:template>
  <!-- Template to create the object type -->
  <xsl:template name="ObjectType" match="/TableDefinition/FkConstraints" mode="ObjectColl">
    <xsl:variable name="tableName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="FkConstraint[1]/TableName/text()"/>
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
    <xsl:call-template name="CreateAttribute">
      <xsl:with-param name="tableName" select="$tableName"/>
      <!--<xsl:with-param name="tableShortName" select="$tableShortName"/>-->
      <xsl:with-param name="tableOfTypeName" select="$tableOfTypeName"/>
    </xsl:call-template>
    <xsl:call-template name="ParameterlessConstructorDecl">
      <xsl:with-param name="memberName" select="$typeName"/>
    </xsl:call-template>
    <xsl:apply-templates select="FkConstraint[FkType='DETAIL']" mode="CreateConstructors"/>
    <xsl:apply-templates select="FkConstraint[FkType='DETAIL']" mode="SetFKColDecl"/>
    <xsl:call-template name="InsertDecl"/>
    <xsl:call-template name="DeleteDecl"/>
    <xsl:call-template name="DeleteCascDecl"/>
    <xsl:call-template name="AddTypeDecl">
      <xsl:with-param name="tableName" select="$tableName"/>
      <!--<xsl:with-param name="tableShortName" select="$tableShortName"/>-->
      <xsl:with-param name="tableOfElementTypeName" select="$tableOfElementTypeName"/>
    </xsl:call-template>
    <xsl:call-template name="AddTblDecl">
      <xsl:with-param name="tableName" select="$tableName"/>
      <!--<xsl:with-param name="tableShortName" select="$tableShortName"/>-->
      <xsl:with-param name="tableOfTypeName" select="$tableOfTypeName"/>
    </xsl:call-template>
    <xsl:call-template name="ToXMLDecl"/>
  </xsl:template>
  <!-- Template to do the create type declaration -->
  <xsl:template name="CreateType">
    <xsl:param name="typeName"/>
    <xsl:value-of select="concat($createTypeDecl, $typeName, $space, $objectTypeHeading )"/>
  </xsl:template>
  <!-- Template to do the create type declaration -->
  <xsl:template name="CreateAttribute">
    <xsl:param name="tableName"/>
    <!--<xsl:param name="tableShortName"/> -->
    <xsl:param name="tableOfTypeName"/> 
    <xsl:variable name="tableAttribute" select="substring($tableName, $tblPrefixLength+1)"/>
    <xsl:variable name="tableAttributeType" select="$tableOfTypeName"/>
    <xsl:value-of select="concat('  ', $tableAttribute, $space, $tableAttributeType)"/>
  </xsl:template>
  <!-- Parameterless Constructor -->
  <xsl:template name="ParameterlessConstructorDecl">
    <xsl:param name="memberName"/>
    <xsl:value-of select="concat($newLine, '-- ',$cmtParameterLessConstructor)"/>
    <xsl:value-of select="concat($newLineComma,'constructor function ', $memberName,' return self as result')"/>
  </xsl:template>
  <!-- Template to create a constructor -->
  <xsl:template name="CreateConstructors" match="FkConstraint" mode="CreateConstructors">
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
    <xsl:variable name="constraintName" select="./Name/text()"/>
    <xsl:value-of select="concat($newLine,'-- ',$cmtFKBasedConstructor,$constraintName)"/>
    <xsl:value-of select="concat($newLineComma,$constuctorDecl, $typeName)"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[1]" mode="FirstConstructorParameter"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[position()>1]" mode="NextConstructorParameters"/>
    <xsl:value-of select="$constuctorDeclClosure"/>
  </xsl:template>
  <!-- Template to do the first constructor parameter -->
  <xsl:template name="FirstConstructorParameter" match="ConstraintColumns/ConstraintColumn"
                mode="FirstConstructorParameter">
    <xsl:variable name="ConstraintColName" select="ColumnName"/>
     <xsl:variable name="Parameter" select="concat('p_', $ConstraintColName)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine, '                       ( ', $Parameter,$space, /TableDefinition/Columns/Column[ColName/text()=$ConstraintColName]/DataType/text())"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Template to do the first constructor parameter -->
  <xsl:template name="NextConstructorParameters" match="ConstraintColumns/ConstraintColumn"
                mode="NextConstructorParameters">
    <xsl:variable name="ConstraintColName"  select="ColumnName"/>
    <xsl:variable name="Parameter" select="concat('p_', $ConstraintColName)"/>
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat($newLine, '                       , ', $Parameter,$space, /TableDefinition/Columns/Column[ColName/text()=$ConstraintColName]/DataType/text())"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Methods to set the FK Columns on all members of the collection -->
  <xsl:template name="SetFKColDecl" match="FkConstraint" mode="SetFKColDecl">
    <xsl:variable name="constraintName" select="./Name/text()"/>
    <xsl:variable name="memberName">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text"  select="concat('set_', $constraintName)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($newLine, '-- ',$cmtSetFKColMethodA,$constraintName,$cmtSetFKColMethodB)"/> 
    <xsl:value-of select="concat($newLineComma,$memberProcDecl, $memberName)"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[1]" mode="FirstConstructorParameter"/>
    <xsl:apply-templates select="ConstraintColumns/ConstraintColumn[position()>1]" mode="NextConstructorParameters"/>
    <xsl:value-of select="')'"/>
  </xsl:template>
  <!-- insert Method -->
  <xsl:template name="InsertDecl">
  <xsl:value-of select="concat($newLine, '-- ',$cmtInsertMethod)"/>
    <xsl:value-of select="concat($newLineComma,$memberProcDecl, $insertMemberName)"/>
  </xsl:template>
  <!-- delete Method -->
  <xsl:template name="DeleteDecl">
  <xsl:value-of select="concat($newLine, '-- ',$cmtDeleteMethod)"/>
    <xsl:value-of select="concat($newLineComma,$memberProcDecl, $deleteMemberName)"/>
  </xsl:template>
  <!-- cascading delete Method -->
  <xsl:template name="DeleteCascDecl">
  <xsl:value-of select="concat($newLine, '-- ',$cmtDeleteCascMethod)"/>
    <xsl:value-of select="concat($newLineComma,$memberProcDecl, $deleteCascMemberName)"/>
  </xsl:template> 
  <!-- Add type Method -->
  <xsl:template name="AddTypeDecl">
    <xsl:param name="tableName"/>
    <!--<xsl:param name="tableShortName"/> -->
    <xsl:param name="tableOfElementTypeName" />
    <xsl:variable name="memberName" select="concat('add_', substring($tableName, $tblPrefixLength+1))"/>
    <xsl:variable name="tableAttribute" select="substring($tableName, $tblPrefixLength+1)"/>
    <xsl:variable name="parameter" select="concat('p_', substring($tableName, $tblPrefixLength+1))"/>
    <xsl:variable name="parameterType" select="$tableOfElementTypeName"/>    
    <xsl:value-of select="concat($newLine, '-- ',$cmtAddTypeMethodA,$parameterType,$cmtAddTypeMethodB, $tableAttribute)"/>
    <xsl:value-of select="concat($newLineComma,$memberProcDecl, $memberName,'(',$parameter,$space, $parameterType,')')"/>
  </xsl:template>
  <!-- Add type Method -->
  <xsl:template name="AddTblDecl">
    <xsl:param name="tableName"/>
    <!--<xsl:param name="tableShortName"/> -->
    <xsl:param name="tableOfTypeName" />
    <xsl:variable name="memberName" select="concat('add_', substring($tableName, $tblPrefixLength+1))"/>
    <xsl:variable name="tableAttribute" select="substring($tableName, $tblPrefixLength+1)"/>
    <xsl:variable name="parameter" select="concat('p_', substring($tableName, $tblPrefixLength+1),'_tbl')"/>
    <xsl:variable name="parameterType" select="$tableOfTypeName"/> 
    <xsl:value-of select="concat( $newLine, '-- ',$cmtAddTypeMethodA,$parameterType,$cmtAddTypeMethodB, $tableAttribute)"/>
    <xsl:value-of select="concat($newLineComma,$memberProcDecl, $memberName,'(',$parameter,$space, $parameterType,')')"/>
  </xsl:template>
  <!-- To XML Method -->
  <xsl:template name="ToXMLDecl">
  <xsl:value-of select="concat($newLine, '-- ',$cmtToXMLMethod)"/>
    <xsl:value-of select="concat($newLineComma,$memberFuncDecl, $toXmlMemberName,' return sys.xmltype')"></xsl:value-of>
  </xsl:template>
  <!-- Generate the Custom Methods -->
  <xsl:template name="CustomMethods" match="/TableDefinition" mode="CustomMethods">
    <xsl:variable name="typeName" select="CollectionTypeName/text()"/> 
    <xsl:if test="count(CustomMethods/CustomMethod[typeName=$typeName])>0">
      <xsl:value-of select="concat($newLine,'  --', $newLine,'  -- Custom Methods for ', $typeName,$newLine,'  --')" />
    </xsl:if>
    <xsl:apply-templates select="CustomMethods/CustomMethod[typeName=$typeName]" mode="CustomMethod" />
  </xsl:template>
    <!-- Generate a Custom Method -->
  <xsl:template name="CustomMethod" match="CustomMethods/CustomMethod"  mode="CustomMethod">
    <xsl:value-of select="concat($newLine, '  ', methodComment)"/>
    <xsl:value-of select="concat($newLine, ', member ' , methodSpecification)"/>
  </xsl:template>
  <!-- to LowerCase -->
  <xsl:template name="toLowerCase"  >
    <xsl:param name="text" />
    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ'" />
    <xsl:value-of select="translate($text, $uppercase, $smallcase)" />
  </xsl:template>
</xsl:stylesheet>