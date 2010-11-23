jQuery(function($){
	
	$(document)
		.bind('refresh',function(e){
			$('.section li, .section h4').hover(
				function(){
					$(this).css('background-color','#f6f6f6');
				},
				function(){
					$(this).css('background-color','#fff');
				}
			);
		})
		.bind('resume-delete',function(e){
			var d = $('<div>Are you sure you want to delete this resume? This cannot be undone.</div>');
			d.dialog({
				title:'Notice!',
				modal:true,
				resizable:false,
				width:500,
				buttons:{
					OK: function(){
						$(this).dialog('close');
						var to = setTimeout(function(){
							$.getJSON(
								Resume.deleteResume,
								{ resumeid : Resume.id },
								function(response){
									if (response.success){
										window.location = Resume.show;
									} else {
										alert("Something went wrong!");
									}
								}
							);
						},100);
					},
					Cancel: function(){
						$(this).dialog('close');
					}
				}	
			});
		})
		.bind('section-add',function(e){
			$('#sectionEditor').dialog({
				title:'Add Section',
				modal:true,
				resizable:false,
				width: 600,
				buttons: {
					OK:function(){
						var _this = this		
						$.getJSON(
							Resume.createSection,
							{ resumeid : Resume.id, title : $('#sectionTitle').val().trim() },
							function(response){
								if (response.success){
									var html = '<div id=\"section' + response.section.id + '\" class=\"left_bg section\">';
										html += '<h3>' + response.section.title + '</h3>';
										html += '<ul class=\"items\"></ul>';
										html += '<p class=\"editor\">';
										html += '<span class=\"icon ui-icon ui-icon-plusthick right_align\" title=\"Add Item\" data-action=\"item-add\" data-section-id=\"' + response.section.id + '\"></span>';
										html += '<span class=\"icon ui-icon ui-icon-trash right_align\" title=\"Delete Section\" data-action=\"section-delete\" data-section-id=\"' + response.section.id + '\"></span>';
										html += '<span class=\"icon ui-icon ui-icon-pencil right_align\" title=\"Edit Section\" data-action=\"section-edit\" data-section-id=\"' + response.section.id + '\"></span>';
										html += '<div class=\"clr\"></div>';
										html += '<div id=\"addItem' + response.section.id + '\" class=\"hidden editor-field\">';
										html += '<p>';	
										html += '<label for=\"itemTitleInput' + response.section.id + '\">New Item: </label>';
										html += '<input type=\"text\" class=\"text\" id=\"itemTitleInput' + response.section.id + '\" />';
										html += '<span class=\"icon ui-icon ui-icon-closethick right_align\" title=\"Cancel\" data-action=\"item-add-cancel\" data-section-id=\"' + response.section.id + '\"></span>';
										html += '<span class=\"icon ui-icon ui-icon-disk right_align\" title=\"Save Item\" data-action=\"item-add-save\" data-section-id=\"' + response.section.id + '\"></span>';
										html += '</p>';
										html += '</div>';
										html += '<div id=\"editItem' + response.section.id + '\" class=\"hidden editor-field\">';
										html += '<p>';
										html += '<input type=\"hidden\" id=\"editItemID' + response.section.id + '\" />';
										html += '<label for=\"editItemTitleInput' + response.section.id + '\">Edit Item: </label>';
										html += '<input type=\"text\" class=\"text\" id=\"editItemTitleInput' + response.section.id + '\" />';
										html += '<span class=\"icon ui-icon ui-icon-closethick right_align\" title=\"Cancel\" data-action=\"item-edit-cancel\" data-section-id=\"' + response.section.id + '\"></span>';
										html += '<span class=\"icon ui-icon ui-icon-disk right_align\" title=\"Save Item\" data-action=\"item-edit-save\" data-section-id=\"' + response.section.id + '\"></span>';
										html += '</p>';
										html += '</div>';
										html += '<div id=\"editSection' + response.section.id + '\" class=\"hidden editor-field\">';
										html += '<p>';
										html += '<label for=\"editSectionTitleInput' + response.section.id + '\">Section Title: </label>';
										html += '<input type=\"text\" class=\"text\" id=\"editSectionTitleInput' + response.section.id + '\" />';
										html += '<span class=\"icon ui-icon ui-icon-closethick right_align\" title=\"Cancel\" data-action=\"section-edit-cancel\" data-section-id=\"' + response.section.id + '\"></span>';
										html += '<span class=\"icon ui-icon ui-icon-disk right_align\" title=\"Save Item\" data-action=\"section-edit-save\" data-section-id=\"' + response.section.id + '\"></span>';
										html += '</p>';
										html += '</div>';
										html += '</p>';
										html += '</div>';
									$('#sections').append(html);
								} else {
									alert("Something went wrong!");
								}
								$(_this).dialog('close');
							}
						);
					},
					Cancel:function(){
						$(this).dialog('close');
					}
				},
				close: function(){
					$('#sectionEditor #sectionTitle').val('');
				}
			});
		})
		.bind('section-edit',function(e){
			var sectionID = $(e.tar).attr('data-section-id');
			$('#editSectionTitleInput' + sectionID).val($('#section' + sectionID + ' h3:first').text().trim());
			$('#editSection' + sectionID).show('slow',function(){
				$('#editSectionTitleInput' + sectionID).focus();
			});
		})
		.bind('section-edit-save',function(e){
			var sectionID = $(e.tar).attr('data-section-id');
			$.getJSON(
				Resume.updateSection,
				{resumeid:Resume.id, sectionid:sectionID, title:$('#editSectionTitleInput' + sectionID).val().trim()},
				function(response){
					if (response.success){
						$('#section' + sectionID + ' h3:first').text($('#editSectionTitleInput' + sectionID).val().trim());
						$('#editSection' + sectionID).hide('slow');
						$('#editSectionTitleInput' + sectionID).val('');
					}
				}
			);
		})
		.bind('section-edit-cancel',function(e){
			var sectionID = $(e.tar).attr('data-section-id');
			$('#editSectionTitleInput' + sectionID).val('');
			$('#editSection' + sectionID).hide('slow');
		})
		.bind('section-delete',function(e){
			var sectionID = $(e.tar).attr('data-section-id');
			var headerText = $('#section' + sectionID + ' h3').text().trim();
			var d = $('<div><p>Are you sure you want to delete this section?</p><p><strong>' + headerText + '</strong></p>');
			d.dialog({
				modal:true,
				resizable:false,
				title:'Notice!',
				width:500,
				buttons: {
					OK: function(){
						$(this).dialog('close');
						$.getJSON(
							Resume.deleteSection,
							{ resumeid : Resume.id, sectionid : sectionID },
							function(response){
								if (response.success){
									$('#section' + sectionID).remove();
								} else {
									alert("Something went wrong!");
								}
							}
						);
					},
					Cancel: function(){
						$(this).dialog('close');
					}
				}
			});
		})
		.bind('item-add',function(e){
			var sectionID = $(e.tar).attr('data-section-id');
			$('#itemTitleInput' + sectionID).val('');
			$('#addItem' + sectionID).toggle('slow',function(){
				$('#itemTitleInput' + sectionID).focus();
			});
		})
		.bind('item-add-save',function(e){
			var sectionID = $(e.tar).attr('data-section-id');
			var isJob = false;
			var params = {resumeid:Resume.id,sectionid:sectionID,isJob:isJob,title:$('#itemTitleInput' + sectionID).val()}
			
			$.getJSON(
				Resume.createItem,
				params,
				function(response){
					if (response.success){
						var li = '<li id=\"item' + response.item.id + '\">';
							li += '<p>' + response.item.title + '<span class=\"editor\">';
							li += '<span class=\"icon ui-icon ui-icon-trash right_align\" title=\"Delete: ' + response.item.title + '\" data-action=\"item-delete\" data-id=\"' + response.item.id + '\" data-section-id=\"' + sectionID + '\"></span>';
							li += '<span class=\"icon ui-icon ui-icon-pencil right_align\" title=\"Edit: ' + response.item.title + '\" data-action=\"item-edit\" data-id=\"' + response.item.id + '\" data-section-id=\"' + sectionID + '\"></span>';
							li += '</span></p>';
						$('#section' + sectionID + ' .items').append(li);
						$('#itemTitleInput' + sectionID).val('');
						$('#addItem' + sectionID).toggle('slow');
						$(document).trigger('refresh');
					} else {
						alert("Something went wrong!");
					}
				}
			);
		})
		.bind('item-add-cancel',function(e){
			var sectionID = $(e.tar).attr('data-section-id');
			$('#itemTitleInput' + sectionID).val('');
			$('#addItem' + sectionID).hide('slow');
		})
		.bind('item-edit',function(e){
			var id = $(e.tar).attr('data-id');
			var sectionID = $(e.tar).attr('data-section-id');
			
			$('#editItemID' + sectionID).val(id);
			$('#editItemTitleInput' + sectionID).val($('#item' + id).text().trim());
			$('#editItem' + sectionID).show('slow');
		})
		.bind('item-edit-save',function(e){
			var sectionid = $(e.tar).attr('data-section-id');
			var id = $('#editItemID' + sectionid).val();
			
			var params = { resumeid : Resume.id, sectionid : sectionid, itemid : id, title : $('#editItemTitleInput' + sectionid).val().trim() };
			
			$.getJSON(
				Resume.updateItem,
				params,
				function(response){
					if (response.success){
						var innerHTML = $('#item' + id + ' p:first').html();
						var text = $('#item' + id + ' p:first').text().trim();
						$('#item' + id + ' p:first').html(innerHTML.replace(text,$('#editItemTitleInput' + sectionid).val().trim()));
						$('#editItem' + sectionid).hide('slow');
						$('#editItemTitleInput' + sectionid).val('');
						$('#editItemID' + sectionid).val('');
					} else {
						alert("Something went wrong!");
					}
				}
			);
		})
		.bind('item-edit-cancel',function(e){
			var sectionID = $(e.tar).attr('data-section-id');
			$('#editItemTitleInput' + sectionID).val('');
			$('#editItem' + sectionID).hide('slow');
		})
		.bind('item-delete',function(e){
			var id = $(e.tar).attr('data-id');
			var sectionid = $(e.tar).attr('data-section-id');
			$('<div><p>Are you sure you want to delete this item?</p><p><strong>' + $('#item' + id).text() + '</strong></p></div>').dialog({
				title:"Notice",
				modal:true,
				width:400,
				resizable:false,
				buttons: {
					OK: function(){
						$(this).dialog('close');
						$.getJSON(
							Resume.deleteItem,
							{ resumeid : Resume.id, itemid : id, sectionid : sectionid },
							function(response){
								if (response.success){
									$('#item' + id).remove();
								} else {
									alert("Something went wrong!");
								}
							}
						);
					},
					Cancel: function(){
						$(this).dialog('close');
					}
				}
			});
		})
		.bind('job-add',function(e){
			var sectionID = $(e.tar).attr('data-section-id');
			$('#jobEditor').dialog({
				modal:true,
				width:600,
				resizable:false,
				title:'Add Job',
				buttons: {
					OK: function(){
						var _this = this;
						
						if ($('#jobCurrent').attr('checked') === 'true'){
							$('#jobEnd').val(new Date().format('mm/dd/yyyy'));
						}
						
						var params = {
							resumeid : Resume.id,
							sectionid : sectionID,
							title : $('#jobTitleField').val().trim(),
							company : $('#jobCompany').val().trim(),
							summary : $('#jobSummary').val().trim(),
							start : $('#jobStart').val().trim(),
							end : $('#jobEnd').val().trim(),
							current : $('#jobCurrent').attr('checked'),
							isJob : true
						}
						
						$.getJSON(
							Resume.createItem,
							params,
							function(response){
								if (response.success){
									
									var html = '<div class=\"job\" id=\"item' + response.item.id + '\">';
										html += '<h4>' + response.item.title + ' - ' + response.item.company;
										html += '<span class=\"editor\">';
										html += '<span class=\"icon ui-icon ui-icon-trash right_align\" title=\"Delete: ' + response.item.title + ' - ' + response.item.company + '\" data-action=\"item-delete\" data-id=\"' + response.item.id + '\" data-section-id=\"' + sectionID + '\"></span>';
										html += '<span class=\"icon ui-icon ui-icon-pencil right_align\" title=\"Edit: ' + response.item.title + ' - ' + response.item.company + '\" data-action=\"job-edit\" data-id=\"' + response.item.id + '\" data-section-id=\"' + sectionID + '\"></span>';
										html += '</span></h4>';
										html += '<h6>' + response.item.start + ' - ' + (response.item.current ? 'Present' : response.item.end) + '</h6>';
										html += '<p>' + response.item.summary + '</p>';
										if (response.item.items != null && response.item.items.length){
											html += '<ul>';
											for (var i=0; i < response.item.items; i++){
												html += '<li><p>' + response.item.items[i].title + '</p></li>';
											} 
											html += '</ul>';
										}
										html += '</div><div class=\"clr\"></div>';
									$('#section' + sectionID + ' p.editor').before(html);
									$(_this).dialog('close');
								} else {
									alert("Something went wrong!");
								}
							}
						);
					},
					Cancel: function(){
						$(this).dialog('close');
					}
				},
				close: function(){
					$('#jobEditor .input').each(function(){
						$(this).val('');
					});
					$('#jobCurrent').attr('checked',false);
				}
			});
		})
		.bind('job-edit',function(e){
			var sectionID = $(e.tar).attr('data-section-id');
			var id = $(e.tar).attr('data-id');
			$.getJSON(
				Resume.showItem,
				{ resumeid : Resume.id, sectionid : sectionID, itemid : id },
				function(response){
					if (response.success){
						
						$('#jobTitleField').val(response.item.title);
						$('#jobCompany').val(response.item.company);
						$('#jobSummary').val(response.item.summary);
						$('#jobStart').val(new Date(response.item.start).format('mm/dd/yyyy'));
						$('#jobEnd').val(new Date(response.item.end).format('mm/dd/yyyy'));
						$('#jobCurrent').attr('checked',response.item.current);
						
						$('#jobEditor').dialog({
							title:'Edit ' + response.item.title + ' - ' + response.item.company,
							modal:true,
							resizable:false,
							width:600,
							buttons:{
								OK: function(){
									var params = {
										resumeid : Resume.id,
										sectionid : sectionID,
										itemid : id,
										title : $('#jobTitleField').val().trim(),
										company : $('#jobCompany').val().trim(),
										summary : $('#jobSummary').val().trim(),
										start : $('#jobStart').val().trim(),
										end : $('#jobEnd').val().trim(),
										current : $('#jobCurrent').attr('checked'),
										isJob : true
									}
									
									$.getJSON(
											Resume.updateItem,
											params,
											function(response){
												if (response.success){
													
													$('#item' + id).remove();
													
													var html = '<div class=\"job\" id=\"item' + response.item.id + '\">';
														html += '<h4>' + response.item.title + ' - ' + response.item.company;
														html += '<span class=\"editor\">';
														html += '<span class=\"icon ui-icon ui-icon-trash right_align\" title=\"Delete: ' + response.item.title + ' - ' + response.item.company + '\" data-action=\"item-delete\" data-id=\"' + response.item.id + '\" data-section-id=\"' + sectionID + '\"></span>';
														html += '<span class=\"icon ui-icon ui-icon-pencil right_align\" title=\"Edit: ' + response.item.title + ' - ' + response.item.company + '\" data-action=\"job-edit\" data-id=\"' + response.item.id + '\" data-section-id=\"' + sectionID + '\"></span>';
														html += '</span></h4>';
														html += '<h6>' + response.item.start + ' - ' + (response.item.current ? 'Present' : response.item.end) + '</h6>';
														html += '<p>' + response.item.summary + '</p>';
														if (response.item.items != null && response.item.items.length){
															html += '<ul>';
															for (var i=0; i < response.item.items; i++){
																html += '<li><p>' + response.item.items[i].title + '</p></li>';
															} 
															html += '</ul>';
														}
														html += '</div><div class=\"clr\"></div>';
													$('#section' + sectionID + ' p.editor').before(html);
												} else {
													alert("Something went wrong!");
												}
											}
										);
									
									$(this).dialog('close');
								},
								Cancel: function(){
									$(this).dialog('close');
								}
							},
							close: function(){
								$('#jobEditor .input').each(function(){
									$(this).val('');
								});
								$('#jobCurrent').attr('checked',false);
							}
						});
						
					} else {
						$('<div>There was a problem getting the details for this job. Please try again later.</div>').dialog({
							modal:true,
							title:'Notice!',
							resizable:false,
							buttons:{
								OK:function(){
									$(this).dialog('close');
								}
							}
						});
					}
				}
			);
		})
		.bind('toggle-controls',function(e){
			var action = $(e.tar).attr('title').split(' ')[0];
			if (action === 'Show'){
				action = 'Hide';
				$('.editor').show('slow');
				if ($('.editor').children().length){
					$('.editor').children().show('slow');	
				}
			} else if (action === 'Hide'){
				action = 'Show';
				if ($('.editor').children().length){
					$('.editor').children().hide('slow');	
				}
				$('.editor').hide('slow');
			}
			$(e.tar).attr('title', action + ' Controls');
		})
		.bind('resume-edit',function(e){
			console.log($('#summary').html());
			$('#resumeSummary').val($('#summary').html().trim().replace(/<br?[^>]+?>/gim,'\n'));
			$('#resumeEditor').dialog({
				modal:true,
				title:'Edit Resume Summary',
				width:500,
				resizable:false,
				close: function(){
					$('#resumeSummary').val('');
				},
				buttons:{
					OK:function(){
						var summary = $('#resumeSummary').val().trim();
						$(this).dialog('close');
						$.getJSON(
							Resume.updateResume,
							{ resumeid : Resume.id, summary : summary },
							function(response){
								if (response.success){
									$('#summary').html(response.summary.replace('\n','<br/>'));
								} else {
									alert("Something went wrong!");
								}
							}
						);
					},
					Cancel:function(){
						$(this).dialog('close');
					}
				}
			});
		})
		.bind('resume-toggle-visibility',function(e){
			var $this = $(e.tar);
			var visible = ($this.attr('title').split(' ')[3] === 'On') ? false : true;
			$.getJSON(
				Resume.toggleVisibility,
				{resumeid:Resume.id,visible:!visible},
				function(response){
					var newTitle = $this.attr('title').replace(($this.attr('title').split(' ')[3] === 'On') ? 'On' : 'Off',($this.attr('title').split(' ')[3] === 'On') ? 'Off' : 'On');
					$this.attr('title',newTitle).toggleClass('ui-state-highlight');
				}
			);
		});
	
	$('.icon').live('click',function(){
		$(document).trigger({type:$(this).attr('data-action'),tar:$(this)});
	});
	
	$(document).trigger('refresh');
});