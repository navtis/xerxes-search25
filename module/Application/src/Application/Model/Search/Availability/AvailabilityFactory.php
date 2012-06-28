<?php

namespace Application\Model\Search\Availability;

/**
 * Availability factory
 *
 * @author David Walker
 * @copyright 2011 California State University
 * @link http://xerxes.calstate.edu
 * @license
 * @version
 * @package Xerxes
 */

class AvailabilityFactory
{
	public function getAvailabilityObject($name)
	{	
		$name = preg_replace('/\W/', '', $name);
		
		// main class
		
		$class_name = 'Application\Model\Availability' . '\\' . ucfirst($name);
		
		// local custom version
		
		$local_file = "custom/Availability/$name.php";
		
		if ( file_exists($local_file) )
		{
			require_once($local_file);
			
			$class_name = 'Local\Availability' . '\\' . ucfirst($name);
			
			if ( ! class_exists($class_name) )
			{
				throw new \Exception("the custom availability class '$name' should have a class called '$class_name'");
			}
		}

		// make it

		$availability = new $class_name();
		
		if ( ! $availability instanceof AvailabilityInterface )
		{
			throw new \Exception("class '$class_name' for the '$name' availability class must extend AvailabilityInterface");
		}
		
		return $availability;
	}
}