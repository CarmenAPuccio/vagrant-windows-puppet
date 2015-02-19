$DesiredPuppetVersion = '3.7.4'
$MsiUrl = "https://downloads.puppetlabs.com/windows/puppet-3.7.4.msi"
$PuppetInstallerPath = 'c:\vagrantshared\resources\installers'
$PuppetInstallerFile = 'puppet.msi'
if ([System.IntPtr]::Size -eq 8) {
  Write-Host "Going to Puppet 64-bit."
  $MsiUrl = "https://downloads.puppetlabs.com/windows/puppet-3.7.4-x64.msi"
  $PuppetInstallerFile = 'puppet-x64.msi'
}
$PuppetInstaller = Join-Path $PuppetInstallerPath $PuppetInstallerFile

$PuppetInstalled = $false
$PuppetVersionMatch = $false
try {
  $ErrorActionPreference = "Stop";
  Get-Command puppet | Out-Null
  $PuppetInstalled = $true
  $PuppetVersion=&puppet "--version"
  if ($PuppetVersion -eq $DesiredPuppetVersion)
  { 
    Write-Host "Puppet $PuppetVersion is installed and matches. Exiting."
    $PuppetVersionMatch = $true
    $PuppetInstalled = $true
    Exit 0
  }

  else
  {
  Write-Host "Puppet $PuppetVersion is installed but does not match. This is not the desired version which is $DesiredPuppetVersion. Continuing..."
  }

} catch {
  Write-Host "Puppet is not installed and/or isn't the desired version, continuing..."
}

if (!($PuppetInstalled) -or !($PuppetVersionMatch)) {
  $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  if (! ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
    Write-Host -ForegroundColor Red "You must run this script as an administrator."
    Exit 1
  }

  if (!(Test-Path $PuppetInstallerPath)) {
    Write-Host "Creating folder `'$PuppetInstallerPath`'"
    $null = New-Item -Path "$PuppetInstallerPath" -ItemType Directory
  }

  if (!(Test-Path $PuppetInstaller)) {
    Write-Host "Downloading `'$MsiUrl`' to `'$PuppetInstaller`'"
    (New-Object Net.WebClient).DownloadFile("$MsiUrl","$PuppetInstaller")
  }


  # Install it - msiexec will download from the url
  $install_args = @("/qn", "/norestart","/i", "$PuppetInstaller")
  Write-Host "Installing Puppet. Running msiexec.exe $install_args"
  $process = Start-Process -FilePath msiexec.exe -ArgumentList $install_args -Wait -PassThru
  if ($process.ExitCode -ne 0) {
    Write-Host "Installer failed."
    Exit 1
  }

  Write-Host "Puppet successfully installed."
}