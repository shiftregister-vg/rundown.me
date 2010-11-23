jQuery(function($){
	
	$('#saveBtn').click(function(){
		$.getJSON(
			saveUserAction,
			{
				id:id,
				username:$('#username').val(),
				firstName:$('#firstName').val(),
				lastName:$('#lastName').val(),
				bio:$('#bio').val(),
				email:$('#email').val()
			},
			function(response){
				if (response.success){
					window.location = '/admin/showUser/' + response.username;
				} else {
					alert("There was a problem.\n" + response.message);
				}
			}
		);
	});
	
});