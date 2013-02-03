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
		<xsl:with-param name="sidebar">none</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="javascript_include">
        <script src="javascript/jquery/jquery-1.6.2.min.js" language="javascript" type="text/javascript"></script>
        <script src="javascript/pz2.js" language="javascript" type="text/javascript"></script>
</xsl:template>

	
<xsl:template name="main">
	<h1>London and the South-East on your Bookshelf!</h1>

	<p>Search25 is a regional resource discovery tool; providing one stop access to the library catalogues of nearly 60 world-renowned institutions and specialist collections within the <a href="http://www.m25lib.ac.uk">M25 Consortium of Academic Libraries</a> &mdash; helping you easily obtain resources from across London and the South-East. The M25 Consortium of Academic Libraries is a collaborative organisation that works to improve library and information services within the London region and more widely across the East and South-East.</p>

	<p>Search25 makes it easier to search, locate and obtain resources at any library in the Consortium, enabling users to benefit from the wealth of materials available to them. As a regional union catalogue, focused in and around the capital, Search25 provides students and academics with an exciting new research tool. It allows users to hop between a vast range of large academic institutions and rare specialist collections densely packed in South-East England, like no other service available.</p>

	<p class="slogan">Why not try library hopping today?</p>


	</xsl:template>


</xsl:stylesheet>
