<ol>
  <li>
    <label for="firstName">First Name <span class="red">*</span></label>
    <input type="text" class="text" id="firstName" name="firstName" value="${ params?.firstName }" />
    <div class="clr"></div>
  </li>
  <li>
  	<label for="lastName">Last Name <span class="red">*</span></label>
  	<input type="text" id="lastName" class="text" name="lastName" value="${ params?.lastName }" />
  	<div class="clr"></div>
  </li>
  <li>
    <label for="email">Your email <span class="red">*</span></label>
    <input id="email" name="email" class="text" value="${ params?.email }" />
    <div class="clr"></div>
  </li>
  <li>
  	<label for="bio">Bio</label>
  	<textarea id="bio" name="bio">${ params?.bio }</textarea>
  	<div class="clr"></div>
  </li>
  <li>
    <label for="username">Username <span class="red">*</span></label>
    <input id="username" name="username" class="text" value="${ params?.username }"  />
    <div class="clr"></div>
  </li>
  <li>
    <label for="password">Password <span class="red">*</span></label>
    <input type="password" id="password" name="password" class="text" />
    <div class="clr"></div>
  </li>
  <li class="buttons">
    <button id="submitUserBtn" type="submit">Save</button>
  </li>
</ol>
<div class="clr"></div>