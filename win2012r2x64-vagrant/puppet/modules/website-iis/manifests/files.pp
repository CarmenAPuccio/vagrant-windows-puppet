
class website-iis::files {

	$username = 'RND\bizadmin'
	 $password = 'bts@p2005'
	 $share =  '\\rndlabshare1.rnd.local\arc\Installers\TeamCity\Redit'
	 $safeshare = regsubst($share, '[\\$]', '.', 'G')

	exec { 'install_mount':
	   command => "$netuse $share /USER:$username $password"
	 }


	file { 'C:/inetpub/wwwroot/APRedit':
		recurse => true,
		ensure => directory,
		owner => 'Administrator',
		group => 'Users',
		mode => '7777',
		notify => Service["W3SVC"],
		source => "$share",
		require => Exec['install_mount']
	}


}