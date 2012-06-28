<?php

namespace Application\Model\Search\Availability;

use Application\Model\Search,
	Zend\Http\Client;

/**
 * Retrieve item and holdings information from an Ex Libris Voyager system
 * 
 * @author David Walker
 * @copyright 2012 California State University
 * @link http://xerxes.calstate.edu
 * @version
 * @license
 */

class Voyager implements AvailabilityInterface
{
	protected $url = ''; // final url
	protected $server = ''; // server address
	protected $ignore_locations = array();
		
	/**
	 * Create new Voyager availability lookup object
	 *
	 * @param string $server		server address
	 */
	
	public function __construct( Client $client = null )
	{
		$server = '';
		
		$this->server = rtrim($server, '/');
	
		if ( $client != null )
		{
			$this->client = $client;
		}
		else
		{
			$this->client = new Client();
		}
		
		
	
        // load configuration 
		
        $this->config = parse_ini_file('conf/VoyagerXML.ini', true);
        $this->host = $this->config['Catalog']['url'];
        
        $ignore = $this->config['Holdings']['ignore_locations'];
        $this->ignore_locations = explode(";", $ignore);
    }
    
    /**
     * Fetch record information
     *
     * @param string $id	bibliographic id
     */
	
	public function getHoldings( $id )
	{
	
		$url = $this->host . "GetHoldingsService?bibId=$id";
		$content = file_get_contents($url);
		
		
		
		$xml = new \DOMDocument();
		$xml->loadXML($content);
		
		// header("Content-type: text/xml"); echo $xml->saveXML(); 	exit;
		
		$records = $xml->getElementsByTagName("mfhdRecord");
		
		$items = array();
		
		foreach ( $records as $record )
		{
			$item = array();
			
			$item["id"] = $record->getAttribute("mfhdId");
			
			$item_count = (int) $record->getElementsByTagName("itemCount")->item(0)->nodeValue;
			
			foreach ( $record->getElementsByTagName("datafield") as $datafield )
			{
				if ( $datafield->getAttribute("tag") == "866")
				{
					$datafield->textContent;
				}
			}
			
			
			if ( $item_count == 0 )
			{
				continue;
			}
			
			$unavailable = 0;
			
			foreach ( $record->getElementsByTagName("itemData") as $itemData )
			{
				if ( $itemData->getAttribute("name") == "statusCode")
				{
					if ( $itemData->nodeValue != 1 )
					{
						$unavailable++;
					}
				}
			}
			
			if ( $item_count > 1 && $unavailable > 0)
			{
				$complex = true;
				$item["holding"] = "Y";
						
				// item count summary
			
				$available = $item_count - $unavailable;
				$number_of_items = "$item_count items ($available available)";
				
				$item["Number of items"] = $number_of_items;
				array_push($items, $item);
				continue;				
			}
			
			// locations
			
			$locations = array();			
			
			foreach ( $record->getElementsByTagName("itemLocation") as $location_node )
			{
				$location = "";
				$caption = "";
				$temp = false;
				
				foreach ( $location_node->getElementsByTagName("itemLocationData") as $location_data )
				{
					if ( $location_data->getAttribute("name") == "tempLocation")
					{
						if ( ! in_array($location_data->nodeValue, $this->ignore_locations) )
						{
							$location = $location_data->nodeValue;
						}
					}
					elseif ( $location_data->getAttribute("name") == "itemCaption" )
					{
						$caption = $location_data->nodeValue;
					}
					elseif ( $location_data->getAttribute("name") == "tmpLoc" )
					{
						$temp = true;
					}
				}
				
				if ( $location != "" )
				{
					// if this is the temp location, then previous one is the 'old' location
					
					if ( $temp == true )
					{
						array_pop($locations);
					}
					
					$locations[$location] = $caption;
				}
				
			}
			
			// no locations, so skip it yo!
			
			if ( count($locations) == 0)
			{
				continue;
			}
			
			// call number
			
			foreach ( $record->getElementsByTagName("mfhdData") as $data )
			{
				if ( $data->getAttribute("name") == "callNumber")
				{
					$item["callnumber"] = $data->nodeValue;
				}
			}
			
			// status
			
			foreach ( $record->getElementsByTagName("itemData") as $data )
			{
				if ( $data->getAttribute("name") == "statusCode")
				{
					$status = $data->nodeValue;
					$key = "holdings_item_status_$status";
					
					if ( array_key_exists($key, $this->config['Holdings']) )
					{
						$item["status"] = $this->config['Holdings'][$key];
						
						if ( $item_count > count($locations) )
						{
							$item["status"] .= " ($item_count items)";
						}
					}
					
					if ( $status == 1 )
					{
						$item["availability"] = true;
					}
					else
					{
						$item["availability"] = false;
					}
				}
				elseif ( $data->getAttribute("name") == "statusDate" )
				{
					$date = $data->nodeValue;
					$matches = array();
					
					if ( preg_match('/([0-9]{4})-([0-9]{2})-([0-9]{2})/', $date, $matches) )
					{
						$item["duedate"] = $matches[2] . "-" . $matches[3] . "-" . $matches[1];
						$item["status"] = str_replace('\d', $item["duedate"], $item["status"]);
					}
				}
			}
			
			foreach ( $locations as $item_location => $caption )
			{
				if ( $caption != "" )
				{
					$item["location"] = "$caption shelved at $item_location";
				}
				else
				{
					$item["location"] = $item_location;
				}
				
				array_push($items, $item);
			}
		}
		
		return $items;
	}

	protected function getElement($node, $name)
	{
		$elements = $node->getElementsByTagName($name);
		
		if ( count($elements) > 0 )
		{
			return $elements->item(0);
		}
		else
		{
			return null;
		}
	}
}
