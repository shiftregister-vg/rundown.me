<html>
	<head>
		<title>Edit ${session.user.fullName()}</title>
		<meta name="layout" content="main" />
	</head>
	<body>
	
	<div class="left">
      <div class="left_bg">
	      <h2>Edit Details for ${ session.user.fullName().encodeAsHTML() }</h2>
	      <g:form name="editform" controller="user" action="doEdit" method="post" class="form">
	        <ol>
	          <li>
	            <label for="firstName">First Name <span class="red">*</span></label>
	            <input type="text" class="text" id="firstName" name="firstName" value="${session.user.firstName.encodeAsHTML()}" />
	            <div class="clr"></div>
	          </li>
	          <li>
	          	<label for="lastName">Last Name <span class="red">*</span></label>
	          	<input type="text" id="lastName" class="text" name="lastName" value="${session.user.lastName.encodeAsHTML()}" />
	          	<div class="clr"></div>
	          </li>
	          <li>
	            <label for="email">Your email <span class="red">*</span></label>
	            <input id="email" name="email" class="text" value="${session.user.email.encodeAsHTML()}"  />
	            <div class="clr"></div>
	          </li>
	          <li>
	          	<label for="bio">Bio</label>
	          	<textarea id="bio" name="bio">${ session.user.bio.encodeAsHTML() }</textarea>
	          	<div class="clr"></div>
	          </li>
	          <li>
	            <label for="password">Password</label>
	            <input type="password" id="password" name="password" class="text" />
	            <div class="clr"></div>
	          </li>
	          <li class="buttons">
	            <button type="submit">Save</button>
	          </li>
	        </ol>
	      </g:form>
	      <div class="clr"></div>
      </div>
      <div class="clr"></div>
    </div>
    <div class="right">
      <div class="clr"></div>
    </div>
	<div class="clr"></div>
	</body>
</html>