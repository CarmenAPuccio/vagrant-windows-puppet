
class website-iis::apppool {
	iis_apppool {'APRedit':
		ensure => present,
    	managedpipelinemode => 'Integrated',
    	managedruntimeversion => 'v4.0',
  	}

  	iis_site {'Default Web Site':
		ensure		=> absent,
	}

  	iis_site { 'APRedit':
  		ensure => present,
  		require => Iis_apppool['APRedit'],
  		id => '2',
  		bindings => ["http/*:80:"],
  	}

  	iis_app { 'APRedit/':
  		ensure => present,
  		require => Iis_apppool['APRedit'],
  		applicationpool => 'APRedit',
  	}

  	iis_vdir { 'APRedit/':
  		ensure  => present,
  		require	=> Iis_app['APRedit/'],
        iis_app => 'APRedit/',
        physicalpath => 'C:\inetpub\wwwroot\APRedit'
    }
}