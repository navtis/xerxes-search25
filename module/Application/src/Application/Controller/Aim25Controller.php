<?php

namespace Application\Controller;

use Application\Model\Aim25\HttpEngine,
    Application\Model\Pazpar2\UserOptions,
    Zend\Mvc\MvcEvent,
    Zend\Debug;
/**
 * When a new pazpar2 search takes place, simultaneously search the
 * AIM25 (www.aim25.ac.uk) archive site to see if it has any possibly
 * related material. Return the counts, rather than the contents
 * This controller will either screen-scrape using the HttpEngine
 * or go via Z39.50 with the Pz2Engine. Unfortunately the counts returned
 * by Z39.50 do not match those returned by the web site which will be
 * linked to. 
 */
class Aim25Controller extends SearchController
{
	protected $id = "aim25";

    protected function getEngine()
    {
        return new HttpEngine();
    }

    public function indexAction()
    {
        return($this->data);
    }

    public function ajaxgethitsAction()
    {
        // the remote fetch should only occur once, when a new pz2
        // session is created for a new query. Otherwise, the existing
        // result should be returned.

        $uo = new UserOptions($this->request); 
        $sid = $uo->getSessionData('pz2session');
        $aid = $uo->getSessionData('aim25session');
        if ($aid != $sid)
        {
            $aid = null; // new pz2session, so new query, restart
        }
        $hits = array();
        if ( is_null( $sid ) )
        {
            // if there's no session yet, just return nothing
            $hits['hits'] = 0;
        }
        else // new session
        {
            $hits = $this->engine->getHitCount($aid, $sid, $this->query);
            $uo->setSessionData('aim25session', $sid);
        }
        $response = $this->getResponse();
        $response->headers()->addHeaderLine("Content-type", "application/json");
        $response->setContent(json_encode($hits));
        // returned to View\Listener
        return $response;
    }

}
