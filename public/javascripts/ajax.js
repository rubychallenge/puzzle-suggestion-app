$(document).ready(function() {

  var options = {    
		success: handleNewSuggestion,
		resetForm: true
  };
  
  $("#suggestion_form").ajaxForm(options);

  function handleNewSuggestion(response, statusText) {
	  $("#thanks_for_suggestion").show();
		$("#suggestion-list").prepend(response); 
  }
})