# For more information please visit: http://technet.microsoft.com/en-us/library/dd744582(v=ws.10).aspx
# Quick usage to see Roles or Features run the following command: Dism /online /Get-Features

class windows-iis {

	dism { 'IIS-WebServerRole': 
		ensure => present,
	}

	dism { 'NetFx4Extended-ASPNET45':
		ensure => present,
	}

	dism { 'IIS-WebServer': 
		ensure => present,
		require => Dism['IIS-WebServerRole'],
	}

	dism { 'IIS-CommonHttpFeatures': 
		ensure => present,
		require => Dism['IIS-WebServer'],
	}

	dism { 'IIS-DefaultDocument': 
		ensure => present,
		require => Dism['IIS-CommonHttpFeatures'],
	}

	dism { 'IIS-DirectoryBrowsing': 
		ensure => present,
		require => Dism['IIS-CommonHttpFeatures'],
	}

	dism {	'IIS-HttpErrors': 
		ensure => present,
		require => Dism['IIS-CommonHttpFeatures'],
	}

	dism {	'IIS-StaticContent': 
		ensure => present,
		require => Dism['IIS-CommonHttpFeatures'],
	}

	dism { 'IIS-HealthAndDiagnostics': 
		ensure => present,
		require => Dism['IIS-WebServer'],
	}

	dism { 'IIS-HttpLogging': 
		ensure => present,
		require => Dism['IIS-HealthAndDiagnostics'],
	}

	dism { 'IIS-LoggingLibraries': 
		ensure => present,
		require => Dism['IIS-HealthAndDiagnostics'],
	}

	dism { 'IIS-RequestMonitor': 
		ensure => present,
		require => Dism['IIS-HealthAndDiagnostics'],
	}

	dism { 'IIS-Performance': 
		ensure => present,
		require => Dism['IIS-WebServer'],
    }

	dism { 'IIS-HttpCompressionStatic': 
		ensure => present,
		require => Dism['IIS-Performance'],
	}

	dism { 'IIS-Security': 
		ensure => present,
		require => Dism['IIS-WebServer'],
	}

	dism { 'IIS-RequestFiltering': 
		ensure => present,
		require => Dism['IIS-Security'],
    }

    dism { 'IIS-ApplicationDevelopment': 
    	ensure => present,
    	require => Dism['IIS-WebServer'],
	}

	dism { 'IIS-ISAPIExtensions': 
		ensure => present,
		require => Dism['IIS-ApplicationDevelopment'],
	}
    
    dism { 'IIS-ISAPIFilter': 
    	ensure => present,
    	require => Dism['IIS-ApplicationDevelopment'],
    }

    dism { 'IIS-NetFxExtensibility45': 
		ensure => present,
		require => [
			Dism['NetFx4Extended-ASPNET45'],
			Dism['IIS-ISAPIFilter'],
		]
	}

	dism { 'IIS-ASPNET45':
		ensure => present,
		require => [
			Dism['NetFx4Extended-ASPNET45'],
			Dism['IIS-NetFxExtensibility45'],
		]
	}

    dism { 'IIS-FTPServer':
    	ensure => present,
    	require => Dism['IIS-WebServerRole'],
    	}

    dism { 'IIS-WebServerManagementTools': 
    	ensure => present,
    	require => Dism['IIS-WebServerRole'],
    }

    dism { 'IIS-ManagementConsole': 
    	ensure => present,
    	require => Dism['IIS-WebServerManagementTools'],
    }

    dism { 'IIS-IIS6ManagementCompatibility':
    	ensure => present,
    	require => Dism['IIS-WebServerManagementTools'],
    }
}
