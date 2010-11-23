package org.stevegood.resume


class Job extends Item {
	
	String company
	String summary
	Date start
	Date end
	boolean current
	
	def String toString(){
		"$title - $company"
	}
	
	static mapping = {
		summary type:'text'
		sort start:"desc"
	}
	
    static constraints = {
    }
}
