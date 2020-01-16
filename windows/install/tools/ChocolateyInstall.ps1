# Description: Boxstarter Script
# Author: Faraaz Khan
# Common settings for developers and devops at rationalize it

Disable-UAC
$ConfirmPreference = "None" #ensure installing powershell modules don't prompt on needed dependencies
$ErrorActionPreference = 'SilentlyContinue' #Tolerate failure silently. We know this is bad, but this script isn't critical

 #Get the base URI path from the ScriptToCall value
#$helperUri = Get-PackageRoot($MyInvocation)
#$helperUri += "/scripts"
#write-host "helper script base URI is $helperUri"
#
#function executeScript {
    #Param ([string]$script)
    #write-host "executing $helperUri/$script ..."
  #iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
#}


# Install the Windows Subsystem for Linux
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

# Windows Containers on Windows 10
Enable-WindowsOptionalFeature -Online -FeatureName containers -All -NoRestart
RefreshEnv


#--- Configuring Windows properties ---
#--- Windows Features ---
# Show hidden files, Show protected OS files, Show file extensions
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

#--- File Explorer Settings ---
# will expand explorer to the actual folder you're in
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
# adds things back in your left pane like recycle bin
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
# opens PC to This PC, not quick access
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
# taskbar where window is open for multi-monitor
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#--- Enable Developer Mode ---
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1


# Common Tools
choco install -y 7zip.install
choco install -y firefox
choco install -y googlechrome
choco install -y slack
choco install -y sysinternals

# Developer Packages
choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"
choco install -y git-credential-manager-for-windows
choco install -y nodejs
choco install -y poshgit
choco install -y powershell-core
choco install -y python
choco install -y vscode
choco install -y vscode-docker
choco install -y golang
choco install -y Microsoft-Hyper-V-All -source=windowsFeatures
#choco install -y openconnect-gui
choco install -y microsoft-windows-terminal
choco install -y notepadplusplus
choco install -y thunderbird


# DevOps Packages
choco install -y awscli
choco install -y azure-cli
choco install -y docker-for-windows
choco install -y kubernetes-cli
choco install -y kubernetes-helm
choco install -y minikube
choco install -y terraform
choco install -y virtualbox
choco install -y vagrant
choco install -y packer
choco install -y inspec

## Add All Local Users to Docker Group
Get-LocalUser | Where-Object {$_.Enabled -eq 'True'} | ForEach-Object {Add-LocalGroupMember -Group 'docker-users' -Member $_}


#--- Ubuntu ---
 #TODO: Move this to choco install once --root is included in that package
#Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile ~/Ubuntu.appx -UseBasicParsing
#Add-AppxPackage -Path ~/Ubuntu.appx
 #run the distro once and have it install locally with root user, unset password
#
#RefreshEnv
#Ubuntu1804 install --root
#Ubuntu1804 run apt update -y
#Ubuntu1804 run apt install software-properties-common git -y
#Ubuntu1804 run apt-add-repository ppa:ansible/ansible -y
#Ubuntu1804 run apt update -y
#Ubuntu1804 run apt-get install ansible -y

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula

Write-Host "Uninstall some applications that come with Windows out of the box" -ForegroundColor "Yellow"

function removeApp {
	Param ([string]$appName)
	Write-Output "Trying to remove $appName"
	Get-AppxPackage $appName -AllUsers | Remove-AppxPackage
	Get-AppXProvisionedPackage -Online | Where DisplayNam -like $appName | Remove-AppxProvisionedPackage -Online
}

$applicationList = @(
	"Microsoft.BingFinance"
	"Microsoft.3DBuilder"
	"Microsoft.BingFinance"
	"Microsoft.BingNews"
	"Microsoft.BingSports"
	"Microsoft.BingWeather"
	"Microsoft.CommsPhone"
	"Microsoft.Getstarted"
	"Microsoft.WindowsMaps"
	"*MarchofEmpires*"
	"Microsoft.GetHelp"
	"Microsoft.Messaging"
	"*Minecraft*"
	"Microsoft.MicrosoftOfficeHub"
	"Microsoft.OneConnect"
	"Microsoft.WindowsPhone"
	"Microsoft.WindowsSoundRecorder"
	"*Solitaire*"
	"Microsoft.MicrosoftStickyNotes"
	"Microsoft.Office.Sway"
	"Microsoft.XboxApp"
	"Microsoft.XboxIdentityProvider"
	"Microsoft.ZuneMusic"
	"Microsoft.ZuneVideo"
	"Microsoft.NetworkSpeedTest"
	"Microsoft.FreshPaint"
	"Microsoft.Print3D"
	"*Autodesk*"
	"*BubbleWitch*"
    "king.com*"
    "G5*"
	"*Dell*"
	"*Facebook*"
	"*Keeper*"
	"*Netflix*"
	"*Twitter*"
	"*Plex*"
	"*.Duolingo-LearnLanguagesforFree"
	"*.EclipseManager"
	"ActiproSoftwareLLC.562882FEEB491" # Code Writer
	"*.AdobePhotoshopExpress"
  "Dropbox.Promotion"
  "*McAfee*"
  "*Booking.com*"
);

foreach ($app in $applicationList) {
    removeApp $app
}
