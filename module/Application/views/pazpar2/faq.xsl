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
	<h1>Frequently Asked Questions</h1>
	<div id="faq">
	<dl>

		<dt>What is Search25?</dt>
		<dd>Search25 is a regional resource discovery tool for London and the South East; providing one stop access to the library catalogues of nearly 60 world-renowned institutions and specialist collections within the <a href="http://www.m25lib.ac.uk" target="_blank">M25 Consortium of Academic Libraries</a>. Search25 is funded by the Consortium and makes it easier to search, locate and obtain resources at any M25 library, enabling users to benefit from the wealth of materials available to them.
		</dd>

		<dt>What is the M25 Consortium of Academic Libraries?</dt>
		<dd>The <a href="http://www.m25lib.ac.uk" target="_blank">M25 Consortium of Academic Libraries</a> is a collaborative organisation that works to improve library and information services within the M25 region and more widely across the East and Southeast. The Consortium currently has 57 member institutions and in 2013 celebrates its twentieth year. Its aim is to provide services and resources for the benefit of learners, researchers and staff in its member libraries.
		</dd>
		
		<dt>Why use Search25 for your research?</dt>
		<dd>It is not possible for a single library to store all the books that you may need when doing research. Search25 allows you to search the library catalogues of many libraries at once, saving time and duplication of effort. Research materials are easily located and the subsequent library information describes how to access it. Search25 also enables researchers to find previously undiscovered material in specialist libraries densely packed into a single region. 
		</dd>

		<dt>How do I start searching for materials using Search25?</dt>
		<dd>Simply type the title of a book, the name of an author, the ISBN, a subject term or a keyword into the search box on any page and click <em>Go</em>. You are able to peruse research items at your leisure with no need to sign in. You can change the way you search by going to Search Options.
		</dd>

		<dt>What extra features are there on the <a href="/pazpar2/options">Search options</a> page?</dt>
		<dd>The <a href="/pazpar2/options">Search options</a> page allows you to customise your search. From this page you can:
    <ul>
    <li><span>limit the number of libraries to search to ones you like would like to visit,</span></li>
    <li><span>select your institution in order to search only at libraries from which you can borrow items,</span></li>
    <li><span>search the Union List of Serials,</span></li>
    <li><span>increase the number of records returned from each library,</span></li>
    <li><span>and search libraries that hold a lot of items on a particular subject</span></li>
    </ul>
		</dd>

		<dt>How do I access materials found on Search25?</dt>
		<dd>Most M25 libraries allow borrowing or reference access for visitors. There is information on how to visit a library, such as location, telephone numbers and transport links, once you have discovered the research materials that you wish to obtain. It is also worth watching the short film about library hopping on the homepage. We recommend when library hopping, if you wish to borrow an item, you check your access rights first by entering your current institution and role on the <a href="/pazpar2/options">Search options</a> page. Please check the institution ID and specific entry requirements before visiting.
		</dd>

		<dt>Can I order an inter-library loan through Search25?</dt>
		<dd>No, Search25 has no materials itself and does not offer this facility. Please contact your home institutional library and they can give advice on how to borrow and any associated charges.
		</dd>
		
		<dt>How do I find out where books and journals etc are held?</dt>
		<dd>When you search, the results will show a list of items held at M25 Institutions. Beneath each result is a list of libraries at which the item is held.
		</dd>

		<dt>How do I select specific libraries to search?</dt>
		<dd>On the <a href="/pazpar2/options">Search options</a> page you are able to select specific libraries to search by ticking the appropriate box.
		</dd>

		<dt>How do I select my institutional affiliation in order to search for items that I have access to?</dt>
		<dd>On the <a href="/pazpar2/options">Search options</a> page you can select your institution and your role. This allows you to limit your search to libraries where you have borrowing or reference access.
		</dd>

		<dt>What different types of research items are discoverable through Search25?</dt>
		<dd>Anything held in the M25 libraries - books, journals, videos, etc.. Also, we do a background search of AIM25, which enables you to find archive materials. Sometimes you will get an 'unknown' item; this means the system has not worked out what it is due to the way it has been catalogued.
		</dd>

		<dt>Where is the Union List of Serials?</dt>
		<dd>You can select it under 'Resource type to search' on the Search Options page, and then carry out a search.
		</dd>

		<dt>How do I import M25 Consortium records in to reference manager software? (eg. Endnote/Zotero)</dt>
		<dd>This option is currently unavailable but it is hoped to be available soon.</dd>
		<!-- <dd>Click on My Records, then select items you wish to import. Please note that they are only saved for the length of your session.
		</dd> -->

		<dt>What is AIM25 and why does it sometimes appear after searching for items?</dt>
		<dd><a href="http://www.aim25.ac.uk" target="_blank">AIM25</a> provides archival collection level descriptions of over one hundred higher education institutions, learned societies, cultural organisations and livery companies within the greater London area. Search25 does a background search and lets you know if there is any archive material relevant to your search.
		</dd>

		<dt>Can I use Search25 to access electronic materials from other libraries?</dt>
		<dd>No, unless you can login to the institution that holds the rights to the electronic material.
		</dd>

		<dt>Why is the holdings and circulation information sometimes not visible in my results?</dt>
		<dd>This data comes from the individual M25 libraries and is sometimes unavailable.
		</dd>

		<dt>How does Search25 work?</dt>
		<dd>When you use Search25, it connects to each M25 library catalogue in real time and brings back records from each one. The system tries to merge as many records as possible before showing you the results. Sometimes the search process takes a little longer than expected as the system has to wait for records to be returned from all the libraries searched.
		</dd>

		<dt>How was Search25 developed?</dt> 
		<dd>The Search25 development was funded by <a href="http://www.jisc.ac.uk" target="_blank">JISC</a> and the <a href="http://www.m25lib.ac.uk" target="_blank">M25 Consortium</a>. It is based on a number of open-source software products: <a href="https://www.indexdata.com/pazpar2" target="_blank">Pazpar2</a> for querying remote library catalogues, <a href="http://www.sinatrarb.com/" target="_blank">Sinatra</a> to manage the API which returns M25 library data and details of access rules, and <a href="http://code.google.com/p/xerxes-portal/" target="_blank">Xerxes</a> for presentation of the results.
		</dd>

		<dt>How do I report an error or give feedback on Search25?</dt>
		<dd>There is an error and comments form on the <a href="/papzpar2/contact">Contact</a> page, which you can fill in.
		</dd>

		<dt>Why are the facets limited to 27 things?</dt>
		<dd>This is a temporary problem caused by a bug in one of the products which make up Search25. It is hoped that this problem will be fixed in the next software release.
		</dd>

		<dt>Can I download MARC records?</dt>
		<dd>Search25 does not contain any Marc records itself; the Marc records obtained from the remote servers are processed and merged in an internal format before being presented, and so are not available for download.
		</dd>

		<dt>What is the Search25 cookie policy?</dt>
		<dd>Search25 uses cookies to keep your current search results available as you move from page to page and to maintain details of the options you have currently selected. This type of cookie is known as a <a href="http://en.wikipedia.org/wiki/HTTP_cookie#Session_cookie" target="_blank">session cookie</a> - your browser can remove them automatically when it is restarted. Search25 does not use cookies to keep your information from one session to the next, or to track your usage of the system.
		</dd>

		<dt>Search25 doesn't cover all London libraries. How can I search the rest?</dt>
		<dd>Search25 only searches libraries which are members of the <a href="http://www.m25lib.ac.uk" target="_blank">M25 Consortium of Academic Libraries</a>. This includes many, but not all, academic and research libraries from London and the SouthEast. Some libraries are members of <a href="http;//www.copac.org.uk" target="_blank">Copac</a>, which has contributing libraries across the whole of the UK. Some libraries in the region aalso contribute journal titles to <a href="http://www.suncat.ac.uk" target="_blank">Suncat</a>. The Search results page in Search25 will always display links to Copac and Suncat so you can search these services with a single click. Unfortunately, even taken together, Search25, Copac, and Suncat do not cover every academic library in the South East.
		</dd>

		<dt>How do I find out what I am allowed to do in a particular M25 library?</dt>
		<dd>Go to the <a href="/pazpar2/options">Search options</a> page, select your home institution and role, and submit. Then at the bottom of the page click the information ('i') button next to the name of the institution you are interested in. This will show you the details for all libraries in that institution, together with information about your access rights there.     
		</dd>

	</dl>
	</div>
</xsl:template>


</xsl:stylesheet>
