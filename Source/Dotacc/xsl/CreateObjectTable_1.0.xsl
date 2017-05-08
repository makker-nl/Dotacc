<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="text" indent="no"/>
 <!-- Stylesheet to Generate an Oracle 'Table of' Object Type from an XML Query on a table in the database
     Author: Martien van den Akker, Darwin-IT Professionals
     Version 1.0, juni 2014
-->
 <!-- Variables -->
 <!-- Close the Type -->
 <xsl:variable name="CloseType">
  <xsl:text>;</xsl:text>
 </xsl:variable>
 <!-- Object Heading -->
 <xsl:variable name="objectTypeHeading">
  <xsl:text>as table of </xsl:text>
 </xsl:variable>
 <xsl:variable name="space" select="' '"/>
 <!-- Main template -->
 <xsl:template match="/">
  <xsl:apply-templates select="/TableDefinition/FkConstraints" mode="ObjectTbl"/>
 </xsl:template>
 <!-- Template to create the object type -->
 <xsl:template name="ObjectType" match="/TableDefinition/FkConstraints" mode="ObjectTbl">
  <xsl:variable name="tableShortName">
    <xsl:call-template name="toLowerCase">
       <xsl:with-param name="text" select="FkConstraint[1]/TableShortName"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="tableTypeName">
    <xsl:call-template name="toLowerCase">
       <xsl:with-param name="text"  select="FkConstraint[1]/TableOfTypeName"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="typeName">
    <xsl:call-template name="toLowerCase">
       <xsl:with-param name="text" select="FkConstraint[1]/TypeName"/> 
    </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="CreateType">
   <xsl:with-param name="tableTypeName" select="$tableTypeName"/>
   <xsl:with-param name="typeName" select="$typeName"/>
  </xsl:call-template>
  <xsl:value-of select="$CloseType"/>
 </xsl:template>
 <!-- template to do the create type declaration. -->
 <xsl:template name="CreateType">
  <xsl:param name="tableTypeName"/>
  <xsl:param name="typeName"/>
  <xsl:value-of select="concat('create or replace type ', $tableTypeName,$space, $objectTypeHeading, $typeName)"/>
 </xsl:template>
  <!-- to LowerCase -->
  <xsl:template name="toLowerCase"  >
    <xsl:param name="text" />
    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ'" />
    <xsl:value-of select="translate($text, $uppercase, $smallcase)" />
  </xsl:template>
</xsl:stylesheet>