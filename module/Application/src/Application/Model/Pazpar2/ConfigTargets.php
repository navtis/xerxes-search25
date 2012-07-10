<?php

namespace Application\Model\Pazpar2;

use Zend\Debug;
/**
 * An implementation of the abstract Targets class,
 * selected in configuration
 *
 * @author David Walker
 * @author Graham Seaman
 * @copyright 2011 California State University
 * @link http://xerxes.calstate.edu
 * @license http://www.gnu.org/licenses/
 * @version
 * @package Xerxes
 */

class ConfigTargets extends Targets
{
    protected $targets = array();
    protected $config;

    /**
     * Constructor
     * 
     */
        
    public function __construct()
    {
        // full set of Targets from configuration file 
        $this->config = Config::getInstance();
        $config = $this->config->getConfig("targets");

        if ( $config != null )
        { 
            foreach ( $config->target as $target_data )
            { 
                $data = array();
                // convert from SimpleXmlElement to array
                foreach($target_data->attributes() as $a => $b) 
                {
                    $data[$a] = (string)$b;
                }
                $target = new Target();
                $target->load($data);
                $this->targets[$target->pz2_key] = $target;
            }

        }
    }

    // Helper function for getTargets()
    function alphasort( $a, $b )
    {
        return strcmp( $a->title_short, $b->title_short );
    }

    /**
     * Get one or a set of targets 
     *
     * @param mixed $keys               [optional] null returns all targets, array returns a list of targets by id, string id returns single id
     * @param boolean $alpha            [optional] specifies alphabetic order
     * @return array                    array of Target objects
     */
        
    public function getTargets($keys = null, $alpha = null)
    {
        $arrTargets = array ( );
        if ( $keys == null )
        {
            // all databases
            $arrTargets = $this->targets;
        }
        else
        {
            if (! is_array( $keys ) )
            {
                // convert single id to array
                $keys = array( $keys );
            }
            // list of databases or single db
            foreach( $keys as $key )
            {
                if ( in_array( $key, $this->targets ) )
                {
                    $arrTargets[$key] = $this->targets[$key];
                }
            }
        }               
        
        if ( $alpha != null )
        {
            usort( $arrTargets, 'alphasort' );
        }
        return $arrTargets;
    }
        
}