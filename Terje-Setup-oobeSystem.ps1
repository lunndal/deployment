
# Source 
# https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup-oobeSystem.ps1

#
# USAGE
# Run this script during the "oobeSystem" phase from autounattend.xml
# Commands will run in the context of the first admin user created, when the installer automatically logs the user in.
#
# PURPOSE
# Global software installation go in this file. After this script is run, the following happens:
# 1. The autounattend will clone the Private git repo, and we can subsequentally 
#    run the rest of the scripts from local disk.
# 2. The Terje-Setup-oobeSystem-FirstLogon.ps1 will run, and perform configuration intende for the
#    first defined admin user form the unattend file.
#
# NOTE
# This script will count against the "FirstRun" for the first configured admin user, but it's solely for
# installing software pre Git clone of Private repo. Later in this phase, after cloning the repo, 
# any other FirstRun commands for the first logged in admin user will be run from the 
# Terje-Setup-oobeSystem-FirstLogon.ps1 script.
# All other users will instead run the Terje-Setup-NewUsers-FirstLogon.ps1 script.
# 

#
# ISSUES
# ?

#
# Declarations
#

$logDir = "C:\Windows\Setup\Scripts"
$logFile = "$($logDir)\Terje-Setup-oobeSystem-$($env:USERNAME).log"
$chocoLog = "$($logDir)\Setup-oobeSystem-CHOCO.log"
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
FoxitReader
greenshot
"@

# Log settings
$logDir = "C:\Windows\Setup\Scripts"
$logFile = "$($logDir)\Terje-Setup-oobeSystem-$($env:USERNAME).log"

# Enable logging.
Start-Transcript -Path $logFile -Append
Write-Output "Starting script in oobeSystem phase."

#
# Debug handling.
#
Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-START oobeSystem phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal


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


Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-END oobeSystem phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

# Stop logging.
Stop-Transcript