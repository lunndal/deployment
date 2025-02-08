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
# Commands will run in the context of the first admin user created, when the installer automatically logs the user in.
#
# Global software installation go in this file. After it is run the Private git repo will be cloned, 
# and we can run the rest of the scripts from local disk.
# 

#
# ISSUES
# ?

#
# Declarations
#
$logFile = "C:\Windows\Temp\Setup-oobeSystem.log"
$chocoLog = "C:\Windows\Temp\Setup-oobeSystem-choco.log"
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


#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-END oobeSystem phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

# Stop logging.
Stop-Transcript