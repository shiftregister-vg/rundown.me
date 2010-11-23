package org.stevegood.resume

class SectionController {
	
	def sectionService
	def resumeService
	
	def beforeInterceptor = [action:this.&checkUser]
	
	def create = {
		def resume = resumeService.getResume(params.resumeid as int)
		if (!resume) render(builder:'json'){
			[success:false,message:"No resume found"]
		}
		
		def section = sectionService.createSection(params.title,resume.sections.size())
		resumeService.addSection(params.resumeid as int, section)
		
		render(builder:'json'){
			[success:true,section:section]
		}
	}
	
	def delete = {
		def resume = resumeService.getResume(params.resumeid as int)
		if (!resume) render(builder:'json'){
			[success:false,message:"No resume found"]
		}
		
		def section = sectionService.getSection(params.sectionid as int)
		resumeService.removeSection(params.resumeid as int, section)
		sectionService.deleteSection(params.sectionid as int)
		
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
		
		sectionService.updateSection(params.sectionid as int, params.title)
		
		render(builder:'json'){
			[success:true]
		}
	}
	
	def checkUser(){
		if (!session.user){
			redirect(controller:"user",action:"login",params:[returnURI:actionUri])
			return false
		}
	}
}
