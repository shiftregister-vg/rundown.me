jQuery(function($){		
	$('textarea').markItUp(myHtmlSettings);
	
	$('#save-btn').click(function(){
		var label = "Welcome Page";
		var body = $('#body').val();
		
		$.getJSON(
			'/admin/saveContent',
			{ label : label, body : body },
			function(response){
				if (response.success){
					$('#body').val(response.content.body);
				} else {
					alert('Something went wrong!\n' + response.message);
				}
			}
		);
	});
});