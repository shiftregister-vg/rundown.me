class UrlMappings {
	
	static excludes = ["/images/*", "/css/*", "/js/*"]
	static mappings = {
		/*"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}*/

		"/classDiagram/$action?"(controller:"classDiagram")
		
		"/"(controller:"resume",action:"index")
		"/login"(controller:"user",action:"login")
		"/user/validate"(controller:"user",action:"validate")
		"/user/edit"(controller:"user",action:"edit")
		"/user/doEdit"(controller:"user",action:"doEdit")
		"/user/create"(controller:"user",action:"create")
		"/register"(controller:"user",action:"register")
		"/logout"(controller:"user",action:"logout")
		"/create"(controller:"resume",action:"create")
		"/item/show"(controller:"item",action:"show")
		"/item/create"(controller:"item",action:"create")
		"/item/delete"(controller:"item",action:"delete")
		"/item/update"(controller:"item",action:"update")
		"/section/create"(controller:"section",action:"create")
		"/section/delete"(controller:"section",action:"delete")
		"/section/update"(controller:"section",action:"update")
		"/resume/update"(controller:"resume",action:"update")
		"/resume/doCreate"(controller:"resume",action:"doCreate")
		"/resume/delete"(controller:"resume",action:"delete")
		"/resume/toggle"(controller:"resume",action:"toggle")
		"/admin"(controller:"admin",action:"index")
		"/admin/$action/$username?"(controller:"admin")
		"/admin/showUser/$username"(controller:"admin",action:"showUser")
		"/$username"(controller:"user",action:"index")
		"/$username/$uri?/"(controller:"resume",action:"show")
		
		"500"(view:'/error')
	}
}
