<html>
	<head>
		<title>Edit Welcome Page</title>
		<meta name="layout" content="admin" />
		<g:javascript src="markitup/jquery.markitup.js" />
		<g:javascript src="markitup/full-set.js" />
		<g:javascript src="editWelcomePage.js" />
	</head>
	<body>
		<h2>Edit the Welcome Page</h2>
		
		<textarea id="body">${ welcomePageContent.encodeAsHTML() }</textarea>
		<div class="buttons">
			<div class="btn" id="save-btn">Save</div>
		</div>
		<div class="clr"></div>
	</body>
</html>