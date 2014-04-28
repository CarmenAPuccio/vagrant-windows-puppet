
class website-iis::files {
	file { 'C:/inetpub/wwwroot/APRedit':
		recurse => false,
		ensure => directory,
		owner => 'Administrator',
		group => 'Users',
		mode => '7777',
		notify => Service["W3SVC"],
	}
}