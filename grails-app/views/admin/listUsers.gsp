<html>
	<head>
		<title>User List</title>
		<meta name="layout" content="admin" />
	</head>
	<body>
		<h2>User List</h2>
		<table width="100%">
			<thead>
				<tr>
					<th>Last Name</th>
					<th>First Name</th>
					<th>Username</th>
					<th>Resumes</th>
					<th>Last Login</th>
				</tr>
			</thead>
			<tbody>
			<g:def var="ctr" value="${ 1 }" />
			<g:each in="${ users.sort{ it.lastName } }" var="user">
				<tr class="${ ctr % 2 ? "even" : "odd" }">
					<td>${ user.lastName }</td>
					<td>${ user.firstName }</td>
					<td><g:link action="showUser" params="[username:user]">${ user }</g:link></td>
					<td>${ user.resumes.size() }</td>
					<td>${ user.lastLogin ? user.lastLogin.dateTimeString : "never logged in" }</td>
				</tr>
				<g:set var="ctr" value="${ ctr++ }" />
			</g:each>
			</tbody>
		</table>
	</body>
</html>