package org.stevegood.resume

class MailService extends org.grails.mail.MailService {
	
    static transactional = true

    def sendPasswordChangeNotice(User user) {
		sendMail {
			to user.email
			subject "Your Password has Been Reset"
			body "Your http://rundown.me/ password has been set to ${ user.password }\n\nThanks!\nThe Rundown Team"
		}
    }
	
	def sendRegistrationWelcome(User user){
		sendMail {
			to user.email
			subject "Welcome to rundown.me!"
			body "Welcome to rundown.me!\n\nPlease find your credentials below and save them in a safe place.\n\nusername: $user\npassword: $user.password\n\nIf you haven't already, go create your first resume! You can login here: http://rundown.me/login\n\nThanks!\nTeam Rundown"
		}
	}
}
