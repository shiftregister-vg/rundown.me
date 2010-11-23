<html>
	<head>
		<title>Reset ${ user.fullName() }'s Password</title>
		<meta name="layout" content="admin" />
		<script type="text/javascript">
		var pwResetAction = '${ createLink(controller:'admin',action:'doUserPasswordReset') }';
		var username = '${ params.username }';
		</script>
		<g:javascript src="admin/resetUserPassword.js"/>
	</head>
	<body>
		<h2>Reset <g:link action="showUser" params="[username:params.username]">${ user.fullName() }</g:link>'s Password</h2>
		<div class="ui-widget">
			<div class="ui-state-error">
				<p>
					<span class="ui-icon ui-icon-alert" style="float:left; margin-right: 0.3em;"></span>
					Resetting ${ user.firstName }'s password is not reversible, only do this if you are sure this is what you want to do. The new password will be emailed to ${ user.fullName() } at <a href="mailto:${ user.email }">${ user.email }</a>.
				</p>
			</div>
		</div>
		<p>
			<div id="resetPasswordBtn" class="btn">
				<span class="ui-icon ui-icon-alert" style="float:left; margin:0.3em;"></span>
				Confirm Password Reset
			</div>
		</p>
	</body>
</html>