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

class ApiTargets extends Targets
{
    protected $targets = array();
    protected $client;

    // Helper function 
    function alphasort( $a, $b )
    {
        return strcmp( $a->sort_name, $b->sort_name );
    }

    /**
     * Constructor
     * 
     */
        
    public function __construct()
    {
        // full set of Targets from Search25 API
        $this->config = Config::getInstance();
        $url = $this->config->getConfig("apiurl");
        $command = '/institutions.json?active=true';
        $this->client = Factory::getHttpClient();
        $this->client->setUri($url.$command);
        $api_institutions = $this->client->send()->getBody();
        // FIXME need to be able to vary source_type
        $command = '/z3950.json?active=true&source_type=library';
        $this->client->setUri($url.$command);
        $api_targets = $this->client->send()->getBody();
        $api_institutions = json_decode($api_institutions, true);
        $api_institutions = array_pop($api_institutions);
        $api_targets = json_decode($api_targets, true);
        $api_targets = array_pop($api_targets);
        $tgtArray = array();
        foreach($api_targets as $api_target)
        {
            $data = array();
            $key = $api_target['m25_code'];
            $data['pz2_key'] = $key;
            $data['z3950_location'] = $api_target['z39_name'];
            $data['linkback_url'] = $api_target['linkback_url'];
            $i = 0;
            while( $api_institutions[$i]['m25_code'] != $key )
            { 
                $i++;
            }
            $data['short_name'] = $api_institutions[$i]['short_name'];
            $data['display_name'] = htmlentities( $api_institutions[$i]['full_name'] );
            $data['sort_name'] = htmlentities( $api_institutions[$i]['sort_name'] );
            $data['library_url'] = $api_institutions[$i]['library_url'];
            $target = new Target();
            $target->load($data);
            $tgtArray[] = $target;
        }

        usort( $tgtArray, array($this, 'alphasort') );

        for( $i=0; $i < count($tgtArray); $i++)
        {
            $tgt = $tgtArray[$i];
            $tgt->position = $i;
            $this->targets[$tgt->pz2_key] = $tgt; 
        }
    }


    /**
     * Get one or a set of targets 
     *
     * @param mixed $keys               [optional] null returns all targets, array returns a list of targets by id, string id returns single id
     * @return array                    array of Target objects
     */
        
    public function getTargets($keys = null)
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
        
        return $arrTargets;
    }
        
}
