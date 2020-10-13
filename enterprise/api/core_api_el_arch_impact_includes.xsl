<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xpath-default-namespace="http://protege.stanford.edu/xml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xslt" xmlns:pro="http://protege.stanford.edu/xml" xmlns:eas="http://www.enterprise-architecture.org/essential" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ess="http://www.enterprise-architecture.org/essential/errorview">
    <xsl:include href="../../common/core_utilities.xsl"/>
	<xsl:include href="../../common/core_js_functions.xsl"/>
	<xsl:output method="text" encoding="UTF-8"/>
	<xsl:param name="param1"/>
    <xsl:param name="param2"/>
	
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
	
	<xsl:variable name="impactBusEnvFactors" select="/node()/simple_instance[type = 'Business_Environment_Factor']"/>
	<xsl:variable name="impactBusEnvCorrelations" select="/node()/simple_instance[name = $impactBusEnvFactors/own_slot_value[slot_reference = 'bus_env_factor_correlations']/value]"/>
	
	<xsl:variable name="impactBusOutcomeSQs" select="/node()/simple_instance[(type = 'Business_Service_Quality') and (own_slot_value[slot_reference = 'sq_for_classes']/value = 'Business_Capability')]"/>
	<xsl:variable name="impactCostTypes" select="/node()/simple_instance[type = 'Cost_Component_Type']"/>
	<xsl:variable name="impactRevenueTypes" select="/node()/simple_instance[type = 'Revenue_Component_Type']"/>
	
	<xsl:variable name="impactTechCapabilities" select="/node()/simple_instance[type='Technology_Capability']"/>
	<xsl:variable name="impactTechComponents" select="/node()/simple_instance[type='Technology_Component']"/>
	<xsl:variable name="impactTechProdRoles" select="/node()/simple_instance[type='Technology_Product_Role']"/>
	<xsl:variable name="impactTechProducts" select="/node()/simple_instance[type='Technology_Product']"/>
	<xsl:variable name="impactTPRUsages" select="/node()/simple_instance[type='Technology_Provider_Usage']"/>
	<xsl:variable name="impactTechBuildArchs" select="/node()/simple_instance[type='Technology_Build_Architecture']"/>
	<xsl:variable name="impactTechProd2TechProdRels" select="/node()/simple_instance[type=':TPU-TO-TPU-RELATION']"/>
	<xsl:variable name="impactTechBuilds" select="/node()/simple_instance[type='Technology_Product_Build']"/>
	
	<xsl:variable name="impactInfoViews" select="/node()/simple_instance[type='Information_View']"/>
	<xsl:variable name="impactBusCap2InfoViewRels" select="/node()/simple_instance[type='BUSCAP_TO_INFOVIEW_RELATION']"/>
	<xsl:variable name="impactInfoConcepts" select="/node()/simple_instance[type='Information_Concept']"/>
	
	<xsl:variable name="impactAppProviders" select="/node()/simple_instance[type=('Composite_Application_Provider', 'Application_Provider')]"/>
	<xsl:variable name="impactApplicationProRoles" select="/node()/simple_instance[type='Application_Provider_Role']"/>
	<xsl:variable name="impactAppDeployments" select="/node()/simple_instance[type='Application_Deployment']"/>
	<xsl:variable name="impactApplicatonServices" select="/node()/simple_instance[type='Application_Service']"/>
	<xsl:variable name="impactApSvc2BusProcRels" select="/node()/simple_instance[type='APP_SVC_TO_BUS_RELATION']"/>
	<xsl:variable name="impactApplicationCapabilities" select="/node()/simple_instance[type='Application_Capability']"/>
	<xsl:variable name="impactApptoPhysProcesses" select="/node()/simple_instance[type='APP_PRO_TO_PHYS_BUS_RELATION']"/>
	<xsl:variable name="impactAppUsages" select="/node()/simple_instance[type='Static_Application_Provider_Usage']"/>
	<xsl:variable name="impactApp2AppRels" select="/node()/simple_instance[type=':APU-TO-APU-STATIC-RELATION']"/>
	
	<xsl:variable name="impactTechCompUsages" select="/node()/simple_instance[type='Technology_Component_Usage']"/>
	<xsl:variable name="impactTechCompArchs" select="/node()/simple_instance[type='Technology_Component_Architecture']"/>
	<xsl:variable name="impactTechComposites" select="/node()/simple_instance[type='Technology_Composite']"/>	
	
	
	<xsl:variable name="impactPhysProcesses" select="/node()/simple_instance[type='Physical_Process']"/>
	<xsl:variable name="impactOrgs" select="/node()/simple_instance[type='Group_Actor']"/>
	<xsl:variable name="impactBusProcesses" select="/node()/simple_instance[type='Business_Process']"/>
	
	<!-- Eco system impacts -->
	<xsl:variable name="impactActor2Roles" select="/node()/simple_instance[type = 'ACTOR_TO_ROLE_RELATION']"/>
	<xsl:variable name="impactExternalRoles" select="/node()/simple_instance[(type = 'Group_Business_Role') and (own_slot_value[slot_reference = 'role_is_external']/value = 'true')]"/>
	
	<xsl:variable name="impactChannelTypes" select="/node()/simple_instance[type = 'Channel_Type']"/>
	<xsl:variable name="impactChannels" select="/node()/simple_instance[type = 'Channel']"/>
	<xsl:variable name="impactBrands" select="/node()/simple_instance[type = 'Brand']"/>
	<!--<xsl:variable name="impactProdConcepts" select="/node()/simple_instance[type = 'Product_Concept']"/>-->
	<xsl:variable name="impactProdTypes" select="/node()/simple_instance[type = ('Product_Type', 'Composite_Product_Type')]"/>
	<xsl:variable name="impactInternalProductTypes" select="$impactProdTypes[own_slot_value[slot_reference = 'product_type_external_facing']/value = 'Yes']"/>
	<xsl:variable name="impactExternalProductTypes" select="$impactProdTypes except $impactInternalProductTypes"/>
	
	
	<!-- exclude root and level 1 capabilities from impacts -->
	<xsl:variable name="allBusinessCapabilities" select="/node()/simple_instance[type='Business_Capability']"/>
	
	<xsl:variable name="busCapReportConstant" select="/node()/simple_instance[type = 'Report_Constant' and own_slot_value[slot_reference = 'name']/value = 'Root Business Capability']"/>
	<xsl:variable name="rootBusCap" select="$allBusinessCapabilities[name = $busCapReportConstant/own_slot_value[slot_reference = 'report_constant_ea_elements']/value]"/>
	<xsl:variable name="L0BusCaps" select="$allBusinessCapabilities[name = $rootBusCap/own_slot_value[slot_reference = 'contained_business_capabilities']/value]"/>
	<xsl:variable name="impactBusinessCapabilities" select="$allBusinessCapabilities except ($rootBusCap, $L0BusCaps)"/>
	
	
	
	
	<!-- ***********************
	IMPACT JSON RENDERERS
	****************************** -->
	
	<xsl:template mode="BusEnvFactorImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<xsl:variable name="parentCatId" select="$this/own_slot_value[slot_reference = 'bef_category']/value"/>
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"categoryId": "<xsl:value-of select="$parentCatId"/>",
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($this)"/>],
		"directImpacts": []	
		}<xsl:if test="not(position() = last())">,</xsl:if>
		
	</xsl:template>	
	
	
	<xsl:template mode="BusCapImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<xsl:variable name="thisinScopeBusCapAncestors" select="eas:get_object_descendants($this, $impactBusinessCapabilities, 0, 5, 'supports_business_capabilities')"/>
		<xsl:variable name="thisinScopeBusCapDescendants" select="eas:get_object_descendants($this, $impactBusinessCapabilities, 0, 5, 'contained_business_capabilities')"/>
		<xsl:variable name="thisinScopeBusCapRelatives" select="$thisinScopeBusCapAncestors union $thisinScopeBusCapDescendants"/>
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($thisinScopeBusCapRelatives)"/>],
		"directImpacts": []	
		}<xsl:if test="not(position() = last())">,</xsl:if>
		
	</xsl:template>
	
	
	<xsl:template mode="BusProcImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<!-- get conceptual scopeIds -->
		<xsl:variable name="thisBusCaps" select="$impactBusinessCapabilities[name = $this/own_slot_value[slot_reference='realises_business_capability']/value]"/>
		<xsl:variable name="thisinScopeBusCapAncestors" select="eas:get_object_descendants($thisBusCaps, $impactBusinessCapabilities, 0, 5, 'supports_business_capabilities')"/>
		<xsl:variable name="thisinScopeBusCapDescendants" select="eas:get_object_descendants($thisBusCaps, $impactBusinessCapabilities, 0, 5, 'contained_business_capabilities')"/>
		<xsl:variable name="thisinScopeBusCapRelatives" select="$thisinScopeBusCapAncestors union $thisinScopeBusCapDescendants"/>
		
		<!-- get direct impacts -->
		
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($thisinScopeBusCapRelatives)"/>],
		"directImpacts": []	
		}<xsl:if test="not(position() = last())">,</xsl:if>
	</xsl:template>
	
	
	<xsl:template mode="ChannelTypeImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($this)"/>],
		"directImpacts": []	
		}<xsl:if test="not(position() = last())">,</xsl:if>
		
	</xsl:template>
	
	
	<xsl:template mode="BrandImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($this)"/>],
		"directImpacts": []	
		}<xsl:if test="not(position() = last())">,</xsl:if>
		
	</xsl:template>
	
	
	<xsl:template mode="ProdTypeImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<xsl:variable name="isCustomerFacing">
			<xsl:choose>
				<xsl:when test="$this/own_slot_value[slot_reference='product_type_external_facing']/value = 'Yes'">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"isCustomerFacing": <xsl:value-of select="$isCustomerFacing"/>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($this)"/>],
		"directImpacts": []	
		}<xsl:if test="not(position() = last())">,</xsl:if>
		
	</xsl:template>
	
	
	<xsl:template mode="RoleImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($this)"/>],
		"directImpacts": []	
		}<xsl:if test="not(position() = last())">,</xsl:if>
		
	</xsl:template>
	
	
	
	<xsl:template mode="AppCapImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<xsl:variable name="thisinScopeAppCapAncestors" select="eas:get_object_descendants($this, $impactApplicationCapabilities, 0, 5, 'contained_in_application_capability')"/>
		<xsl:variable name="thisinScopeAppCapDescendants" select="eas:get_object_descendants($this, $impactApplicationCapabilities, 0, 5, 'contained_app_capabilities')"/>
		<xsl:variable name="thisinScopeAppCapRelatives" select="$thisinScopeAppCapAncestors union $thisinScopeAppCapDescendants"/>
		
		<!-- direct impacts -->
		<xsl:variable name="thisAppSvcs" select="$impactApplicatonServices[own_slot_value[slot_reference='realises_application_capabilities']/value = $thisinScopeAppCapRelatives/name]"/>
		<xsl:variable name="thisInScopeAPRs" select="$impactApplicationProRoles[name = $thisAppSvcs/own_slot_value[slot_reference='provides_application_services']/value]"/>
		<xsl:variable name="thisInScopeApps" select="$impactAppProviders[name = $thisInScopeAPRs/own_slot_value[slot_reference='role_for_application_provider']/value]"/>
		<xsl:variable name="thisDirectApp2PhysProcRels" select="$impactApptoPhysProcesses[own_slot_value[slot_reference=('apppro_to_physbus_from_apppro', 'apppro_to_physbus_from_appprorole')]/value = ($thisInScopeApps, $thisInScopeAPRs)/name]"/>
		<xsl:variable name="thisDirectPhysProcs" select="$impactPhysProcesses[name = $thisDirectApp2PhysProcRels/own_slot_value[slot_reference='apppro_to_physbus_to_busproc']/value]"/>
		<xsl:variable name="thisDirectOrgs" select="$impactOrgs[name = $thisDirectPhysProcs/own_slot_value[slot_reference='process_performed_by_actor_role']/value]"/>
		<xsl:variable name="thisDirectBusProcs" select="$impactBusProcesses[name = $thisDirectPhysProcs/own_slot_value[slot_reference='implements_business_process']/value]"/>
		<xsl:variable name="thisInScopeBusCaps" select="$impactBusinessCapabilities[name = $thisDirectBusProcs/own_slot_value[slot_reference='realises_business_capability']/value]"/>
		
		<xsl:variable name="thisDirectBusCaps" select="$impactBusinessCapabilities[name = $thisinScopeAppCapRelatives/own_slot_value[slot_reference='app_cap_supports_bus_cap']/value]"/>
		<xsl:variable name="thisDirecBusCapAncestors" select="eas:get_object_descendants(($thisDirectBusCaps, $thisInScopeBusCaps), $impactBusinessCapabilities, 0, 5, 'supports_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapDescendants" select="eas:get_object_descendants(($thisDirectBusCaps, $thisInScopeBusCaps), $impactBusinessCapabilities, 0, 5, 'contained_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapRelatives" select="$thisDirecBusCapAncestors union $thisDirectBusCapDescendants"/>
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="$thisinScopeAppCapRelatives"/>],
		"directImpacts": [
		<xsl:call-template name="RenderDirecImpactListJSON"><xsl:with-param name="impactClass">Business_Capability</xsl:with-param><xsl:with-param name="impactedElements" select="$thisDirectBusCapRelatives"/></xsl:call-template>,
		<xsl:call-template name="RenderDirecImpactListJSON"><xsl:with-param name="impactClass">Group_Actor</xsl:with-param><xsl:with-param name="impactedElements" select="$thisDirectOrgs"/></xsl:call-template>
		]	
		}<xsl:if test="not(position() = last())">,</xsl:if>
	</xsl:template>
	
	
	<xsl:template mode="AppServiceImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<xsl:variable name="thisInScopeAppCaps" select="$impactApplicationCapabilities[name = $this/own_slot_value[slot_reference='realises_application_capabilities']/value]"/>
		<xsl:variable name="thisinScopeAppCapAncestors" select="eas:get_object_descendants($thisInScopeAppCaps, $impactApplicationCapabilities, 0, 5, 'contained_in_application_capability')"/>
		<xsl:variable name="thisinScopeAppCapDescendants" select="eas:get_object_descendants($thisInScopeAppCaps, $impactApplicationCapabilities, 0, 5, 'contained_app_capabilities')"/>
		<xsl:variable name="thisinScopeAppCapRelatives" select="$thisinScopeAppCapAncestors union $thisinScopeAppCapDescendants"/>
		
		<!-- direct impacts -->
		<xsl:variable name="thisDirectBusProcRels" select="$impactApSvc2BusProcRels[name = $this/own_slot_value[slot_reference='supports_business_process_appsvc']/value]"/>
		<xsl:variable name="thisDirectBusProcs" select="$impactBusProcesses[name = $thisDirectBusProcRels/own_slot_value[slot_reference='appsvc_to_bus_to_busproc']/value]"/>
		
		<xsl:variable name="thisDirectBusCaps" select="$impactBusinessCapabilities[name = $thisDirectBusProcs/own_slot_value[slot_reference='realises_business_capability']/value]"/>
		<xsl:variable name="thisDirectBusCapAncestors" select="eas:get_object_descendants($thisDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'supports_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapDescendants" select="eas:get_object_descendants($thisDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'contained_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapRelatives" select="$thisDirectBusCapAncestors union $thisDirectBusCapDescendants"/>
		
		<!-- indirect impacts -->
		<!--<xsl:variable name="thisInDirectBusCaps" select="$impactBusinessCapabilities[name = $thisinScopeAppCapRelatives/own_slot_value[slot_reference='app_cap_supports_bus_cap']/value]"/>
		<xsl:variable name="thisInDirecBusCapAncestors" select="eas:get_object_descendants($thisInDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'supports_business_capabilities')"/>
		<xsl:variable name="thisInDirectBusCapDescendants" select="eas:get_object_descendants($thisInDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'contained_business_capabilities')"/>
		<xsl:variable name="thisInDirectBusCapRelatives" select="$thisInDirecBusCapAncestors union $thisInDirectBusCapDescendants"/>-->
		<!-- NOTE: RECURSION OF BUS PROCS THAT CONTAIN THIS BUS PROC 
			ADD BUS CAPS OF THESE BUS PROCS		
		-->
		
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($thisinScopeAppCapRelatives)"/>],
		"directImpacts": [
		<xsl:call-template name="RenderDirecImpactListJSON"><xsl:with-param name="impactClass">Business_Capability</xsl:with-param><xsl:with-param name="impactedElements" select="$thisDirectBusCapRelatives"/></xsl:call-template>,
		<xsl:call-template name="RenderDirecImpactListJSON"><xsl:with-param name="impactClass">Business_Process</xsl:with-param><xsl:with-param name="impactedElements" select="$thisDirectBusProcs"/></xsl:call-template>
		]
		}<xsl:if test="not(position() = last())">,</xsl:if>
	</xsl:template>
	
	
	<xsl:template mode="AppImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<!-- conceptual scopeIds -->
		<xsl:variable name="thisInScopeAPRs" select="$impactApplicationProRoles[name = $this/own_slot_value[slot_reference='provides_application_services']/value]"/>
		<xsl:variable name="thisInScopeAppSvcs" select="$impactApplicatonServices[name = $thisInScopeAPRs/own_slot_value[slot_reference='implementing_application_service']/value]"/>
		<xsl:variable name="thisInScopAppCaps" select="$impactApplicationCapabilities[name = $thisInScopeAppSvcs/own_slot_value[slot_reference='realises_application_capabilities']/value]"/>
		<xsl:variable name="thisinScopeAppCapAncestors" select="eas:get_object_descendants($thisInScopAppCaps, $impactApplicationCapabilities, 0, 5, 'contained_in_application_capability')"/>
		<xsl:variable name="thisinScopeAppCapDescendants" select="eas:get_object_descendants($thisInScopAppCaps, $impactApplicationCapabilities, 0, 5, 'contained_app_capabilities')"/>
		<xsl:variable name="thisinScopeAppCapRelatives" select="$thisinScopeAppCapAncestors union $thisinScopeAppCapDescendants"/>
		
		<!-- direct business impacts -->
		<xsl:variable name="thisDirectApp2PhysProcRels" select="$impactApptoPhysProcesses[own_slot_value[slot_reference=('apppro_to_physbus_from_apppro', 'apppro_to_physbus_from_appprorole')]/value = ($this, $thisInScopeAPRs)/name]"/>
		<xsl:variable name="thisDirectPhysProcs" select="$impactPhysProcesses[name = $thisDirectApp2PhysProcRels/own_slot_value[slot_reference='apppro_to_physbus_to_busproc']/value]"/>
		<xsl:variable name="thisDirectOrgs" select="$impactOrgs[name = $thisDirectPhysProcs/own_slot_value[slot_reference='process_performed_by_actor_role']/value]"/>
		<xsl:variable name="thisDirectBusProcs" select="$impactBusProcesses[name = $thisDirectPhysProcs/own_slot_value[slot_reference='implements_business_process']/value]"/>
		<xsl:variable name="thisDirectBusCaps" select="$impactBusinessCapabilities[name = $thisDirectBusProcs/own_slot_value[slot_reference='realises_business_capability']/value]"/>
		<xsl:variable name="thisDirectBusCapAncestors" select="eas:get_object_descendants($thisDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'supports_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapDescendants" select="eas:get_object_descendants($thisDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'contained_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapRelatives" select="$thisDirectBusCapAncestors union $thisDirectBusCapDescendants"/>
		
		<!-- direct app impacts -->
		<xsl:variable name="thisAppUsages" select="$impactAppUsages[own_slot_value[slot_reference='static_usage_of_app_provider']/value = $this/name]"/>
		<xsl:variable name="thisDirecAppDepRels" select="$impactApp2AppRels[own_slot_value[slot_reference=':TO']/value = $thisAppUsages/name]"/>
		<xsl:variable name="thisDirectAppUsages" select="$impactAppUsages[name = $thisDirecAppDepRels/own_slot_value[slot_reference=':FROM']/value]"/>
		<xsl:variable name="thisDirectApps" select="$impactAppProviders[name = $thisDirectAppUsages/own_slot_value[slot_reference='static_usage_of_app_provider']/value]"/>
		<xsl:variable name="thisDirectAPRs" select="$impactApplicationProRoles[name = $thisDirectApps/own_slot_value[slot_reference='provides_application_services']/value]"/>
		<xsl:variable name="thisDirectAppSvcs" select="$impactApplicatonServices[name = $thisDirectAPRs/own_slot_value[slot_reference='implementing_application_service']/value]"/>
		<xsl:variable name="thisDirectAppCaps" select="$impactApplicationCapabilities[name = $thisDirectAppSvcs/own_slot_value[slot_reference='realises_application_capabilities']/value]"/>
		<xsl:variable name="thisDirectAppCapAncestors" select="eas:get_object_descendants($thisDirectAppCaps, $impactApplicationCapabilities, 0, 5, 'contained_in_application_capability')"/>
		<xsl:variable name="thisDirectAppCapDescendants" select="eas:get_object_descendants($thisDirectAppCaps, $impactApplicationCapabilities, 0, 5, 'contained_app_capabilities')"/>
		<xsl:variable name="thisDirectAppCapRelatives" select="$thisDirectAppCapAncestors union $thisDirectAppCapDescendants"/>
		
		<!-- indirect impacts -->
		<!--<xsl:variable name="thisInDirectBusCaps" select="$impactBusinessCapabilities[name = $thisInScopAppCaps/own_slot_value[slot_reference='app_cap_supports_bus_cap']/value]"/>
		<xsl:variable name="thisInDirecBusCapAncestors" select="eas:get_object_descendants($thisInDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'supports_business_capabilities')"/>
		<xsl:variable name="thisInDirectBusCapDescendants" select="eas:get_object_descendants($thisInDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'contained_business_capabilities')"/>
		<xsl:variable name="thisInDirectBusCapRelatives" select="$thisInDirecBusCapAncestors union $thisInDirectBusCapDescendants"/>-->
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($thisinScopeAppCapRelatives)"/>],
		"directImpacts": [
			<xsl:call-template name="RenderDirecImpactListJSON"><xsl:with-param name="impactClass">Business_Capability</xsl:with-param><xsl:with-param name="impactedElements" select="$thisDirectBusCapRelatives"/></xsl:call-template>
			<!--<xsl:apply-templates mode="ImpactIdListJSON" select="($thisDirectBusCapRelatives, $thisDirectBusProcs, $thisDirectOrgs, $thisDirectApps, $thisDirectAppCapRelatives)"/>]-->
		}<xsl:if test="not(position() = last())">,</xsl:if>
		
	</xsl:template>
	
	
	<xsl:template mode="InfoConceptImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<xsl:variable name="thisDirectBusCaps" select="$impactBusinessCapabilities[own_slot_value[slot_reference='business_capability_requires_information']/value = $this/name]"/>
		<xsl:variable name="thisDirecBusCapAncestors" select="eas:get_object_descendants($thisDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'supports_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapDescendants" select="eas:get_object_descendants($thisDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'contained_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapRelatives" select="$thisDirecBusCapAncestors union $thisDirectBusCapDescendants"/>
		
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="$this"/>],
		"directImpacts": [
		<xsl:call-template name="RenderDirecImpactListJSON"><xsl:with-param name="impactClass">Business_Capability</xsl:with-param><xsl:with-param name="impactedElements" select="$thisDirectBusCapRelatives"/></xsl:call-template>
		<!--<xsl:apply-templates mode="ImpactIdListJSON" select="$thisDirectBusCapRelatives"/>-->
		]
		}<xsl:if test="not(position() = last())">,</xsl:if>
	</xsl:template>
	
	
	<xsl:template mode="InfoViewImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<!-- Scope -->
		<xsl:variable name="thisInfoConcepts" select="$impactInfoConcepts[name = $this/own_slot_value[slot_reference='refinement_of_information_concept']/value]"/>
		
		<!-- Direct Impacts -->
		<xsl:variable name="thisBusCap2InfoViewRels" select="$impactBusCap2InfoViewRels[own_slot_value[slot_reference='buscap_to_infoview_to_infoview']/value = $this/name]"/>		
		<xsl:variable name="thisDirectBusCaps" select="$impactBusinessCapabilities[name = $thisBusCap2InfoViewRels/own_slot_value[slot_reference='buscap_to_infoview_from_buscap']/value]"/>
		<xsl:variable name="thisDirectBusCapAncestors" select="eas:get_object_descendants($thisDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'supports_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapDescendants" select="eas:get_object_descendants($thisDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'contained_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapRelatives" select="$thisDirectBusCapAncestors union $thisDirectBusCapDescendants"/>
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($thisInfoConcepts)"/>],
		"directImpacts": [
			<xsl:call-template name="RenderDirecImpactListJSON"><xsl:with-param name="impactClass">Business_Capability</xsl:with-param><xsl:with-param name="impactedElements" select="$thisDirectBusCapRelatives"/></xsl:call-template>
			<!--<xsl:apply-templates mode="ImpactIdListJSON" select="($thisDirectBusCapRelatives)"/>-->
		]
		}<xsl:if test="not(position() = last())">,</xsl:if>
	</xsl:template>
	
	
	<xsl:template mode="TechCapImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<xsl:variable name="thisinScopeTechCapAncestors" select="eas:get_object_descendants($this, $impactTechCapabilities, 0, 5, 'contained_in_technology_capabilities')"/>
		<xsl:variable name="thisinScopeTechCapDescendants" select="eas:get_object_descendants($this, $impactTechCapabilities, 0, 5, 'contained_technology_capabilities')"/>
		<xsl:variable name="thisinScopeTechCapRelatives" select="$thisinScopeTechCapAncestors union $thisinScopeTechCapDescendants"/>
		
		<!-- direct impacts -->
		<xsl:variable name="thisTechComps" select="$impactTechComponents[own_slot_value[slot_reference='realisation_of_technology_capability']/value = $thisinScopeTechCapRelatives/name]"/>
		<xsl:variable name="thisTPRs" select="$impactTechProdRoles[own_slot_value[slot_reference='implements_technology_components']/value = $thisTechComps/name]"/>
		<xsl:variable name="thisDirectTPRUsages" select="$impactTPRUsages[own_slot_value[slot_reference='provider_as_role']/value = $thisTPRs/name]"/>
		<xsl:variable name="thisDirectTechBuildArchs" select="$impactTPRUsages[name = $thisDirectTPRUsages/own_slot_value[slot_reference='used_in_technology_provider_architecture']/value]"/>
		<xsl:variable name="thisDirectTechBuilds" select="$impactTPRUsages[name = $thisDirectTechBuildArchs/own_slot_value[slot_reference='describes_technology_provider']/value]"/>
		<xsl:variable name="thisDirectAppDeployments" select="$impactAppDeployments[own_slot_value[slot_reference='application_deployment_technical_arch']/value = $thisDirectTechBuilds/name]"/>
		<xsl:variable name="thisDirectApps" select="$impactAppProviders[own_slot_value[slot_reference='deployments_of_application_provider']/value = $thisDirectAppDeployments/name]"/>
		<xsl:variable name="thisInScopeAPRs" select="$impactApplicationProRoles[name = $thisDirectApps/own_slot_value[slot_reference='provides_application_services']/value]"/>
		<xsl:variable name="thisInScopeAppSvcs" select="$impactApplicatonServices[name = $thisInScopeAPRs/own_slot_value[slot_reference='implementing_application_service']/value]"/>
		<xsl:variable name="thisInScopAppCaps" select="$impactApplicationCapabilities[name = $thisInScopeAppSvcs/own_slot_value[slot_reference='realises_application_capabilities']/value]"/>
		
		<xsl:variable name="thisDirectAppCaps" select="$impactApplicationCapabilities[own_slot_value[slot_reference='app_cap_supporting_tech_caps']/value = $thisinScopeTechCapRelatives/name]"/>
		<xsl:variable name="thisDirectAppCapAncestors" select="eas:get_object_descendants(($thisDirectAppCaps, $thisInScopAppCaps), $impactApplicationCapabilities, 0, 5, 'contained_in_application_capability')"/>
		<xsl:variable name="thisDirectAppCapDescendants" select="eas:get_object_descendants(($thisDirectAppCaps, $thisInScopAppCaps), $impactApplicationCapabilities, 0, 5, 'contained_app_capabilities')"/>
		<xsl:variable name="thisDirectAppCapRelatives" select="$thisDirectAppCapAncestors union $thisDirectAppCapDescendants"/>
		
		<!-- indirect impacts -->
		<!--<xsl:variable name="thisInDirectBusCaps" select="$impactBusinessCapabilities[name = $thisDirectAppCapRelatives/own_slot_value[slot_reference='app_cap_supports_bus_cap']/value]"/>
		<xsl:variable name="thisInDirecBusCapAncestors" select="eas:get_object_descendants($thisInDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'supports_business_capabilities')"/>
		<xsl:variable name="thisInDirectBusCapDescendants" select="eas:get_object_descendants($thisInDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'contained_business_capabilities')"/>
		<xsl:variable name="thisInDirectBusCapRelatives" select="$thisInDirecBusCapAncestors union $thisInDirectBusCapDescendants"/>-->
		
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="$thisinScopeTechCapRelatives"/>],
		"directImpacts": [
			<xsl:call-template name="RenderDirecImpactListJSON"><xsl:with-param name="impactClass">Application_Capability</xsl:with-param><xsl:with-param name="impactedElements" select="$thisDirectAppCapRelatives"/></xsl:call-template>
			<!--<xsl:apply-templates mode="ImpactIdListJSON" select="$thisDirectAppCapRelatives"/>-->
		]
		}<xsl:if test="not(position() = last())">,</xsl:if>
	</xsl:template>
	
	
	<xsl:template mode="TechCompImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<!-- Scope/direct impact tech caps -->
		<xsl:variable name="thisInScopeTechCaps" select="$impactTechCapabilities[name = $this/own_slot_value[slot_reference='realisation_of_technology_capability']/value]"/>	
		<xsl:variable name="thisinScopeTechCapAncestors" select="eas:get_object_descendants($thisInScopeTechCaps, $impactTechCapabilities, 0, 5, 'contained_in_technology_capabilities')"/>
		<xsl:variable name="thisinScopeTechCapDescendants" select="eas:get_object_descendants($thisInScopeTechCaps, $impactTechCapabilities, 0, 5, 'contained_technology_capabilities')"/>
		<xsl:variable name="thisinScopeTechCapRelatives" select="$thisinScopeTechCapAncestors union $thisinScopeTechCapDescendants"/>
		
		<!-- direct apps -->
		<xsl:variable name="thisDirectTechCompUsages" select="$impactTechCompUsages[own_slot_value[slot_reference='usage_of_technology_component']/value = $this/name]"/>
		<xsl:variable name="thisDirectTechCompArchs" select="$impactTechCompArchs[name = $thisDirectTechCompUsages/own_slot_value[slot_reference='inverse_of_technology_component_usages']/value]"/>
		<xsl:variable name="thisDirectTechComposites" select="$impactTechComposites[name = $thisDirectTechCompArchs/own_slot_value[slot_reference='describes_technology_composite']/value]"/>
		<xsl:variable name="thisDirectApps" select="$impactAppProviders[own_slot_value[slot_reference='implemented_with_technology']/value = $thisDirectTechComposites/name]"></xsl:variable>
		
		
		<!-- indirect bus procs/capabilities -->
		<!--<xsl:variable name="thisInScopeAPRs" select="$impactApplicationProRoles[name = $thisDirectApps/own_slot_value[slot_reference='provides_application_services']/value]"/>
		<xsl:variable name="thisDirectApp2PhysProcRels" select="$impactApptoPhysProcesses[own_slot_value[slot_reference=('apppro_to_physbus_from_apppro', 'apppro_to_physbus_from_appprorole')]/value = ($thisDirectApps, $thisInScopeAPRs)/name]"/>
		<xsl:variable name="thisDirectPhysProcs" select="$impactPhysProcesses[name = $thisDirectApp2PhysProcRels/own_slot_value[slot_reference='apppro_to_physbus_to_busproc']/value]"/>
		<xsl:variable name="thisDirectOrgs" select="$impactOrgs[name = $thisDirectPhysProcs/own_slot_value[slot_reference='process_performed_by_actor_role']/value]"/>
		<xsl:variable name="thisDirectBusProcs" select="$impactBusProcesses[name = $thisDirectPhysProcs/own_slot_value[slot_reference='implements_business_process']/value]"/>
		<xsl:variable name="thisDirectBusCaps" select="$impactBusinessCapabilities[name = $thisDirectBusProcs/own_slot_value[slot_reference='realises_business_capability']/value]"/>
		<xsl:variable name="thisDirectBusCapAncestors" select="eas:get_object_descendants($thisDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'supports_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapDescendants" select="eas:get_object_descendants($thisDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'contained_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapRelatives" select="$thisDirectBusCapAncestors union $thisDirectBusCapDescendants"/>-->
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($thisinScopeTechCapRelatives)"/>],
		"directImpacts": [<xsl:apply-templates mode="ImpactIdListJSON" select="($thisDirectApps)"/>]
		}<xsl:if test="not(position() = last())">,</xsl:if>
	</xsl:template>
	
	
	<xsl:template mode="TechProdImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		<!-- scoping tech caps -->
		<xsl:variable name="thisScopeTPRs" select="$impactTechProdRoles[name = $this/own_slot_value[slot_reference='implements_technology_components']/value]"/>
		<xsl:variable name="thisScopeTechComps" select="$impactTechComponents[name = $thisScopeTPRs/own_slot_value[slot_reference='implementing_technology_component']/value]"/>
		<xsl:variable name="thisScopeTechCaps" select="$impactTechCapabilities[name = $thisScopeTechComps/own_slot_value[slot_reference='realisation_of_technology_capability']/value]"/>
		<xsl:variable name="thisinScopeTechCapAncestors" select="eas:get_object_descendants($thisScopeTechCaps, $impactTechCapabilities, 0, 5, 'contained_in_technology_capabilities')"/>
		<xsl:variable name="thisinScopeTechCapDescendants" select="eas:get_object_descendants($thisScopeTechCaps, $impactTechCapabilities, 0, 5, 'contained_technology_capabilities')"/>
		<xsl:variable name="thisinScopeTechCapRelatives" select="$thisinScopeTechCapAncestors union $thisinScopeTechCapDescendants"/>
		
		<!-- direct apps ??tech prods - DEFERRED?? -->
		<xsl:variable name="thisDirectTPRUsages" select="$impactTPRUsages[own_slot_value[slot_reference='provider_as_role']/value = $thisScopeTPRs/name]"/>
		<xsl:variable name="thisDirectTechBuildArchs" select="$impactTPRUsages[name = $thisDirectTPRUsages/own_slot_value[slot_reference='used_in_technology_provider_architecture']/value]"/>
		<xsl:variable name="thisDirectTechBuilds" select="$impactTPRUsages[name = $thisDirectTechBuildArchs/own_slot_value[slot_reference='describes_technology_provider']/value]"/>
		<xsl:variable name="thisDirectAppDeployments" select="$impactAppDeployments[own_slot_value[slot_reference='application_deployment_technical_arch']/value = $thisDirectTechBuilds/name]"/>
		<xsl:variable name="thisDirectApps" select="$impactAppProviders[own_slot_value[slot_reference='deployments_of_application_provider']/value = $thisDirectAppDeployments/name]"/>
		
		<!-- indirect bus procs/caps -->
		<!--<xsl:variable name="thisInScopeAPRs" select="$impactApplicationProRoles[name = $thisDirectApps/own_slot_value[slot_reference='provides_application_services']/value]"/>
		<xsl:variable name="thisDirectApp2PhysProcRels" select="$impactApptoPhysProcesses[own_slot_value[slot_reference=('apppro_to_physbus_from_apppro', 'apppro_to_physbus_from_appprorole')]/value = ($thisDirectApps, $thisInScopeAPRs)/name]"/>
		<xsl:variable name="thisDirectPhysProcs" select="$impactPhysProcesses[name = $thisDirectApp2PhysProcRels/own_slot_value[slot_reference='apppro_to_physbus_to_busproc']/value]"/>
		<xsl:variable name="thisDirectOrgs" select="$impactOrgs[name = $thisDirectPhysProcs/own_slot_value[slot_reference='process_performed_by_actor_role']/value]"/>
		<xsl:variable name="thisDirectBusProcs" select="$impactBusProcesses[name = $thisDirectPhysProcs/own_slot_value[slot_reference='implements_business_process']/value]"/>
		<xsl:variable name="thisDirectBusCaps" select="$impactBusinessCapabilities[name = $thisDirectBusProcs/own_slot_value[slot_reference='realises_business_capability']/value]"/>
		<xsl:variable name="thisDirectBusCapAncestors" select="eas:get_object_descendants($thisDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'supports_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapDescendants" select="eas:get_object_descendants($thisDirectBusCaps, $impactBusinessCapabilities, 0, 5, 'contained_business_capabilities')"/>
		<xsl:variable name="thisDirectBusCapRelatives" select="$thisDirectBusCapAncestors union $thisDirectBusCapDescendants"/>-->
		
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($thisinScopeTechCapRelatives)"/>],
		"directImpacts": [<xsl:apply-templates mode="ImpactIdListJSON" select="($thisDirectApps)"/>]
		}<xsl:if test="not(position() = last())">,</xsl:if>
	</xsl:template>
	
	
	<xsl:template mode="CostTypeImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($this)"/>],
		"directImpacts": []	
		}<xsl:if test="not(position() = last())">,</xsl:if>
		
	</xsl:template>
	
	
	<xsl:template mode="RevenueTypeImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($this)"/>],
		"directImpacts": []	
		}<xsl:if test="not(position() = last())">,</xsl:if>
		
	</xsl:template>
	
	
	<xsl:template mode="BusOutcomeImpactJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		"<xsl:value-of select="$this/name"/>": {
		<xsl:call-template name="RenderImpactIdNameJSON"><xsl:with-param name="this" select="$this"/></xsl:call-template>,
		"scopeIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="($this)"/>],
		"directImpacts": []	
		}<xsl:if test="not(position() = last())">,</xsl:if>
		
	</xsl:template>
	
	
	<xsl:template mode="ImpactIdListJSON" match="node()">
		<xsl:variable name="this" select="current()"/>
		
		"<xsl:value-of select="$this/name"/>"<xsl:if test="not(position() = last())">,</xsl:if>
	</xsl:template>
	
	<xsl:template name="RenderImpactIdNameJSON">
		<xsl:param name="this"/>
		
		"id": "<xsl:value-of select="$this/name"/>",
		"name": "<xsl:call-template name="RenderMultiLangInstanceName"><xsl:with-param name="theSubjectInstance" select="$this"/><xsl:with-param name="isRenderAsJSString" select="true()"/></xsl:call-template>",
		"meta": {
			"anchorClass": "<xsl:value-of select="$this/type"/>"
		}
	</xsl:template>
	
	<xsl:template name="RenderDirecImpactListJSON">
		<xsl:param name="impactedElements"/>
		<xsl:param name="impactClass"/>
		
		{
		"impactIds": [<xsl:apply-templates mode="ImpactIdListJSON" select="$impactedElements"/>],
		"meta": {
		"anchorClass": "<xsl:value-of select="$impactClass"/>"
		}
		}
	</xsl:template>
	
	
	<xsl:template match="node()" mode="InstanceSimpleJSON">
		<xsl:variable name="this" select="current()"/>
		
		<xsl:variable name="thisLink">
			<xsl:call-template name="RenderInstanceLinkForJS">
				<xsl:with-param name="theSubjectInstance" select="$this"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="thisDesc">
			<xsl:call-template name="RenderMultiLangInstanceDescription"><xsl:with-param name="theSubjectInstance" select="$this"/></xsl:call-template>
		</xsl:variable>
		
		{
		"id": "<xsl:value-of select="eas:getSafeJSString(current()/name)"/>",
		"link": "<xsl:value-of select="$thisLink"/>",
		"name": "<xsl:value-of select="$this/own_slot_value[slot_reference = 'name']/value"/>",
		"type": "<xsl:value-of select="$this/type"/>"<!--,
		"description": "<xsl:value-of select="eas:validJSONString($thisDesc)"/>"-->
		}<xsl:if test="not(position() = last())"><xsl:text>,
		</xsl:text></xsl:if>
		
	</xsl:template>
	
		
</xsl:stylesheet>

