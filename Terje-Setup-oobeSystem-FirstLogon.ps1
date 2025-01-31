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
# https://raw.githubusercontent.com/lunndal/deployment/refs/heads/main/Terje-Setup-oobeSystem-FirstLogon.ps1

#
# USAGE
# Run this script during the "oobeSystem" phase, under the FirstLogonCommands section, of autounattend.xml
# Commands will run only once in the context of the logged in user.
# 

#
# ISSUES
# 

#
# Declarations
#
$logFile = "C:\Windows\Temp\Setup-oobeSystem-FirstLogon-$($env:USERNAME).log"

# Enable logging.
Start-Transcript -Path $logFile -Append

#
# Windows settings.
#


#
# Install applications.
#

#
# ? Install Chrome extensions
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
# Application settings
#

# Git (this was done earlier during the first logon of the first admin account.)
#git config --global user.email $myEmail
#git config --global user.name $myName

# Stop logging.
Stop-Transcript