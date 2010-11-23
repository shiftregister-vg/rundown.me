<div class="footer">
  <div class="footer_resize"> <a href="http://stevegood.org/" target="_blank"><img src="${ resource(dir:'images',file:'cube-logo.png') }" alt="picture" width="207" height="113" border="0" /></a>
    <p class="leftt">Copyright &copy; <a href="http://stevegood.org/" target="_blank">stevegood.org</a><br/>All Rights Reserved<br />
      <g:link controller="resume" action="index">Home</g:link> | <g:link controller="user" action="${ session.user ? 'logout' : 'login' }" params="${ session.user ? [] : [returnURI:request.forwardURI - request.contextPath] }">${ session.user ? 'Logout' : 'Login' }</g:link></p>
    <div class="clr"></div>
  </div>
  <div class="clr"></div>
</div>