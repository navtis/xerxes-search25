<?php

namespace Application\Model\Metalib;

use Application\Model\Authentication\User,
	Application\Model\KnowledgeBase\Database,
	Application\Model\KnowledgeBase\KnowledgeBase,
	Xerxes\Metalib,
	Xerxes\Utility\Cache,
	Xerxes\Utility\Factory,
	Xerxes\Utility\Parser,
	Xerxes\Utility\Xsl;

/**
 * Metalib Search Group
 *
 * @author David Walker
 * @copyright 2012 California State University
 * @link http://xerxes.calstate.edu
 * @license http://www.gnu.org/licenses/
 * @version
 * @package Xerxes
 */

class Group
{
	protected $date; // date search was initialized
	protected $id; // id for the group
	
	protected $merged_set; // merged result set
	protected $included_databases = array(); // databases included in the search
	protected $excluded_databases = array(); // databases excluded from the search
	
	protected $config; // metalib config
	protected $client; // metalib client
	protected $cache; // cache

	public function __sleep()
	{
		// don't include config & cache
		
		return Parser::removeProperties(get_object_vars($this), array('config', 'cache'));
	}
	
	/**
	 * Initiate the search with Metalib for this Group
	 */
	
	public function initiateSearch(Query $query)
	{
		// flesh out database information from the kb
		
		$this->fillDatabaseInfo($query);		
		
		// start the search
		
		$this->id = $this->client()->search( $query->toQuery(), $this->getSearchableDatabases() );
		
		// register the date
		
		$this->date = $this->getSearchDate();
	}
	
	/**
	 * Check the status of the search
	 * 
	 * Updates internal Merged/Database Result Set objects as well
	 * 
	 * @return Status
	*/
	
	public function getSearchStatus()
	{
		$status = new Status();
		
		// get latest status from metalib
	
		$status_xml = $this->client()->getSearchStatus($this->id);
		
		// header("Content-type: text/xml"); echo $status_xml->saveXML(); exit;
		
		// parse response		
	
		$x_server_response = simplexml_import_dom($status_xml->documentElement);
	
		foreach ( $x_server_response->find_group_info_response->base_info as $base_info )
		{
			// metalib id
				
			$database_id = (string) $base_info->base_001;
				
			
			// merged set
			
			if ( (string) $base_info->base == 'MERGESET')
			{
				continue;
			}
			
			// not here?
			
			if ( ! array_key_exists($database_id, $this->included_databases) )  
			{
				continue;
			}
			
			
			## update internal record set objects
			
			$database_resultset = $this->included_databases[$database_id];
			$database_resultset->set_number = (string) $base_info->set_number;
			$database_resultset->find_status = (string)  $base_info->find_status;
			
			// @todo: see x1 for usual 'there were hits' madness
			
			$database_resultset->total = (int)  $base_info->no_of_documents; 
			
			$this->included_databases[$database_id] = $database_resultset;
			
			
			## add to status
			
			$status->addDatabaseResultSet($database_resultset);
		}
		
		// see if search is finished
		
		$status->setFinished($this->client()->isFinished($this->id));
		
		return $status;
	}
	
	/**
	 * Merge the search results
	 * 
	 * @param string $primary_sort			primary sort order
	 * @param string $secondary_sort		secondary sort order
	 * 
	 * @return Status
	 */
	
	public function merge($primary_sort = null, $secondary_sort = null)
	{
		// merge results
		
		$merged_xml = $this->client()->merge($this->id, $primary_sort, $secondary_sort);
		
		// create new merged set

		$this->merged_set = new MergedResultSet($merged_xml);
		
		// fetch facets
			
		// only if we should show facets and there is more than 15 results
			
		if ( $this->merged_set->total > 15 ) // && $this->config()->getConfig('FACETS', false, false) == true )
		{
			// full version (this is huge)
			
			$facet_xml = $this->client()->getFacets( $this->merged_set->set_number, "all" );
			$this->cache()->set( "facets-" . $this->id, $facet_xml->saveXML() );
		
			// slimmed down version (used for display) 
			
			$xsl = new Xsl(__DIR__, getcwd());
			
			$facets_slim = $xsl->transformToXml( $facet_xml, "xsl/facets-slim.xsl" );
			$this->cache()->set( "facets-slim-" . $this->id, $facets_slim );
		}
		
		// update search status
		
		return $this->getSearchStatus();
	}
	
	/**
	 * Get facets
	 */
	
	public function getFacets()
	{
		return $this->cache()->get("facets-slim-" . $this->id);
	}
	
	/**
	 * Lazyload Metalib Client
	 */
	
	protected function client()
	{
		if ( ! $this->client instanceof Metalib )
		{
			$this->client = Engine::getMetalibClient(); // metalib client
		}
		
		return $this->client;
	}
	
	/**
	 * Lazyload Config
	 */
	
	protected function config()
	{
		if ( ! $this->config instanceof Config )
		{
			$this->config = Config::getInstance();
		}
	
		return $this->config;
	}
	
	/**
	 * Lazyload Cache
	 */
	
	protected function cache()
	{
		if ( ! $this->cache instanceof Cache )
		{
			$this->cache = new Cache();
		}
	
		return $this->cache;
	}	
	
	/**
	 * Flesh out the request with database information from KB
	 *
	 * @throws \Exception
	 */
	
	protected function fillDatabaseInfo(Query $query)
	{
		// databases or subject chosen
	
		$databases = $query->getDatabases();
		$subject = $query->getSubject();
		$user = $query->getUser();
		
		// make sure we have a scope, either databases or subject
		
		if ( count($databases) == 0 && $subject == null )
		{
			throw new \Exception("No databases or subject supplied");
		}		
		
		$knowledgebase = new KnowledgeBase(); // metalib kb
		
		### populate the database information from KB
	
		// databases specifically supplied
	
		if ( count($databases) > 0 )
		{
			$databases = $knowledgebase->getDatabases($databases);
			
			foreach ( $databases as $database_object )
			{
				$this->addDatabase($database_object, $user);
			}
		}
	
		// just a subject supplied, so get databases from that subject, yo!
	
		elseif ( $subject != null )
		{
			$search_limit = $this->config()->getConfig( "SEARCH_LIMIT", true );
			
			$subject_object = $knowledgebase->getSubject($subject);
	
			// did we find a subject that has subcategories?
	
			if ( $subject_object != null 
					&& $subject_object->subcategories != null 
					&& count( $subject_object->subcategories ) > 0 )
			{
				$subs = $subject_object->subcategories;
				$subcategory = $subs[0];
				$index = 0;
					
				// get databases up to search limit from first subcategory
					
				foreach ( $subcategory->databases as $database_object )
				{
					if ( $database_object->searchable == 1 )
					{
						$this->addDatabase($database_object, $user);
						$index++;
					}
	
					if ( $index >= $search_limit )
					{
						break;
					}
				}
			}
		}
	}
	
	/**
	 * Add database to group
	 * 
	 * Assigns non-searchable databases to excluded list
	 * 
	 * @param Database $database_object
	 */
	
	public function addDatabase( Database $database_object, User $user )
	{
		$id = $database_object->database_id;
		
		// see if this database is searchable
		
		if ( $database_object->isSearchableByUser($user) )
		{
			$this->included_databases[$id] = new DatabaseResultSet($database_object);
		}
		else // dump it into the excluded pile
		{
			$this->excluded_databases[$id] = $database_object;
		}
	}
	
	/**
	 * Get searchable database IDs
	 *
	 * @return array
	 */
	
	protected function getSearchableDatabases()
	{
		return array_keys($this->included_databases);
	}
	
	/**
	 * Calculate search date based on Metalib search flush
	 */
	
	protected function getSearchDate()
	{
		$time = time();
		$hour = (int) date("G", $time);
		 
		$flush_hour = $this->config()->getConfig("METALIB_RESTART_HOUR", false, 4);
	
		if ( $hour < $flush_hour )
		{
			// use yesterday's date
			// by setting a time at least one hour greater than the flush hour,
			// so for example 5 hours ago if flush hour is 4:00 AM
		 	
			$time = $time - ( ($flush_hour + 1) * (60 * 60) );
		}
	
		return date("Y-m-d", $time);
	}
	
	/**
	 * Group ID
	 */
	
	public function getId()
	{
		return $this->id;
	}
}
