package org.stevegood.resume

class Section {
	
	String title
	int position
	
	static hasMany = [items:Item]
	
	def String toString(){
		title
	}
	
    static constraints = {
		items(nullable:true)
    }
}
