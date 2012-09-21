<?php

namespace Application\Model\Pazpar2;

use Zend\Debug,
    Xerxes\Utility\Factory;
/**
 * An implementation of the abstract Subjects class,
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

class ApiSubjects extends Subjects
{
    // hashes of arrays
    protected $subjects_to_targets = array();
    protected $targets_to_subjects = array();
    // array of objects
    protected $subjects = array();
    // array of names
    protected $subject_names = array();
    protected $client;
    protected $config;
    protected $url;

    /**
     * Constructor
     * 
     */
        
    public function __construct()
    {
        // full set of Subjects from API 
        $this->config = Config::getInstance();
        $this->url = $this->config->getConfig( "apiurl" );
        $command = '/subjects.json?active=true';
        $this->client = Factory::getHttpClient();
        $this->client->setUri( $this->url.$command );
        $api_subjects = $this->client->send()->getBody();
        $api_subjects = json_decode( $api_subjects, true );
        $api_subjects = array_pop( $api_subjects );
        $subjArray = array();
        foreach( $api_subjects as $sub )
        {
            $subject = new Subject();
            $subject->load(array('name' => $sub['subject'], 'id' => $sub['subject_id'], 'position' => $sub['subject_id'], 'url' => $sub['ukat_url'])); 
            $subjArray[] = $subject;
        }
        
        usort( $subjArray, array($this, 'alphasort') );

        for( $i=0; $i < count($subjArray); $i++)
        {
            $subj = $subjArray[$i];
            $subj->setPosition($i);
            $this->subjects[] = $subj; 
        }
    }

    // Helper function for getSubjects()
    function alphasort( $a, $b )
    {
        return strcmp( $a->name, $b->name );
    }

    /**
     * Get one or a set of subjects 
     * 
     * @param mixed $keys               [optional] null returns all subjects, array returns a list of subjects by id, string id returns single id
     * @return array                    array of Subject objects
     */
        
    public function getSubjects($keys = null)
    {
        $arrSubjects = array ( );
        if ( $keys == null )
        {
            // all subjects
            $arrSubjects = $this->subjects;
        }
        else
        {
            if (! is_array( $keys ) )
            {
                // convert single id to array
                $keys = array( $keys );
            }
            // list of subjects or single subject
            foreach( $this->subjects as $subject )
            {
                if ( in_array( $subject->id, $keys ) )
                {
                    $arrSubjects[] = $subject;
                }
            }
        } 
        return $arrSubjects;
        
    }

    /** 
     * Fetch all subjects for a library
     *
     * @param string $pz2_key   Identifier for a pazpar2 z39.50 target
     * @param string $library_id Identifier for a library within that institution
     * @returns array of Subjects
     */
    public function getSubjectsByLibrary($pz2_key, $library_id)
    {

        $arrSubjects = array ( );

        $command = "/institutions/$pz2_key/libraries/$library_id/subjects.json";
        $this->client->setUri( $this->url.$command );
        $api_subjects = $this->client->send()->getBody();
        $api_subjects = json_decode( $api_subjects, true );
        $api_subjects = array_pop( $api_subjects );
        foreach( $api_subjects as $sub )
        {
            $subject = new Subject();
            $subject->load(array('name' => $sub['subject'], 'id' => $sub['subject_id'], 'position' => $sub['subject_id'], 'url' => $sub['ukat_url'])); 
            $subjArray[] = $subject;
        }
        usort( $subjArray, array($this, 'alphasort') );
        return $subjArray;
    }

    /**
     * Fetch all subjects relative to a target specified
     * by its pazpar2 key (from the pazpar2 configuration files 
     *
     * @param string $pz2_key   Identifier for a pazpar2 z39.50 target
     * @returns array of Subjects
     */
    public function getSubjectsByTarget($pz2_key)
    {

        $arrSubjects = array ( );

        $command = "/institutions/$pz2_key/subjects.json";
        $this->client->setUri( $this->url.$command );
        $api_subjects = $this->client->send()->getBody();
        $api_subjects = json_decode( $api_subjects, true );
        $api_subjects = array_pop( $api_subjects );
        foreach( $api_subjects as $sub )
        {
            $subject = new Subject();
            $subject->load(array('name' => $sub['subject'], 'id' => $sub['subject_id'], 'position' => $sub['subject'], 'url' => $sub['ukat_url'])); 
            $subjArray[] = $subject;
        }
        usort( $subjArray, array($this, 'alphasort') );
        return $subjArray;
    }

    /**
     * Get all the pazpar2 targets which cover a particular subject
     * @param string/array $subject_ids     Single subject_id or array of subject_ids
     * @returns Targets object  
     */
    public function getTargetsBySubject($type, $subject_ids)
    {
        // force single sid into an array
        if (! is_array($subject_ids) )
        {
            $sn = array();
            $sn[] = $subject_ids;
            $subject_ids = $sn;
        }
        $keys = array();
        foreach( $subject_ids as $sid )
        {
            $command = "/subjects/$sid/institutions.json?active=true";
            $this->client->setUri( $this->url.$command );
            $api_targets = $this->client->send()->getBody();
            $api_targets = json_decode( $api_targets, true );
            $api_targets = array_pop( $api_targets );
            foreach( $api_targets as $tgt )
            {
                $keys[$tgt['m25_code']] = 1;
            }
        }
        // filter out institutions without working z-server
        $targets = array();
        $command = "/z3950server.json?active=true";
        $this->client->setUri( $this->url.$command );
        $api_targets = $this->client->send()->getBody();
        $api_targets = json_decode( $api_targets, true );
        $api_targets = array_pop( $api_targets );
        foreach( $api_targets as $tgt )
        {
            $targets[$tgt['m25_code']] = 1;
        }
        $filtered_keys = array_intersect($keys, $targets);
        return new Targets( $type, array_keys($filtered_keys) );
    }
}
