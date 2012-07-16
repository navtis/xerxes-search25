<?php

namespace Application\Model\Pazpar2;

use Zend\Debug,
    Xerxes\Utility\Factory;

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

class ApiLibraries extends Libraries
{
    protected $libraries = array();
    protected $client;

    // Helper function 
    function alphasort( $a, $b )
    {
        return strcmp( $a->name, $b->name );
    }

    /**
     * Constructor
     * 
     */
        
    public function __construct($pz2_key)
    {
        // full set of Libraries for this institution from Search25 API
        $this->config = Config::getInstance();
        $url = $this->config->getConfig("apiurl");
        $command = "/institutions/$pz2_key/libraries.json?active=true";
        $this->client = Factory::getHttpClient();
        $this->client->setUri($url.$command);
        $api_libraries = $this->client->send()->getBody();
        $api_libraries = json_decode($api_libraries, true);
        $api_libraries = array_pop($api_libraries);
        $arr = array();
        foreach($api_libraries as $api_library)
        {
            $library = new Library();
            $api_library['pz2_key'] = $pz2_key;
            $library->load($api_library);
            $arr[] = $library;
        }

        usort( $arr, array($this, 'alphasort') );
        $this->libraries = $arr;
    }


    /**
     * Get one or a set of libraries 
     *
     * @param mixed $keys               [optional] null returns all libraries, array returns a list of libraries by id, string id returns single id
     * @return array                    array of Library objects
     */
        
    public function getLibraries($keys = null)
    {
        $arr = array ( );
        if ( $keys == null )
        {
            // all libraries
            $arr = $this->libraries;
        }
        else
        {
            if (! is_array( $keys ) )
            {
                // convert single id to array
                $keys = array( $keys );
            }
            // list of libraries or single library
            foreach( $keys as $key )
            {
                if ( in_array( $key, $this->libraries ) )
                {
                    $arr[$key] = $this->libraries[$key];
                }
            }
        }               
        
        return $arr;
    }
        
}
