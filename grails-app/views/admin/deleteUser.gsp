<html>
	<head>
		<title>Delete ${ user.fullName() } (${ user })</title>
		<meta name="layout" content="admin" />
		<script type="text/javascript">
		var deleteUserAction = '${ createLink(controller:'admin',action:'doDeleteUser') }';
		var username = '${ user.username }';
		</script>
		<g:javascript src="admin/deleteUser.js"/>
	</head>
	<body>
		<h2>Delete ${ user.fullName() } (<g:link action="showUser" params="[username:user.username]">${ user }</g:link>)</h2>
		<div class="ui-widget">
			<div class="ui-state-error">
				<p>
					<span class="ui-icon ui-icon-alert" style="float:left; margin-right: 0.3em;"></span>
					Deleting ${ user.firstName } is not reversible, only do this if you are sure this is what you want to do.
				</p>
			</div>
		</div>
		<p>
			<div id="deleteUserBtn" class="btn">
				<span class="ui-icon ui-icon-alert" style="float:left; margin:0.3em;"></span>
				Confirm User Delete
			</div>
		</p>
	</body>
</html>