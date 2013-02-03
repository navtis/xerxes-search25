<?xml version="1.0" encoding="UTF-8"?>

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
<xsl:import href="../includes.xsl" />

<!-- hide record saving till working -->
<xsl:template name="save_record" />

<xsl:template name="header_div" >
        <div id="hd-banner">
	<ul>
		<li><a href="/pazpar2">HOME</a></li>
		<li><a href="/pazpar2/about">ABOUT</a></li>
		<li><a href="/pazpar2/faq">FAQ</a></li>
		<li><a href="/pazpar2/libraries">LIBRARIES</a></li>
		<li><a href="/pazpar2/access">ACCESS</a></li>
		<li><a href="/pazpar2/contact">CONTACT</a></li>
	</ul>
        <xsl:call-template name="searchbox" />
        <a href="{$base_url}" id="hd-banner-link"><img src="images/search25/search25_logo1918x676.png" alt="Search25 Logo" id="banner-logo"/></a>
	</div>
 </xsl:template>

	<!--
		TEMPLATE: SIMPLE SEARCH (overrides views/search/results.xsl)
	-->
	
	<xsl:template name="simple_search">
	
		<xsl:variable name="query"	select="request/query" />

		<div class="raised-box search-box">
	
			<div class="search-label">
				<label for="field">Search</label><xsl:text> </xsl:text>
			</div>
			
			<div class="search-inputs">
				<xsl:choose>
					<xsl:when test="//pazpar2options/user-options/source_type='uls'">
						<xsl:call-template name="search-dropdown">
							<xsl:with-param name="select-list" select="config/uls_search_fields/field"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="search-dropdown">
							<xsl:with-param name="select-list" select="config/basic_search_fields/field"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
	
				<xsl:text> </xsl:text><label for="query"><xsl:value-of select="$text_searchbox_for" /></label><xsl:text> </xsl:text>
				
				<input id="query" name="query" type="text" size="32" value="{$query}" /><xsl:text> </xsl:text>
				
				<input type="submit" name="Submit" value="GO" class="submit-searchbox{$language_suffix}" />
			
			</div>
			
			<xsl:call-template name="search_refinement" />
			
			<xsl:call-template name="advanced_search_option" />
		</div>
	
	</xsl:template>

	<xsl:template name="search-dropdown">
		<xsl:param name="select-list"/>
		<select id="field" name="field">
			
			<xsl:for-each select="$select-list">
					
				<xsl:variable name="internal">
					<xsl:choose>
						<xsl:when test="@id"><xsl:value-of select="@id" /></xsl:when>
						<xsl:otherwise><xsl:value-of select="@internal" /></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
			
				<option value="{$internal}">
					<xsl:if test="//request/field = $internal">
						<xsl:attribute name="selected">selected</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="@public" />
				</option>
				
			</xsl:for-each>
		</select>
	</xsl:template>

<xsl:template name="error-message">
	<xsl:param name="msg"/>
	<div class="comms-box error-box"><xsl:value-of select="$msg"/></div>
</xsl:template>

<!--
<xsl:template name="breadcrumb">
	<span>Currently searching: </span>
	<xsl:choose>
		<xsl:when test="//pazpar2options/user-options/source_type='uls'">
			<span>Union List of Serials</span>
		</xsl:when>
		<xsl:otherwise>
			<span>M25 Libraries</span>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
-->

<xsl:template name="breadcrumb_start">
    <a>
        <xsl:attribute name="href">
            <xsl:value-of select="//request/controller"/>
            <xsl:text>/index?</xsl:text>
            <xsl:for-each select="//request/session/targetnames">
                <xsl:text>&amp;target=</xsl:text><xsl:value-of select="." />
            </xsl:for-each>
        </xsl:attribute>
        <xsl:text>Library selection</xsl:text>
    </a>
</xsl:template>

<!--  hidden field setting called from ../includes.xsl GS -->
    <xsl:template name="searchbox_hidden_fields_local">
        <xsl:call-template name="session-data"/>
    </xsl:template>

    <!-- include the current session values -->
    <xsl:template name="session-data">
        <!-- see http://www.w3.org/TR/html5/elements.html#embedding-custom-non-visible-data-with-the-data-attributes -->
        <!-- this is used by javascript and not a real hidden field -->
	<span id="pz2session" data-value="{//request/session/pz2session}" data-completed="{//request/session/completed}" data-querystring="{//request/session/querystring}" />
    </xsl:template>


    <xsl:template name="type-dependent-heading">
	<xsl:param name="type"/>
	<xsl:choose>
		<!-- FIXME remove constant -->
		    <xsl:when test="$type='uls'">
            		<h1><xsl:value-of select="$text_uls_search_module" /></h1> 
			</xsl:when>
			<xsl:otherwise>
				<h1><xsl:value-of select="$text_search_module" /></h1>
		    </xsl:otherwise>
		</xsl:choose>

    </xsl:template>
	<xsl:template name="options_sidebar">
		<div id="account" class="box">
			<h2><xsl:copy-of select="$text_header_options" /></h2>
			<ul>
				<li id="goto-options">
					<a>
						<xsl:attribute name="href">/pazpar2/options</xsl:attribute>
						<xsl:copy-of select="$text_header_my_options" />
					</a>
				</li>
	<li id="my-saved-records" class="sidebar-folder">
		<xsl:call-template name="img_save_record">
		<xsl:with-param name="id">folder</xsl:with-param>
		<xsl:with-param name="test" select="//navbar/element[@id='saved_records']/@numSessionSavedRecords &gt; 0" />
		</xsl:call-template>
		<xsl:text> </xsl:text>
		<a>
			<xsl:attribute name="href"><xsl:value-of select="//navbar/my_account_link" /></xsl:attribute>
			<xsl:copy-of select="$text_header_savedrecords" />

		</a>
	</li>
			</ul>
		</div>
	</xsl:template>

	<xsl:template name="sidebar_box">
		<div id="account" class="box">
			<!--		<h2><xsl:copy-of select="$text_link_options" /></h2> -->
			<ul>
				<xsl:if test="//config/aim25_hits=true()">
		            <xsl:call-template name="aim25_hits"/>
                </xsl:if>
                <xsl:if test="//config/search_copac = true()">
		            <xsl:call-template name="search_copac"/>
                </xsl:if>
                <xsl:if test="//config/search_suncat = true()">
		            <xsl:call-template name="search_suncat"/>
                </xsl:if>
            </ul>
        </div>
    </xsl:template>


    <xsl:template name="search_copac">
      <xsl:if test="//externalLinks/COPAC">
        <li id="search_copac">
            Try outside the M25 libraries with <a href="{//externalLinks/COPAC}" target="_blank" title="Copac National, Academic, and Specialist library catalogue">the same search in Copac</a>
        </li>
      </xsl:if>
    </xsl:template>

    <xsl:template name="search_suncat">
      <xsl:if test="//externalLinks/SUNCAT">
        <li id="search_suncat">
            Find more journals with <a href="{//externalLinks/SUNCAT}" target="_blank">the same search in SunCat</a>
        </li>
      </xsl:if>
    </xsl:template>

    <xsl:template name="aim25_hits">
        <li class="hidden" id="aim25-hits">
            Also found: <span id="aim25-hitcount"></span> AIM25 <a href="" target="_blank">archive collections</a> that may relate to your search
        </li>
</xsl:template>

    <!-- override search/results tab so no count unless live -->
    <xsl:template name="tab"> 
        <xsl:for-each select="option"> 
            <li id="tab-{@id}">
                <xsl:choose>
                    <xsl:when test="@current = 1"> 
                        <xsl:attribute name="class">here</xsl:attribute> 
                        <a href="{@url}"> 
                            <xsl:value-of select="@public" /> <xsl:text> </xsl:text> 
                        <!-- count is wrong anyway! -->
                        <!--    <xsl:call-template name="tab_hit" /> -->
                        </a> 
                    </xsl:when>
                    <xsl:otherwise>
                        <a href="{@url}"> 
                            <xsl:value-of select="@public" />  
                        </a> 
                    </xsl:otherwise>
                </xsl:choose>
            </li> 
	</xsl:for-each> 
    </xsl:template>


	<!--
		TEMPLATE: ACCOUNT OPTIONS
		links to login, options, my saved records, and other personalization features
	-->	
	
	<xsl:template name="account_options">
	
		<ul>
			<xsl:if test="//config/uselogin">
			<li id="login-option">
				<xsl:choose>
					<xsl:when test="//request/session/role and //request/session/role = 'named'">
					
						<xsl:call-template name="img_logout" />
						<xsl:text> </xsl:text>
					
						<a id="logout">
						<xsl:attribute name="href"><xsl:value-of select="//navbar/logout_link" /></xsl:attribute>
							<xsl:copy-of select="$text_header_logout" />
						</a>
						
					</xsl:when>
					<xsl:otherwise>
					
						<xsl:call-template name="img_login" />
						<xsl:text> </xsl:text>			

						<a id="login">
						<xsl:attribute name="href"><xsl:value-of select="//navbar/login_link" /></xsl:attribute>
							<xsl:copy-of select="$text_header_login" />
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</li>
		</xsl:if>
		<li><img src="images/famfamfam/user.png"/>
			<a href="/pazpar2/options"><xsl:value-of select="$text_options_module"/></a>
		</li>
		<!--
			<li id="my-saved-records" class="sidebar-folder">
				<xsl:call-template name="img_save_record">
					<xsl:with-param name="id">folder</xsl:with-param>
					<xsl:with-param name="test" select="count(//session/resultssaved) &gt; 0" />
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<a>
				<xsl:attribute name="href"><xsl:value-of select="//navbar/my_account_link" /></xsl:attribute>
					<xsl:copy-of select="$text_header_savedrecords" />
				</a>
			</li>
	-->	
		</ul>	
	
	</xsl:template>

</xsl:stylesheet>
