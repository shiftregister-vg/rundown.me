package org.stevegood.resume

class PasswordService {

    static transactional = true
	
	def randomPassword(){
		return randomPassword(8)
	}
	
	def randomPassword(int length){
		String validChars ="abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789"
		String password = ""
		java.util.Random rnd = new java.util.Random(System.currentTimeMillis()*(new java.util.Random().nextInt()))
		for ( i in 0..length ) {
			int rndPos = Math.abs(rnd.nextInt() % validChars.length())
			password += validChars.charAt(rndPos)
		}
		return password
	}
}
