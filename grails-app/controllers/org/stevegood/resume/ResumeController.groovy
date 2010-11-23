package org.stevegood.resume

class ResumeController {
	
	def contentService
	def resumeService
	def userService
	
	def beforeInterceptor = [action:this.&checkUser,except:['index','show','edit']]
    
	def index = {
		def welcomeContent = contentService.getContent("Welcome Page")
		def resumes = resumeService.getNewResumes()
		["resumes" : resumes, "welcomeContent" : welcomeContent]
	}
	
	def show = {
		def resume = resumeService.getResume(params.username,params.uri)
		if (!resume || (!resume.visible && (!session.user || session.user.username != params.username))){
			redirect(controller:"user",action:"index",params:[username:params.username])
		}
		
		["resume" : resume]
	}
	
	def create = {}
	
	def doCreate = {
		def resume = resumeService.getResume(session.user.username,resumeService.titleToUri(params.title))
		if (resume){
			flash.message="A resume with the same title already exists, please choose a different title."
			render(view:"create")
		} else {
			resume = resumeService.createResume(params.title,params.summary,session.user.username)
			userService.addResume(session.user.id as int, resume.id as int)
			redirect(controller:"resume",action:"show",params:[username:session.user.username,uri:resume.uri])
		}
	}
	
	def update = {
		def resume = resumeService.updateResume(params.resumeid, params.summary, session.user)
		if (!resume) render(builder:'json'){ [success:false,message:"No resume found"] }
		else
		render(builder:'json'){
			[success:true,summary:resume.summary.encodeAsHTML().replaceAll("\r", "\n").replaceAll("\n\n", "\n").replaceAll("\n", "<br />")]
		}
	}
	
	def delete = {
		def deleted = resumeService.deleteResume(params.resumeid,session.user)
		if (!deleted) render(builder:'json'){
			[success:false,message:"No resume found"]
		}
		
		render(builder:'json'){
			[success:true]
		}
	}
	
	def toggle = {
		def resume = resumeService.setResumeVisibility(params.resumeid,params.visible == "true" ? true : false)
		if (!resume) render(builder:'json'){
			[success:false,message:"No resume found"]
		}
		
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
