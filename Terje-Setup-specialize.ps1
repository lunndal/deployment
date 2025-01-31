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
# https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup-specialize.ps1


#
# USAGE
# Run this script during the "specialize" phase from autounattend.xml.
# Commands will run in system context before any users are created.
# 

#
# ISSUES
# ? Execution Policy er ikke liberal nok når dette skriptet skal kjøres.
# ? WiFi var ikke påkoblet. Måtte gjøres manuelt. 

#
# Declarations
#
$logFile = "C:\Windows\Temp\Setup-specialize.log"
$myName = "Terje With Lunndal"
$myEmail = "terje@lunndal.priv.no"
$chocoApps = @"
choco-cleaner
choco-upgrade-all-at-startup
1password
sysinternals
pwsh
git
notepadplusplus
GoogleChrome
powertoys
putty
7zip
ffmpeg
fsviewer
greenshot
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
"@

# Enable logging.
Start-Transcript -Path $logFile -Append

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
choco install @chocoAppsArray

#
# Install Chrome extensions
# BROKEN - plugins do not appear!
#

$updateUrl = 'json { "update_url": "https://clients2.google.com/service/update2/crx" }'

# 1password
$regPath = "HKLM:\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\aeblfdkhhhdcdjpifhhbdiojplfjncoa"
New-Item -Path $regPath -Force
Set-ItemProperty -Path $regPath -Name "update_url" -Value $updateUrl

# Dark Reader
$regPath = "HKLM:\SOFTWARE\WOW6432Node\Google\Chrome\Extensions\eimadpbcbfnmbkopoojfekhnkhdbieeh"
New-Item -Path $regPath -Force
Set-ItemProperty -Path $regPath -Name "update_url" -Value $updateUrl

#
# Global application settings
#


# Stop logging.
Stop-Transcript