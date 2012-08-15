<?php

namespace Application\Model\Pazpar2;

use Zend\Debug,
    Xerxes\Utility\Factory;

/**
 * An implementation of the abstract Affiliations class,
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

class ApiAffiliations extends Affiliations
{
    protected $client;
    protected $apiurl;

    public function __construct() 
    { 
        $config = Config::getInstance();
        $this->apiurl = $config->getConfig("apiurl");
        $this->client = Factory::getHttpClient();
    }

    public function getAllInstitutions()
    {
        // full set of Institutions from Search25 API
        // only institution needs to be active, not z3950_server
        $command = '/institutions.json?active=true'; 
        $this->client->setUri($this->apiurl.$command);
        $api_institutions = $this->client->send()->getBody();
        $api_institutions = json_decode($api_institutions, true);
        $api_institutions = array_pop($api_institutions);
        $affiliations = array();
        foreach($api_institutions as $api_institution)
        {
            $key = $api_institution['domain'];
            $affiliations[$key] = $api_institution['full_name'];
        }
        return $affiliations;
    }

    public function getRolesByAffiliation($domain)
    {
        // fetch all roles
        $command = '/roles.json'; 
        $this->client->setUri($this->apiurl.$command);
        $api_roles = $this->client->send()->getBody();
        $api_roles = json_decode($api_roles, true);
        $api_roles = array_pop($api_roles);

        // following section is hardcoded details which belong
        // in the API itself FIXME
        $bits = explode('.', $domain);
        $category = $bits[0];

        $roles = array();
        switch($category)
        {
        case 'fe': // further ed
            foreach( $api_roles as $key => $v )
            {
                if ( preg_match('/^fe/', $v['role_id']) )
                {
                    $roles[$v['role_id']] = $v['name'];
                }
            }
            break;
        case 'he': // higher ed, non-m25
            foreach( $api_roles as $key => $v)
            {
                if (preg_match('/^(he|pg|ug)/', $v['role_id']) )
                {
                    $roles[$v['role_id']] = $v['name'];
                }
            }
            break;
        case 'pub': // member of public
            foreach( $api_roles as $key => $v)
            {
                if ( $v['role_id'] == 'rescom' )
                {
                    $roles['rescom'] = $v['name'];
                }
                else if ( $v['role_id'] == 'other' )
                {
                    $roles['other'] = $v['name'];
                }
            }
            break;
        default: // m25 member
            foreach( $api_roles as $key => $v )
            {
                if ( (! preg_match('/^fe/', $v['role_id']) ) // fe not in m25
                    && ( $v['role_id'] != 'rescom' )
                    && ( $v['role_id'] != 'other' )
                ){
                    $roles[$v['role_id']] = $v['name'];
                }
            }
        }
        return $roles;
    }
    /**
     * Lists institutions accessible given an entitlement
     * @param string $type          Kind of target to filter on
     * @param array $affiliation    EduPerson style role+domain
     * @param string $entitlement   array of entitlement ids
     * @return array                pz2_keys => institution names
     */
    public function getTargetsByEntitlement($type, $entitlements, $affiliation)
    {
        $institutions = array();
        foreach($entitlements as $entitlement)
        {
            $command = "/entitlements/$entitlement/institutions.json";
            $params = "?active=true&affiliation=$affiliation";
            $command = $command . $params;
            $this->client->setUri($this->apiurl.$command);
            $api_institutions = $this->client->send()->getBody();
            $api_institutions = json_decode($api_institutions, true);
            $api_institutions = array_pop($api_institutions);
            foreach($api_institutions as $api_institution)
            {
                $key = $api_institution['m25_code'];
                $institutions[$key] = 1;
            }
        }
        // filter out institutions without working z-server
        $targets = array();
        $command = "/z3950.json?active=true&source_type=$type";
        $this->client->setUri( $this->apiurl.$command );
        $api_targets = $this->client->send()->getBody();
        $api_targets = json_decode( $api_targets, true );
        $api_targets = array_pop( $api_targets );
        foreach( $api_targets as $tgt )
        {
           $targets[$tgt['m25_code']] = 1;
        }
        $filtered_keys = array_intersect_assoc($institutions, $targets);
        return $filtered_keys;
        //return new Targets( array_keys($filtered_keys) );
    }

    public function getEntitlementsAtInstitution($institution, $affiliation)
    {
        $entitlements = array();
        $command = "/institutions/$institution/entitlements.json?affiliation=$affiliation";
        $this->client->setUri( $this->apiurl.$command );
        $api_values = $this->client->send()->getBody();
        $api_values = json_decode( $api_values, true );
        if ( $api_values != null )
        {
            $api_values = array_pop( $api_values );
            foreach( $api_values as $val )
            {
                array_push($entitlements, new Entitlement($val));
            }
        }
        return $entitlements;
    }
}       
