dataSource {
	pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "resume"
    password = "resume"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost:3306/resume"
        }
    }
	stage {
		dataSource {
			dbCreate = "update"
			url = "jdbc:mysql://localhost:3306/resume-staging"
		}
	}
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://178.18.17.140:3306/resume"
        }
    }
}
