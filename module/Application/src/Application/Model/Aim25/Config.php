<?php

namespace Application\Model\Aim25;

use 
    Application\Model\Search;

/**
 * Aim25 Config
 *
 * @author David Walker
 * @copyright 2011 California State University
 * @link http://xerxes.calstate.edu
 * @license http://www.gnu.org/licenses/
 * @version
 * @package Xerxes
 */

class Config extends Search\Config
{
	protected $config_file = "config/aim25";
	private static $instance; // singleton pattern
	
	public static function getInstance()
	{
		if ( empty( self::$instance ) )
		{
			self::$instance = new Config();
			$object = self::$instance;
			$object->init();			
		}
		return self::$instance;
	}

}
