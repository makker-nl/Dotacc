<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="no"/>	
	<xsl:template match="/" >
       <xsl:apply-templates select="/TableDefinition" mode="EnqueueProcedure"/>
	</xsl:template>
	<!-- Procedure Template -->
	<xsl:template name="ObjectType" match="/TableDefinition" mode="EnqueueProcedure" >
	    <!-- Procedure and Parameter Declaration -->
    	<xsl:call-template name="CreateProcedure"/>		
    	<!-- Locals Declaration -->
    	<xsl:call-template name="LocalDeclarations"/>
    	<!-- Procedure body -->
    	<xsl:call-template name="ProcedureBody"/>		
	</xsl:template>
	
	<!-- Create Procedure Declaration -->
	<xsl:template name="CreateProcedure">
		<xsl:value-of select="concat('create or replace procedure enq_',Name)"/>
		<xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[1]" mode="ProcedureParametersFirst" />	
    	<xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[position()>1]" mode="ProcedureParametersRest" />
		<xsl:text>) is</xsl:text>
	</xsl:template> 
	<!-- Parameter Declaration -->		
	<xsl:template name="ProcedureParametersFirst" match="PrimaryKey/PrimaryKeyColumns/Column" mode="ProcedureParametersFirst">
      <xsl:value-of select="concat('( p_',Name, ' ', DataType)"/>
	</xsl:template>	
	<xsl:template name="ProcedureParametersRest" match="PrimaryKey/PrimaryKeyColumns/Column" mode="ProcedureParametersRest">
      <xsl:value-of select="concat(', p_',Name, ' ', DataType)"/>
	</xsl:template>
	<!-- Local Declarations -->
	<xsl:template name="LocalDeclarations">
		<xsl:text>
  l_enqueue_options dbms_aq.enqueue_options_t;
  l_message_properties dbms_aq.message_properties_t;
  l_msg_id raw(32);
</xsl:text>
    	<xsl:call-template name="LocalObjectVariableDeclaration"/>
	</xsl:template>
	<xsl:template name="LocalObjectVariableDeclaration">
	  <xsl:value-of select="concat('  l_',Name,' ',Name, '_type;')"/>
	</xsl:template>	
	
	<!-- Procedure Body  -->
	<xsl:template name="ProcedureBody">
		<xsl:call-template name="ProcedureBodyBegin"/>
		<xsl:call-template name="LocalObjectInstantiation"/>
		<xsl:call-template name="Enqueue"/>
		<xsl:call-template name="ProcedureEnd"/>
	</xsl:template>
	<!-- Procedure Body Begin  -->	
	<xsl:template name="ProcedureBodyBegin">
		<xsl:text>
begin
  l_enqueue_options.visibility := dbms_aq.on_commit;
</xsl:text>
	</xsl:template>
	<!-- Procedure Body Local Object Instantiation  -->
	<xsl:template name="LocalObjectInstantiation">
	<xsl:value-of select="concat('  l_',Name,' := ',Name, '_type')"/>
    	<xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[1]" mode="ObjectParameterAssignmentFirst" />	
    	<xsl:apply-templates select="PrimaryKey/PrimaryKeyColumns/Column[position()>1]" mode="ObjectParameterAssignmentRest" />
    	<xsl:text>);</xsl:text>
	</xsl:template>
	<!-- Parameter Assignment -->		
	<xsl:template name="ObjectParameterAssignmentFirst" match="PrimaryKey/PrimaryKeyColumns/Column" mode="ObjectParameterAssignmentFirst">
      <xsl:value-of select="concat('( p_', Name, ' => p_', Name)"/>
	</xsl:template>	
	<xsl:template name="ObjectParameterAssignmentRest" match="PrimaryKey/PrimaryKeyColumns/Column" mode="ObjectParameterAssignmentRest">
      <xsl:value-of select="concat(', p_', Name, ' => p_', Name)"/>
	</xsl:template>
	<!-- Procedure Body  Perform the Enqueue-->
	<xsl:template name="Enqueue">
		<xsl:text>
    dbms_aq.enqueue( queue_name         => 'XXX_</xsl:text>
	<xsl:value-of select="Name"/>
		<xsl:text>_Q'
                   , enqueue_options    => l_enqueue_options
                   , message_properties => l_message_properties
</xsl:text>
      <xsl:value-of select="concat('                   , payload            => l_', Name)"/>
		<xsl:text>
                   , msgid              => l_msg_id);
</xsl:text>
	</xsl:template>
	<!-- Procedure Body Ebd -->
	<xsl:template name="ProcedureEnd">
		<xsl:value-of select="concat('end enq_', Name, ';')"/>
	</xsl:template>
</xsl:stylesheet>