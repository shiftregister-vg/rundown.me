jQuery(function($){
	
	$('#password').attr('disabled',$('#genPWBtn').button('widget').attr('aria-pressed') === "true" ? true : false);
	$('#genPWBtn').click(function(){
		$('#password').attr('disabled',$(this).button('widget').attr('aria-pressed') === "true" ? true : false);
	});
	
	$('#submitUserBtn').click(function(){
		var params = {
			generatePassword : $('#genPWBtn').button('widget').attr('aria-pressed'),
			sendUserInfo : $('#sendInfoBtn').button('widget').attr('aria-pressed'),
			makeAdmin : $('#makeAdminBtn').button('widget').attr('aria-pressed'),
			bio : $('#bio').val()
		};
		
		$('.form input').each(function(){
			params[$(this).attr('id')] = $(this).val();
		});
		
		$.getJSON(
			createUserAction,
			params,
			function(response){
				if (response.success){
					window.location = '/admin/listUsers';
				} else {
					alert("There was a problem creating the user...\n\n" + response.message);
				}
			}
		);
	});
	
});