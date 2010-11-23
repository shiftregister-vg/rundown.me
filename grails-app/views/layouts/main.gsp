<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><g:layoutTitle default="" /> - rundown.me</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	
	<g:javascript library="jquery" plugin="jquery"/>
	<jqui:resources theme="flick" />
	<g:javascript src="jquery.blockui.js" />
	<g:javascript src="global.js" />
	
	<link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
	<link href="${ resource(dir:"css",file:"style.css") }" rel="stylesheet" type="text/css" />
	<g:layoutHead />
</head>
<body>
<div class="header">
  <div class="block_header">
    <div class="logo"><g:link controller="resume" action="index"><img src="${ resource(dir:"images",file:"rundown.png") }" width="983" height="184" border="0" alt="logo" /></g:link></div>
    <div class="clr"></div>
    <div class="menu">
      <g:render template="/inc/mainNavigation" />
    </div>
    <div class="clr"></div>
  </div>
  <div class="main">
    <div class="body">
    	<g:if test="${ flash.message }">
    		<div class="ui-widget">
    			<div class="ui-state-error" style="padding: 0pt 0.7em;">
    				<p>
    					<span class="ui-icon ui-icon-alert" style="float:left; margin-right: 0.3em;"></span>
    					${ flash.message }
    				</p>
    			</div>
    		</div>
    		<div class="clr"></div>
    	</g:if>
      <g:layoutBody />
      <div class="clr"></div>
    </div>
    <div class="clr"></div>
  </div>
</div>
<g:render template="/inc/footer" />
<g:render template="/inc/woopraTracking" />
</body>
</html>