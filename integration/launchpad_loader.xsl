<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" xpath-default-namespace="http://protege.stanford.edu/xml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xslt" xmlns:pro="http://protege.stanford.edu/xml" xmlns:eas="http://www.enterprise-architecture.org/essential" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ess="http://www.enterprise-architecture.org/essential/errorview">
	<xsl:include href="../common/core_doctype.xsl"/>
	<xsl:include href="../common/core_common_head_content.xsl"/>
	<xsl:include href="../common/core_header.xsl"/>
	<xsl:include href="../common/core_footer.xsl"/>
	<xsl:include href="../common/core_external_doc_ref.xsl"/>
	<xsl:output method="html" omit-xml-declaration="yes" indent="yes"/>

	<xsl:param name="param1"/>

	<!-- START GENERIC PARAMETERS -->
	<xsl:param name="viewScopeTermIds"/>

	<!-- END GENERIC PARAMETERS -->

	<!-- START GENERIC LINK VARIABLES -->
	<xsl:variable name="viewScopeTerms" select="eas:get_scoping_terms_from_string($viewScopeTermIds)"/>
	<xsl:variable name="linkClasses" select="('Business_Capability', 'Application_Provider')"/>
	<!-- END GENERIC LINK VARIABLES -->

	<!--
		* Copyright © 2008-2017 Enterprise Architecture Solutions Limited.
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
	<!-- 19.04.2008 JP  Migrated to new servlet reporting engine	 -->
	<!-- 06.11.2008 JWC	Migrated to XSL v2 -->
	<!-- 29.06.2010	JWC	Fixed details links to support " ' " characters in names -->
	<!-- 01.05.2011 NJW Updated to support Essential Viewer version 3-->
	<!-- 05.01.2016 NJW Updated to support Essential Viewer version 5-->


	<xsl:template match="knowledge_base">
		<xsl:call-template name="docType"/>
		<html>
			<head>
				<xsl:call-template name="commonHeadContent"/>
				<xsl:for-each select="$linkClasses">
					<xsl:call-template name="RenderInstanceLinkJavascript">
						<xsl:with-param name="instanceClassName" select="current()"/>
						<xsl:with-param name="targetMenu" select="()"/>
					</xsl:call-template>
				</xsl:for-each>
				<title>Launchpad Plus Loaders</title>
			</head>
			<body>
				<!-- ADD THE PAGE HEADING -->
				<xsl:call-template name="Heading"/>

				<!--ADD THE CONTENT-->
				<div class="container-fluid">
				    <div class="row">
				        <div class="col-xs-12">
				            <div class="page-header">
				                <h1>
				                    <span class="text-primary">
				                        <xsl:value-of select="eas:i18n('View')" />: </span>
				                    <span class="text-darkgrey">Launchpad Plus Loaders</span>
				                </h1>
                                <p style="font-size:12pt">
                                Populate the Launchpad foundation first and import your data before extracting these files.  These sheets pull the imported information into an Excel file, allowing you to capture additional data to populate other views.  <br/>Notes:<br/>
                                    <i class="fa fa-info-circle"></i> When you click the spreadsheet link it will download an XML file.  <b>Open this file with Excel.</b><br/>
                                    <i class="fa fa-info-circle"></i> Do not edit the purple sheets, they will not be imported. We recommend you don't edit the pink worksheets.   
                                </p>
				            </div>
				        </div>

				        <!--Setup Description Section-->
				        <div class="col-xs-6">
                            <h3><i class="fa fa-file"></i> Strategic Plans</h3>
                            <p style="font-size:12pt">This supports strategic plans and roadmap views.  The first sheet to populate will be the Roadmap sheet.  Add additional rows to the end of the sheets if required. </p>
                                
				            <a class="noUL" href="report?XML=reportXML.xml&amp;XSL=integration/l4plus_strategy_planner_export.xsl&amp;CT=application/ms-excel&amp;FILE=strategic_plans.xml&amp;cl=en-gb">

				                <div class="downloadBtn btn btn-default bg-primary text-white small bottom-10">Download Strategic Plans as Excel</div>
				            </a><br/>
                            <a class="noUL" href="https://enterprise-architecture.org/downloads_area/strategic_plans_import.zip" download="strategic_plans_import.zip">

				                <div class="downloadBtn btn btn-default bg-secondary text-white small bottom-10">Download Strategic Plans Import Specification</div>
                                </a><br/>
                             <a href="https://enterprise-architecture.org/downloads_area/Using_the_Strategic_Plans_Launchpad_Plus.docx" download="Using_the_Strategic_Plans_Launchpad_Plus.docx"><h4><i class="fa fa-book"></i> Documentation</h4></a> 
                            
                            <hr/>
                            <h3><i class="fa fa-file"></i> Technology Reference </h3>
                            <p style="font-size:12pt">Data to support the Strategic Technology Product Selector and technology reference models<br/>
                           
                            </p>
				            <a class="noUL" href="report?XML=reportXML.xml&amp;XSL=integration/l4plus_tech_reference_export.xsl&amp;CT=application/ms-excel&amp;FILE=technology_reference.xml&amp;cl=en-gb">

				                <div class="downloadBtn btn btn-default bg-primary text-white small bottom-10">Download Technology Reference as Excel</div>
				            </a><br/>
                             <a class="noUL" href="https://enterprise-architecture.org/downloads_area/Technology_Reference_Import.zip" download="Technology_Reference_Import.zip">

				                <div class="downloadBtn btn btn-default bg-secondary text-white small bottom-10">Download Technology Reference Import Specification</div>
				            </a><br/>
                             <a href="https://enterprise-architecture.org/downloads_area/LaunchpadPlus-Technology_Reference_worksheet.docx" download="LaunchpadPlus-Technology_Reference_worksheet.docx"><h4><i class="fa fa-book"></i> Documentation</h4></a> 
                             
				        </div>
				        <div class="col-xs-6">
                            <h3><i class="fa fa-file"></i> Strategy Planner</h3>
                            <p style="font-size:12pt">Support for the Strategic Planner view including Customer Journeys</p>
				            <a class="noUL" href="report?XML=reportXML.xml&amp;XSL=integration/l4plus_strat_planner_export.xsl&amp;CT=application/ms-excel&amp;FILE=cust_journey_strat_planner.xml&amp;cl=en-gb">

				                <div class="downloadBtn btn btn-default bg-primary text-white small bottom-10">Download Strategy Planner as Excel</div>
				            </a><br/>
                            <a class="noUL" href="https://enterprise-architecture.org/downloads_area/Strategy_Planner_Import_v2.zip" download="Strategy_Planner_Import_v2.zip">

				                <div class="downloadBtn btn btn-default bg-secondary text-white small bottom-10">Download Strategy Planner Import Specification</div>
				            </a><br/>
                            <a href="https://enterprise-architecture.org/downloads_area/LaunchpadPlus-Strategy_Planner_and_Customer_Journeys.docx" download="LaunchpadPlus-Strategy_Planner_and_Customer_Journeys.docx"><h4><i class="fa fa-book"></i> Documentation</h4></a> 
				       <hr/> 
                             <h3><i class="fa fa-file"></i> Value Streams</h3>
                            <p style="font-size:12pt">Data to support the Value Streams<br/>
                           
                            </p>
				            <a class="noUL" href="report?XML=reportXML.xml&amp;XSL=integration/l4plus_value_stream_export.xsl&amp;CT=application/ms-excel&amp;FILE=value_streams.xml&amp;cl=en-gb">

				                <div class="downloadBtn btn btn-default bg-primary text-white small bottom-10">Download Value Streams as Excel</div>
				            </a><br/>
                             <a class="noUL" href="https://enterprise-architecture.org/downloads_area/Value_Streams_Import_v1.zip" download="Value_Streams_Import_v1.zip">

				                <div class="downloadBtn btn btn-default bg-secondary text-white small bottom-10">Download Value Streams Import Specification</div>
				            </a><br/>
                            <a href="https://enterprise-architecture.org/downloads_area/LaunchpadPlus-Value_Streams.docx" download="LaunchpadPlus-Value_Streams.docx"><h4><i class="fa fa-book"></i> Documentation</h4></a> 
				        </div>
				    </div>
				</div>

				<!-- ADD THE PAGE FOOTER -->
				<xsl:call-template name="Footer"/>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
