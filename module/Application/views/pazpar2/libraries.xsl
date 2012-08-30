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
	<p>Key: Institutions marked 'searchable' can be searched using Search25. Where the word is in red, search is currently unavailable for technical reasons. Institutions marked 'ULS' contribute to the Union List of Serials, which can also be searched using Search25.</p>
	<div id="list-column" style="float:left">
		<xsl:call-template name="loop_columns">
			<xsl:with-param name="num_columns">2</xsl:with-param>
		</xsl:call-template>
       </div>
	</xsl:template>

<!-- 
        TEMPLATE: LOOP_COLUMNS
        
        A recursively called looping template for dynamically determined number of columns.
        produces the following logic 
        
        for ($i = $initial-value; $i<=$maxount; ($i = $i + 1)) {
                // print column
        }
-->
<xsl:template name="loop_columns">
        <xsl:param name="num_columns"/>
        <xsl:param name="iteration_value">1</xsl:param>
        
	<xsl:variable name="total" select="count(//institutions/institution)" />
	<xsl:variable name="numRows" select="ceiling($total div $num_columns)"/>
        <xsl:if test="$iteration_value &lt;= $num_columns">
                <div style="float: left">
                <xsl:attribute name="class">
                        <xsl:text>yui-u</xsl:text><xsl:if test="$iteration_value = 1"><xsl:text> first</xsl:text></xsl:if>
		</xsl:attribute>
		<ul>
			<xsl:for-each select="//institutions/institution[position &gt; ($numRows * ($iteration_value -1)) and position &lt;= ( $numRows * $iteration_value )]">
                <xsl:variable name="key"><xsl:value-of select="m25_code"/></xsl:variable>
                <li>
			<span class="subjectDatabaseTitle"> <a href="{library_url}" title="Go directly to {short_name}"><xsl:value-of select="full_name" /></a></span>
			<xsl:if test="has_target">
				<xsl:choose>
					<xsl:when test="has_target='t'">
						<span class="active"> Searchable </span>
					</xsl:when>
					<xsl:otherwise>
						<span class="inactive"> Searchable </span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="in_uls"><span class="active"> ULS </span></xsl:if>
				
			<xsl:if test="has_target"><span class="subjectDatabaseInfo" style="margin-right: 5px;"><a title="Information about {short_name} libraries" href="/pazpar2/library?target={$key}"> <img src="images/info.gif" alt="Information about {short_name} libraries" /></a></span></xsl:if>
                </li>
            </xsl:for-each>
                        
    </ul>
	</div>        
                <xsl:call-template name="loop_columns">
                        <xsl:with-param name="num_columns" select="$num_columns"/>
                        <xsl:with-param name="iteration_value"  select="$iteration_value+1"/>
                </xsl:call-template>
        </xsl:if>
        
</xsl:template>

</xsl:stylesheet>
