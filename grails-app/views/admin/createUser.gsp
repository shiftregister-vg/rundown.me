<html>
	<head>
		<title>Create New User</title>
		<meta name="layout" content="admin" />
		<script type="text/javascript">
		var createUserAction = '${ createLink(controller:'admin',action:'doCreateUser') }';
		</script>
		<g:javascript src="admin/createUser.js" />
	</head>
	<body>
	
      <h2>Create New User Account</h2>
      
      <div>
		<input type="checkbox" id="genPWBtn" class="btn" checked=checked/><label for="genPWBtn">Generate Password</label>
		<input type="checkbox" id="sendInfoBtn" class="btn" checked=checked/><label for="sendInfoBtn">Send User Info</label>
		<input type="checkbox" id="makeAdminBtn" class="btn" /><label for="makeAdminBtn">Make Admin</label>
      </div>
      
      <div class="form">
        <g:render template="/inc/newUserForm" />
      </div>
	  
	</body>
</html>