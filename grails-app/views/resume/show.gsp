<g:set var="hasAccess" value="${session.user && session.user.username == params.username}" />
<html>
	<head>
		<title>${ resume.title } - ${resume.owner.fullName()}</title>
		<meta name="layout" content="main" />
		<g:if test="${ hasAccess }">
			<g:javascript>
				var Resume = Resume || {};
				Resume.id = ${ resume.id };
				Resume.show = '${ createLink(controller:'resume',action:'show',params:[username:params.username,uri:params.uri]) }';
				Resume.showItem = '${ createLink(controller:'item',action:'show') }';
				Resume.createItem = '${ createLink(controller:'item',action:'create') }';
				Resume.deleteItem = '${ createLink(controller:'item',action:'delete') }';
				Resume.updateItem = '${ createLink(controller:'item',action:'update') }';
				Resume.createSection = '${ createLink(controller:'section',action:'create') }';
				Resume.deleteSection = '${ createLink(controller:'section',action:'delete') }'
				Resume.updateSection = '${ createLink(controller:'section',action:'update') }';
				Resume.updateResume = '${ createLink(controller:'resume',action:'update') }';
				Resume.toggleVisibility = '${ createLink(controller:'resume',action:'toggle') }';
				Resume.deleteResume = '${ createLink(controller:'resume',action:'delete') }';
			</g:javascript>
			<g:javascript src="editResume.js" />
		</g:if>
	</head>
	<body>
	
	<div class="left">
		<div class="left_bg">
			<h2><g:link controller="user" action="index" params="[username:params.username]">${resume.owner.fullName().encodeAsHTML()}</g:link></h2>
			<p id="summary">${ resume.summary.encodeAsHTML().replaceAll("\r", "\n").replaceAll("\n\n", "\n").replaceAll("\n", "<br />") }</p>
		</div>
		<div id="sections">
			<g:each in="${ resume.sections.sort{ it.position } }" var="section">
				<div id="section${ section.id }" class="left_bg section">
					<h3>${ section.encodeAsHTML() }</h3>
					
					<g:if test="${ section.title == 'Experience' }">
						<g:each in="${ section.items.sort{ a,b-> b.start <=> a.start } }" var="job">
					     	<div class="job" id="item${ job.id }">
					     		<h4>
					     			${ job.encodeAsHTML() }
						     		<g:if test="${ hasAccess }">
						     			<span class="editor">
								     		<span class="icon ui-icon ui-icon-trash right_align" title="Delete: ${ job }" data-action="item-delete" data-id="${ job.id }" data-section-id="${ section.id }"></span>
								     		<span class="icon ui-icon ui-icon-pencil right_align" title="Edit: ${ job }" data-action="job-edit" data-id="${ job.id }" data-section-id="${ section.id }"></span>
								     	</span>
								     </g:if>
					     		</h4>
					     		<h6>${ job.start.format('MMMM d, yyyy') } - ${ job.current ? 'Present' : job.end.format('MMMM d, yyyy') }</h6>
					     		<p>${ job.summary.encodeAsHTML().replaceAll("\r", "\n").replaceAll("\n\n", "\n").replaceAll("\n", "<br />") }</p>
					     		<g:if test="${ job.items.size() }">
						     		<ul>
						     			<g:each in="${ job.items }" var="jobItem">
						     				<li><p>${ jobItem.encodeAsHTML().replaceAll("\r", "\n").replaceAll("\n\n", "\n").replaceAll("\n", "<br />") }</p></li>
						     			</g:each>
						     		</ul>
					     		</g:if>
					     	</div>
			     		</g:each>
			     		
			     		<g:if test="${ hasAccess }">
			     			<p class="editor">
			     				<span class="icon ui-icon ui-icon-plusthick right_align" title="Add Item" data-action="job-add" data-section-id="${ section.id }" data-isJob="true"></span>
			     				<div id="jobEditor" class="hidden form">
					     			<ol>
					     				<li>
					     					<label for="jobTitleField">Title</label>
					     					<input type="text" id="jobTitleField" class="text input" />
					     					<div class="clr"></div>
					     				</li>
					     				<li>
					     					<label for="jobCompany">Company</label>
					     					<input type="text" id="jobCompany" class="text input" />
					     					<div class="clr"></div>
					     				</li>
					     				<li>	
					     					<label for="jobSummary">Summary</label>
					     					<textarea id="jobSummary" class="input"></textarea>
					     					<div class="clr"></div>
					     				</li>
					     				<li>	
					     					<label for="jobStart">Start</label>
					     					<input type="text" class="calendar input text" id="jobStart" />
					     					<div class="clr"></div>
					     				</li>
					     				<li>	
					     					<label for="jobEnd">End</label>
					     					<input type="text" class="calendar input text" id="jobEnd" />
					     					<div class="clr"></div>
					     				</li>
					     				<li>	
					     					<input type="checkbox" id="jobCurrent" />
					     					<label for="jobCurrent">Current</label>
					     					<div class="clr"></div>
					     				</li>
					     			</ol>
			     				</div>
			     			</p>
			     		</g:if>
			     		
					</g:if>
					
					<g:else>
						<ul class="items">
					     	<g:each in="${ section.items.sort{ it.id } }" var="item">
					     		<li id="item${ item.id }">
					     			<p>${ item.encodeAsHTML() }
						     			<g:if test="${ hasAccess }">
							     			<span class="editor">
									     		<span class="icon ui-icon ui-icon-trash right_align" title="Delete: ${ item }" data-action="item-delete" data-id="${ item.id }" data-section-id="${ section.id }"></span>
									     		<span class="icon ui-icon ui-icon-pencil right_align" title="Edit: ${ item }" data-action="item-edit" data-id="${ item.id }" data-section-id="${ section.id }"></span>
									     	</span>
								     	</g:if>
							     	</p>
					     		</li>
					     	</g:each>
				     	</ul>
				     	<g:if test="${ hasAccess }">
					     	<p class="editor">
					     		<span class="icon ui-icon ui-icon-plusthick right_align" title="Add Item" data-action="item-add" data-section-id="${ section.id }"></span>
					     		<span class="icon ui-icon ui-icon-trash right_align" title="Delete Section" data-action="section-delete" data-section-id="${ section.id }"></span>
					     		<span class="icon ui-icon ui-icon-pencil right_align" title="Edit Section" data-action="section-edit" data-section-id="${ section.id }"></span>
					     		<div class="clr"></div>
					     		<div id="addItem${ section.id }" class="hidden editor-field">
						     		<p>
						     			<label for="itemTitleInput${ section.id }">New Item: </label>
						     			<input type="text" class="text" id="itemTitleInput${ section.id }" />
						     			<span class="icon ui-icon ui-icon-closethick right_align" title="Cancel" data-action="item-add-cancel" data-section-id="${ section.id }"></span>
						     			<span class="icon ui-icon ui-icon-disk right_align" title="Save Item" data-action="item-add-save" data-section-id="${ section.id }"></span>
						     		</p>
					     		</div>
					     		<div id="editItem${ section.id }" class="hidden editor-field">
						     		<p>
						     			<input type="hidden" id="editItemID${ section.id }" />
						     			<label for="editItemTitleInput${ section.id }">Edit Item: </label>
						     			<input type="text" class="text" id="editItemTitleInput${ section.id }" />
						     			<span class="icon ui-icon ui-icon-closethick right_align" title="Cancel" data-action="item-edit-cancel" data-section-id="${ section.id }"></span>
						     			<span class="icon ui-icon ui-icon-disk right_align" title="Save Item" data-action="item-edit-save" data-section-id="${ section.id }"></span>
						     		</p>
					     		</div>
					     		<div id="editSection${ section.id }" class="hidden editor-field">
					     			<p>
					     				<label for="editSectionTitleInput${ section.id }">Section Title: </label>
						     			<input type="text" class="text" id="editSectionTitleInput${ section.id }" />
						     			<span class="icon ui-icon ui-icon-closethick right_align" title="Cancel" data-action="section-edit-cancel" data-section-id="${ section.id }"></span>
						     			<span class="icon ui-icon ui-icon-disk right_align" title="Save Item" data-action="section-edit-save" data-section-id="${ section.id }"></span>
					     			</p>
					     		</div>
					     	</p>
				    	</g:if>
					</g:else>
				</div>
			</g:each>
		</div>
	</div>
	
	<div class="right">
		
		<!--div class="right_bg">
			avatar
		</div-->
		
		<div class="right_bg">
			<h3>About ${ resume.owner.firstName.encodeAsHTML() }</h3>
			<p>${ resume.owner.bio.encodeAsHTML().replaceAll("\r", "\n").replaceAll("\n\n", "\n").replaceAll("\n", "<br />") }</p>
		</div>
		
		<g:if test="${hasAccess}">
			<div class="right_bg">
		      	<ul id="icons">
		      		<li class="ui-state-default ui-corner-all ${ resume.visible ? "ui-state-highlight" : "" } icon" title="Toggle Resume Visibility ${ resume.visible ? "Off" : "On" }" data-action="resume-toggle-visibility"><span class="ui-icon ui-icon-power"></span></li>
		      		<li class="ui-state-default ui-corner-all icon" title="Edit Resume" data-action="resume-edit"><span class="ui-icon ui-icon-pencil"></span></li>
		      		<li class="ui-state-default ui-corner-all icon" title="Add Section" data-action="section-add"><span class="ui-icon ui-icon-folder-collapsed"></span></li>
		      		<li class="ui-state-default ui-corner-all icon" title="Delete Resume" data-action="resume-delete"><span class="ui-icon ui-icon-trash"></span></li>
		      		<li class="ui-state-default ui-corner-all icon" title="Hide Controls" data-action="toggle-controls"><span class="ui-icon ui-icon-gear"></span></li>
		      	</ul>
		      	<div class="clr"></div>
		    </div>
		    
		    <div id="sectionEditor" class="hidden form">
		    	<ol>
		    		<li>
		    			<label for="sectionTitle">Title</label>
		    			<input type="text" id="sectionTitle" class="text input" />
		    			<div class="clr"></div>
		    		</li>
		    	</ol>
		    </div>
		    
		    <div id="resumeEditor" class="hidden form">
		    	<h3>${ resume.title.encodeAsHTML() }</h3>
		    	<ol>
		    		<li>
		    			<label for="resumeSummary">Summary</label>
		    			<textarea id="resumeSummary"></textarea>
		    			<div class="clr"></div>
		    		</li>
		    	</ol>
		    </div>
	    </g:if>
	</div>
	<div class="clr"></div>
	</body>
</html>