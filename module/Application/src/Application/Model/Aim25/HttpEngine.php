<?php

namespace Application\Model\Aim25;

use Xerxes\Utility\Factory,
    Xerxes\Utility\Cache,
    Application\Model\Search,
	Zend\Http\Client;

/**
 * A screen scraping engine which returns the count of items
 * found for a search on the Aim25 archives website.
 * It cannot be used as a full Search Engine.
 *
 * @author David Walker
 * @author Graham Seaman
 * @copyright 2011 California State University
 * @link http://xerxes.calstate.edu
 * @license http://www.gnu.org/licenses/
 * @version
 * @package Xerxes
 */

class HttpEngine extends Search\Engine
{
    protected $cache;
    protected $config;

    /* getHitCount may be called multiple times: this
       is a lazy access to avoid keep calling the httpclient
    */
    public function getHitCount($aim25sid=null, $pz2sid, $query)
    {   
        $hits = array();
        if (! is_null( $aim25sid ) )
        {
            // should have hits stored away - no need to rerun
            $hits['hits'] = $this->cache()->get('hits_'.$aim25sid);
            $hits['url'] = $this->cache()->get('url_'.$aim25sid);
            $hits['session'] = $this->cache()->get('sid_'.$aim25sid);
        }
        else
        {
            $hits['hits'] = 0;
            $hits['url'] = '';
            $hits['session'] = '';
            $params = $query->getAllSearchParams();
            // the aim25 web search doesn't do Z39.50, so we need
            // to approximate as best we can
            if (($params['field'] == 'keyword')  
                || ($params['field'] == 'title')
                || ($params['field'] == 'author')
                )
            {
                $querystring = 'zany2?term1=' . urlencode($params['query']);
            }
            else if ($params['field'] == 'subject')
            {
                $querystring = 'zub2?term1=' . urlencode($params['query']);
            }
            else
            { 
            // we don't handle isbn etc
                return $hits;
            }
	    $url = $this->conf()->getConfig('AIM25_HTTPURL', false);
            $url .= $querystring;
            $hits['url'] = $url;

            // generate a random sessionid to enable identification
            // of cached data
            //$aim25sid = md5( mt_rand() );
            $aim25sid = $pz2sid;
            $hits['session'] = $aim25sid;

            // blocking (synchronous) call to pz2 search
            $hits['hits'] = $this->scrape( $url );

            // cache so we don't need to rerun next time
            $this->cache()->set('hits_'.$aim25sid, $hits['hits']);
            $this->cache()->set('url_'.$aim25sid, $hits['url']);
            $this->cache()->set('sid_'.$aim25sid, $hits['session']);
        }
        return $hits;
    }   

    public function scrape( $url )
    {
        $client = new Client($url);
        $records = 0;
        $response = $client->send();
        if ( $response->isClientError() )
        {
            return $records;
        }
        $html = $response->getBody();
        //$html = $response->getBody();
        // although AIM25 is xhtml, it isn't quite valid enough
        // just to load into a domdocument
        //$dd = new \DOMDocument();
        //if (! $dd->loadHTML($html) )
        //{
        //    return $res;
        //}
        //$xp = new \DOMXPath($dd); 
        //$el = $xp->query("//*[@id='content']/h1")->item(0);
        // so just brute-force it with a regex. Probably much quicker anyway
        if ( preg_match('/ \((\d+) matches\)/', $html, $matches) != 1)
        {
            return 0;
        }
        return( $matches[1] );
    }
    
	public function conf()
	{
        if ( ! $this->config instanceof Config )
        {
            $this->config = Config::getInstance();
        }
        return $this->config;
	}

    public function getConfig()
    {
       return $this->conf();
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

    // Need to 'implement' these to satisfy parent requirements
    public function getHits(\Application\Model\Search\Query $search){}
    public function search(\Application\Model\Search\Query $search, $start = 1, $max = 10, $sort = ''){}
    public function searchRetrieve(\Application\Model\Search\Query $search, $start = 1, $max = 10, $sort = ''){}
    public function getRecord($id){}
    public function getRecordForSave($id){}

}
