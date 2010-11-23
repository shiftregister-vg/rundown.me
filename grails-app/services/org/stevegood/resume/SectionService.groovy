package org.stevegood.resume

class SectionService {

    static transactional = true

    def getSection(int id) {
		return Section.get(id)
    }
	
	def createSection(title, position){
		return new Section(title:title,position:position).save()
	}
	
	def addItem(int id, def item){
		def section = getSection(id)
		section.addToItems(item).save()
	}
	
	def removeItem(int id, def item){
		def section = getSection(id)
		section.removeFromItems(item).save()
	}
	
	def updateSection(int id, def title){
		def section = getSection(id)
		section.title = title
		section.save()
	}
	
	def deleteSection(int id){
		def section = getSection(id)
		section.items.each{ outer ->
			outer.items.each { inner ->
				inner.delete()
			}
			outer.delete()
		}
		
		section.delete(flush:true)
	}
}
