<ul>
	<li><g:link controller="resume" action="index" class="${ (params.controller == 'resume' && params.action == 'index') ? 'active' : '' }"><span>Home</span></g:link></li>
	<g:if test="${ session.user }">
		<li><g:link controller="user" action="index" params="[username:session.user]" class="${ (params.controller == 'user' && params.action == 'index' && params.username == session.user.username)  ? 'active' : '' }"><span>My Profile</span></g:link></li>
		<li><g:link controller="resume" action="create" class="${ (params.controller == 'resume' && params.action == 'create')  ? 'active' : '' }"><span>New Resume</span></g:link></li>
	</g:if>
	<g:else>
		<li><g:link controller="user" action="register" class="${ (params.controller == 'user' && params.action == 'register')  ? 'active' : '' }"><span>Register</span></g:link></li>
	</g:else>
	<g:if test = "${ session.user && session.user.admin }">
		<li><g:link controller="admin" action="index" class="${ (params.controller == 'admin')  ? 'active' : '' }"><span>Admin</span></g:link></li>
	</g:if>
	<li><g:link controller="user" action="${ session.user ? 'logout' : 'login' }" params="[returnURI:request.forwardURI - request.contextPath]" class="${ (params.controller == 'user' && params.action == 'login') ? 'active' : '' }"><span>${ session.user ? 'Logout' : 'Login' }</span></g:link></li>
</ul>