<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="no"/>
	<xsl:template match="/" >
       <xsl:apply-templates select="/TableDefinition" mode="AddQueue"/>
	</xsl:template>
	<xsl:template name="ObjectType" match="/TableDefinition" mode="AddQueue" >
	<xsl:value-of select="concat('create or replace procedure add_q_',Name,'(p_tablespace in varchar2) is')"/>
	<xsl:text>
begin
</xsl:text>
<xsl:text disable-output-escaping= "yes">  xxx_queue_adm.recreate_object_queue( p_name         =>'</xsl:text><xsl:value-of select="Name"/><xsl:text>'
</xsl:text>
<xsl:text disable-output-escaping= "yes">                                     , p_comment      => 'Queue for updates on </xsl:text><xsl:value-of select="Name"/><xsl:text>'
                                     , p_tablespace   => p_tablespace
</xsl:text>
<xsl:text>                                     , p_object_name  => '</xsl:text><xsl:value-of select="Name"/><xsl:text>_TYPE');
</xsl:text>
<xsl:value-of select="concat('end add_q_',Name,';')"/>
	</xsl:template>
</xsl:stylesheet>

<!-- U+0027 quote &#x022; -->
<!-- U+0022 doublequote &#x022; -->


