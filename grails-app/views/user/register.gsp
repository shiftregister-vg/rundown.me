<html>
	<head>
		<title>Register</title>
		<meta name="layout" content="main" />
	</head>
	<body>
	
	<div class="left">
      <div class="left_bg">
	      <h2>Register a New Account</h2>
	      <g:form name="registerform" controller="user" action="create" method="post" class="form">
	        <g:render template="/inc/newUserForm" />
	      </g:form>
      </div>
      <div class="clr"></div>
    </div>
    <div class="right">
      <div class="clr"></div>
    </div>
	<div class="clr"></div>
	</body>
</html>