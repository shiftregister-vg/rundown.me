package org.stevegood.resume


class Resume {
	
	String title
	String uri
	String summary
	Date created
	boolean visible = false
	
	static belongsTo = [owner:User]
	static hasMany = [sections:Section]
	
	def String toString(){
		uri
	}
	
	static mapping = {
		summary type:'text'
	}
	
    static constraints = {
		sections(nullable:true)
		uri(unique:'owner')
    }
}
