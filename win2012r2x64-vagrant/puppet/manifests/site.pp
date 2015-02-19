package { 'Notepadplusplus':
  ensure => latest,
  provider => 'chocolatey',
}

package { 'msdeploy':
  ensure => latest,
  provider => 'chocolatey',
}

node default {
	include windows-iis, website-iis, registry
}
