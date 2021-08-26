<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xpath-default-namespace="http://protege.stanford.edu/xml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xslt" xmlns:pro="http://protege.stanford.edu/xml" xmlns:eas="http://www.enterprise-architecture.org/essential" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ess="http://www.enterprise-architecture.org/essential/errorview">
    <xsl:include href="../../common/core_utilities.xsl"/>
	<xsl:include href="../../common/core_js_functions.xsl"/>
	<xsl:output method="text" encoding="UTF-8"/>
	<xsl:param name="param1"/> 
 
    <xsl:variable name="dataObjects" select="/node()/simple_instance[type='Data_Object']"/>
	<xsl:variable name="primitiveDataObjects" select="/node()/simple_instance[type='Primitive_Data_Object']"/>
    <xsl:variable name="dataObjectAttributes" select="/node()/simple_instance[type='Data_Object_Attribute']"/>  
 	<xsl:variable name="dataAttributesCardinality" select="/node()/simple_instance[type='Data_Attribute_Cardinality']"/> 	
  	<xsl:variable name="synonyms" select="/node()/simple_instance[type='Synonym']"/>	
 	 
	<!--
		* Copyright © 2008-2019 Enterprise Architecture Solutions Limited.
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
	<!-- 03.09.2019 JP  Created	 -->
	 
	<xsl:template match="knowledge_base">
		{"data_object_attributes":[<xsl:apply-templates select="$dataObjects" mode="dataObjectAttributes"></xsl:apply-templates>]}
	</xsl:template>

	 
 	 
 <xsl:template match="node()" mode="dataObjectAttributes">
	 <xsl:variable name="thisAttributes" select="$dataObjectAttributes[name=current()/own_slot_value[slot_reference='contained_data_attributes']/value]"/>
    <!-- last two need to be org roles as the slots have been deprecated -->
    {"id":"<xsl:value-of select="eas:getSafeJSString(current()/name)"/>",
	 "name":"<xsl:call-template name="RenderMultiLangInstanceName"><xsl:with-param name="theSubjectInstance" select="current()"/><xsl:with-param name="isForJSONAPI" select="true()"/></xsl:call-template>",
	 "attributes":[<xsl:for-each select="$thisAttributes">
	  <xsl:variable name="syns" select="$synonyms[name=current()/own_slot_value[slot_reference='synonyms']/value]"/>
	 {"id":"<xsl:value-of select="eas:getSafeJSString(current()/name)"/>",
	 "name":"<xsl:call-template name="RenderMultiLangInstanceName"><xsl:with-param name="theSubjectInstance" select="current()"/><xsl:with-param name="isForJSONAPI" select="true()"/></xsl:call-template>",
	 "description":"<xsl:call-template name="RenderMultiLangInstanceDescription"><xsl:with-param name="theSubjectInstance" select="current()"/><xsl:with-param name="isForJSONAPI" select="true()"/></xsl:call-template>",
	 "synonyms":[<xsl:for-each select="$syns">{"name":"<xsl:call-template name="RenderMultiLangInstanceName"><xsl:with-param name="theSubjectInstance" select="current()"/><xsl:with-param name="isForJSONAPI" select="true()"/></xsl:call-template>",<xsl:call-template name="RenderSecurityClassificationsJSONForInstance"><xsl:with-param name="theInstance" select="current()"/></xsl:call-template>}<xsl:if test="position()!=last()">,</xsl:if></xsl:for-each>],
     "typeObject":"<xsl:value-of select="$dataObjects[name=current()/own_slot_value[slot_reference='type_for_data_attribute']/value]/own_slot_value[slot_reference='name']/value"/>",
	 "typePrimitive":"<xsl:value-of select="$primitiveDataObjects[name=current()/own_slot_value[slot_reference='type_for_data_attribute']/value]/own_slot_value[slot_reference='name']/value"/>",
	 "cardinality":"<xsl:value-of select="$dataAttributesCardinality[name=current()/own_slot_value[slot_reference='data_attribute_cardinality']/value]/own_slot_value[slot_reference='name']/value"/>"}<xsl:if test="position()!=last()">,</xsl:if> </xsl:for-each>],<xsl:call-template name="RenderSecurityClassificationsJSONForInstance"><xsl:with-param name="theInstance" select="current()"/></xsl:call-template>}<xsl:if test="position()!=last()">,</xsl:if>
      
  </xsl:template>
	
</xsl:stylesheet>
