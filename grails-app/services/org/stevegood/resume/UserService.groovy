package org.stevegood.resume

class UserService {
	
	def mailService
	def passwordService
	def resumeService
	
    static transactional = true

    def getUser(String username, String password) {
		def user = User.findByUsernameAndPassword(username,password)
		if (user) user.lastLogin = new Date()
		return user
    }
	
	def getUser(String username){
		return User.findByUsername(username)
	}
	
	def getUser(int id){
		return User.get(id)
	}
	
	def listUsers(){
		return User.list()
	}
	
	def createUser(def username, def firstName, def lastName, def email, def bio, def password,def setLastLogin=true){
		def user = getUser(username)
		if (!user){
			user = new User(
					username:username,
					firstName:firstName,
					lastName:lastName,
					email:email,
					bio:bio,
					password:password,
					lastLogin:setLastLogin ? new Date() : null
				).save()
		} else {
			user = null
		}
		return user
	}
	
	def updateUser(def username, def firstName, def lastName, def email, def bio, def password="", int id=0){
		def user = (id != 0) ? getUser(id) : getUser(username)
		
		if (user){
			if (id != 0 && user.username != username) user.username = username
			user.firstName = firstName
			user.lastName = lastName
			user.email = email
			user.bio = bio
			
			if (password.length()) user.password = password
			
			user.save()
		}
		return user
	}
	
	def deleteUser(def username){
		def user = getUser(username)
		if (!user) return false
		
		user.delete(flush:true)
		return true
	}
	
	def addResume(int id, int resumeid){
		def user = User.get(id)
		def resume = Resume.get(resumeid)
		user.addToResumes(resume)
		user.save()
	}
	
	def resetPassword(String username){
		String newPassword = passwordService.randomPassword()
		def user = getUser(username)
		user.password = newPassword
		user.save()
		
		mailService.sendPasswordChangeNotice(user)
		
		return newPassword
	}
}
