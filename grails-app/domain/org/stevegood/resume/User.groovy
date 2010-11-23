package org.stevegood.resume


class User {
	
	String username
	String password
	String firstName
	String lastName
	String email
	String bio
	Date lastLogin
	boolean admin = false
	
	static hasMany = [resumes:Resume]
	
	String toString() {
		"$username"
	}
	
	def fullName = {
		"$firstName $lastName"
	}
	
	static mapping = {
		bio type:'text'
	}
	
    static constraints = {
		username(username:true,unique:true)
		password(blank:false, password:true)
		bio(nullable:true)
		lastLogin nullable:true
    }
}
