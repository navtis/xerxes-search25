<?php

namespace Application\Model\Pazpar2;

use Zend\Debug,
    Xerxes\Utility\Factory;

/**
 * Utility interface to the API, returning data unprocessed
 *
 * @author David Walker
 * @author Graham Seaman
 * @copyright 2011 California State University
 * @link http://xerxes.calstate.edu
 * @license http://www.gnu.org/licenses/
 * @version
 * @package Xerxes
 */

class ApiRaw
{
    protected $client;
    protected $apiurl;
    protected $api_data;

    public function __construct($command) 
    { 
        $config = Config::getInstance();
        $this->apiurl = $config->getConfig("apiurl");
        $this->client = Factory::getHttpClient();
        $this->client->setUri($this->apiurl.$command);
        $api_data = $this->client->send()->getBody();
        $api_data = json_decode($api_data, true);
        $api_data = array_pop($api_data);
        $i = 1;
        foreach($api_data as $k => $v)
        {
            $api_data[$k]['position'] = $i++;
        }
        $this->api_data = $api_data;
    }

    public function getdata()
    {
        return $this->api_data;
    }
}       
