package org.stevegood.resume


class Item {
	
	String title
	
	static hasMany = [items:Item]
	
	def String toString(){
		title
	}
	
    static constraints = {
		items(nullable:true)
    }
}
