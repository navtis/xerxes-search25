<?xml version="1.0" encoding="UTF-8"?>

<!--

 author: David Walker
 author: Graham Seaman
 copyright: 2010 California State University
 version: $Id$
 package: pazpar2 
 link: http://xerxes.calstate.edu
 license: http://www.gnu.org/licenses/
 
 -->
 
<!DOCTYPE xsl:stylesheet  [
<!ENTITY nbsp   "&#160;">
<!ENTITY copy   "&#169;">
<!ENTITY reg    "&#174;">
<!ENTITY trade  "&#8482;">
<!ENTITY mdash  "&#8212;">
<!ENTITY ldquo  "&#8220;">
<!ENTITY rdquo  "&#8221;"> 
<!ENTITY pound  "&#163;">
<!ENTITY yen    "&#165;">
<!ENTITY euro   "&#8364;">
]>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl" exclude-result-prefixes="php">

<xsl:import href="../search/results.xsl" />  
<xsl:import href="includes.xsl" />


<xsl:output method="html" encoding="utf-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>

<xsl:template match="/*">
	<xsl:call-template name="surround">
		<xsl:with-param name="sidebar">right</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="javascript_include">
	<xsl:call-template name="jslabels" />
        <script src="javascript/jquery/jquery-1.6.2.min.js" language="javascript" type="text/javascript"></script>
	<script src="javascript/pz2.js" language="javascript" type="text/javascript"></script>
</xsl:template>	
	
	<xsl:template name="main">
	<xsl:if test="//Error">
		<xsl:call-template name="error-message">
			<xsl:with-param name="msg"><xsl:value-of select="//Error"/></xsl:with-param>
		</xsl:call-template>
	</xsl:if>

		<p class="intro">Search25 provides one-stop access to the library catalogues of over 50 world-renowned institutions and specialist collections within the M25 Consortium of Academic Libraries - helping you easily obtain resources from across London and the South East</p>
		<p class="slogan">Try Library Hopping today. Find out how here:</p>
		<div id="video" style="margin-left: auto; margin-right: auto;">
			<img src="images/videomock.jpg" width="640" height="385" style="margin-left: auto; margin-right:auto" onclick="alert('Video coming soon')"/>
	</div>
	<xsl:if test="//Error">
		<xsl:call-template name="error-message">
			<xsl:with-param name="msg"><xsl:value-of select="//Error"/></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="sidebar">
	<a href="http://www.m25lib.ac.uk" target="_new" style="float:right"><img src="images/search25/m25logo_transparent.png" alt="M25 Consortium Logo"/></a><div style="clear:both"/>
		<p>The <a href="http://www.m25lib.ac.uk" target="_blank">M25 Consortium of Academic Libraries</a> is a collaborative organisation that works to improve library and information services within the M25 region and more widely across the east and Southeast</p>
	<a href="http://www.jisc.ac.uk" target="_new" style="float:right"><img src="images/search25/jisclogogif_001.gif" alt="JISC Logo" style="margin-left: 25px;"/></a>
		<p>Initial development of Search25 was funded by the M25 Consortium and <a href="http://www.jisc.ac.uk">JISC</a></p>
</xsl:template>

</xsl:stylesheet>
