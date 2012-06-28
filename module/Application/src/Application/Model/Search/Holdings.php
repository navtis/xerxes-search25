<?php

namespace Application\Model\Search;

/**
 * Result Holdings
 *
 * @author David Walker
 * @copyright 2011 California State University
 * @link http://xerxes.calstate.edu
 * @license
 * @version
 * @package Xerxes
 */

class Holdings
{
	public $id; // bibliographic id
	public $bibliographicRecord; // bibliographic record
	public $items = array(); // item record
	public $holdings = array(); // periodical holdigs
	public $electronicResources = array(); // ERM resources
	public $none; // placeholder to show there are no holdings
	
	/**
	 * Add an item to this group of items
	 * 
	 * @param Item $item
	 */
	
	public function addItem(Item $item)
	{
		array_push($this->items, $item);
	}

	/**
	 * Add (journal) holdings record to this group of items
	 * 
	 * @param Holding $holdings
	 */
	
	public function addHolding(Holding $holdings)
	{
		array_push($this->holdings, $holdings);
	}
	
	/**
	 * Add (journal) holdings record to this group of items
	 *
	 * @param Holding $holdings
	 */
	
	public function addElectronicResource(ElectronicResource $electronic)
	{
		array_push($this->electronicResources, $electronic);
	}	
	
	/**
	 * Get all items
	 */
	
	public function getItems()
	{
		return $this->items;
	}

	/**
	 * Get all holdings
	 */
	
	public function getHoldingRecords()
	{
		return $this->holdings;
	}	
	
	/**
	 * Get all electronic resources
	 */
	
	public function getElectronicResources()
	{
		return $this->electronicResources;
	}	
	
	/**
	 * The number of items
	 */
	
	public function length()
	{
		return count($this->items);
	}
}
