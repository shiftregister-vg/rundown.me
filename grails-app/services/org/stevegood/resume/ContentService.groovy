package org.stevegood.resume

class ContentService {

    static transactional = true
	
	def getContent(String label){
		return Content.findByLabel(label)
	}
	
	def getContent(int id){
		return Content.get(id)
	}
	
    def updateContent(int id, String label, String body) {
		def content = Content.get(id)
		content.label = label
		content.body = body
		content.save()
		return content
    }
	
	def createContent(String label, String body){
		return new Content(label:label, body:body).save()
	}
	
	def deleteContent(int id){
		def content = Content.get(id)
		if (content) content.delete(flush:true)
	}
}
