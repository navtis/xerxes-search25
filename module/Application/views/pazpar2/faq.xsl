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

		<dt>Where is the old Union List of Serials?
		</dt>
		<dd>The <a href="/pazpar2/options">Search options</a> page allows you to select the type of resource to search. Select the Union List of Serials in the drop-down in this section.
		</dd>

		<dt>What is Search25?</dt>
		<dd>Search25 is a new regional resource discovery tool; providing one stop access to the library catalogues of over 50 world-renowned institutions and specialist collections within the <a href="http://www.m25lib.ac.uk" target="_blank">M25 Consortium of Academic Libraries</a>. Search25 makes it easier to search, locate and obtain resources at any library in the consortium, enabling users to benefit from the wealth of materials available to them. As a regional union catalogue, focused in and around the capital, Search25 provides librarians, students and academics with an exciting new research tool. It allows users to hop between a vast range of world-renowned large academic institutions and rare specialist collections densely packed in to South-East England, like no other service available.
		</dd>

		<dt>What is the M25 Consortium of Academic Libraries?</dt>
		<dd>The <a href="http://www.m25lib.ac.uk" target="_blank">M25 Consortium of Academic Libraries</a> is a collaborative organisation that works to improve library and information services within the M25 region and more widely across the East and Southeast. The Consortium now has 57 member institutions. Its aim is to provide services and resources for the benefit of learners and researchers.
		</dd>
		
		<dt>Why use Search25 for your research?</dt>
		<dd>It is not possible for a single library to store all the books that you may need when doing research. Search25 allows you to search the library catalogues of lots of libraries at once, saving time and duplication of effort. Research materials are easily located and the subsequent library information describes how to access it. Search25 also enables researchers to do a vast literature search of specialist libraries densely packed into a single region that may have previously remained undiscovered. 
		</dd>

		<dt>How do I start searching for materials using Search25?</dt>
		<dd>Simply type the title of a book, the name of an author, the ISBN, a subject or a Keyword into the search box on any page and click <em>Go</em>. You are able to peruse research items at your leisure with no need to sign in. Search25 allows you to narrow your results after or before, it is up to you. To narrow your results before you search click on Search Options. Note that if you wish to limit your search to libraries at which you can borrow, you will need to enter your institution on the Search Options page and enter your role.
		</dd>

		<dt>What extra features are there on the <a href="/pazpar2/options">Search options</a> page?</dt>
		<dd>The <a href="/pazpar2/options">Search options</a> page allows you to do a targeted search. From this page you can limit the number of libraries to search to ones you like would like to visit, select your institution in order to search only at libraries from which you can borrow items, search the Union List of Serials, increase the number of records returned from each library, and search libraries that hold a lot of items on a particular subject.
		</dd>

		<dt>How do I access materials found on Search25?</dt>
		<dd>Search25 allows you access to the library catalogues of over 50 institutions densely packed into London and the South-East. It is therefore possible to hop between the libraries that are a part of the <a href="http://www.m25lib.ac.uk" target="_blank">M25 Consortium</a>. Most of the libraries have a reciprocal access scheme, meaning you can borrow items (if you do not wish to borrow items, you can always visit another library and work there for the day). There is information on how to visit a library, such as location, telephone numbers and transport links, once you have discovered the research materials that you wish to obtain. It is also worth watching the short film about library hopping on the homepage. We recommend when library hopping, if you wish to borrow an item, you check your access rights first by entering your current institution and role on the <a href="/pazpar2/options">Search options</a> page. When library hopping take a passport photo with you for each institution you intend to visit, ID with an address on it, your current library/student card, and a <a href="http://www.access.sconul.ac.uk" target="_blank">Sconul access</a> card. If you do not wish to visit the library in person you can arrange for an inter-library loan with your current institution.
		</dd>

		<dt>Can I order an inter-library loan through Search25?</dt>
		<dd>No, Search25 has no materials itself. You would have to go to your local library to organise an inter-library loan. There may be a charge for this service but library staff should be able to advise you of these.
		</dd>
		
		<dt>How do I find out where books and journals etc are held?</dt>
		<dd>When you search using Search25, you will return a list of items held at M25 Institutions. Beneath each result is a list of libraries at which the item is held.
		</dd>

		<dt>How do I select specific libraries to search?</dt>
		<dd>On the <a href="/pazpar2/options">Search options</a> page you are able to select and deselect specific libraries to search. Simply tick the box of the libraries you wish to search.
		</dd>

		<dt>How do I select my institutional affiliation in order to search for items that I have access to?</dt>
		<dd>On the <a href="/pazpar2/options">Search options</a> page you can select your institution and role. This allows you to limit your search to libraries at which you can borrow.
		</dd>

		<dt>What different types of research items are discoverable through Search25?</dt>
		<dd>Anything held in the libraries Search25 searches - books, journals, videos. Also, we do a background search of AIM25, which enables you to find archive materials. Sometimes you will get an 'unknown' item; this means the system has not worked out what it is due to the way it has been catalogued.
		</dd>

		<dt>Where is the Union List of Serials?</dt>
		<dd>You can select it under 'Resource type to search' on the Search Options page.
		</dd>

		<dt>How do I import M25 Consortium records in to reference manager software? (eg. Endnote/Zotero)</dt>
		<dd>Click on My Records, then select items you wish to import. Please note that they are only saved for the length of your session. This option is currently unavailable but we hope to have this working soon.
		</dd>

		<dt>What is AIM25 and why does it sometimes appear after searching for items?</dt>
		<dd><a href="http://www.aim25.ac.uk" target="_blank">AIM25</a> is a major project to provide electronic access to collection level descriptions of the archives of over one hundred higher education institutions, learned societies, cultural organisations and livery companies within the greater London area. Search25 does a background search and lets you know if there is any archive material related to what you are researching.
		</dd>

		<dt>Can I use Search25 to access electronic materials from other libraries?</dt>
		<dd>No. Not unless you can login to the institution that holds the rights to the electronic material.
		</dd>

		<dt>Why is the holdings and circulation information sometimes not visible in my results?</dt>
		<dd>This is not a problem with Search25, it is to do with each institution in the M25 Consortium - some libraries make them visible and some don’t.
		</dd>

		<dt>How does Search25 work?</dt>
		<dd>Many academic libraries run a server connected to their catalogue which allows external access (using the Z39.50 standard). When a search term is entered, Search25 connects to each of the servers selected and asks them to carry out the same search. It then collects up all the results and tries to find records it can merge together (eg. copies of the same book at different libraries) and display them. This is very different from many search systems which create a local index of all the records to be searched: it means that the results returned are always up-to-date, but that the results cannot all be presented till the slowest server has completed its search.
		</dd>

		<dt>How was Search25 developed?</dt> 
		<dd>The Search25 development was funded by the <a href="http://www.m25lib.ac.uk" target="_blank">M25 Consortium</a> and <a href="http://www.jisc.ac.uk" target="_blank">JISC</a>. Search25 is based on a number of open-source products: <a href="https://www.indexdata.com/pazpar2" target="_blank">Pazpar2</a> for querying remote servers, <a href="http://www.sinatrarb.com/" target="_blank">Sinatra</a> to manage the API which returns details of libraries and their access rules, and <a href="http://code.google.com/p/xerxes-portal/" target="_blank">Xerxes</a> for presentation of the results.
		</dd>

		<dt>How do I report an error on Search25?</dt>
		<dd>There is an error and comments form on the <a href="/papzpar2/contact">Contact</a> page, which you can fill in.
		</dd>

		<dt>Why are the facets limited to 27 things?</dt>
		<dd>This is a temporary problem caused by a bug in one of the products which make up Search25. It is hoped that this problem will be fixed in the next release.
		</dd>

		<dt>Can I download MARC records?</dt>
		<dd>Search25 does not contain any Marc records itself; the Marc records obtained from the remote servers are processed and merged in an internal format before being presented, and so are not available for download.
		</dd>

		<dt>What is the Search25 cookie policy?</dt>
		<dd>Search25 uses cookies to keep your current search results available as you move from page to page and to maintain details of the options you have currently selected. This type of cookies are known as <a href="http://en.wikipedia.org/wiki/HTTP_cookie#Session_cookie" target="_blank">session cookies</a> - your browser can remove them automatically when it is restarted. Search25 does not use cookies to keep your information from one session to the next, or to track your usage of the system.
		</dd>

		<dt>Search25 doesn't cover all London libraries. How can I search the rest?</dt>
		<dd>Search25 only searches libraries which are members of the <a href="http://www.m25lib.ac.uk" target="_blank">M25 Consortium of Academic Libraries</a>. This includes many, but not all, academic and research libraries from London and the SouthEast. Some libraries in this area are members of <a href="http;//www.copac.org.uk" target="_blank">COPAC</a>, which has contributing libraries across the whole country. Some libraries in the area contribute journal titles to <a href="http://www.suncat.ac.uk" target="_blank">Suncat</a>. The Search results page in Search25 will always display links to COPAC and Suncat already populated with the same search you have just made, so you can cross-check in both. Unfortunately, even taken together, Search25, COPAC, and Suncat do not cover every academic library in the South East.
		</dd>

		<dt>Search25 says it has found more records than it's showing me. Why?</dt>
		<dd>Search25 first counts all records it has found. For broad searches, this number may exceed the total number of records specified as maximum in the <a href="/pazpar2/options">Search options</a>. Some libraries also limit the number of records that can be returned from a search (most often to a maximum of 1000). Once Search25 has retrieved the records, it attempts to merge records for identical items found in different libraries, so it can display more on a page. What were originally 5 separate copies may be shown as one merged record. It is the count of merged records which is displayed at the top of each page.
		</dd>

		<dt>How do I find out what I am allowed to do in a particular library?</dt>
		<dd>Go to the <a href="/pazpar2/options">Search options</a> page, enter your personal academic affiliation and role, and hit submit. Then click the information ('i') button next to the name of the institution you are interested in at the bottom of the page. This will show you the details for all libraries in that institution, together with information about your access rights there.     
		</dd>

	</dl>
	</div>
</xsl:template>


</xsl:stylesheet>
