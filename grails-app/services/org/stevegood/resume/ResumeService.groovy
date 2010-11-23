package org.stevegood.resume

class ResumeService {
	
    static transactional = true
	
	def passwordService
	
    def getResume(String username, String uri) {
		return Resume.findByOwnerAndUri(User.findByUsername(username),uri)
    }
	
	def getResume(String uri){
		return Resume.findByUri(uri)
	}
	
	def getResume(int id){
		return Resume.get(id)
	}
	
	def getNewResumes(){
		def resumes = Resume.findAll("from Resume as r where r.visible=1")
		resumes = resumes?.sort{ a,b-> (a.created>b.created ? -1 : 1) }
		if (resumes.size() >= 5) resumes = resumes[0..4]
		return resumes
	}
	
	def getAllResumesByOwner(def owner){
		return Resume.findAllByOwner(owner)
	}
	
	def getVisibleResumesByOwner(def owner){
		return Resume.findAllByOwnerAndVisible(owner,true)
	}
	
	def createResume(def title, def summary, def username){
		def resume = new Resume(
				owner:User.findByUsername(username),
				title:title,
				summary:summary,
				uri:titleToUri(title),
				created:new Date()
			)
		def section = new Section(title:"Experience",position:0).save()
		resume.addToSections(section)
		resume.save()
		
		return resume
	}
	
	def updateResume(def resumeid, def summary, def owner){
		def resume = Resume.findByIdAndOwner(resumeid,owner)
		if (resume){
			resume.summary = summary
			resume.save()
		}
		
		return resume
	}
	
	def deleteResume(def resumeid, def owner){
		def resume = Resume.findByIdAndOwner(resumeid,owner)
		if (!resume) return false
		
		resume.sections.each { section ->
			section.items.each { outer ->
				outer.items.each { inner ->
					inner.delete()
				}
				outer.delete()
			}
			section.delete()
		}
		
		resume.delete(flush:true)
		
		return true
	}
	
	def setResumeVisibility(def resumeid,def visible){
		def resume = Resume.get(resumeid)
		
		if (resume){
			resume.visible = visible
			resume.save()
		}
		
		return resume
	}
	
	def addSection(int id, def section){
		def resume = getResume(id)
		resume.addToSections(section)
		resume.save()
	}
	
	def removeSection(int id, def section){
		def resume = getResume(id)
		resume.removeFromSections(section)
		resume.save()
	}
	
	def titleToUri(def title){
		return title.replaceAll(/[^a-z-A-Z0-9]/, '_').toLowerCase()
	}
	
	def createShareURL(Resume resume){
		def token = passwordService.randomPassword()
		"http://rundown.me/${ resume.owner }/${ resume.uri }/${ token }"
	}
}
