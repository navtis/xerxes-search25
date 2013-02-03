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
    <h1>Using and visiting libraries in the M25 Consortium</h1>
    <p>Most staff and students can use our libraries under the terms of the national <a href="http://www.access.sconul.ac.uk/sconul-access" title="SCONUL Access details">SCONUL Access Scheme</a>.
    Your home library will issue eligible users with an Access card 
before you travel to the library you wish to use. The library you visit 
will
     quite often ask you to complete a further application and present 
current I.D. to get the full benefit of membership.</p>
    
     <p>To find out where you might be eligble to visit check your access options on 
     <a href="http://www.access.sconul.ac.uk/sconul-access" title="SCONUL Library Search">SCONUL Library Search</a>.</p>
    <p>For staff and researchers from our special and museum library members, we offer an access scheme just for you.</p>
    
    <h2>M25 Access and Borrowing Scheme</h2>
    

    <p>The M25 Access and Borrowing Scheme supports library access for staff and research students from the following institutions 
    who are not part of the SCONUL Access Scheme:<img src="images/search25/m25cardpile.jpg" alt="Example M25 Scheme cards" align="right" border="0" height="210" width="296"/></p>

    <ul>
	<li>British Library</li>
       <li>British Museum</li>
       <li>Horniman Museum</li>
       <li>Imperial War Museum</li>
      	<li>Institute of Development Studies</li>
      	<li>Lambeth Palace Library</li>
      	<li>Royal Botanic Gardens, Kew</li>
      	<li>Royal Society of Chemistry</li>
      	<li>Science Museum</li>
      	<li>Victoria and Albert Museum</li>
      	<li>The Wiener Library for the Study of the Holocaust &amp; Genocide</li>
      	<li>Wellcome Library </li>
    </ul>
      
    <h2>How to Join</h2> 
 
    <p>Users wishing to join the scheme will first need to complete an application form. Forms are only available from your home library. The library you visit will quite often ask you to complete a further application and present current I.D. to get the full benefit of membership.</p>

    <h2>Help and information</h2>  

    <p>If you have any queries or difficulties about using any of these schemes, please consult staff at your local library.</p>

<p>Further details about the M25 access scheme are available in a short <a href="pdfs/m25userguide.pdf">M25 
      Scheme User Guide</a>.</p>

    <p>Further <a href="pdfs/m25staffguide.pdf">information 
      for M25 librarians</a> is also available.</p>    
    

</xsl:template>


</xsl:stylesheet>
