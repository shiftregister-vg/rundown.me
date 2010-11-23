package org.stevegood.resume

class UserController {
	
	def mailService
	def userService
	def resumeService
	
	def beforeInterceptor = [action:this.&checkUser,except:['index','show','register','login','create','validate','logout']]
	
    def index = {
		def user = userService.getUser(params.username)
		
		if (!user){
			redirect(controller:"resume",action:"index")
		}
		
		def resume = resumeService.getVisibleResumesByOwner(user)
		if (session.user && (session.user.username == user.username)){
			resume = resumeService.getAllResumesByOwner(user)
		}
		
		["user" : user,"resumes" : resume]
	}
	
	def register = {
		if (session.user)
			redirect(controller:"user",action:"index",params:[username:session.user.username])
	}
	
	def create = {
		def existingUser = userService.getUser(params.username)
		if (existingUser){
			flash.message = "Username taken, please try again"
			render(view:"register")
		} else {
			if (!params.firstName.length() || !params.lastName.length() || !params.username.length() || !params.email.length() || !params.password.length()){
				flash.message = "Please fill out all required fields"
				render(view:"register")
			} else {
				def user = userService.createUser(params.username, params.firstName, params.lastName, params.email, params.bio, params.password)
				mailService.sendRegistrationWelcome(user)
				session.user = user
				redirect(controller:"user",action:"index",params:[username:session.user.username])
			}
		}
	}
	
	def login = {
		if (session.user) redirect(controller:"user",action:"index",params:[username:session.user.username])
	}
	
	def validate = {
		def user = userService.getUser(params.username,params.password)
	    if(user){
			session.user = user
			flash.message = "Hello ${user.fullName()}, welcome back!"
		  
			if (params.returnURI.length())
		  		redirect(uri:params.returnURI)
			else
				 redirect(url:resource(dir:''))
	    }else{
	      flash.message = "Sorry, the credentials entered are not valid. Please try again."
	      render(view:'login')
	    }
	}
	
	def logout = {
		session.user = null
		session.invalidate()
		if (params.returnURI && params.returnURI.length())
			redirect(uri:params.returnURI)
		else
			redirect(url:resource(dir:''))
	}
	
	def edit = {}
	
	def doEdit = {
		def user = userService.updateUser(session.user.username,params.firstName,params.lastName,params.email,params.bio,params.password)
		if (user){
			session.user = user
			redirect(controller:"user",action:"index",params:[username:session.user.username])
		} else {
			flash.message = "There was a problem updating your information, please try again later."
			render(view:"edit")
		}
	}
	
	def checkUser(){
		if (!session.user){
			redirect(controller:"user",action:"login",params:[returnURI:actionUri])
			return false
		}
	}
}
