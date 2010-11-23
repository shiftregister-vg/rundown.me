import org.stevegood.resume.*
import grails.converters.JSON
import grails.util.Environment

class BootStrap {

    def init = { servletContext ->
		
		/*
		 * Auto JSON date formatting
		 */
		JSON.registerObjectMarshaller(Date){
			return it?.format('MMMM d, yyyy')
		}
		
		if (Environment.current != Environment.PRODUCTION){
			new Content(label:"Welcome Page",body:"""<h2>Welcome to ResumeBuilder</h2>
          <div class="clr"></div>
          <p>Rundown.me is a Proof-of-Concept resume builder application written by <a href="http://stevegood.org/" target="_blank">Steve Good</a>. It was designed better his understanding of <a href="http://grails.org" target="_blank">Grails</a>.</p>
          <p><a href="/register">Register</a> an account and get started building your first resume today! There's no limit to the number of resumes you can create.</p>""").save()
			
		  new User(firstName:"Chester",lastName:"Tester",email:"sgood@lanctr.com",username:"chester",password:"tester",bio:"Stuff.").save()
		  	def user = new User(firstName:"Steve",lastName:"Good",email:"steve@stevegood.org",username:"stevegood",password:"\$jtalg00d!",admin:true).save()
			
			def resume = new Resume(
			  created:new Date(),
			  title:"My Resume",
			  uri:"my_resume",
			  visible:true,
			  summary:"I have been involved with web development since 1996 and developing web applications since 1999. In addition to my ColdFusion experience I am also proficient in Flex, AIR, Java, Groovy, Grails, JavaScript and jQuery.",
			  owner:user,
			  sections:[
				  new Section(
					  title:"Experience",
					  position:0,
					  items:[
						  new Job(
							  company:"Equator, LLC",
							  title:"Enterprise Architect",
							  summary:"Enterprise R&D. Discovering and testing optimal JVM settings. Integrated AIR (Flex) applications.",
							  start: new Date().parse('MM/dd/yyyy','12/07/2009'),
							  end: new Date(),
							  current:true,
							  items:[
								  new Item(title:"Maintained and modified a custom workflow engine designed for the forclosure industry.")
							  ]
						  ).save(),
					  	  new Job(
							  company:"Slantsoft",
							  title:"Owner",
							  summary:"Single handedly defeated the Mongols during the battle of Waterloo.",
							  start:new Date().parse('MM/dd/yyyy','01/01/2009'),
							  end:new Date(),
							  current: true
						  ).save()
					  ]
				  ).save(),
			  	  new Section(
						title:"Languages",
						position:2,
						items:[
							new Item(title:"ColdFusion"),
							new Item(title:"JavaScript"),
							new Item(title:"Java"),
							new Item(title:"Groovy / Grails"),
							new Item(title:"Flex / Actionscript"),
							new Item(title:"HTML / CSS")
						]
				  ).save(),
				  new Section(
				  		title:"Software",
						position:1,
						items:[
							new Item(title:"IIS, Apache"),
							new Item(title:"ColdFusion 6-9"),
							new Item(title:"Railo 3.1.2+"),
							new Item(title:"Mura CMS"),
							new Item(title:"Subversion, GIT, MKS")
						]
				  ).save()
			  ]          
	      ).save()
		  
		  user.addToResumes(resume)
    	}
    }
    def destroy = {
    }
}
