class website-iis::files {
	$username = '** insert DOMAIN\username **'
	$password = '** insert password here **'
	$share =  '** insert \\server\sharefolder **'
	$safeshare = regsubst($share, '[\\$]', '.', 'G')

	$netuse = 'C:\Windows\system32\cmd.exe /c net use'

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