<html>
	<head>
		<title>Create New Resume</title>
		<meta name="layout" content="main" />
	</head>
	<body>
	
	<div class="left">
      <div class="left_bg">
      	<h2>New Resume</h2>
      	<g:form controller="resume" action="doCreate" method="post" class="form">
      		<ol>
      			<li>
      				<label for="title">Resume Name</label>
      				<input type="text" id="title" name="title" class="text" value="${ params?.title }" />
      				<div class="clr"></div>
      			</li>
      			<li>
      				<label for="summary">Resume Summary</label>
      				<textarea id="summary" name="summary">${ params?.summary }</textarea>
      				<div class="clr"></div>
      			</li>
      			<li class="buttons">
      				<button type="submit">Create Resume</button>
      				<div class="clr"></div>
      			</li>
      		</ol>
      	</g:form>
      	<div class="clr"></div>
      </div>
    </div>
    <div class="right">
      
    </div>
	
	<div class="clr"></div>
	
	</body>
</html>