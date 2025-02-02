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

# OK - Enable Ultimate Performance power plan.
$out = powercfg.exe /DUPLICATESCHEME e9a42b02-d5df-448d-aa00-03f14749eb61;
if ( $out -match '\s([a-f0-9-]{36})\s' ) {
    powercfg.exe /SETACTIVE $Matches[1];
}


#
# Install applications.
#

# OK - Install chocolatey (in system context, elevated)
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
# Install browser extensions
#

# 1password
$1passChromeExtId = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"



$1passFirefoxExtId = "d634138d-c276-4fc8-924b-40a0ea21d284.xpi"
$1passFirefoxExtId = "dppgmdbiimibapkepcbdbmkaabgiofem;https://edge.microsoft.com/extensionwebstorebase/v1/crx"

# Dark reader

# Consent-o-matic

#
# Pin taskbar icons.
#
$pinTaskbarUrl = "https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Windows/Pin-TaskbarIcons.ps1"
Invoke-Expression (Invoke-WebRequest -UseBasicParsing -Headers @{"Cache-Control"="no-cache"} $pinTaskbarUrl).content -Verbose

#
# Application settings
#


#Start-Process powershell -ArgumentList "-NoExit -Command `"Write-Host 'DEBUG-END oobeSystem phase. Exit shell when done debugging.'`"" -Wait -WindowStyle Normal

# Stop logging.
Stop-Transcript