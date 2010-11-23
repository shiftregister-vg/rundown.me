package org.stevegood.resume

class ItemController {
	
	def itemService
	def sectionService
	def resumeService
	
	def beforeInterceptor = [action:this.&checkUser]
	
	def show = {
		def resume = resumeService.getResume(params.resumeid as int)
		if (!resume) render(builder:'json'){
			[success:false,message:"No resume found"]
		}
		
		def section = sectionService.getSection(params.sectionid as int)
		if (!resume.sections.contains(section)) render(builder:'json'){
			[success:false,message:"Resume does not contain section"]
		}
		
		def item = itemService.getItem(params.itemid as int)
		render(builder:'json'){
			[success:true,item:item]
		}
	}
	
    def create = {
		def resume = resumeService.getResume(params.resumeid as int)
		if (!resume) render(builder:'json'){
			[success:false,message:"No resume found"]
		}
		
		def section = sectionService.getSection(params.sectionid as int)
		if (!resume.sections.contains(section)) render(builder:'json'){
			[success:false,message:"Resume does not contain section"]
		}
		
		def item
		if (params.isJob == "true")
			item = itemService.createJob(params.title,params.company,params.summary,params.start,params.end,params.current)
		else
			item = itemService.createItem(params.title)
		
		if (!item) render(builder:'json'){
			[success:false,message:"Item could not be created",params:params]
		}
		sectionService.addItem(params.sectionid as int, item)
		
		render(builder:'json'){
			[success:true,item:item]
		}
	}
	
	def delete = {
		def resume = resumeService.getResume(params.resumeid as int)
		if (!resume) render(builder:'json'){
			[success:false,message:"No resume found"]
		}
		
		def section = sectionService.getSection(params.sectionid as int)
		if (!resume.sections.contains(section)) render(builder:'json'){
			[success:false,message:"Resume does not contain section"]
		}
		
		def item = itemService.getItem(params.itemid as int)
		if (!item || !section.items.contains(item)) render (builder:'json'){
			[success:false,message:"Item does not belong to section"]
		}
		sectionService.removeItem(params.sectionid as int, item)
		itemService.deleteItem(params.itemid as int)
		render(builder:'json'){
			[success:true]
		}
	}
	
	def update = {
		def resume = resumeService.getResume(params.resumeid as int)
		if (!resume) render(builder:'json'){
			[success:false,message:"No resume found"]
		}
		
		def section = sectionService.getSection(params.sectionid as int)
		if (!resume.sections.contains(section)) render(builder:'json'){
			[success:false,message:"Resume does not contain section"]
		}
		
		def item = itemService.getItem(params.itemid as int)
		if (!item || !section.items.contains(item)) render (builder:'json'){
			[success:false,message:"Item does not belong to section"]
		}
		
		if (params.isJob == "true"){
			itemService.updateJob(params.itemid as int, params.title, params.company, params.summary, params.start, params.end, params.current)
		} else {
			itemService.updateItem(params.itemid as int, params.title)
		}
		
		render(builder:'json'){
			[success:true,item:item]
		}
	}
	
	def checkUser(){
		if (!session.user){
			redirect(controller:"user",action:"login",params:[returnURI:actionUri])
			return false
		}
	}
}
