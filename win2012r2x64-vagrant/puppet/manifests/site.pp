package { 'Notepadplusplus':
  ensure => latest,
  provider => 'chocolatey',
}

package { 'msdeploy':
  ensure => latest,
  provider => 'chocolatey',
}

package { 'VisualStudio2013Ultimate':
  ensure => latest,
  provider => 'chocolatey',
}
