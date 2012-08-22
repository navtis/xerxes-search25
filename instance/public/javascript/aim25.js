/**
 *
 *
 * @author David Walker
 * @author Graham Seaman
 * @copyright 2011 California State University
 * @link http://xerxes.calstate.edu
 * @license http://www.gnu.org/licenses/
 * @version
 * @package Xerxes
 */
$(document).ready(function(){

    var querystring = $('#pz2session').data('querystring');
    $.ajax(
    { 
        url: "aim25/ajaxgethits",
        data: querystring,
        cache: false,
        datatype: "json",
        success: function(data)
        {
            if (data['hits'] > 0)
            {
                $('#aim25-hits > a').attr("href", data['url']);
                $('#aim25-hitcount').text(data['hits']);
                $('#aim25-hits').show();
            }
            else
            {
                $('#aim25-hits').hide();
            }
         }, 
         error: function(e, xhr)
         {
            $('#aim25-hits').hide();
         }
     }); 
});  

