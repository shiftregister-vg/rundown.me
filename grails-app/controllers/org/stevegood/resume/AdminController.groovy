package org.stevegood.resume

class AdminController {
	
	def contentService
	def mailService
	def passwordService
	def userService
	
	def beforeInterceptor = [action:this.&checkUser]
	
    def index = { }
	
	def editWelcomePage = {
		["welcomePageContent" : contentService.getContent("Welcome Page")]
	}
	
	def saveContent = {
		def content = contentService.getContent(params.label)
		content = contentService.updateContent(content.id as int, params.label, params.body)
		render(builder:'json'){
			[success : true, content : content]
		}
	}
	
	def listUsers = {
		["users" : userService.listUsers()]
	}
	
	def showUser = {
		if (params.username) ["user" : userService.getUser(params.username)]
		else redirect(action:"listUsers")
	}
	
	def resetUserPassword = {
		["user" : userService.getUser(params.username)]
	}
	
	def doUserPasswordReset = {
		userService.resetPassword(params.username)
		flash.message="Password has been reset!"
		render(builder:'json'){
			[success:true]
		}
	}
	
	def editUser = {
		["user" : userService.getUser(params.username)]
	}
	
	def saveUser = {
		def user = userService.updateUser(params.username,params.firstName,params.lastName,params.email,params.bio,"",params.id as int)
		if (user){
			mailService.sendMail {
				to user.email
				subject "Your profile has been updated"
				body "An administrator on rundown.me has updated your profile.\n\nThanks!\nTeam Rundown"
			}
			flash.message="${user.fullName()} ($user) updated!"
		}
		render(builder:'json'){
			[
				"success" : user ? true : false,
				"message" : user ? "" : "There was a problem updating the user.",
				"username" : user ? user.username : params.username
			]
		}
	}
	
	def deleteUser = {
		["user" : userService.getUser(params.username)]
	}
	
	def doDeleteUser = {
		def user = userService.getUser(params.username)
		def success = false
		if (user){
			def emailAddress = user.email
			def name = user.fullName()
			success = userService.deleteUser(params.username)
			
			if (success){
				mailService.sendMail {
					to emailAddress
					subject "Account Deleted"
					body "$name,\n\nYour rundown.me account has been deleted by an administrator.\n\nRegards,\nTeam Rundown"
				}
			}
		}
		render(builder:'json'){
			["success":success]
		}
	}
	
	def createUser = {
		
	}
	
	def doCreateUser = {
		
		if (params.generatePassword == "true") params.password = passwordService.randomPassword()
		
		def user = userService.createUser(params.username,params.firstName,params.lastName,params.email,params.bio,params.password,false)
		
		if (params.sendUserInfo == "true") mailService.sendRegistrationWelcome(user)
		
		render(builder:'json'){
			["success":true, "message": user ? "" : "User could not be created, perhaps a user already exists?"]
		}
	}
	
	def checkUser(){
		if (!session.user || (session.user && !session.user.admin)){
			redirect(controller:"user",action:"login",params:[returnURI:actionUri,username:params?.username])
			return false
		}
	}
	
	def classDiagram = {
		redirect(controller:"classDiagram")
	}
}
