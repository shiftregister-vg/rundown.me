<html>
	<head>
		<title>Edit ${ user.fullName() }</title>
		<meta name="layout" content="admin" />
		<script type="text/javascript">
		var saveUserAction = '${ createLink(controller:'admin', action:'saveUser') }';
		var id = ${ user.id };
		</script>
		<g:javascript src="admin/editUser.js"/>
	</head>
	<body>
		<h2>Edit ${ user.fullName() }</h2>
		<div class="form">
			<ol>
				<li>
					<label for="username">Username</label>
					<input type="text" class="text" id="username" value="${ user }" />
				</li>
				
				<li>
					<label for="firstName">First Name</label>
					<input type="text" class="text" id="firstName" value="${ user.firstName }" />
				</li>
				
				<li>
					<label for="lastName">Last Name</label>
					<input type="text" class="text" id="lastName" value="${ user.lastName }" />
				</li>
				
				<li>
					<label for="email">Email Address</label>
					<input type="text" class="text" id="email" value="${ user.email }" />
				</li>
				
				<li>
					<label for="bio">Bio</label>
					<textarea id="bio" rows="5">${ user.bio }</textarea>
				</li>
				
				<li class="buttons">
					<div id="saveBtn" class="btn">Save Changes</div>
				</li>
			</ol>
			<div class="clr"></div>
		</div>
	</body>
</html>