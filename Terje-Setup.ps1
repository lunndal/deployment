#
# Assumes the hard-autounattend.xml is applied.
#    Need to customize this at some point, to enable security and some apps/features.
#

#
# ISSUES
#
# Execution Policy er ikke liberal nok når dette skriptet skal kjøres.
# WiFi var ikke påkoblet. Måtte gjøres manuelt.

#
# Windows settings.
#


# Install chocolatey (as admin!)
# DEBUG
#Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
#choco feature enable -n allowGlobalConfirmation

#
# Install choco applications.  
#
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
microsoft-windows-terminal
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

$chocoAppsArray = ($chocoApps -split "`n")
# DEBUG
choco install @chocoAppsArray

#
# Install Chrome extensions
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

