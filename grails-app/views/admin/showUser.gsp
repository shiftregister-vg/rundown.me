<html>
	<head>
		<title>Manage ${ user.fullName() }</title>
		<meta name="layout" content="admin" />
	</head>
	<body>
		<h2>Manage ${ user.fullName() }</h2>
		<p>[ <g:link action="resetUserPassword" params="[username:user]">Reset Password</g:link> | <g:link action="editUser" params="[username:user]">Edit</g:link> | <g:link action="deleteUser" params="[username:user]">Delete</g:link> ]</p>
		<p>
			<div><strong>Username:</strong> ${ user }</div>
			<div><strong>Email Address:</strong> ${ user.email }</div>
			<div>
				<h4>Bio</h4>
				<p>${ user.bio.encodeAsHTML() }</p>
			</div>
		</p>
		<h4>Resumes</h4>
		<ul>
			<g:each in="${ user.resumes }" var="resume">
				<li><g:link controller="resume" action="show" params="[username:user,uri:resume]">${ resume.title }</g:link></li>
			</g:each>
		</ul>
	</body>
</html>