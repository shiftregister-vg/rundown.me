<html>
	<head>
		<title>${user.fullName()}'s Profile</title>
		<meta name="layout" content="main" />
	</head>
	<body>
	
	<div class="left">
		<div class="left_bg">
			<h2>${ user.fullName().encodeAsHTML() }</h2>
			<div class="clr"></div>
			<p>${ user.bio.encodeAsHTML().replaceAll("\r", "\n").replaceAll("\n\n", "\n").replaceAll("\n", "<br />") }</p>
		</div>
	</div>
	
	<div class="right">
		<div class="right_bg">
			<h3>Resumes</h3>
			<div class="clr"></div>
			<g:each in="${resumes}" var="r">
      			<p><g:link controller="resume" action="show" params="[username:params.username,uri:r.uri]">${r.title.encodeAsHTML()}</g:link></p>
      		</g:each>
      		 <g:if test="${session.user && session.user.getUsername() == params.username}">
      		 	<p><g:link controller="resume" action="create">New Resume</g:link>
      		 </g:if>
      	</div>
      	
	    <g:if test="${session.user && session.user.getUsername() == params.username}">
	      	<div class="right_bg">
	      		<h3>Manage</h3>
	      		<p><g:link controller="user" action="edit">Edit Profile</g:link></p>
	      	</div>
	    </g:if>
	</div>
	
	<div class="clr"></div>
	</body>
</html>