

class website-iis {

	include website-iis::files
	include website-iis::apppool

	service { 'W3SVC':
		ensure => 'running',
		enable => 'true',
	}
Class[website-iis::files]->Class[website-iis::apppool]
}