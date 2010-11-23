<html>
	<head>
		<title>Welcome</title>
		<meta name="layout" content="main" />
	</head>
	<body>
	
	<div class="left">
        <div class="left_bg">
          ${ welcomeContent }
          <div class="clr"></div>
        </div>
      </div>
      
      <div class="right">
        <div class="right_bg">
          <h3>New Resumes</h3>
          <div id="newRes">
	     	<g:each in="${ resumes }" var="r">
	    		<p class="resume"><g:link controller="resume" action="show" params="[username:r.owner,uri:r.uri]" title="View ${r.owner.fullName()}'s Resume">${r.title.encodeAsHTML()}</g:link> - <g:link controller="user" action="index" params="[username:r.owner]">${r.owner.fullName().encodeAsHTML()}</g:link></p>
	    	</g:each>
          </div>
          
          <div class="clr"></div>
        </div>
      </div>
      <div class="clr"></div>
	</body>
</html>