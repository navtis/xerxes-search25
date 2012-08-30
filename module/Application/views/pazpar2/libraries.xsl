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

<xsl:template name="main">
	<h1>M25 Member Institutions</h1>
	<p>The following institutions are members of the M25 Consortium.</p>
	<p>Key: Institutions marked 'searchable' can be searched using Search25. Where marked in red, search is currently unavailable for technical reasons. Institutions marked 'ULS' contribute to the Union List of Serials, which can also be searched using Search25.</p>
	<div id="list-column" style="float:left">
		<xsl:call-template name="institution-table"/>
       </div>
	</xsl:template>

<xsl:template name="institution-table">
                <div style="float: left">
                <xsl:attribute name="class">
			<xsl:text>yui-u first</xsl:text>
		</xsl:attribute>
		<table class="institutions">
			<tr><th></th><th>Searchable</th><th>ULS</th><th></th></tr>
			<xsl:for-each select="//institutions/institution">
                <xsl:variable name="key"><xsl:value-of select="m25_code"/></xsl:variable>
		<tr>
			<td> <a href="{library_url}" title="Go directly to {short_name}"><xsl:value-of select="full_name" /></a></td>
			<xsl:choose>
				<xsl:when test="has_target">
					<xsl:choose>
						<xsl:when test="has_target='t'">
							<td style="background-color: green;"></td>
						</xsl:when>
						<xsl:otherwise>
							<td style="background-color: red;"></td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise><td></td></xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="in_uls">
					<td style="background-color: green;"></td>
				</xsl:when>
				<xsl:otherwise>
					<td> </td>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="no_libraries > 0">
					<td><a title="Information about {short_name} libraries" href="/pazpar2/library?target={$key}">Library information</a></td>
				</xsl:when>
				<xsl:otherwise>
					<td> </td>
				</xsl:otherwise>
			</xsl:choose>
                </tr>
            </xsl:for-each>
                        
    </table>
	</div>        
        
</xsl:template>

</xsl:stylesheet>
