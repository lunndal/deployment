<#

    ██     ██  █████  ██████  ███    ██ ██ ███    ██  ██████  ██ 
    ██     ██ ██   ██ ██   ██ ████   ██ ██ ████   ██ ██       ██ 
    ██  █  ██ ███████ ██████  ██ ██  ██ ██ ██ ██  ██ ██   ███ ██ 
    ██ ███ ██ ██   ██ ██   ██ ██  ██ ██ ██ ██  ██ ██ ██    ██    
     ███ ███  ██   ██ ██   ██ ██   ████ ██ ██   ████  ██████  ██ 

      -------------------------------------------------------
      This script is public and should NEVER contain secrets!
      -------------------------------------------------------
#>

# Source 
# https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup-oobeSystem.ps1

#
# USAGE
# Run this script during the "oobeSystem" phase from autounattend.xml
# Commands will run in the context of the first admin user created, 
# when the installer automatically logs the user in.
#
# Global system settings go in this file.
# 

#
# ISSUES
# - Mouse pad does not seem to work.
#   ? Do we need a reboot after this?

#
# Declarations
#
$logFile = "C:\Windows\Temp\Setup-oobeSystem.log"
$chocoLog = "C:\Windows\Temp\Setup-specialize-choco.log"
$chocoApps = @"
powertoys
notepadplusplus
choco-cleaner
choco-upgrade-all-at-startup
1password
sysinternals
pwsh
git
GoogleChrome
putty
7zip
ffmpeg
fsviewer
logitech-camera-settings
paint.net
protonvpn
teamviewer
transgui
treesizefree
vlc
wireshark
yt-dlp
vscode
Firefox
audacious
audacity
asio4all
greenshot
"@


# Enable logging.
Start-Transcript -Path $logFile -Append
Write-Output "Starting script in oobeSystem phase."

#
# Debug handling.
#
#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-START oobeSystem phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal


#
# Windows settings.
#

# Enable Ultimate Performance power plan.
$out = powercfg.exe /DUPLICATESCHEME e9a42b02-d5df-448d-aa00-03f14749eb61;
if ( $out -match '\s([a-f0-9-]{36})\s' ) {
    powercfg.exe /SETACTIVE $Matches[1];
}

# Disable modern standby
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Power" -Name "PlatformAoAcOverride" -Value 0 -Type DWord

# Set screen off time when plugged in to 10 minutes
& powercfg /change monitor-timeout-ac 10

# Set screen off time when on battery to 5 minutes
& powercfg /change monitor-timeout-dc 5

# Disable sleep when plugged in
& powercfg /change standby-timeout-ac 0

# Set sleep time on battery to 15 minutes
& powercfg /change standby-timeout-dc 15

# Disable lid close action
& powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 0
& powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 0


#
# Install applications.
#

# chocolatey (in system context, elevated)
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation

# Choco applications.  
# OK? for 7zip. Not sure about the list as a whole.
$chocoAppsArray = ($chocoApps -split "`n")
choco install @chocoAppsArray --log-file=$($chocoLog) --no-progress --yes --no-color --limit-output --ignore-detected-reboot

# onthespot
$installDir = (Join-Path $env:ProgramFiles "onthespot")
New-Item -ItemType Directory -Path $installDir
Invoke-WebRequest -Uri "https://github.com/casualsnek/onthespot/releases/latest/download/onthespot_win_ffm.exe" -OutFile "$($installDir)\onthespot_win_ffm.exe"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/lunndal/onthespot-cachefix/refs/heads/main/Start-OnTheSpot.ps1" -OutFile "$($installDir)\Start-OnTheSpot.ps1" 
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/lunndal/onthespot-cachefix/refs/heads/main/Start-OnTheSpot.ps1.lnk" -OutFile "$($installDir)\Start-OnTheSpot.ps1.lnk" 


#
# Application settings
#




#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-END oobeSystem phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

# Stop logging.
Stop-Transcript