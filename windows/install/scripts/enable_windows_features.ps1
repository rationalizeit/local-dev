# Install Hyper-V on Windows 10
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart

# Install the Windows Subsystem for Linux
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

# Windows Containers on Windows 10
Enable-WindowsOptionalFeature -Online -FeatureName containers -All -NoRestart
RefreshEnv
