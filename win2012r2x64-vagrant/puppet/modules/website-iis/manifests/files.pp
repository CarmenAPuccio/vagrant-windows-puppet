class website-iis::files (
	$destination = hiera("physicalpath"),
	$shareusername = hiera("shareusername"),
	$sharepassword = hiera("sharepassword"),
	$share = hiera("share")
	)

{
	$safeshare = regsubst($share, '[\\$]', '.', 'G')

	$netuse = 'C:\Windows\system32\cmd.exe /c net use'

	exec { 'install_mount':
	   command => "$netuse $share /USER:$shareusername $sharepassword"
	}

	file { $destination:
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