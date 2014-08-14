@echo 'Installing software...'
@echo 'Ensuring .NET 4.0 is installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrantshared\shell\InstallNet4.ps1"

echo 'Ensuring Chocolatey is Installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrantshared\shell\InstallChocolatey.ps1"

echo 'Install puppet if missing'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrantshared\shell\InstallPuppetFromMSI.ps1"

SET PATH=%PATH%;%SystemDrive%\Program Files (x86)\Puppet Labs\Puppet\bin;%SystemDrive%\Program Files\Puppet Labs\Puppet\bin;
SET PATH=%PATH%;%SystemDrive%\ProgramData\chocolatey\bin;

@echo 'Ensuring GIT is Installed'
@powershell -NoProfile -ExecutionPolicy Bypass "cinst git"

SET PATH=%PATH%;%SystemDrive%\Program Files (x86)\Git\bin
@echo "Ensuring environment for puppet - this puts the puppet ruby on the path for librarian"
@echo "You can confirm the environment by saying facter --puppet after the below is run"
@echo "The environment.bat file is in C:\Program Files (x86)\Puppet Labs\Puppet\bin"
call environment.bat
SET FACTER_domain=local

@echo 'Install Required libraries for puppet if missing'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrantshared\shell\PreparePuppetProvisioner.ps1"

::puppet resource
::call puppet agent --test --debug --verbose

