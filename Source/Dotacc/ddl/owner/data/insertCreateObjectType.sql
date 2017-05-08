set serveroutput on
set define off
declare
  l_xsl_name xxx_xml_documents.docname%type := 'CreateObjectType_1.2.xsl';
  l_xsl_content clob := q'{<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" indent="no"/>
  <!-- Stylesheet to Generate an Oracle Object Type from an XML Query on a table in the database
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
  <!-- table prefix length-->
  <xsl:variable name="tblPrefixLength" select="number(4)"/>
  <!-- Member Names -->
  <xsl:variable name="insertMemberName" select="'ins'"/>
  <xsl:variable name="updateMemberName" select="'upd'"/>
  <xsl:variable name="updateNotNulAttrsMemberName" select="'upd_not_null_attrs'"/>
  <xsl:variable name="deleteMemberName" select="'del'"/>
  <xsl:variable name="toXmlMemberName" select="'to_xml'"/>
  <!-- Close the Type -->
  <xsl:variable name="CloseType">
    <xsl:text>
);</xsl:text>
  </xsl:variable>
  
  <!-- Object Heading -->
  <xsl:variable name="ObjectTypeHeading">
    <xsl:text> as object
(
  -- Author  : Martien van den Akker, Darwin-IT Professionals
  -- Created : 11/06/2014 12:00:00 PM
  -- Purpose : Table to Object Mapping
  
  -- Attributes
</xsl:text>
  </xsl:variable>
  <!-- Main template -->
  <xsl:template match="/">
    <xsl:apply-templates select="/TableDefinition" mode="ObjectType"/>
  </xsl:template>
  <!-- Template to create the object type -->
  <xsl:template name="ObjectType" match="/TableDefinition" mode="ObjectType">
    <xsl:variable name="typeName" > 
       <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="TypeName"/> 
       </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="CreateType">
      <xsl:with-param name="typeName" select="$typeName"/>
    </xsl:call-template>
    <xsl:call-template name="Attributes"/>
    <xsl:call-template name="ParameterlessConstructorDecl">
      <xsl:with-param name="typeName" select="$typeName"/>
    </xsl:call-template>
    <xsl:call-template name="PKConstructorDecl">
      <xsl:with-param name="typeName" select="$typeName"/>
    </xsl:call-template>
    <xsl:call-template name="InsertDecl"/>
    <xsl:call-template name="UpdateDecl"/>
    <xsl:call-template name="UpdateNotNullAttrsDecl"/>
    <xsl:call-template name="DeleteDecl"/>
    <xsl:call-template name="DeleteCascDecl"/>
    <xsl:call-template name="ToXMLDecl"/>
    <xsl:call-template name="CustomMethods">
      <xsl:with-param name="typeName" select="$typeName"/>
    </xsl:call-template>
    <xsl:value-of select="$CloseType"/>
  </xsl:template>
  <!-- Template to do the create type declaration -->
  <xsl:template name="CreateType">
    <xsl:param name="typeName"/>
    <xsl:value-of select="concat('create or replace type ', $typeName, $space, $ObjectTypeHeading)"/>
  </xsl:template>
  <!-- Generate the Attributes -->
  <xsl:template name="Attributes">
    <xsl:apply-templates select="Columns/Column[1]" mode="AttributeFirst"/>
    <xsl:apply-templates select="Columns/Column[position()>1]" mode="AttributeRest"/>
    <xsl:apply-templates select="DerivedColumns/DerivedColumn" mode="DerivationAttributes"/>
    <xsl:apply-templates select="FkConstraints/FkConstraint[FkType='LOOKUP']" mode="FKAttributes"/>
    <xsl:apply-templates select="PrimaryKey/ReferingForeignKeys/ReferingForeignKey" mode="RefFKAttributes"/>
  </xsl:template>
  <!-- Generate First of the Attributes -->
  <xsl:template name="AttributeFirst" match="Columns/Column" mode="AttributeFirst">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="concat('  ',ColName, ' ' , DataType)"/>
      </xsl:call-template>
    <xsl:call-template name="DataTypeDefinition"/>
  </xsl:template>
  <!-- Generate Rest of the Attributes -->
  <xsl:template name="AttributeRest" match="Columns/Column" mode="AttributeRest">
      <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="concat($newLineComma, ColName, ' ' , DataType)"/>
      </xsl:call-template>
    <xsl:call-template name="DataTypeDefinition"/>
  </xsl:template>
  <!-- Generate LookUp FK Attributes -->
  <xsl:template name="FKAttributes" match="FkConstraint" mode="FKAttributes">
    <xsl:variable name="tableName" select="./RefConstraint/TableName/text()"/>
    <xsl:variable name="tableShortName" select="./RefConstraint/TableShortName/text()"/>
    <xsl:variable name="attribute" select="LookupAttrName"/>
    <xsl:variable name="attributeType" select="./RefConstraint/TypeName/text()"/>
    <xsl:value-of select="concat($newLine,'-- Lookup attribute based on foreinkey to ' , $tableName)"/>
    <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="concat($newLineComma,$attribute, ' ' , $attributeType)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Generate Refering FK Attributes -->
  <xsl:template name="RefFKAttributes" match="ReferingForeignKey" mode="RefFKAttributes">
    <xsl:variable name="tableName" select="./TableName/text()"/>
    <xsl:variable name="tableShortName" select="./TableShortName/text()"/>
    <xsl:variable name="collAttribute" select="substring($tableName, $tblPrefixLength+1)"/>
    <xsl:variable name="collAttributeType" select="./CollectionTypeName/text()"/> 
    <xsl:value-of select="concat($newLine,'-- Collection attribute based on foreinkey to ' , $tableName)"/>
    <xsl:call-template name="toLowerCase">
        <xsl:with-param name="text" select="concat($newLineComma,$collAttribute, ' ' , $collAttributeType)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Generate Derivation Attributes: attributes to derive table-column-attributes -->
  <xsl:template name="DerivationAttributes" match="DerivedColumn" mode="DerivationAttributes">
    <xsl:variable name="derivedColumn" select="./DerivedColumn/text()"/>
    <xsl:variable name="derivationAttribute" select="./DerivationAttribute/text()"/>
    <xsl:variable name="derivationAttributeType" select="./DerivationObjectType/text()"/>
    <xsl:value-of select="concat($newLine,'-- Attribute to derive ' , $derivedColumn)"/>
    <xsl:value-of select="concat($newLineComma,$derivationAttribute, ' ' , $derivationAttributeType)"/>
  </xsl:template>
  <!-- DataType Definition -->
  <xsl:template name="DataTypeDefinition">
    <xsl:if test="DataType!='DATE' and DataType!='TIMESTAMP' and DataType!='CLOB' and DataType!='BLOB' and DataType!='XMLTYPE'">
      <xsl:choose>
        <xsl:when test="string-length(DataPrecision)>0 and string-length(DataScale)>0">
          <xsl:value-of select="concat('(', DataPrecision, ', ' ,DataScale, ')')"/>
        </xsl:when>
        <xsl:when test="string-length(DataPrecision)>0">
          <xsl:value-of select="concat('(', DataPrecision,')')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('(', DataLength, ')')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <!-- Parameterless Constructor -->
  <xsl:template name="ParameterlessConstructorDecl">
    <xsl:param name="typeName" />
    <xsl:value-of select="concat($newLine, '-- Parameterless constructor')"/>
    <xsl:value-of select="concat($newLineComma,'constructor function ', $typeName,' return self as result')"/>
  </xsl:template>
  <!-- Primary Key based Constructor -->
  <xsl:template name="PKConstructorDecl">
    <xsl:param name="typeName" />
    <xsl:value-of select="concat($newLine, '-- Primary key based constructor')"/>
    <xsl:value-of select="concat($newLineComma,'constructor function ', $typeName)"/>
    <xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[1]" mode="PKConstructorParametersFirst"/>
    <xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[position()>1]" mode="PKConstructorParametersRest"/>
    <xsl:text>) return self as result</xsl:text>
  </xsl:template>
  <!-- Primary Key Constructor, first PK-parameter -->
  <xsl:template name="PKConstructorParametersFirst" match="PrimaryKey/PrimaryKeyColumns/Column"
                mode="PKConstructorParametersFirst">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat('( p_',Name, ' ', DataType)"/>
    </xsl:call-template>
  </xsl:template>
  <!-- Primary Key Constructor, rest of the PK-parameters -->
  <xsl:template name="PKConstructorParametersRest" match="PrimaryKey/PrimaryKeyColumns/Column"
                mode="PKConstructorParametersRest">
    <xsl:call-template name="toLowerCase">
      <xsl:with-param name="text" select="concat(', p_',Name, ' ', DataType)"/>
    </xsl:call-template>      
  </xsl:template>
  <!-- insert Method -->
  <xsl:template name="InsertDecl">
    <xsl:value-of select="concat($newLine, '-- Perform Insert on object and sub-types.')"/>
    <xsl:value-of select="concat($newLineComma, 'member procedure ', $insertMemberName)"/>
  </xsl:template>
  <!-- update Method -->
  <xsl:template name="UpdateDecl">
    <xsl:value-of select="concat($newLine, '-- Perform Update on object.')"/>
    <xsl:value-of select="concat($newLineComma, 'member procedure ',$updateMemberName)"/>
  </xsl:template>
  <!-- update Method -->
  <xsl:template name="UpdateNotNullAttrsDecl">
    <xsl:value-of select="concat($newLine, '-- Perform Update on object with conditional column assignments: update column only when attribute is set.')"/>
    <xsl:value-of select="concat($newLineComma, 'member procedure ',$updateNotNulAttrsMemberName)"/>
  </xsl:template>
  <!-- delete Method -->
  <xsl:template name="DeleteDecl">
    <xsl:value-of select="concat($newLine, '-- Perform Delete on object.')"/>
    <xsl:value-of select="concat($newLineComma, 'member procedure ',$deleteMemberName)"/>
  </xsl:template>
  <!-- Cascading Delete Method -->
  <xsl:template name="DeleteCascDecl">
    <xsl:value-of select="concat($newLine, '-- Perform Cascading Delete on object.')"/>
    <xsl:value-of select="concat($newLineComma, 'member procedure del_casc')"/>
  </xsl:template>  
  <!-- To XML Method -->
  <xsl:template name="ToXMLDecl">
    <xsl:value-of select="concat($newLine, '-- Return object attributes including subtypes in XML Format')"/>
    <xsl:value-of select="concat($newLineComma, 'member function ',$toXmlMemberName,' return sys.xmltype')"/>
  </xsl:template>
  <!-- Generate the Custom Methods -->
  <xsl:template name="CustomMethods">
    <xsl:param name="typeName" />
    <xsl:value-of select="concat($newLine, '-- Custom Methods for ', $typeName, $newLine, '--')" />
    <xsl:apply-templates select="CustomMethods/CustomMethod[typeName=$typeName]" />
  </xsl:template>
    <!-- Generate a Custom Method -->
  <xsl:template name="CustomMethod" match="CustomMethods/CustomMethod" >
    <xsl:value-of select="concat($newLine, methodComment)"/>
    <xsl:value-of select="concat($newLine,', member ' , methodSpecification)"/>
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
  dbms_output.put_line('Save '||l_xsl_name);
  xxx_xmldoc.save( name   => l_xsl_name
                 , xmldoc => l_xsl_content);
end;