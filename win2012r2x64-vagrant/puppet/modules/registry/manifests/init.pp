

class registry {

	registry_key { 'HKLM\System\CurrentControlSet\Services\HTTP\Parameters':
		ensure => present,
	}

	registry_value { 'HKLM\System\CurrentControlSet\Services\HTTP\Parameters\URLSegmentMaxLength':
	  ensure => present,
	  type   => dword,
	  data   => "0x00001000",
	}

}