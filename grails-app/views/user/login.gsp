<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<meta name="layout" content="main" />
		<title>Login</title>
	</head>
	<body>
	
		<div class="left">
			<div class="left_bg">
				<h2>Login</h2>
				<g:form action="validate" method="post" class="form">
					<input type="hidden" name="returnURI" value="${params?.returnURI}" />
					<input type="hidden" name="cName" value="${ cName }" />
					<input type="hidden" name="aName" value="${ aName }" />
					<ol>
						<li>
							<label for="username">Username:</label>
							<input id="username" type='text' class="text" name='username' value='${user?.username}' />
						</li>
						<li>
							<label for='password'>Password:</label>
							<input id="password" type='password' class="text" name='password' value='' />
						</li>
						<li class="buttons">
							<button type="submit">Login</button>
						</li>
					</ol>
				</g:form>
				<div class="clr"></div>
			</div>
		</div>
		
		<div class="right">
			<!-- something could go here I'm sure... -->
		</div>
		
		<div class="clr"></div>
	</body>
</html>