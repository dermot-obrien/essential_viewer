<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xpath-default-namespace="http://protege.stanford.edu/xml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xslt" xmlns:pro="http://protege.stanford.edu/xml" xmlns:eas="http://www.enterprise-architecture.org/essential" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ess="http://www.enterprise-architecture.org/essential/errorview">
    <xsl:import href="../../../common/core_js_functions.xsl"/>
	<xsl:output method="text" encoding="UTF-8"/>
	
	
	<xsl:variable name="scopedClassNames" select="('Business_Capability', 'Composite_Application_Provider', 'Application_Provider', 'Technology_Product')"/>
	<xsl:variable name="allActor2Roles" select="/node()/simple_instance[type='ACTOR_TO_ROLE_RELATION']"/>
	<xsl:variable name="relevantRoles" select="/node()/simple_instance[(name = $allActor2Roles/own_slot_value[slot_reference = 'act_to_role_to_role']/value) and (own_slot_value[slot_reference = 'role_for_classes']/value = $scopedClassNames)]"/>
	<xsl:variable name="relevantActor2Roles" select="$allActor2Roles[own_slot_value[slot_reference = 'act_to_role_to_role']/value = $relevantRoles/name]"/>
	<xsl:variable name="relevantActors" select="/node()/simple_instance[name = $relevantActor2Roles/own_slot_value[slot_reference = 'act_to_role_from_actor']/value]"/>

 	
	<!--
		* Copyright © 2008-2021 Enterprise Architecture Solutions Limited.
	 	* This file is part of Essential Architecture Manager, 
	 	* the Essential Architecture Meta Model and The Essential Project.
		*
		* Essential Architecture Manager is free software: you can redistribute it and/or modify
		* it under the terms of the GNU General Public License as published by
		* the Free Software Foundation, either version 3 of the License, or
		* (at your option) any later version.
		*
		* Essential Architecture Manager is distributed in the hope that it will be useful,
		* but WITHOUT ANY WARRANTY; without even the implied warranty of
		* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		* GNU General Public License for more details.
		*
		* You should have received a copy of the GNU General Public License
		* along with Essential Architecture Manager.  If not, see <http://www.gnu.org/licenses/>.
		* 
	-->
	<!-- 03.12.2020 JP  Created	 -->
	

	<xsl:template match="knowledge_base">
		{
			"scopingLists": [
			<xsl:apply-templates mode="RenderStakeholderListJSON" select="$relevantRoles">
					<xsl:sort select="own_slot_value[slot_reference='name']/value"/>
				</xsl:apply-templates>
			]
		}
	</xsl:template>


	<!-- RENDER A SCOPING LIST BASED ON A GIVEN ROLE -->
	<xsl:template mode="RenderStakeholderListJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<xsl:variable name="thisActor2Roles" select="$relevantActor2Roles[own_slot_value[slot_reference = 'act_to_role_to_role']/value = $this/name]"/>
		<xsl:variable name="thisName">
			<xsl:call-template name="RenderMultiLangInstanceName"><xsl:with-param name="isRenderAsJSString" select="true()"/><xsl:with-param name="theSubjectInstance" select="$this"/></xsl:call-template>
		</xsl:variable>
		{
		"id": "<xsl:value-of select="$this/name"/>",
		"name": "<xsl:value-of select="$thisName"/>",
		"valueClass": "ACTOR_TO_ROLE_RELATION",
		"description": "The list of individuals or organisations that play the role of <xsl:value-of select="$thisName"/>",
		"isGroup": false,
		"icon": "fa-users",
		"color":"hsla(320, 75%, 35%, 1)",
		"values": [
			{
				"id": "NONE_<xsl:value-of select="$this/name"/>",
				"name": "No <xsl:value-of select="$thisName"/> Defined"			
			}<xsl:if test="count($thisActor2Roles) > 0">,</xsl:if>
			<xsl:apply-templates mode="RenderActor2RoleScopeJSON" select="$thisActor2Roles">
				<xsl:sort select="own_slot_value[slot_reference='name']/value"/>
			</xsl:apply-templates>
		]
		}<xsl:if test="not(position() = last())">,
		</xsl:if>
	</xsl:template>


	<xsl:template mode="RenderActor2RoleScopeJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<xsl:variable name="thisActor" select="$relevantActors[name = $this/own_slot_value[slot_reference = 'act_to_role_from_actor']/value]"/>
		
		{
		"id": "<xsl:value-of select="$this/name"/>",
		"name": "<xsl:call-template name="RenderMultiLangInstanceName"><xsl:with-param name="isRenderAsJSString" select="true()"/><xsl:with-param name="theSubjectInstance" select="$thisActor"/></xsl:call-template>"			
		}<xsl:if test="not(position() = last())">,
		</xsl:if>
	</xsl:template>

	
	<xsl:template mode="RenderBasicScopeJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		{
			"id": "<xsl:value-of select="$this/name"/>",
			"name": "<xsl:call-template name="RenderMultiLangInstanceName"><xsl:with-param name="isRenderAsJSString" select="true()"/><xsl:with-param name="theSubjectInstance" select="$this"/></xsl:call-template>"			
		}<xsl:if test="not(position() = last())">,
		</xsl:if>
	</xsl:template>
		
</xsl:stylesheet>
