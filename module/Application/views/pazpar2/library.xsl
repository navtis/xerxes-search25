<?xml version="1.0" encoding="UTF-8"?>

<!--

 author: David Walker
 copyright: 2010 California State University
 version:
 package: Worldcat
 link: http://xerxes.calstate.edu
 license: http://www.gnu.org/licenses/
 
 -->
 
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:php="http://php.net/xsl" exclude-result-prefixes="php">

	<xsl:import href="../includes.xsl" />
	<xsl:import href="../search/results.xsl" />
	<xsl:import href="includes.xsl" />

<xsl:output method="html" />

<xsl:template match="/*">
	<xsl:call-template name="surround" >
		<xsl:with-param name="surround_template">none</xsl:with-param>
		<xsl:with-param name="sidebar">none</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- override javascript-include from ../includes.xsl GS --> 
<xsl:template name="javascript_include"> 
	<xsl:call-template name="jslabels" /> 
	<script src="javascript/jquery/jquery-1.6.2.min.js" language="javascript" type="text/javascript"></script> 
	<script src="javascript/pz2_ping_noredirect.js" language="javascript" type="text/javascript"></script> 
	<script src="javascript/leaflet/leaflet.js" language="javascript" type="text/javascript"></script> 
	<script src="javascript/library_map.js" language="javascript" type="text/javascript"></script> 
	<script src="javascript/pz2.js" language="javascript" type="text/javascript"></script> 
	<link href="javascript/leaflet/leaflet.css" rel="stylesheet" type="text/css" />
	<!--[if lte IE 8]>
		<link href="javascript/leaflet/leaflet.ie.css" rel="stylesheet" type="text/css" />
	 <![endif]-->
</xsl:template>

<xsl:template name="main">

    <h1><a href="{//target/library_url}" name="{//target/short_name} Library Website" target="_blank"><xsl:value-of select="//target/display_name"/></a></h1>	
    <xsl:variable name="no-of-libraries" select="count(//libraries/library)"/>
    <!-- only display this if access option enabled in config -->
    <xsl:if test="//config/groupby/option[@id='access']">
        <xsl:choose>
            <xsl:when test="//libraries/library/type = 'virtual'"/>
            <xsl:otherwise>
                <div name="access-info">
                    <xsl:choose>
                        <!-- check user has selected role -->
                        <xsl:when test="//user-options/readable_affiliation">
                            <xsl:choose>
                                <!-- affiliation has some entitlements -->
	                        <xsl:when test="//entitlements/entitlement[@rule_id > 0]">
                                    <p>As a <span style="font-style: italic"><xsl:value-of select="//user-options/readable_role"/></span> at  <span style="font-style:italic"><xsl:value-of select="//user-options/readable_affiliation"/></span> you have the right to:</p>
                                    <ul id="entitlements">
                                        <xsl:for-each select="//entitlements/entitlement[@rule_id > 0]">

                                            <li>
                                                <xsl:choose>
                                                    <xsl:when test="./entitlement_name = 'borrow'">
                                                        <xsl:text>Borrow from </xsl:text> 
	                                            </xsl:when>
	                                            <xsl:when test="./entitlement_name = 'reference'">
	                                                <xsl:text>Use </xsl:text>
						    </xsl:when>
						    <xsl:when test="./entitlement_name = 'reserve'">
						        <xsl:text>Reserve items at </xsl:text>
						    </xsl:when>
						    <xsl:otherwise/>
					            </xsl:choose>
						    <xsl:text> this institution's libraries under the </xsl:text> <a href="{scheme_url}" target="_blank"><xsl:value-of select="scheme_name"/></a> scheme. <xsl:value-of select="charges"/> Requirements: <xsl:value-of select="requirements"/>
	                                    </li>
	                                </xsl:for-each>
	                            </ul>
			        </xsl:when>
                                <xsl:otherwise>
                                    <!-- affiliation has no known entitlements -->
				    <p>As a <span style="font-style: italic"><xsl:value-of select="//user-options/readable_role"/></span> at  <span style="font-style:italic"><xsl:value-of select="//user-options/readable_affiliation"/></span>, your rights at this institution's libraries are not known; please confirm with the institution before visiting.</p>
			        </xsl:otherwise>
		            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
				<p>If you select your home institution using the <em><xsl:value-of select="$text_options_module"/></em> above, you can see what access rights you have in this institution's libraries.</p>
			</xsl:otherwise>
		    </xsl:choose>
                </div>
                <br />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:if>
    <xsl:choose>
        <xsl:when test="$no-of-libraries = 1">
    	    <p>This institution has one library.</p>
	</xsl:when>
	<xsl:otherwise>
	    <p>This institution has <xsl:value-of select="$no-of-libraries"/> member libraries.</p>
	</xsl:otherwise>
    </xsl:choose>
    <div id="map-container">
	<div id="map-info">
            <xsl:for-each select="//libraries/library">
	        <span class="library-data" name="{full_name}" x="{latitude}" y="{longitude}"/>
            </xsl:for-each>
	</div>
	<div id="map" style="height: 250px; width: 400px;"></div>
	<span id="map-attribution">Map data © <a href="http://openstreetmap.org" target="_blank">OpenStreetMap</a> contributors</span><br />
    </div>
		<xsl:for-each select="//libraries/library">
			<xsl:choose>
				<xsl:when test="$no-of-libraries > 1">
					<h2><xsl:value-of select="position()"/>. <xsl:value-of select="full_name"/></h2>
				</xsl:when>
				<xsl:otherwise>
					<br /><br />
				</xsl:otherwise>
			</xsl:choose>
		<xsl:if test="description">
			<p><xsl:value-of select="description"/></p>
		</xsl:if>
		<xsl:if test="subjects and subjects != ''">
			<p>The library specialises in the following subjects: <xsl:value-of select="subjects"/></p>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="type = 'virtual'"/>
			<xsl:otherwise>
			<span class="heading">Address:</span><br />
			<xsl:call-template name="tokenize">
				<xsl:with-param name="text"><xsl:value-of select="address"/></xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="postcode"/><br /><br />
	
			<xsl:if test="phone != ''">
				<span class="heading">Phone: </span><xsl:value-of select="phone"/><br />
			</xsl:if>
			<xsl:if test="email != ''">
				<span class="heading">Email: </span><a href="mailto:{email}"><xsl:value-of select="email"/></a><br />
			</xsl:if>
			<br />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="(visitor_information != '') or (opac_url != '')">
			<span class="heading">Links</span><br/>
			<xsl:if test="visitor_information_url != ''">
				<a href="{visitor_information_url}" target="_blank">Visitor information</a><br />
			</xsl:if>
			<xsl:if test="opac_url != ''">
				<a href="{opac_url}" target="_blank">Library Catalogue</a><br />
			</xsl:if>
			<br />
		</xsl:if>
		<xsl:if test="(find_tube != '') or (find_train != '') or (find_bus != '') or (find_other != '') or (find_parking != '')">
			<span class="heading">Travel information</span><br/>
			<xsl:if test="find_tube != ''">
				<span class="title">Tube: </span><span class="info"><xsl:value-of select="find_tube" disable-output-escaping="yes"/></span><br/>
			</xsl:if>
			<xsl:if test="find_train != ''">
				<span class="title">Train: </span><span class="info"><xsl:value-of select="find_train" disable-output-escaping="yes"/></span><br/>
			</xsl:if>
			<xsl:if test="find_bus != ''">
				<span class="title">Bus: </span><span class="info"><xsl:value-of select="find_bus" disable-output-escaping="yes"/></span><br/>
			</xsl:if>
			<xsl:if test="find_parking != ''">
				<span class="title">Parking: </span><span class="info"><xsl:value-of select="find_parking" disable-output-escaping="yes"/></span><br/>
			</xsl:if>
			<xsl:if test="find_other != ''">
				<span class="title">General: </span><span class="info"><xsl:value-of select="find_other" disable-output-escaping="yes"/></span><br/>
			</xsl:if>
			<br />
		</xsl:if>
		<xsl:if test="notes != ''">
			<span class="heading">General notes</span><br/>
			<span class="info"><xsl:value-of select="notes" disable-output-escaping="yes"/></span>
			<br />
		</xsl:if>
	</xsl:for-each>
</xsl:template>


<!-- utility to split comma separate strings into separate lines for addresses etc -->
<xsl:template name="tokenize"> 
	<xsl:param name="text"/> 
	<xsl:param name="separator" select="','"/> 
	<xsl:choose> 
		<xsl:when test="not(contains($text, $separator))"> 
			<xsl:value-of select="normalize-space($text)"/> <br /> 
		</xsl:when> 
		<xsl:otherwise>
			<xsl:variable name="line" select="normalize-space(substring-before($text, $separator))"/>
			<xsl:value-of select="$line"/>
			<xsl:choose>
			<!-- no newline for building numbers in address -->
				<xsl:when test="string(number($line))='NaN'">
				<br /> 
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>, </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="tokenize"> 
				<xsl:with-param name="text" select="substring-after($text, $separator)"/> 
			</xsl:call-template> 
		</xsl:otherwise> 
	</xsl:choose> 
</xsl:template> 

</xsl:stylesheet>
