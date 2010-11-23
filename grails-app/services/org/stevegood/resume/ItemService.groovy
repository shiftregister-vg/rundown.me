package org.stevegood.resume

class ItemService {

    static transactional = true

    def getItem(int id) {
		return Item.get(id)
    }
	
	def createItem(def title){
		return new Item(title:title).save()
	}
	
	def createJob(def title,def company,def summary,def start,def end,def current){
		return new Job(
			title : title,
			company : company,
			summary : summary,
			start : new Date().parse('MM/dd/yyyy',start),
			end : end.length() ? new Date().parse('MM/dd/yyyy',end) : new Date(),
			current : current
		).save()
	}
	
	def deleteItem(int id){
		def item = getItem(id)
		item.delete(flush:true)
	}
	
	def updateItem(int id, def title){
		def item = getItem(id)
		item.setTitle(title)
		return item.save()
	}
	
	def updateJob(int id, def title, def company, def summary, def start, def end, def current){
		def job = getItem(id)
		job.company = company
		job.start = new Date().parse('MM/dd/yyyy',start)
		job.end = new Date().parse('MM/dd/yyyy',end)
		job.current = current == "true" ? true : false
		job.summary = summary
		
		return job.save()
	}
}
