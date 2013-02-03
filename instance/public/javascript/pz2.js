/**
 * pazpar2 utilities
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

    // hide an info box
    $(".comms-box").click(function() {
	$(this).hide("slow");
    });

    // manage changes of sourcetype from the search box
    var url = $(location).attr('href'); 
    var page = url.substring(url.lastIndexOf('/') + 1);

    if (page == 'options'){
	// on the options page, submit to get the target lists refereshed
	// everywhere else, use ajax
    	$("#search-type").change(function() {
		// set the value in the original form
		$('#sourcetype').val($('#search-type').val());
		$('#sourcetype_form').submit();
	});
    }
    else {
	     
    // change the search type if requested
    $("#search-type").change(function() {
        $.ajax(
        { 
            url: "pazpar2/ajaxchangetype",
            data: "sourcetype=" + $('#search-type').val(),
            cache: false,
            datatype: "json",
             success: function(data)
             {
		// delete options in searchtype dropdown
		var $el = $("#field");
		$el.empty();
		// insert new options
		$(data.field).each(function(){
			var row = this["@attributes"];
			$el.append($("<option></option>")
				 .attr("value", row["id"]).text(row["public"]));
		});
	     }
        })
        return false;
    });
  } // end else

});  

