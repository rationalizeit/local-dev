
# Development

See Boxstarter Documentation for instructions. Some useful commands:

```
New-BoxstarterPackage -Name DevOps -Description -Path "g:\windows\install"
Invoke-BoxstarterBuild DevOps
Install-BoxstarterPackage -PackageName DevOps
Install-BoxstarterPackage -PackageName
https://raw.githubusercontent.com/rationalizeit/local-dev/master/windows/install/tools/ChocolateyInstall.ps1
-Credential $cred
```

### Run via JumpCloud

```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); . { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force
Set-ExecutionPolicy Bypass -Scope Process -Force; Import-Module "C:\ProgramData\Boxstarter\Boxstarter.Chocolatey"; $password = ConvertTo-SecureString "<actual password>" -AsPlainText -Force;$Cred = New-Object System.Management.Automation.PSCredential (“<username>”, $password);Install-BoxstarterPackage -Package https://raw.githubusercontent.com/rationalizeit/local-dev/master/windows/install/tools/ChocolateyInstall.ps1 -Credential $Cred -DisableReboots
```
