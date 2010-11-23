package org.stevegood.resume

class Content {
	
	String label
	String body
	
	String toString(){
		body
	}
	
	static mapping = {
		body type:'text'
	}
	
    static constraints = {
		label unique:true, nullable:false, blank:false
    }
}
