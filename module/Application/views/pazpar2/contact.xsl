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

	
<xsl:template name="main">
	<h1>Contact Us</h1>
	<xsl:choose>
		<xsl:when test="//success='1'">
			<p>Thank you for your comments, which have been sent on to the Search25 team.</p>
		</xsl:when>
		<xsl:otherwise>
	<p>If you have any comments on this service this form will send them to us. We are particularly grateful for reports of bugs and errors, so that we can try to fix them.</p>
	<p>Your email adress is optional, but without it we will not be able to reply to you.</p>
	Success: <xsl:value-of select="//success"/>
	Body: <xsl:value-of select="//msg"/>
	<form action="" method="post" id="contact-form">
		<label for="name">Name:</label> 
			<input type="text" name="name" id="name" /> 
		<label for="email">Email:</label> 
			<input type="text" name="email" id="email" /> 
		<label for="message">Message:</label><br /> 
		<textarea name="message" rows="20" cols="20" id="message"></textarea> 
		<input type="submit" name="submit-comment" value="Submit" class="submit-button" />
	</form>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="sidebar">
	<h2>Our address</h2>
	<p>
		M25 Support Team<br/>
		LSE Library<br/>
		10 Portugal Street<br/>
		London<br/>
		WC2A 2HD<br/>
		<br/>
		Tel. 020 7955 6451<br/>
	</p>	
</xsl:template>


</xsl:stylesheet>
