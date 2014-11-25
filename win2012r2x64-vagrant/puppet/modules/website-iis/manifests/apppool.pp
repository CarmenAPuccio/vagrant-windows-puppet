class website-iis::apppool (
  $apppool = hiera("apppool"),
  $website = hiera("website"),
  $siteid = hiera("siteid"),
  $physicalpath = hiera("physicalpath"),
  $ipbinding = hiera("ipbinding"),
  $logfile_directory = hiera("logfile_directory")
  )
{
  iis_apppool {$apppool:
    ensure => present,
      managedpipelinemode => 'Integrated',
      managedruntimeversion => 'v4.0',
    }

    iis_site {'Default Web Site': ensure => absent,
      } ->
      iis_site { $website:
      ensure => present,
      require => Iis_apppool[$apppool],
      id => $siteid,
      #bindings => ["http/*:80:"],
      bindings => [$ipbinding],
      serverautostart => 'true',
      logfile_logextfileflags => 'BytesRecv, BytesSent, ClientIP, ComputerName, Cookie, Date, Host, HttpStatus, HttpSubStatus, Method, ProtocolVersion, Referer, ServerIP, ServerPort, SiteName, Time, TimeTaken, UriQuery, UriStem, UserAgent, UserName, Win32Status',
      logfile_directory => $logfile_directory,
    }

    iis_app { "$website/":
      ensure => present,
      require => Iis_apppool[$apppool],
      applicationpool => $apppool,
    }

    iis_vdir { "$website/":
      ensure  => present,
      require => Iis_app["$website/"],
        iis_app => "$website/",
        physicalpath => $physicalpath
    }
}